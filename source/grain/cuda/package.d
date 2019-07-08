/// CUDA module
module grain.cuda;
version(grain_cuda):

public import grain.cuda.dpp.driver;
public import grain.cuda.dpp.cublas;
public import grain.cuda.dpp.cudnn;

public import grain.cuda.allocator;
public import grain.cuda.cudnn;
public import grain.cuda.testing;


// TODO: support multiple GPU devices (context)
__gshared CUcontext context;
__gshared cublasHandle_t cublasHandle;
__gshared cudnnHandle_t cudnnHandle;


/// global cuda init
@nogc shared static this()
{
    // Initialize the driver API
    CUdevice device;
    cuInit(0);
    // Get a handle to the first compute device
    cuDeviceGet(&device, 0);
    // Create a compute device context
    cuCtxCreate_v2(&context, 0, device);


    // init CUDA libraries
    checkCublas(cublasCreate_v2(&cublasHandle));
    checkCudnn( cudnnCreate(&cudnnHandle) );
}


/// global cuda exit
@nogc shared static ~this()
{
    cublasDestroy_v2(cublasHandle);
    checkCudnn( cudnnDestroy(cudnnHandle) );
    checkCuda(cuCtxDestroy_v2(context));
}
