module grain.cuda;

import derelict.cuda;

import grain.cuda.cublas;
import grain.cuda.cudnn;
import grain.cuda.testing;

// TODO: support multiple GPU devices (context)
__gshared CUcontext context;
__gshared cublasHandle_t cublasHandle;
__gshared cudnnHandle_t cudnnHandle;


/// global cuda init
shared static this() {
    // Initialize the driver API
    DerelictCUDADriver.load();
    CUdevice device;
    cuInit(0);
    // Get a handle to the first compute device
    cuDeviceGet(&device, 0);
    // Create a compute device context
    cuCtxCreate(&context, 0, device);


    // init CUDA libraries
    checkCublas(cublasCreate_v2(&cublasHandle));
    DerelictCuDNN7.load();
    checkCudnn( cudnnCreate(&cudnnHandle) );
}

/// global cuda exit
shared static ~this() {
    import core.memory : GC;
    GC.collect();
    cublasDestroy_v2(cublasHandle);
    checkCudnn( cudnnDestroy(cudnnHandle) );
    checkCuda(cuCtxDestroy(context));
}
