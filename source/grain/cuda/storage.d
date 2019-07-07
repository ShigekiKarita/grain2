/// CUDA Storage module
module grain.cuda.storage;

import grain.cuda.dpp.driver;
import grain.cuda.testing;


/// fat pointer in CUDA
struct CuPtr(T) {
    CUdeviceptr ptr = 0;
    const size_t length = 0;

    /// create copy of host array into device
    this(T[] host) {
        this(host.length);
        checkCuda(cuMemcpyHtoD_v2(ptr, &host[0], T.sizeof * length));
    }

    @disable this(this); // not copyable
    @disable new(size_t); // not allocatable on heap

    /// create uninitialized T.sizeof * n array in device
    this(size_t n) {
        this.length = n;
        if (n > 0) {
            checkCuda(cuMemAlloc_v2(&this.ptr, T.sizeof * this.length));
        }
    }

    /// create fat pointer from raw pointer and its length
    this(CUdeviceptr p, size_t l) {
        this.ptr = p;
        this.length = l;
    }

    /// dtor calling cuMemFree
    ~this() {
        if (ptr != 0x0) checkCuda(cuMemFree_v2(ptr));
        ptr = 0x0;
    }

    inout T* data() {
        return cast(T*) this.ptr;
    }
}


/// duplicate cuda memory (deep copy)
auto dup(M)(ref M m) if (isDeviceMemory!M) {
    CUdeviceptr ret;
    alias T = CudaElementType!M;
    if (m.length > 0) {
        checkCuda(cuMemAlloc(&ret, T.sizeof * m.length));
        checkCuda(cuMemcpyDtoD(ret, m.ptr, T.sizeof * m.length));
    }
    return CuPtr!T(ret, m.length);
}


version (grain_cuda) @system @nogc
unittest
{
    auto cp = CuPtr!double(3);
}
