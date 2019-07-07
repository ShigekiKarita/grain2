/// High-level wrapper of cudnn library
module grain.cuda.cudnn;

version (grain_cuda):

import grain.tensor : Tensor;
import grain.cuda.dpp.cudnn;
import grain.cuda.dpp.driver : CUdeviceptr;
import grain.cuda.testing;


// TODO make shared
__gshared bool deterministic = false;
__gshared bool nanProp = true;

/// return global cudnn option
auto isDeterministic()
{
    return deterministic ? CUDNN_DETERMINISTIC : CUDNN_NON_DETERMINISTIC;
}

/// ditto
auto isNanProp()
{
    return nanProp ? CUDNN_PROPAGATE_NAN : CUDNN_NOT_PROPAGATE_NAN;
}


/// convert floating point types (float, double) into cudnn enum
template cudnnDataType(T)
{
    // TODO support half
    static if(is(T == float))
        alias cudnnDataType = CUDNN_DATA_FLOAT;
    else static if(is(T == double))
        alias cudnnDataType = CUDNN_DATA_DOUBLE;
    else
        static assert(false, "unsupported type");
}

/// cudnn data type of variable like struct
struct TensorDesc
{
    cudnnTensorDescriptor_t desc;
    CUdeviceptr ptr;
    alias desc this;

    /// no copy
    @disable this(this);
    /// no allocation on heap
    @disable new(size_t);

    @nogc ~this()
    {
        checkCudnn( cudnnDestroyTensorDescriptor(desc) );
    }
}

/// convert variable to cudnn tensor discriptor object
auto makeCudnnTensor(T, size_t dim, Storage)(Tensor!(dim, T, Storage) x)
{
    static assert(Storage.deviceof == "cuda");
    static assert(dim < CUDNN_DIM_MAX);
    static if (dim < 4)
    {
        enum int ddim = 4;
        int[ddim] shape;
        int[ddim] strides;
        shape[] = 1;
        strides[] = 1;
        foreach (d; 0 .. dim)
        {
            assert(x.shape[d] < int.max);
            shape[d] = cast(int) x.shape[d];
            strides[d] = cast(int) x.strides[d];
        }
    } else {
        enum int ddim = cast(int) dim;
        int[ddim] shape;
        foreach (d; 0 .. dim) {
            assert(x.shape[d] < int.max);
            shape[d] = cast(int) x.shape[d];
        }
        auto strides = x.strides;
    }

    TensorDesc tdesc;
    tdesc.ptr = cast(CUdeviceptr)  x.iterator.lightScope;
    checkCudnn(cudnnCreateTensorDescriptor(&tdesc.desc));
    checkCudnn(cudnnSetTensorNdDescriptor(
        tdesc.desc,
        cudnnDataType!T,
        ddim,
        shape.ptr,
        strides.ptr));
    return tdesc;
}

@nogc
unittest
{
    import grain.cuda.allocator : GPUTensor;
    import grain.functions : transposed;
    auto x = GPUTensor!(3, float)(2, 3, 4).transposed;
    auto t = x.makeCudnnTensor;

    cudnnDataType_t dtype;
    int dim;
    int[3] shape;
    int[3] strides;
    import grain.testing;
    cudnnGetTensorNdDescriptor(t.desc, 3, &dtype, &dim, shape.ptr, strides.ptr);
    assert(dtype == CUDNN_DATA_FLOAT);
    assertEqual(dim, 4, "dim < 4 will be 4");
    assert(shape == x.shape);
    assert(strides == x.strides);
}

/// copy src to dst with broadcasting
void transform(T, size_t dim, Storage)(
    Tensor!(dim,  T, Storage) src,
    ref Tensor!(dim, T, Storage) dst,
    T alpha=1,
    T beta=0
)
{
    static assert(Storage.deviceof == "cuda");
    assert(src.shape == dst.shape);
    checkCUDNN(
        cudnnTransformTensor(
            cudnnHandle,
            cast(const void*) &alpha, src.makeCudnnTensor, cast(const void*) src.data.ptr,
            cast(const void*) &beta, dst.makeCudnnTensor, cast(void*) dst.data.ptr
            ) );
}
