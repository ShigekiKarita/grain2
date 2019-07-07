/// CUDA Storage module
module grain.cuda.storage;

import mir.rc : RCArray;

import grain.cuda.dpp.driver;
import grain.cuda.testing;

/// fat pointer in CUDA
struct CuArray(T) {
    CUdeviceptr cuptr = 0;
    const size_t length = 0;

    @disable this(this); // not copyable
    @disable new(size_t); // not allocatable on heap

    /// create uninitialized T.sizeof * n array in device
    this(size_t n)
    {
        this.length = n;
        if (n > 0)
        {
            checkCuda(cuMemAlloc_v2(&this.cuptr, T.sizeof * this.length));
        }
    }

    /// create fat pointer from raw pointer and its length
    this(CUdeviceptr p, size_t l)
    {
        this.cuptr = p;
        this.length = l;
    }

    /// dtor calling cuMemFree
    ~this()
    {
        checkCuda(cuMemFree_v2(this.cuptr));
    }

    T* ptr() inout
    {
        return cast(T*) this.cuptr;
    }

    /// duplicate cuda memory (deep copy)
    CuArray!T dup() const
    {
        CUdeviceptr ret;
        if (this.length > 0)
        {
            checkCuda(cuMemAlloc_v2(&ret, T.sizeof * this.length));
            checkCuda(cuMemcpyDtoD_v2(ret, this.cuptr, T.sizeof * this.length));
        }
        return CuArray!T(ret, this.length);
    }

    ref fromHost(const T[] host)
    {
        assert(host.length == this.length);
        checkCuda(cuMemcpyHtoD_v2(this.cuptr, &host[0], T.sizeof * this.length));
        return this;
    }

    RCArray!T toHost() const
    {
        auto ret = RCArray!T(this.length);
        checkCuda(cuMemcpyDtoH_v2(&ret[0], this.cuptr, T.sizeof * this.length));
        return ret;
        
    }
}

struct RCCuArray(T)
{
    import mir.rc.ptr : RCPtr, createRC;

    RCPtr!(CuArray!T) data;
    alias data this;

    this(size_t n)
    {
        this.data = createRC!(CuArray!T)(n);
    }
}


/// create copy of host array into device
RCCuArray!T fromHost(T)(const T[] host)
{
    auto ret = typeof(return)(host.length);
    ret.fromHost(host);
    return ret;
}


version (grain_cuda) @system @nogc
unittest
{
    import mir.ndslice.topology : iota;

    auto h = RCArray!int(3);
    h[0] = 0;
    h[1] = 1;
    h[2] = 2;
    auto p1 = RCCuArray!int(h.length);
    p1.fromHost(h[]);
    auto p2 = p1.dup;
    assert(p1.ptr != p2.ptr);
    assert(p2.toHost.asSlice == h.asSlice);
}
