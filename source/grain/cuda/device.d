/// CUdevice wrapper
module grain.cuda.device;

version (grain_cuda):

import grain.cuda.testing : checkCuda;
import grain.cuda.dpp.runtime_api;

@nogc nothrow:

struct CuDevice
{
    @nogc nothrow:
    cudaStream_t stream = null;

    static CuDevice* devicesPtr;
    static int devicesLength;

    static this()
    {
        import core.stdc.stdio : printf;

        scope (exit) cudaSetDevice(0);
        
        // init cuda devices
        checkCuda(cudaGetDeviceCount(&devicesLength));
        version (grain_debug)
        {
            printf("[grain_debug,info]: device count %d\n", devicesLength);
        }
        import core.memory : pureMalloc;
        devicesPtr = cast(CuDevice*) pureMalloc(CuDevice.sizeof * devicesLength);
        CuDevice.devices[] = CuDevice.init;

        // init P2P
        foreach (i; 0 .. count)
        {
            cudaSetDevice(i);
            foreach (j; 0 .. count)
            {
                if (i == j) continue;
                int ok = 0;
                checkCuda(cudaDeviceCanAccessPeer(&ok, i, j));
                if (!ok)
                {
                    version (grain_debug)
                    {
                        printf("[grain_debug,warn]: no GPU P2P: %d -> %d\n", i, j);
                    }
                    continue;
                }
                cudaDeviceEnablePeerAccess(j, 0);
            }
        }
    }

    static ~this()
    {
        import core.memory : pureFree;
        pureFree(devicesPtr);
        devicesPtr = null;
    }
    
    static count()
    {
        return devicesLength;
    }
    
    static CuDevice[] devices()
    {
        return devicesPtr[0 .. devicesLength];
    }
    
    static get(int index)
    {
        assert(index >= 0);
        checkCuda(cudaSetDevice(index));
        auto dev = devices[index];
        if (dev.stream is null)
        {
            checkCuda(cudaStreamCreateWithFlags(&dev.stream, cudaStreamNonBlocking));
        }
        return dev;
    }
}
