module grain.tensor;

debug import grain.testing : assertAllClose, assertEqual;

enum Device
{
    CPU,
    CUDA
}

// Tensor on CPU implementation
struct Tensor(size_t dim, T, Device device = Device.CPU)
{    
    import mir.ndslice.slice : Slice, Universal, Structure;
    import mir.rc.array : RCArray, RCI;

    size_t[dim] shape;
    ptrdiff_t[dim] stride;
    RCArray!T array;
    ptrdiff_t offset = 0;

    this(size_t[dim] shape...)
    {
        import mir.ndslice.topology : iota;
        
        this.shape = shape;
        size_t n = 1;
        foreach (s; shape)
        {
            n *= s;
        }
        this.stride = shape.iota.strides;
        this.array = typeof(array)(n);
    }
    
    RCI!T iterator()
    {
        return array.asSlice._iterator + offset;
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
}


unittest
{
    auto x = Tensor!(2, double)(2, 3);
    assertEqual(x.stride, [3, 1]);
}
