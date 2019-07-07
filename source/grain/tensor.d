/// Tensor data structure module
module grain.tensor;

import stdx.allocator.mallocator : Mallocator;
import grain.storage : RCStorage;
debug import grain.testing : assertAllClose, assertEqual;


// Tensor on CPU implementation
struct Tensor(size_t dim, T, Storage = RCStorage!Mallocator)
{
    import mir.ndslice.slice : Slice, Universal, Structure;

    size_t[dim] lengths;
    ptrdiff_t[dim] strides;
    Storage payload;
    ptrdiff_t offset = 0;

    alias shape = lengths;
    
    this(size_t[dim] lengths...)
    {
        import mir.ndslice.topology : iota;

        this.lengths = lengths;
        this.strides = lengths.iota.strides;
        this.payload = typeof(payload)(T.sizeof * this.strides[0] * this.lengths[0]);
    }

    auto iterator() @property
    {
        return payload.iterator!(T*) + offset;
    }

    Slice!(typeof(this.iterator()), dim, Universal) asSlice()
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.lengths, this.strides);
        return typeof(return)(structure, this.iterator);
    }

    Slice!(T*, dim, Universal) lightScope()() scope return @property @trusted
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.lengths, this.strides);
        return typeof(return)(structure, this.iterator);
    }
}


@nogc unittest
{
    auto x = Tensor!(2, double)(2, 3);
    assertEqual(x.strides[0], 3);
    assertEqual(x.strides[1], 1);
}
