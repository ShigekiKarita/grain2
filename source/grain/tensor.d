/// Tensor data structure module
module grain.tensor;



import grain.storage : RCStorage, RCIter, DefaultCPUStorage;
debug import grain.testing : assertAllClose, assertEqual;


// TODO fix this linker error
// import std.numeric : CustomFloat;
// /// IEEE 754-2008 16-bit float
// alias CustomFloat!16 half;


struct Opt
{
    bool requireGrad = false;
    bool pinMemory = false;
    int deviceId = 0;
}

// Tensor on CPU implementation
struct Tensor(size_t _dim, T, Storage = DefaultCPUStorage)
{
    import mir.ndslice.slice : Slice, Universal, Structure;

    alias dim = _dim;
    alias deviceof = Storage.deviceof;
    alias shape = lengths;
    
    size_t[dim] lengths;
    ptrdiff_t[dim] strides;
    Storage payload;
    ptrdiff_t offset = 0;

    Opt opt;
    alias opt this;

    this(Opt opt, size_t[dim] lengths...)
    {
        this.opt = opt;
        this(lengths);
    }
    
    this(size_t[dim] lengths...)
    {
        import mir.ndslice.topology : iota;

        this.lengths = lengths;
        this.strides = lengths.iota.strides;
        auto al = typeof(Storage.init.allocator)(this.opt);
        size_t n = T.sizeof * this.strides[0] * this.lengths[0];
        this.payload = typeof(payload)(n, al);
    }

    bool isContiguous() const
    {
        if (this.strides[dim - 1] != 1) return false;
        foreach (i; 0 .. dim - 1)
        {
            if (this.strides[i] != this.lengths[i + 1]) return false;
        }
        return true;
    }

    size_t numel() const
    {
        size_t ret = 1;
        foreach (l; this.lengths) ret *= l;
        return ret;
    }

    RCIter!(T*, Storage) iterator() @property
    {
        static if (deviceof == "cuda")
        {
            import grain.cuda.dpp.runtime_api : cudaSetDevice;
            cudaSetDevice(this.deviceId);
        }
        return payload.iterator!(T*) + offset;
    }

    Slice!(typeof(this.iterator()), dim, Universal) asSlice()()
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.lengths, this.strides);
        return typeof(return)(structure, this.iterator);
    }
    
    Slice!(T*, dim, Universal) lightScope()() scope return @property @trusted
    {
        import std.meta : AliasSeq;
        alias structure = AliasSeq!(this.lengths, this.strides);
        return typeof(return)(structure, this.ptr);
    }

    T* ptr()() scope return @property @trusted
    {
        return this.iterator.lightScope;
    }
}

template isTensor(T)
{
    static if (is(T : Tensor!(N, E, S), E, size_t N, S))
        enum bool isTensor = true;
    else
        enum bool isTensor = false;
}



@nogc unittest
{
    auto x = Tensor!(2, double)(2, 3);
    static assert(isTensor!(typeof(x)));
    static assert(x.deviceof == "cpu");
    assertEqual(x.strides[0], 3);
    assertEqual(x.strides[1], 1);
    assert(x.isContiguous);
    assert(x.numel == 2 * 3);
}

