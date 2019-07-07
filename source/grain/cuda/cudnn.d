/// High-level wrapper of cudnn library
module grain.cuda.cudnn;

import grain.tensor : Tensor;
import grain.cuda.dpp.cudnn;
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
    import grain.cuda.dpp.driver : CUdeviceptr;

    cudnnTensorDescriptor_t desc;
    CUdeviceptr ptr;
    alias desc this;

    /// no copy
    @disable this(this);
    /// no allocation on heap
    @disable new(size_t);

    ~this()
    {
        checkCudnn( cudnnDestroyTensorDescriptor(desc) );
    }
}

/// convert variable to cudnn tensor discriptor object
auto makeCudnnTensor(T, size_t dim, Storage)(Tensor!(T, dim, Storage) x)
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
        }
        // shape[0..dim] = x.shape;
        strides[0..dim] = x.strides;
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
    tdesc.ptr = x.data.ptr;
    checkCUDNN(cudnnCreateTensorDescriptor(&tdesc.desc));
    checkCUDNN(cudnnSetTensorNdDescriptor(
        tdesc.desc,
        cudnnDataType!T,
        ddim,
        shape.ptr,
        strides.ptr));
    return tdesc;
}


/// copy src to dst with broadcasting
void transform(T, size_t dim, Storage)(
    Tensor!(T, dim, Storage) src,
    ref Tensor!(T, dim, Storage) dst,
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
