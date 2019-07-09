module grain.testing;

import mir.format : stringBuf, getData;

/// assert all elements are equal
void assertEqual(
    T1, T2,
    string file = __FILE__,
    size_t line = __LINE__,
    string func = __FUNCTION__
)(T1 actual, T2 desired, string info = "none")
{
    assert(actual == desired,
           stringBuf()
           << "(actual) " << actual
           << " != (desired) " << desired
           << ", (info) " <<  info
           << " (func) " << func
           << " (file) " << file
           << " (line) " << line
           << getData);
}


void assertShapeEqual(
    T1, T2,
    string file = __FILE__,
    size_t line = __LINE__,
    string func = __FUNCTION__
)(T1 actual, T2 desired, string info = "shape mismatch")
{
    assert(actual.shape == desired.shape,
           stringBuf()
           << "(actual) " << actual.shape
           << " != (desired) " << desired.shape
           << ", (info) " <<  info
           << " (func) " << func
           << " (file) " << file
           << " (line) " << line
           << getData);
}


/// assert tensor elements are all close
void assertAllClose(
    T1, T2,
    string file = __FILE__,
    size_t line = __LINE__,
    string func = __FUNCTION__
)(
    T1 actual,
    T2 desired,
    string msg = "",
    double rtol = 1e-7,
    double atol = 0,
)
{
    import grain.tensor : isTensor;
    import mir.ndslice : zip, reshape;
    import std.math : abs;
    assertShapeEqual(actual, desired);
    int err;
    static if (isTensor!T1)
        auto a = actual.asSlice;
    else
        auto a = actual;
    static if (isTensor!T2)
        auto d = desired.asSlice;
    else
        auto d = desired;
    
    auto aflat = a.reshape([-1], err);
    auto dflat = d.reshape([-1], err);
    foreach (t; zip(aflat, dflat))
    {
        auto lhs = abs(t[0] - t[1]);
        auto rhs = atol + rtol * abs(t[1]);
        assert(lhs <= rhs,
               stringBuf() << "ASSERT abs(a - b) <= atol + rtol * abs(b): "
               << lhs << " > " << rhs
               << " (func) " << func
               << " (file) " << file
               << " (line) " << line              
               << getData);
    }
}
