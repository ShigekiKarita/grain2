/// Test functions for CUDA
module grain.cuda.testing;

import std.string : fromStringz;

import mir.format : stringBuf, getData;

import grain.cuda.dpp.driver;
import grain.cuda.dpp.cublas;
import grain.cuda.dpp.cudnn;


/// emit error message string from enum
auto cublasGetErrorEnum()(cublasStatus_t error) {
    switch (error) {
    case CUBLAS_STATUS_SUCCESS:
        return "CUBLAS_STATUS_SUCCESS";

    case CUBLAS_STATUS_NOT_INITIALIZED:
        return "CUBLAS_STATUS_NOT_INITIALIZED";

    case CUBLAS_STATUS_ALLOC_FAILED:
        return "CUBLAS_STATUS_ALLOC_FAILED";

    case CUBLAS_STATUS_INVALID_VALUE:
        return "CUBLAS_STATUS_INVALID_VALUE";

    case CUBLAS_STATUS_ARCH_MISMATCH:
        return "CUBLAS_STATUS_ARCH_MISMATCH";

    case CUBLAS_STATUS_MAPPING_ERROR:
        return "CUBLAS_STATUS_MAPPING_ERROR";

    case CUBLAS_STATUS_EXECUTION_FAILED:
        return "CUBLAS_STATUS_EXECUTION_FAILED";

    case CUBLAS_STATUS_INTERNAL_ERROR:
        return "CUBLAS_STATUS_INTERNAL_ERROR";
    default:
        return "CUBLAS UNKNOWN ERROR";
    }
}

/// cublas error checker
@nogc
void checkCublas(
    string func = __FUNCTION__,
    string file = __FILE__,
    size_t line = __LINE__
)(cublasStatus_t err)
{
    assert(
        err == CUBLAS_STATUS_SUCCESS,
        stringBuf()
        << cublasGetErrorEnum(err)
        << " (func) " << func
        << " (file) " << file
        << " (line) " << line
        << getData);
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
        << " (func) " << func
        << " (file) " << file
        << " (line) " << line
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
    if (err == CUDA_SUCCESS) return;
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
