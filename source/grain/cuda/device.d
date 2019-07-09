/// CUdevice wrapper
module grain.cuda.device;

version (grain_cuda):

struct CuDevice
{
    import grain.cuda.dpp.runtime_api;

    cudaStream_t stream = null;

    enum maxDevice = 32;
    static CuDevice[maxDevice] devices;
    
    static get(int index)
    {
        assert(index >= 0);
        cudaSetDevice(index);
        auto dev = devices[index];
        if (dev.stream is null)
        {
            cudaStreamCreate(&dev.stream);
        }
        return dev;
    }
}
