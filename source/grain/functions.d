module grain.functions;

import std.typecons : Tuple, tuple;
import grain.tensor : Tensor, Device;
debug import grain.testing : assertEqual, assertAllClose;


/// transpose last two dim
struct Transposed(size_t N, T)
{
    static assert(N >= 2);

    static Tensor!(N, T) forward(Tensor!(N, T) x)
    {
        auto n1 = x.shape[$-1];
        auto n2 = x.shape[$-2];
        x.shape[$-2] = n1;
        x.shape[$-1] = n2;
        auto s1 = x.stride[$-1];
        auto s2 = x.stride[$-2];
        x.stride[$-1] = s2;
        x.stride[$-2] = s1;
        return x;
    }

    static Tensor!(N, T) backward(Tensor!(N, T) gy)
    {
        return gy.transposed;
    }
}

/// ditto
auto transposed(size_t N, T)(Tensor!(N, T) x)
{
    return Transposed!(N, T).forward(x);
}

///
@nogc unittest
{
    import mir.ndslice.topology : iota;
    
    // [0, 1, 2]
    // [3, 4, 5]
    // iter   = p
    // shape  = [2, 3]
    // stride = [3, 1]
    auto x = Tensor!(2, size_t)(2, 3);
    x.asSlice[] = iota(2, 3);

    // [0, 3]
    // [1, 4]
    // [2, 5]
    // shape  = [3, 2]
    // stride = [1, 3]
    auto t = x.transposed;
    assert(t.shape[1] == x.shape[0]);
    assert(t.shape[0] == x.shape[1]);
    
    assert(t.asSlice[0, 0] == x.asSlice[0, 0]);
    assert(t.asSlice[0, 1] == x.asSlice[1, 0]);

    assert(t.asSlice[1, 0] == x.asSlice[0, 1]);
    assert(t.asSlice[1, 1] == x.asSlice[1, 1]);   

    assert(t.asSlice[2, 0] == x.asSlice[0, 2]);
    assert(t.asSlice[2, 1] == x.asSlice[1, 2]);

    assert(t.transposed.asSlice == x.asSlice);
}


/// matrix multiplication
struct Matmul(T, Device device) if (device == Device.CPU)
{
    alias Matrix = Tensor!(2, T, device);

    Matrix a, b;

    Matrix forward(Matrix a, Matrix b)
    in
    {
        assertEqual(a.shape[1], b.shape[0], "Matmul shape mismatch");
    }
    do
    {
        import mir.ndslice : as;
        import mir.blas : gemm;
        auto c = Tensor!(2, T)(a.shape[0], b.shape[1]);
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

struct Matmul(T, Device device) if (device == Device.CUDA)
{
    
}

/// ditto
auto matmul(T, Device dev)(Tensor!(2, T, dev) a, Tensor!(2, T, dev) b)
{
    Matmul!(T, dev) mm;
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
