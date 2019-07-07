module grain.cuda.kernel;

/+
/// cuda module compiled from ptx string
struct CuModule {
    CUmodule cuModule;

    ///
    this(string ptxstr) {
        // JIT compile a null-terminated PTX string
        checkCudaErrors(cuModuleLoadData(&cuModule, cast(void*) ptxstr.toStringz));
    }

    ///
    ~this() {
        checkCudaErrors(cuModuleUnload(cuModule));
    }

    ///
    auto kernel(alias F)() {
        return Kernel!F(cuModule);
    }
}

/// global accessor for the cuda module in grain
class Global {
    import K = grain.kernel;
    private this() {}

    // Cache instantiation flag in thread-local bool
    // Thread local
    private static bool instantiated_ = false, cxxInstantiated_ = false;

    // Thread global
    private __gshared CuModule* module_, cxxModule_;

    ///
    static get() {
        if (!instantiated_) {
            synchronized(Global.classinfo) {
                module_ = new CuModule(K.cxxptx);
                instantiated_ = true;
            }
        }
        return module_;
    }

    ///
    static getCxx() {
        if (!cxxInstantiated_) {
            synchronized(Global.classinfo) {
                cxxModule_ = new CuModule(K.cxxptx);
                cxxInstantiated_ = true;
            }
        }
        return cxxModule_;
    }

    ///
    static cxxKernel(T...)(string name, T args) {
        CUfunction cuFunction;
        writeln("getFunction...");
        checkCudaErrors(cuModuleGetFunction(&cuFunction, getCxx(), name.toStringz));
        writeln("getFunction...");
        return Launcher!T(cuFunction, args);
    }

    ///
    static kernel(alias F)() {
        return get().kernel!F;
    }
}

/// ditto
auto global() {
    return Global.get();
}

// pthread error ?
// auto CUDA_POST_KERNEL_CHECK() {
//     checkCudaErrors(cudaPeekAtLastError());
// }

/// cuda kernel function launcher with runtime numbers of blocks/threads
struct Launcher(Args...) {
    CUfunction cuFunction;
    Args args;

    /// create kernel function as void[Args.length]
    auto kernelParams(T...)(T args) {
        void*[args.length] ret;
        foreach (i, a; args) {
            ret[i] = &a;
        }
        return ret;
    }

    /// detailed launch function
    void launch(uint[3] grid, uint[3] block, uint sharedMemBytes=0, CUstream stream=null) {
        checkCudaErrors(cuLaunchKernel(
                            cuFunction,
                            grid[0], grid[1], grid[2],
                            block[0], block[1], block[2],
                            sharedMemBytes, stream,
                            kernelParams(args).ptr, null));
        // CUDA_POST_KERNEL_CHECK();
    }

    // TODO __CUDA_ARCH__ < 200 512
    enum CUDA_NUM_THREADS = 1024;

    static getBlocks(uint n) {
        return (n + CUDA_NUM_THREADS - 1) / CUDA_NUM_THREADS;
    }

    /// convinient launch function
    void launch(uint n=1, uint sharedMemBytes=0, CUstream stream=null) {
        checkCudaErrors(cuLaunchKernel(
                            cuFunction,
                            getBlocks(n), 1, 1,
                            CUDA_NUM_THREADS, 1, 1,
                            sharedMemBytes, stream,
                            kernelParams(args).ptr, null));
        // CUDA_POST_KERNEL_CHECK();
    }
}


/// cuda function object called by mangled name of C++ D device function F
struct Kernel(alias F) if (is(ReturnType!F == void)) {
    // enum name = __traits(identifier, F);
    enum name = F.mangleof;
    CUfunction cuFunction;

    ///
    this(CUmodule m) {
        // writeln("mangled: ", name);
        checkCudaErrors(cuModuleGetFunction(&cuFunction, m, name.toStringz));
    }

    // TODO: compile-time type check like d-nv
    // TODO: separate this to struct Launcher
    auto call(T...)(T args) {
        static assert(args.length == arity!F);
        // Kernel launch
        // checkCudaErrors(cuCtxSynchronize());
        return Launcher!T(cuFunction, args);
    }
}


/// example to launch kernel
unittest {
    import grain.kernel; // : saxpy;

    // Populate input
    uint n = 16;
    auto hostA = new float[n];
    auto hostB = new float[n];
    auto hostC = new float[n];
    foreach (i; 0 .. n) {
        hostA[i] = i;
        hostB[i] = 2 * i;
        hostC[i] = 0;
    }

    // Device data
    auto devA = CuPtr!float(hostA);
    auto devB = CuPtr!float(hostB);
    auto devC = CuPtr!float(n);

    // Kernel launch
    Global.kernel!(saxpy).call(devC.ptr, devA.ptr, devB.ptr, n).launch(n);

    // Validation
    devC.toHost(hostC);
    foreach (i; 0 .. n) {
        // writefln!"%f + %f = %f"(hostA[i], hostB[i], hostC[i]);
        assert(hostA[i] + hostB[i] == hostC[i]);
    }
}


float sumNaive(S)(ref S a) if (isDeviceMemory!S) {
    import grain.kernel : sum;
    auto b = CuPtr!float([0]);
    auto N = cast(int) a.length;
    Global.kernel!sum.call(a.ptr, b.ptr, N)
        .launch(cast(uint[3]) [1U,1,1], cast(uint[3]) [1U,1,1], 0U);
    checkCudaErrors(cuCtxSynchronize());
    return b.toHost[0];
}

unittest {
    auto a = CuPtr!float([3, 4, 5]);
    assert(a.sumNaive == 3+4+5);
}



extern (C++) float sum_thrust(float*, uint n);

/// test sum
float sum(S)(ref S a) if (isDeviceMemory!S) {
    return sum_thrust(cast(float*) a.ptr, cast(uint) a.length);
}

unittest {
    auto a = CuPtr!float([2, 4, 5, 6]);
    auto b = sum(a);
    assert(b == 2+4+5+6);
}

// // test cxx kernel
// unittest {
//     auto a = CuPtr!float([3, 4, 5]);
//     auto b = CuPtr!float([0]);
//     auto N = cast(int) a.length;
//     assert(N == 3);
//     Global.cxxKernel("sum_naive", a.ptr, b.ptr, N)
//         .launch(cast(uint[3]) [1U,1,1], cast(uint[3]) [1U,1,1], 0U);
//     // checkCudaErrors(cuCtxSynchronize());
//     writeln(b.toHost());
//     assert(b.toHost()[0] == 3+4+5);
// }

/// example to fill value
unittest {
    auto d = CuPtr!float(3);
    d.zero_();
    auto h = d.toHost();
    assert(h == [0, 0, 0]);
    // assert(zeros!(CuPtr!float)(3).toHost() == [0, 0, 0]);
    assert(d.fill_(3).toHost() == [3, 3, 3]);
}


/// high-level axpy (y = alpha * x + y) wrapper for CuPtr
void axpy(T)(const ref CuArray!T x, ref CuArray!T y, T alpha=1, int incx=1, int incy=1)  {
    static if (is(T == float)) {
        alias axpy_ = cublasSaxpy_v2;
    } else static if (is(T == double)) {
        alias axpy_ = cublasDaxpy_v2;
    } else {
        static assert(false, "unsupported type: " ~ T.stringof);
    }
    auto status = axpy_(cublasHandle, cast(int) x.length, &alpha,
                        cast(const T*) x.ptr, incx,
                        cast(T*) y.ptr, incy);
    assert(status == CUBLAS_STATUS_SUCCESS, cublasGetErrorEnum(status));
}

/// cublas tests
unittest {
    auto a = CuArray!float([3, 4, 5]);
    auto b = CuArray!float([1, 2, 3]);
    axpy(a, b, 2.0);
    assert(a.toHost() == [3, 4, 5]);
    assert(b.toHost() == [7, 10, 13]);
}

+/
