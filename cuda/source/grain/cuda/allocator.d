module grain.cuda.allocator;

import grain.tensor : Opt;
import grain.allocator : CPUMallocator;
import grain.cuda.testing : checkCuda;
import grain.dpp.cuda_runtime_api;

struct PinnedMallocator
{
    Opt opt;
    alias opt this;

    enum deviceof = "cpu";
    enum pinned = true;

    /**
    Standard allocator methods per the semantics defined above. The
    $(D deallocate) method is $(D @system) because it
    may move memory around, leaving dangling pointers in user code. Somewhat
    paradoxically, $(D malloc) is $(D @safe) but that's only useful to safe
    programs that can afford to leak memory allocated.
    */
    @trusted @nogc nothrow
    void[] allocate()(size_t bytes)
    {
        import grain.dpp.cuda_runtime_api : cudaMallocHost;

        if (!bytes) return null;

        void* p;
        checkCuda(cudaMallocHost(&p, bytes));
        return p ? p[0 .. bytes] : null;
    }

    /// Ditto
    @system @nogc nothrow
    bool deallocate()(void[] b)
    {
        import grain.dpp.cuda_runtime_api : cudaFreeHost;
        checkCuda(cudaFreeHost(b.ptr));
        return true;
    }

    enum instance =  typeof(this)();
}


/// CUDA heap allocator
struct CuMallocator
{
    Opt opt;
    alias opt this;

    /// device indicator
    enum deviceof = "cuda";
    enum pinned = false;

    ///
    @trusted @nogc nothrow
    void[] allocate()(size_t bytes)
    {
        // import grain.dpp.cuda_driver : cuMemAlloc_v2, CUdeviceptr;
        if (!bytes) return null;

        void* p;
        cudaSetDevice(this.opt.deviceId);
        checkCuda(cudaMalloc(&p, bytes));
        return p ? p[0 .. bytes] : null;
    }

    ///
    @system @nogc nothrow
    bool deallocate()(void[] b)
    {
        cudaSetDevice(this.opt.deviceId);
        checkCuda(cudaFree(b.ptr));
        return true;
    }

    enum instance = CuMallocator();
}


@nogc
unittest
{
    import grain.tensor : Tensor;
    import grain.storage : RCStorage;
    auto x = Tensor!(2, double, RCStorage!CuMallocator)(2, 3);
    static assert(x.deviceof == "cuda");
}


import grain.storage : RCStorage;
import grain.tensor : Tensor;

alias DefaultCuStorage = RCStorage!CuMallocator;
alias cuda = RCStorage!CuMallocator;
alias pinned = RCStorage!PinnedMallocator;
alias CuTensor(size_t dim, T) = Tensor!(dim, T, DefaultCuStorage);
