/// Test functions for CUDA
module grain.cuda.testing;

import std.string : fromStringz;

import derelict.cuda;
import mir.format : stringBuf, getData;

import grain.cuda.cublas;
import grain.cuda.cudnn;


/// cublas error checker
@nogc
void checkCublas(cublasStatus_t err)
{
    assert(err == CUBLAS_STATUS_SUCCESS, cublasGetErrorEnum(err));
}


/// cudnn error checker
@nogc
void checkCudnn(
    string func = __FUNCTION__,
    string file = __FILE__,
    size_t line = __LINE__
)(cudnnStatus_t err)
{
    assert(
        err == CUDNN_STATUS_SUCCESS,
        stringBuf()
        << cudnnGetErrorString(err).fromStringz
        << " (file) " << file << " (line) " << line
        << getData);
}


/// cuda error checker
@nogc
void checkCuda(
    string file = __FILE__,
    size_t line = __LINE__,
    string func = __FUNCTION__
)(CUresult err)
{
    const(char)* name, content;
    cuGetErrorName(err, &name);
    cuGetErrorString(err, &content);
    assert(err == CUDA_SUCCESS,
           stringBuf()
           << name.fromStringz
           << " (info) " << content.fromStringz
           << " (func) " << func
           << " (file) " << file
           << " (line) " << line
           << getData);
}
