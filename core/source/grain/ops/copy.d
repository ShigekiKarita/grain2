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


Tensor!(N, T, Dst)
forward(size_t N, T, Src, Dst)(
    Copy!(N, T, Src, Dst) self,
    Tensor!(N, T, Src) x)
if (Src.deviceof == "cpu" && Dst.deviceof == "cpu")
{
    self.srcOpt = x.opt;
    auto y = typeof(return)(self.opt, x.shape);
    y.lightScope[] = x.lightScope;
    return y;
}

import grain.storage : DefaultCPUStorage;

/// ditto
@nogc nothrow
auto copy(Dst, size_t N, T, Src)(Tensor!(N, T, Src) x, Opt opt)
{
    // static if (is(typeof(Dst) == string))
    // {
    //     static if (Dst == "cpu")
    //     {
    //         import grain.storage : DefaultCPUStorage;
    //         alias D = DefaultCPUStorage;
    //     }
    //     static if (Dst == "cuda")
    //     {
    //         import grain.cuda.allocator : DefaultCuStorage;
    //         alias D = DefaultCuStorage;
    //     }
    //     else
    //     {
    //         static assert("unsupported string Dst: " ~ Dst);
    //     }
    // }
    // else
    
    static if (Dst.deviceof != "cpu")
    {
        // update the default device id (-1 is CPU)
        if (opt.deviceId == -1) opt.deviceId = 0;
    }
    Copy!(N, T, Src, Dst) f = {opt: opt};
    return f.apply(x);
}

/// ditto
auto copy(Dst, size_t N, T, Src)(Tensor!(N, T, Src) x)
{
    return copy!Dst(x, x.opt);
}



/// ditto
auto copy(size_t N, T, Src)(Tensor!(N, T, Src) x)
{
    return copy!Src(x, x.opt);
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
            auto y = x.copy;
            assert(y.asSlice == x.asSlice);
            x.asSlice[0, 0] = 1;
            assert(y.asSlice != x.asSlice);
        }
    }
}
