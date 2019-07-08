module grain.cuda.kernel;

version (grain_cuda):

import grain.storage : RCString;
import grain.cuda.testing : checkNvrtc, checkCuda;
import grain.cuda.dpp.driver;

struct CompileOpt
{
    string[] headerSources;
    string[] headerNames;
    string[] options;
    CUjit_option[] jitOptions;
    void** jitOptionValues;

    int deviceId = 0;

    int numHeaders() const pure nothrow @nogc @safe
    {
        assert(headerSources.length == headerNames.length);
        return cast(int) headerSources.length;
    }

    int numOptions() const pure nothrow @nogc @safe
    {
        return cast(int) options.length;
    }
}

/** compile kernel string (input) to PTX

 TODO type check, better default option

 * \brief   nvrtcCreateProgram creates an instance of nvrtcProgram with the
 *          given input parameters, and sets the output parameter \p prog with
 *          it.
 *
 * \param   [in]  src          CUDA program source.
 * \param   [in]  name         CUDA program name.\n
 *                             \p name can be \c NULL; \c "default_program" is
 *                             used when \p name is \c NULL.
 *
 */
nothrow @nogc
CUmodule compileModule(
    scope const(char)[] src,
    scope const(char)[] name = "",
    CompileOpt opt = CompileOpt.init)
{
    import std.string : fromStringz;
    import core.memory : pureMalloc, pureFree;
    import grain.cuda.dpp.nvrtc;
    import grain.cuda.dpp.driver;

    nvrtcProgram prog;
    auto nh = opt.numHeaders;
    alias P = immutable(char)*;
    auto hss = cast(P*) pureMalloc(P.sizeof * opt.numHeaders);
    scope (exit) pureFree(hss);
    auto hns = cast(P*) pureMalloc(P.sizeof * opt.numHeaders);
    scope (exit) pureFree(hns);
    foreach (i; 0 .. opt.numHeaders)
    {
        hss[i] = opt.headerSources[i].ptr;
        hns[i] = opt.headerNames[i].ptr;
    }
    checkNvrtc(nvrtcCreateProgram(&prog, src.ptr, name.ptr, opt.numHeaders, hss, hns));
    scope (exit) checkNvrtc(nvrtcDestroyProgram(&prog));

    // compile PTX
    auto opts = cast(P*) pureMalloc(P.sizeof * opt.numOptions);
    scope (exit) pureFree(opts);
    foreach (i; 0 .. opt.numOptions)
    {
        opts[i] = opt.options[i].ptr;
    }
    nvrtcResult res = nvrtcCompileProgram(prog, opt.numOptions, opts);

    // dump log
    size_t logSize;
    checkNvrtc(nvrtcGetProgramLogSize(prog, &logSize));
    char *log = cast(char*) pureMalloc(char.sizeof * (logSize + 1));
    log[logSize] = '\0';
    scope (exit) pureFree(log);
    checkNvrtc(res, log[0 .. logSize]);

    // fetch PTX
    size_t ptxSize;
    checkNvrtc(nvrtcGetPTXSize(prog, &ptxSize));
    char *ptx = cast(char*) pureMalloc(char.sizeof * ptxSize);
    scope (exit) pureFree(ptx);
    checkNvrtc(nvrtcGetPTX(prog, ptx));

    // load PTX
    CUmodule m;
    checkCuda(cuModuleLoadDataEx(
        &m, ptx,
        cast(int) opt.jitOptions.length,
        opt.jitOptions.ptr,
        opt.jitOptionValues));
    return m;
}


/// runtime function compiler
/// TODO type check version (pick up d-nv impl)
@nogc nothrow
CUfunction compile(
    scope string name, scope string args, scope string proc,
    CompileOpt opt = CompileOpt.init
) {
    import mir.format : stringBuf, getData;
    enum attr = q{extern "C" __global__ void };
    auto src = stringBuf()
               << attr
               << name << "(" << args << ") {\n"
               << proc
               << "\n}"
               << getData;
    auto m = compileModule(src, name, opt);
    CUfunction kernel;
    checkCuda(cuModuleGetFunction(&kernel, m, name.ptr));
    return kernel;
}

///
@system nothrow
unittest
{
    import grain.testing : assertAllClose;
    import grain.tensor : Tensor;
    import grain.cuda : GPUTensor;
    import grain.random : normal_;
    import grain.ops : copy;

    auto cufun = compile(
        "vectorAdd",
        q{const float *A, const float *B, float *C, int numElements},
        q{
            int i = blockDim.x * blockIdx.x + threadIdx.x;
            if (i < numElements) {
                C[i] = A[i] + B[i];
            }
        });

    scope auto n = 50000;
    auto ha = Tensor!(1, float)(n).normal_;
    auto hb = Tensor!(1, float)(n).normal_;

    auto da = ha.copy!"cuda";
    auto db = hb.copy!"cuda";
    auto dc = GPUTensor!(1, float)(n);

    int threadPerBlock = 256;
    int sharedMemBytes = 0;
    CUstream stream = null;
    auto ps = [da.ptr, db.ptr, dc.ptr];
    scope void*[4] args = [
        cast(void*) &ps[0],
        cast(void*) &ps[1],
        cast(void*) &ps[2],
        cast(void*) &n
    ];
    void*[] config;
    checkCuda(cuLaunchKernel(
        cufun,
        // grid
        threadPerBlock, 1, 1,
        // block
        (n + threadPerBlock - 1) / threadPerBlock, 1, 1,
        sharedMemBytes, stream, args.ptr, config.ptr));

    auto hc = dc.copy!"cpu";
    assertAllClose(ha.asSlice + hb.asSlice, hc.asSlice);
}
