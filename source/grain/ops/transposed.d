/// matrix transpose ops
module grain.ops.transposed;

import grain.tensor : Tensor;


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
    assert(!t.isContiguous);
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
