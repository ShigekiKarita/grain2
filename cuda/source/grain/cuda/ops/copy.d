module grain.cuda.ops.copy;

import grain.storage : Storage;
import grain.tensor;
import grain.ops.copy;


Tensor!(N, T, Dst)
forward(size_t N, T, Src, Dst)(
    ref Copy!(N, T, Src, Dst) self,
    Tensor!(N, T, Src) x
)
if (Src.deviceof == "cuda" && Dst.deviceof == "cuda")
{
    import grain.cuda.cudnn : transform;

    self.srcOpt = x.opt;
    auto y = typeof(return)(self.opt, x.shape);
    if (x.deviceId == y.deviceId)
    {
        transform(x, y);
        return y;
    }
    else
    {
        import grain.dpp.cuda_runtime_api; // : cudaMemcpyAsync, cudaMemcpyDeviceToDevice;
        import grain.cuda.device : CuDevice;
        import grain.cuda.testing : checkCuda;

        x = x.contiguous;
        // x -> y dependency
        cudaEvent_t event;
        cudaEventCreateWithFlags(&event, cudaEventDisableTiming);
        cudaEventRecord(event, CuDevice.get(x.deviceId).stream);
        auto dstStream = CuDevice.get(y.deviceId).stream;
        cudaStreamWaitEvent(dstStream, event, 0);
        cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                        cudaMemcpyDeviceToDevice, dstStream);
        return y;
    }
}


Tensor!(N, T, Dst)
forward(size_t N, T, Src, Dst)(
    ref Copy!(N, T, Src, Dst) self,
    Tensor!(N, T, Src) x
)
if (Src.deviceof == "cpu" && Dst.deviceof == "cuda")
{
    import grain.dpp.cuda_runtime_api;
    import grain.cuda.device : CuDevice;
    import grain.cuda.testing : checkCuda;
        
    self.srcOpt = x.opt;
    auto y = typeof(return)(self.opt, x.shape);
    x = x.contiguous;
    static if (Src.pinned)
    {
        cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                        cudaMemcpyHostToDevice,
                        CuDevice.get(self.opt.deviceId).stream);
    }
    else
    {
        cudaMemcpy(y.ptr, x.ptr, T.sizeof * x.numel, cudaMemcpyHostToDevice);
    }
    return y;
}

Tensor!(N, T, Dst)
forward(size_t N, T, Src, Dst)(
    ref Copy!(N, T, Src, Dst) self,
    Tensor!(N, T, Src) x
)
if (Src.deviceof == "cuda" && Dst.deviceof == "cpu")
{
    import grain.cuda.device : CuDevice;
    import grain.dpp.cuda_runtime_api;
    import grain.cuda.testing : checkCuda;

    self.srcOpt = x.opt;
    auto y = typeof(return)(self.opt, x.shape);
    x = x.contiguous;
    static if (Src.pinned)
    {
        auto s = CuDevice.get(x.deviceId).stream;
        cudaMemcpyAsync(y.ptr, x.ptr, T.sizeof * x.numel,
                        cudaMemcpyDeviceToHost, s);
        cudaStreamSynchronize(s);
    }
    else
    {
        checkCuda(cudaMemcpy(y.ptr, x.ptr, T.sizeof * x.numel, cudaMemcpyDeviceToHost));
    }
    return y;
}


///
@nogc
unittest
{
    import grain.allocator : cpu;
    import grain.cuda.allocator : pinned, cuda;
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
            auto y = x.copy;
            assert(y.asSlice == x.asSlice);
            x.asSlice[0, 0] = 1;
            assert(y.asSlice != x.asSlice);

            // FIXME: int/long is supported when transposed
            foreach (host; AliasSeq!(cpu, pinned))
            {
                auto c = x.copy!cuda; // .transposed;
                static assert(c.deviceof == "cuda");
                assert(c.deviceId == 0);
                auto xt = c.copy!host; // .transposed;
                assert(xt.asSlice == x.asSlice);
                assert(xt.ptr != x.ptr);

                import grain.cuda.device : CuDevice;
                if (CuDevice.count > 1)
                {
                    Opt opt = {deviceId: 1};
                    auto d1 = c.copy!cuda(opt);
                    assert(d1.deviceId == 1);
                    assert(d1.copy!host.asSlice == x.asSlice);
                }
            }
        }
    }
}
   

