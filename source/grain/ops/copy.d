/// copy ops
module grain.ops.copy;

import grain.tensor : Tensor, Opt;


/// copy tensor between devices
struct Copy(size_t N, T, Src, Dst)
{
    @nogc nothrow:
    
    alias dsrc = Src.deviceof;
    alias ddst = Dst.deviceof;
    Opt opt, srcOpt;
    
    Tensor!(N, T, Dst) forward(Tensor!(N, T, Src) x)
    {
        this.srcOpt = x.opt;
        auto y = typeof(return)(this.opt, x.shape);
        static if (dsrc == "cpu" && ddst == "cpu")
        {
            y.lightScope[] = x.lightScope;
        }
        else static if (dsrc == "cuda" && ddst == "cuda")
        {
            import grain.cuda.cudnn : transform;
            if (x.deviceId == y.deviceId)
            {
                transform(x, y);
            }
            else
            {
                import grain.cuda.dpp.runtime_api;
                import grain.cuda.device : CuDevice;
                import grain.cuda.testing : checkCuda;

                if (!x.isContiguous)
                {
                    auto f = Copy!(N, T, Src, Src)(x.opt);
                    x = f.forward(x);
                }
                cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                                cudaMemcpyDeviceToDevice, CuDevice.get(x.deviceId).stream);
            }
        }
        else static if (dsrc == "cpu" && ddst == "cuda")
        {
            // TODO
            // import grain.cuda.dpp.driver : cuMemcpyHtoD_v2;
            import grain.cuda.dpp.runtime_api;
            import grain.cuda.dpp.driver;
            import grain.cuda.device : CuDevice;
            import grain.cuda.testing : checkCuda;

            if (!x.isContiguous)
            {
                auto f = Copy!(N, T, Src, Src)(x.opt);
                x = f.forward(x);
            }
            if (x.pinMemory)
            {
                cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                                cudaMemcpyHostToDevice,
                                CuDevice.get(opt.deviceId).stream);
            }
            else
            {
                cudaMemcpy(y.ptr, x.ptr, T.sizeof * x.numel, cudaMemcpyHostToDevice);
            }
        }
        else static if (dsrc == "cuda" && ddst == "cpu")
        {
            // TODO
            import grain.cuda.device : CuDevice;
            import grain.cuda.dpp.runtime_api; // driver : cuMemcpyDtoH_v2, CUdeviceptr;
            import grain.cuda.testing : checkCuda;

            if (!x.isContiguous)
            {
                x = x.copy!Src;
            }
            if (x.pinMemory)
            {
                cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                                cudaMemcpyDeviceToHost, CuDevice.get(x.deviceId).stream);
            }
            else
            {
                checkCuda(cudaMemcpy(y.ptr, x.ptr, T.sizeof * x.numel, cudaMemcpyDeviceToHost));
            }
        }
        else
        {
            static assert(false, "unsupported copy: " ~ dsrc ~ " -> " ~ ddst);
        }
        return y;
    }

    Tensor!(N, T, Src) backward(Tensor!(N, T, Dst) gy)
    {
        static if (dsrc == ddst)
        {
            if (this.opt == this.srcOpt)
                return gy;
            else
                return gy.copy!Src(this.srcOpt);
        }
        else
            return gy.copy!Src(this.srcOpt);
    }
}

/// ditto
@nogc nothrow
auto copy(alias Dst, size_t N, T, Src)(Tensor!(N, T, Src) x, Opt opt)
{
    static if (is(typeof(Dst) == string))
    {
        static if (Dst == "cpu")
        {
            import grain.storage : DefaultCPUStorage;
            alias D = DefaultCPUStorage;
        }
        static if (Dst == "cuda")
        {
            import grain.cuda.allocator : DefaultCuStorage;
            alias D = DefaultCuStorage;
        }
        else
        {
            static assert("unsupported string Dst: " ~ Dst);
        }
    }
    else
    {
        alias D = Dst;
    }
    Copy!(N, T, Src, D) f = {opt: opt};
    return f.forward(x);
}

/// ditto
auto copy(alias Dst, size_t N, T, Src)(Tensor!(N, T, Src) x)
{
    return copy!Dst(x, x.opt);
}

///
@system @nogc
unittest
{
    import grain.ops.transposed : transposed;
    import mir.ndslice.topology : iota;
    import grain.tensor;

    auto x = Tensor!(2, float)(2, 3);
    x.asSlice[] = iota(x.shape);
    auto y = x.copy!"cpu";
    assert(y.asSlice == x.asSlice);
    x.asSlice[0, 0] = 1;
    assert(y.asSlice != x.asSlice);

    version (grain_cuda)
    {
        // FIXME: CUDNN_NOT_SUPPORTED if use int
        Opt opt = {pinMemory: true};
        auto c = x.copy!"cuda"(opt).transposed;
        auto x1 = c.copy!"cpu".transposed;
        assert(x1.pinMemory);
        assert(x1.asSlice == x.asSlice);
    }
}
