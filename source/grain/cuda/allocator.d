module grain.cuda.allocator;

import stdx.allocator.common;
import grain.cuda.testing : checkCuda;

version (grain_cuda):

/// CUDA heap allocator
struct CuMallocator
{
    /// device indicator
    enum deviceof = "cuda";
    
    /**
    In CUDA, the alignment requirement is automatically fulfilled for the built-in types of
    char, short, int, long, longlong, float, double like float2 or float4. 

    See also:
        https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#device-memory-accesses
    */
    enum uint alignment = platformAlignment;

    /**
    Standard allocator methods per the semantics defined above. The
    $(D deallocate) method is $(D @system) because it
    may move memory around, leaving dangling pointers in user code. Somewhat
    paradoxically, $(D malloc) is $(D @safe) but that's only useful to safe
    programs that can afford to leak memory allocated.
    */
    @trusted @nogc nothrow
    static void[] allocate()(size_t bytes)
    {
        import grain.cuda.dpp.driver : cuMemAlloc_v2, CUdeviceptr;
        if (!bytes) return null;

        CUdeviceptr c;
        checkCuda(cuMemAlloc_v2(&c, bytes));
        auto p = cast(void*) c;
        return p ? p[0 .. bytes] : null;
    }

    /// Ditto
    @system @nogc nothrow
    static bool deallocate()(void[] b)
    {
        import grain.cuda.dpp.driver : cuMemFree_v2, CUdeviceptr;
        checkCuda(cuMemFree_v2(cast(CUdeviceptr) b.ptr));
        return true;
    }

    enum CuMallocator instance = CuMallocator();
}


@nogc
unittest
{
    import grain.tensor : Tensor;
    import grain.storage : RCStorage;
    auto x = Tensor!(2, double, RCStorage!CuMallocator)(2, 3);
    static assert(x.deviceof == "cuda");
}
