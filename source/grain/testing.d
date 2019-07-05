module grain.testing;

import mir.format : stringBuf, getData;

void assertEqual(T1, T2)(T1 actual, T2 desired, string info = "none")
{
    assert(actual == desired,
           stringBuf()
           << "(actual)" << actual
           << " !=  (desired)" << desired
           << ", (info)" <<  info
           << getData);
}


void assertShapeEqual(T1, T2)(T1 actual, T2 desired, string info = "shape mismatch")
{
    assertEqual(actual.shape, desired.shape, info);
}


void assertAllClose(T1, T2)(
    T1 actual,
    T2 desired,
    string msg = "",
    double rtol = 1e-7,
    double atol = 0,
)
{
    import mir.ndslice : zip, reshape;
    import std.math : abs;
    assertShapeEqual(actual, desired);
    int err;
    auto aflat = actual.asSlice.reshape([-1], err);
    auto dflat = desired.asSlice.reshape([-1], err);
    foreach (t; zip(aflat, dflat))
    {
        auto lhs = abs(t[0] - t[1]);
        auto rhs = atol + rtol * abs(t[1]);
        assert(lhs <= rhs,
               stringBuf() << "ASSERT abs(a - b) <= atol + rtol * abs(b): "
               << lhs << " > " << rhs << getData);
    }
}
