module grain.tensor;

debug import grain.testing : assertAllClose, assertEqual;

enum Device
{
    CPU,
    CUDA
}

// Tensor on CPU implementation
struct Tensor(size_t dim, T)
{
    import std.traits : isPointer, PointerTarget, isFloatingPoint;
    import mir.rc : RCArray, RCI;
    import mir.ndslice.slice : Slice, Universal;
    import mir.ndslice.topology : iota;
    
    size_t[dim] shape;
    ptrdiff_t[dim] stride;

    RCArray!T storage;
    ptrdiff_t offset = 0;

    this(size_t[dim] shape...)
    {
        this.shape = shape;
        size_t n = 1;
        foreach (s; shape)
        {
            n *= s;
        }
        this.stride = shape.iota.strides;
        this.storage = typeof(storage)(n);
    }

    RCI!T iterator()
    {
        return storage.asSlice._iterator + offset;
    }

    Slice!(typeof(this.iterator()), dim, Universal) asSlice()
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.shape, this.stride);
        return typeof(return)(structure, this.iterator);
    }

    Slice!(T*, dim, Universal) lightScope()
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.shape, this.stride);
        return typeof(return)(structure, this.iterator.lightScope);        
    }
    
    static if (isFloatingPoint!T)
    @trusted ref normal_()
    {
        import grain.random : rng;
        import mir.ndslice : each;
        import mir.random.variable: NormalVariable;
        auto rv = NormalVariable!T(0, 1);
        this.asSlice.each!((ref x) {x = rv(rng);});
        return this;
    }
}


unittest
{
    auto x = Tensor!(2, double)(2, 3);
    assertEqual(x.stride, [3, 1]);
}
