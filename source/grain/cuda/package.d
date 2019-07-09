/// CUDA module
module grain.cuda;
version(grain_cuda):

import grain.cuda.dpp.cublas : cublasHandle_t, cublasCreate_v2, cublasDestroy_v2;
import grain.cuda.dpp.cudnn : cudnnHandle_t, cudnnCreate, cudnnDestroy;

public import grain.cuda.allocator;
public import grain.cuda.cudnn;
public import grain.cuda.testing;

__gshared cublasHandle_t cublasHandle;
__gshared cudnnHandle_t cudnnHandle;


/// global cuda init
@nogc shared static this()
{
    // init CUDA libraries
    checkCublas(cublasCreate_v2(&cublasHandle));
    checkCudnn( cudnnCreate(&cudnnHandle) );
}


/// global cuda exit
@nogc shared static ~this()
{
    cublasDestroy_v2(cublasHandle);
    checkCudnn( cudnnDestroy(cudnnHandle) );
}
