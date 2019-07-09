/// copy ops
module grain.ops.copy;

import core.stdc.stdio;

import mir.format;

import grain.tensor : Tensor, Opt, isTensor;
import grain.ops.common : apply;


@nogc nothrow
auto contiguous(size_t dim, T, Storage)(Tensor!(dim, T, Storage) x)
{
    if (x.isContiguous) return x;
    return x.copy!Storage;
}

/// copy tensor between devices
struct Copy(size_t N, T, Src, Dst)
{
    @nogc nothrow:
    
    alias dsrc = Src.deviceof;
    alias ddst = Dst.deviceof;
    Opt opt, srcOpt;

    static if (dsrc == "cpu" && ddst == "cpu")
    Tensor!(N, T, Dst) forward(Tensor!(N, T, Src) x) 
    {
        this.srcOpt = x.opt;
        auto y = typeof(return)(this.opt, x.shape);
        y.lightScope[] = x.lightScope;
        return y;
    }

    static if (dsrc == "cuda" && ddst == "cuda")
    Tensor!(N, T, Dst) forward(Tensor!(N, T, Src) x)
    {
        import grain.cuda.cudnn : transform;

        this.srcOpt = x.opt;
        auto y = typeof(return)(this.opt, x.shape);
        if (x.deviceId == y.deviceId)
        {
            transform(x, y);
            return y;
        }
        else
        {
            import grain.cuda.dpp.runtime_api : cudaMemcpyAsync, cudaMemcpyDeviceToDevice;
            import grain.cuda.device : CuDevice;
            import grain.cuda.testing : checkCuda;
            
            x = x.contiguous;
            cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                            cudaMemcpyDeviceToDevice, CuDevice.get(x.deviceId).stream);
            return y;
        }
    }

    static if (dsrc == "cpu" && ddst == "cuda")
    Tensor!(N, T, Dst) forward(Tensor!(N, T, Src) x)
    {
        import grain.cuda.dpp.runtime_api;
        import grain.cuda.device : CuDevice;
        import grain.cuda.testing : checkCuda;
        
        this.srcOpt = x.opt;
        auto y = typeof(return)(this.opt, x.shape);
        x = x.contiguous;
        if (x.pinMemory)
        {
            cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                            cudaMemcpyHostToDevice,
                            CuDevice.get(this.opt.deviceId).stream);
            return y;
        }
        else
        {
            cudaMemcpy(y.ptr, x.ptr, T.sizeof * x.numel, cudaMemcpyHostToDevice);
            return y;
        }
    }

    static if (dsrc == "cuda" && ddst == "cpu")
    Tensor!(N, T, Dst) forward(Tensor!(N, T, Src) x)        
    {
        import grain.cuda.device : CuDevice;
        import grain.cuda.dpp.runtime_api;
        import grain.cuda.testing : checkCuda;

        this.srcOpt = x.opt;
        auto y = typeof(return)(this.opt, x.shape);
        x = x.contiguous;
        if (x.pinMemory)
        {
            auto s = CuDevice.get(x.deviceId).stream;
            cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                            cudaMemcpyDeviceToHost, s);
            cudaStreamSynchronize(s);
            return y;
        }
        else
        {
            checkCuda(cudaMemcpy(y.ptr, x.ptr, T.sizeof * x.numel, cudaMemcpyDeviceToHost));
            return y;
        }
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
    static if (D.deviceof != "cpu")
    {
        // update the default device id (-1 is CPU)
        if (opt.deviceId == -1) opt.deviceId = 0;
    }
    Copy!(N, T, Src, D) f = {opt: opt};
    return f.apply(x);
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
    import mir.ndslice.topology : iota, as;
    import grain.tensor;
    import std.meta : AliasSeq;
    import std.typecons : tuple;

    static foreach (dtype; AliasSeq!(float, double, int, long))
    {
        {
            auto x = Tensor!(2, dtype)(2, 3);
            x.asSlice[] = iota(x.shape).as!dtype;
            auto y = x.copy!"cpu";
            assert(y.asSlice == x.asSlice);
            x.asSlice[0, 0] = 1;
            assert(y.asSlice != x.asSlice);

            version (grain_cuda)
            {
                // FIXME: int/long is supported when transposed
                foreach (pin; tuple(true, false))
                {
                    Opt opt = {pinMemory: pin};
                    auto c = x.copy!"cuda"(opt); // .transposed;
                    static assert(c.deviceof == "cuda");
                    assert(c.deviceId == 0);
                    auto xt = c.copy!"cpu"; // .transposed;
                    assert(xt.pinMemory == pin);
                    assert(xt.asSlice == x.asSlice);
                    assert(xt.ptr != x.ptr);

                    import grain.cuda.device : CuDevice;
                    if (CuDevice.count > 1)
                    {
                        opt.pinMemory = pin;
                        opt.deviceId = 1;
                        auto d1 = c.copy!"cuda"(opt);
                        assert(d1.deviceId == 1);
                        assert(d1.pinMemory == pin);
                        assert(d1.copy!"cpu".asSlice == x.asSlice);
                    }
                }
            }
        }
    }
}
