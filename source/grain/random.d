module grain.random;

import mir.random : Random;

/// thread global random number generator (rng)
__gshared Random rng = void;

shared static this()
{
    import mir.random : unpredictableSeed;
    rng = Random(unpredictableSeed);
}

/// set seed for random number generator
void setSeed(uint i)
{
    synchronized
    {
        rng = Random(i);
    }
}

///
unittest
{
    import mir.ndslice : each;
    import mir.random.variable: NormalVariable;
    auto rv = NormalVariable!double(0, 1);
    setSeed(0);
    auto a = rv(rng);
    auto b = rv(rng);
    assert(a != b);
    setSeed(0);
    auto a2 = rv(rng);
    assert(a == a2);
}
