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
    import std.traits : isPointer, PointerTarget;
    import mir.rc : RCArray;
    import mir.ndslice.slice : Slice;

    size_t[dim] shape;
    ptrdiff_t[dim] stride;

    RCArray!T storage;

    this(size_t[dim] shape...)
    {
        this.shape = shape;
        size_t n = 1;
        foreach (i, s; shape)
        {
            this.stride[$-1-i] = n;
            n *= s;
        }
        this.storage = typeof(storage)(n);
    }

    @trusted auto asSlice()
    {
        import mir.ndslice;
        return this.storage.ptr.sliced(shape);
    }

    @trusted ref normal_()
    {
        import grain.random : rng;
        import mir.ndslice : each;
        import mir.random.variable: NormalVariable;
        auto rv = NormalVariable!T(0, 1);
        this.asSlice().each!((ref x) {x = rv(rng);});
        return this;
    }
}


struct Matmul(T)
{
    auto forward(Tensor!(2, T) a, Tensor!(2, T) b)
    in
    {
        assertEqual(a.shape[1], b.shape[0], "Matmul shape mismatch");
    }
    do
    {
        import mir.format : stringBuf, getData;
        import mir.blas : gemm;
        auto c = Tensor!(2, T)(a.shape[0], b.shape[1]);
        c.asSlice[] = 0;
        gemm(cast(T) 1, a.asSlice, b.asSlice, cast(T) 0, c.asSlice);
        return c;
    }
}

auto matmul(T)(Tensor!(2, T) a, Tensor!(2, T) b)
{
    Matmul!T mm;
    return mm.forward(a, b);
}


@safe @nogc
unittest
{
    auto x = Tensor!(2, double)(2, 3).normal_;
    auto y = Tensor!(2, double)(3, 2).normal_;
    auto c = Tensor!(2, double)(2, 2);
    c.asSlice[] = 0;
    foreach (i; 0 .. x.shape[0])
    {
        foreach (j; 0 .. y.shape[1])
        {
            foreach (k; 0 .. x.shape[1])
            {
                c.asSlice[i, j] += x.asSlice[i, k] * y.asSlice[k, j];
            }
        }
    }

    assertAllClose(x.matmul(y), c);
}
