/// Tensor data structure module
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
    RCArray!T payload;
    ptrdiff_t offset = 0;

    this(size_t[dim] shape...)
    {
        import mir.ndslice.topology : iota;

        this.shape = shape;
        this.stride = shape.iota.strides;
        this.payload = typeof(payload)(this.stride[0] * this.shape[0]);
    }

    RCI!T iterator() @property
    {
        return payload.asSlice._iterator + offset;
    }

    Slice!(RCI!T, dim, Universal) asSlice()
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.shape, this.stride);
        return typeof(return)(structure, this.iterator);
    }

    Slice!(T*, dim, Universal) lightScope()() scope return @property @trusted
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.shape, this.stride);
        return typeof(return)(structure, this.iterator.lightScope);
    }
}


@nogc unittest
{
    auto x = Tensor!(2, double)(2, 3);
    assertEqual(x.stride[0], 3);
    assertEqual(x.stride[1], 1);
}
