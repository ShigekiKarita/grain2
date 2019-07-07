module grain.functions;

import std.typecons : Tuple, tuple;
import grain.tensor : Tensor;
debug import grain.testing : assertEqual, assertAllClose;


struct Copy(size_t N, T, Src, Dst)
{
    alias dsrc = Src.deviceof;
    alias ddst = Dst.deviceof;
    
    static if (dsrc == ddst)
    {
        static if (dsrc == "cpu")
        {
            Tensor!(N, T, Dst) forward(Tensor!(N, T, Src) x)
            {
                import mir.ndslice : zip, each;
                auto y = typeof(return)(x.shape);
                y.lightScope[] = x.lightScope;
                return y;
            }
        }
        else static if (dsrc == "cuda")
        {
            // TODO
        }
        else
        {
            static assert(false, "unsupported copy: " ~ dsrc ~ " -> " ~ ddst);
        }

        Tensor!(N, T, Src) backward(Tensor!(N, T, Dst) x)
        {
            return x;
        }
    }
    else
    {
        static if (dsrc == "cpu" && ddst == "cuda")
        {
            // TODO
        }
        else static if (dsrc == "cuda" && ddst == "cpu")
        {
            // TODO
        }
        else
        {
            static assert(false, "unsupported copy: " ~ dsrc ~ " -> " ~ ddst);
        }
    }
}


auto copy(alias Dst, size_t N, T, Src)(Tensor!(N, T, Src) x)
{
    static if (is(typeof(Dst) == string))
    {
        static if (Dst == "cpu")
        {
            import grain.storage : DefaultCPUStorage;
            Copy!(N, T, Src, DefaultCPUStorage) f;
        }
        else
        {
            static assert("unsupported string Dst: " ~ Dst);
        }
    }
    else
    {
        Copy!(N, T, Src, Dst) f;
    }
    return f.forward(x);
}

///
unittest
{
    import mir.ndslice.topology : iota;
    auto x = Tensor!(2, int)(2, 3);
    x.asSlice[] = iota!int(x.shape);
    auto y = x.copy!"cpu";
    assert(y.asSlice == x.asSlice);
    x.asSlice[0, 0] = 1;
    assert(y.asSlice != x.asSlice);
}


/// transpose last two dim
struct Transposed(size_t N, T, Storage)
{
    static assert(N >= 2);

    static Tensor!(N, T, Storage) forward(Tensor!(N, T, Storage) x)
    {
        auto n1 = x.lengths[$-1];
        auto n2 = x.lengths[$-2];
        x.lengths[$-2] = n1;
        x.lengths[$-1] = n2;
        auto s1 = x.strides[$-1];
        auto s2 = x.strides[$-2];
        x.strides[$-1] = s2;
        x.strides[$-2] = s1;
        return x;
    }

    static Tensor!(N, T, Storage) backward(Tensor!(N, T, Storage) gy)
    {
        return gy.transposed;
    }
}

/// ditto
auto transposed(size_t N, T, Storage)(Tensor!(N, T, Storage) x)
{
    return Transposed!(N, T, Storage).forward(x);
}

///
@nogc unittest
{
    import mir.ndslice.topology : iota;
    
    // [0, 1, 2]
    // [3, 4, 5]
    // iter   = p
    // lengths  = [2, 3]
    // strides = [3, 1]
    auto x = Tensor!(2, size_t)(2, 3);
    x.asSlice[] = iota(2, 3);

    // [0, 3]
    // [1, 4]
    // [2, 5]
    // lengths  = [3, 2]
    // strides = [1, 3]
    auto t = x.transposed;
    assert(t.lengths[1] == x.lengths[0]);
    assert(t.lengths[0] == x.lengths[1]);
    
    assert(t.asSlice[0, 0] == x.asSlice[0, 0]);
    assert(t.asSlice[0, 1] == x.asSlice[1, 0]);

    assert(t.asSlice[1, 0] == x.asSlice[0, 1]);
    assert(t.asSlice[1, 1] == x.asSlice[1, 1]);   

    assert(t.asSlice[2, 0] == x.asSlice[0, 2]);
    assert(t.asSlice[2, 1] == x.asSlice[1, 2]);

    assert(t.transposed.asSlice == x.asSlice);
}

/// matrix multiplication
struct Matmul(T, Storage) if (Storage.deviceof == "cpu")
{
    alias Matrix = Tensor!(2, T, Storage);

    Matrix a, b;

    Matrix forward(Matrix a, Matrix b)
    in
    {
        assertEqual(a.lengths[1], b.lengths[0], "Matmul lengths mismatch");
    }
    do
    {
        import mir.ndslice : as;
        import mir.blas : gemm;
        auto c = Tensor!(2, T)(a.lengths[0], b.lengths[1]);
        gemm(cast(T) 1, a.lightScope, b.lightScope, cast(T) 0, c.lightScope);
        return c;
    }

    Tuple!(Matrix, Matrix) backward(Matrix gc)
    {
        auto ga = matmul(gc, this.b.transposed);
        auto gb = matmul(this.a.transposed, gc);
        return tuple(ga, gb);
    }
}

/// ditto
auto matmul(T, Storage)(Tensor!(2, T, Storage) a, Tensor!(2, T, Storage) b)
{
    Matmul!(T, Storage) mm;
    return mm.forward(a, b);
}


@system @nogc
unittest
{
    import grain.random : normal_;
    
    auto x = Tensor!(2, double)(2, 3).normal_;
    auto y = Tensor!(2, double)(3, 2).normal_;
    auto z = x.matmul(y);
    auto c = Tensor!(2, double)(2, 2);
    c.asSlice[] = 0;
    foreach (i; 0 .. x.lengths[0])
    {
        foreach (j; 0 .. y.lengths[1])
        {
            foreach (k; 0 .. x.lengths[1])
            {
                c.asSlice[i, j] += x.asSlice[i, k] * y.asSlice[k, j];
            }
        }
    }
    assertAllClose(x.matmul(y), c);
}

