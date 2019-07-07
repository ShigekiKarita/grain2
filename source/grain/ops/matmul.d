/// matrix multiplication ops
module grain.ops.matmul;

import std.typecons : Tuple, tuple;

import grain.tensor : Tensor;
import grain.testing : assertEqual;


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
        import grain.ops.transposed : transposed;

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
    import grain.testing : assertAllClose;
    
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

