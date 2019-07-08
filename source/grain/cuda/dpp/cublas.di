module grain.cuda.dpp.cublas;


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    struct dim3
    {
        uint x;
        uint y;
        uint z;
    }
    struct double4
    {
        double x;
        double y;
        double z;
        double w;
    }
    struct double3
    {
        double x;
        double y;
        double z;
    }
    struct double2
    {
        double x;
        double y;
    }
    struct double1
    {
        double x;
    }
    struct ulonglong4
    {
        ulong x;
        ulong y;
        ulong z;
        ulong w;
    }
    struct longlong4
    {
        long x;
        long y;
        long z;
        long w;
    }
    struct ulonglong3
    {
        ulong x;
        ulong y;
        ulong z;
    }
    struct longlong3
    {
        long x;
        long y;
        long z;
    }
    struct ulonglong2
    {
        ulong x;
        ulong y;
    }
    struct longlong2
    {
        long x;
        long y;
    }
    struct ulonglong1
    {
        ulong x;
    }
    struct longlong1
    {
        long x;
    }
    struct float4
    {
        float x;
        float y;
        float z;
        float w;
    }
    struct float3
    {
        float x;
        float y;
        float z;
    }
    struct float2
    {
        float x;
        float y;
    }
    struct float1
    {
        float x;
    }
    struct ulong4
    {
        c_ulong x;
        c_ulong y;
        c_ulong z;
        c_ulong w;
    }
    struct long4
    {
        c_long x;
        c_long y;
        c_long z;
        c_long w;
    }
    struct ulong3
    {
        c_ulong x;
        c_ulong y;
        c_ulong z;
    }
    struct long3
    {
        c_long x;
        c_long y;
        c_long z;
    }
    struct ulong2
    {
        c_ulong x;
        c_ulong y;
    }
    struct long2
    {
        c_long x;
        c_long y;
    }
    struct ulong1
    {
        c_ulong x;
    }
    struct long1
    {
        c_long x;
    }
    struct uint4
    {
        uint x;
        uint y;
        uint z;
        uint w;
    }
    struct int4
    {
        int x;
        int y;
        int z;
        int w;
    }
    struct uint3
    {
        uint x;
        uint y;
        uint z;
    }
    struct int3
    {
        int x;
        int y;
        int z;
    }
    struct uint2
    {
        uint x;
        uint y;
    }
    struct int2
    {
        int x;
        int y;
    }
    struct uint1
    {
        uint x;
    }
    struct int1
    {
        int x;
    }
    struct ushort4
    {
        ushort x;
        ushort y;
        ushort z;
        ushort w;
    }
    struct short4
    {
        short x;
        short y;
        short z;
        short w;
    }
    struct ushort3
    {
        ushort x;
        ushort y;
        ushort z;
    }
    struct short3
    {
        short x;
        short y;
        short z;
    }
    struct ushort2
    {
        ushort x;
        ushort y;
    }
    struct short2
    {
        short x;
        short y;
    }
    struct ushort1
    {
        ushort x;
    }
    struct short1
    {
        short x;
    }
    struct uchar4
    {
        ubyte x;
        ubyte y;
        ubyte z;
        ubyte w;
    }
    struct char4
    {
        byte x;
        byte y;
        byte z;
        byte w;
    }
    struct uchar3
    {
        ubyte x;
        ubyte y;
        ubyte z;
    }
    struct char3
    {
        byte x;
        byte y;
        byte z;
    }
    struct uchar2
    {
        ubyte x;
        ubyte y;
    }
    struct char2
    {
        byte x;
        byte y;
    }
    struct uchar1
    {
        ubyte x;
    }
    struct char1
    {
        byte x;
    }
    enum libraryPropertyType_t
    {
        MAJOR_VERSION = 0,
        MINOR_VERSION = 1,
        PATCH_LEVEL = 2,
    }
    enum MAJOR_VERSION = libraryPropertyType_t.MAJOR_VERSION;
    enum MINOR_VERSION = libraryPropertyType_t.MINOR_VERSION;
    enum PATCH_LEVEL = libraryPropertyType_t.PATCH_LEVEL;
    alias libraryPropertyType = libraryPropertyType_t;
    enum cudaDataType_t
    {
        CUDA_R_16F = 2,
        CUDA_C_16F = 6,
        CUDA_R_32F = 0,
        CUDA_C_32F = 4,
        CUDA_R_64F = 1,
        CUDA_C_64F = 5,
        CUDA_R_8I = 3,
        CUDA_C_8I = 7,
        CUDA_R_8U = 8,
        CUDA_C_8U = 9,
        CUDA_R_32I = 10,
        CUDA_C_32I = 11,
        CUDA_R_32U = 12,
        CUDA_C_32U = 13,
    }
    enum CUDA_R_16F = cudaDataType_t.CUDA_R_16F;
    enum CUDA_C_16F = cudaDataType_t.CUDA_C_16F;
    enum CUDA_R_32F = cudaDataType_t.CUDA_R_32F;
    enum CUDA_C_32F = cudaDataType_t.CUDA_C_32F;
    enum CUDA_R_64F = cudaDataType_t.CUDA_R_64F;
    enum CUDA_C_64F = cudaDataType_t.CUDA_C_64F;
    enum CUDA_R_8I = cudaDataType_t.CUDA_R_8I;
    enum CUDA_C_8I = cudaDataType_t.CUDA_C_8I;
    enum CUDA_R_8U = cudaDataType_t.CUDA_R_8U;
    enum CUDA_C_8U = cudaDataType_t.CUDA_C_8U;
    enum CUDA_R_32I = cudaDataType_t.CUDA_R_32I;
    enum CUDA_C_32I = cudaDataType_t.CUDA_C_32I;
    enum CUDA_R_32U = cudaDataType_t.CUDA_R_32U;
    enum CUDA_C_32U = cudaDataType_t.CUDA_C_32U;
    alias cudaDataType = cudaDataType_t;
    struct CUgraphExec_st;
    alias cudaGraphExec_t = CUgraphExec_st*;
    enum cudaGraphNodeType
    {
        cudaGraphNodeTypeKernel = 0,
        cudaGraphNodeTypeMemcpy = 1,
        cudaGraphNodeTypeMemset = 2,
        cudaGraphNodeTypeHost = 3,
        cudaGraphNodeTypeGraph = 4,
        cudaGraphNodeTypeEmpty = 5,
        cudaGraphNodeTypeCount = 6,
    }
    enum cudaGraphNodeTypeKernel = cudaGraphNodeType.cudaGraphNodeTypeKernel;
    enum cudaGraphNodeTypeMemcpy = cudaGraphNodeType.cudaGraphNodeTypeMemcpy;
    enum cudaGraphNodeTypeMemset = cudaGraphNodeType.cudaGraphNodeTypeMemset;
    enum cudaGraphNodeTypeHost = cudaGraphNodeType.cudaGraphNodeTypeHost;
    enum cudaGraphNodeTypeGraph = cudaGraphNodeType.cudaGraphNodeTypeGraph;
    enum cudaGraphNodeTypeEmpty = cudaGraphNodeType.cudaGraphNodeTypeEmpty;
    enum cudaGraphNodeTypeCount = cudaGraphNodeType.cudaGraphNodeTypeCount;
    struct cudaKernelNodeParams
    {
        void* func;
        dim3 gridDim;
        dim3 blockDim;
        uint sharedMemBytes;
        void** kernelParams;
        void** extra;
    }
    struct cudaLaunchParams
    {
        void* func;
        dim3 gridDim;
        dim3 blockDim;
        void** args;
        c_ulong sharedMem;
        CUstream_st* stream;
    }
    enum cudaCGScope
    {
        cudaCGScopeInvalid = 0,
        cudaCGScopeGrid = 1,
        cudaCGScopeMultiGrid = 2,
    }
    enum cudaCGScopeInvalid = cudaCGScope.cudaCGScopeInvalid;
    enum cudaCGScopeGrid = cudaCGScope.cudaCGScopeGrid;
    enum cudaCGScopeMultiGrid = cudaCGScope.cudaCGScopeMultiGrid;
    struct CUgraphNode_st;
    alias cudaGraphNode_t = CUgraphNode_st*;
    struct CUgraph_st;
    alias cudaGraph_t = CUgraph_st*;
    struct CUexternalSemaphore_st;
    alias cudaExternalSemaphore_t = CUexternalSemaphore_st*;
    struct CUexternalMemory_st;
    alias cudaExternalMemory_t = CUexternalMemory_st*;
    alias cudaOutputMode_t = cudaOutputMode;
    alias cudaGraphicsResource_t = cudaGraphicsResource*;
    struct CUevent_st;
    alias cudaEvent_t = CUevent_st*;
    struct CUstream_st;
    alias cudaStream_t = CUstream_st*;
    alias cudaError_t = cudaError;
    struct cudaExternalSemaphoreWaitParams
    {
        static union _Anonymous_0
        {
            static struct _Anonymous_1
            {
                ulong value;
            }
            _Anonymous_1 fence;
        }
        _Anonymous_0 params;
        uint flags;
    }
    struct cudaExternalSemaphoreSignalParams
    {
        static union _Anonymous_2
        {
            static struct _Anonymous_3
            {
                ulong value;
            }
            _Anonymous_3 fence;
        }
        _Anonymous_2 params;
        uint flags;
    }
    struct cudaExternalSemaphoreHandleDesc
    {
        cudaExternalSemaphoreHandleType type;
        static union _Anonymous_4
        {
            int fd;
            static struct _Anonymous_5
            {
                void* handle;
                const(void)* name;
            }
            _Anonymous_5 win32;
        }
        _Anonymous_4 handle;
        uint flags;
    }
    enum cudaExternalSemaphoreHandleType
    {
        cudaExternalSemaphoreHandleTypeOpaqueFd = 1,
        cudaExternalSemaphoreHandleTypeOpaqueWin32 = 2,
        cudaExternalSemaphoreHandleTypeOpaqueWin32Kmt = 3,
        cudaExternalSemaphoreHandleTypeD3D12Fence = 4,
    }
    enum cudaExternalSemaphoreHandleTypeOpaqueFd = cudaExternalSemaphoreHandleType.cudaExternalSemaphoreHandleTypeOpaqueFd;
    enum cudaExternalSemaphoreHandleTypeOpaqueWin32 = cudaExternalSemaphoreHandleType.cudaExternalSemaphoreHandleTypeOpaqueWin32;
    enum cudaExternalSemaphoreHandleTypeOpaqueWin32Kmt = cudaExternalSemaphoreHandleType.cudaExternalSemaphoreHandleTypeOpaqueWin32Kmt;
    enum cudaExternalSemaphoreHandleTypeD3D12Fence = cudaExternalSemaphoreHandleType.cudaExternalSemaphoreHandleTypeD3D12Fence;
    struct cudaExternalMemoryMipmappedArrayDesc
    {
        ulong offset;
        cudaChannelFormatDesc formatDesc;
        cudaExtent extent;
        uint flags;
        uint numLevels;
    }
    struct cudaExternalMemoryBufferDesc
    {
        ulong offset;
        ulong size;
        uint flags;
    }
    struct cudaExternalMemoryHandleDesc
    {
        cudaExternalMemoryHandleType type;
        static union _Anonymous_6
        {
            int fd;
            static struct _Anonymous_7
            {
                void* handle;
                const(void)* name;
            }
            _Anonymous_7 win32;
        }
        _Anonymous_6 handle;
        ulong size;
        uint flags;
    }
    enum cudaExternalMemoryHandleType
    {
        cudaExternalMemoryHandleTypeOpaqueFd = 1,
        cudaExternalMemoryHandleTypeOpaqueWin32 = 2,
        cudaExternalMemoryHandleTypeOpaqueWin32Kmt = 3,
        cudaExternalMemoryHandleTypeD3D12Heap = 4,
        cudaExternalMemoryHandleTypeD3D12Resource = 5,
    }
    enum cudaExternalMemoryHandleTypeOpaqueFd = cudaExternalMemoryHandleType.cudaExternalMemoryHandleTypeOpaqueFd;
    enum cudaExternalMemoryHandleTypeOpaqueWin32 = cudaExternalMemoryHandleType.cudaExternalMemoryHandleTypeOpaqueWin32;
    enum cudaExternalMemoryHandleTypeOpaqueWin32Kmt = cudaExternalMemoryHandleType.cudaExternalMemoryHandleTypeOpaqueWin32Kmt;
    enum cudaExternalMemoryHandleTypeD3D12Heap = cudaExternalMemoryHandleType.cudaExternalMemoryHandleTypeD3D12Heap;
    enum cudaExternalMemoryHandleTypeD3D12Resource = cudaExternalMemoryHandleType.cudaExternalMemoryHandleTypeD3D12Resource;
    struct cudaIpcMemHandle_st
    {
        char[64] reserved;
    }
    alias cudaIpcMemHandle_t = cudaIpcMemHandle_st;
    struct cudaIpcEventHandle_st
    {
        char[64] reserved;
    }
    alias cudaIpcEventHandle_t = cudaIpcEventHandle_st;
    struct cudaDeviceProp
    {
        char[256] name;
        CUuuid_st uuid;
        char[8] luid;
        uint luidDeviceNodeMask;
        c_ulong totalGlobalMem;
        c_ulong sharedMemPerBlock;
        int regsPerBlock;
        int warpSize;
        c_ulong memPitch;
        int maxThreadsPerBlock;
        int[3] maxThreadsDim;
        int[3] maxGridSize;
        int clockRate;
        c_ulong totalConstMem;
        int major;
        int minor;
        c_ulong textureAlignment;
        c_ulong texturePitchAlignment;
        int deviceOverlap;
        int multiProcessorCount;
        int kernelExecTimeoutEnabled;
        int integrated;
        int canMapHostMemory;
        int computeMode;
        int maxTexture1D;
        int maxTexture1DMipmap;
        int maxTexture1DLinear;
        int[2] maxTexture2D;
        int[2] maxTexture2DMipmap;
        int[3] maxTexture2DLinear;
        int[2] maxTexture2DGather;
        int[3] maxTexture3D;
        int[3] maxTexture3DAlt;
        int maxTextureCubemap;
        int[2] maxTexture1DLayered;
        int[3] maxTexture2DLayered;
        int[2] maxTextureCubemapLayered;
        int maxSurface1D;
        int[2] maxSurface2D;
        int[3] maxSurface3D;
        int[2] maxSurface1DLayered;
        int[3] maxSurface2DLayered;
        int maxSurfaceCubemap;
        int[2] maxSurfaceCubemapLayered;
        c_ulong surfaceAlignment;
        int concurrentKernels;
        int ECCEnabled;
        int pciBusID;
        int pciDeviceID;
        int pciDomainID;
        int tccDriver;
        int asyncEngineCount;
        int unifiedAddressing;
        int memoryClockRate;
        int memoryBusWidth;
        int l2CacheSize;
        int maxThreadsPerMultiProcessor;
        int streamPrioritiesSupported;
        int globalL1CacheSupported;
        int localL1CacheSupported;
        c_ulong sharedMemPerMultiprocessor;
        int regsPerMultiprocessor;
        int managedMemory;
        int isMultiGpuBoard;
        int multiGpuBoardGroupID;
        int hostNativeAtomicSupported;
        int singleToDoublePrecisionPerfRatio;
        int pageableMemoryAccess;
        int concurrentManagedAccess;
        int computePreemptionSupported;
        int canUseHostPointerForRegisteredMem;
        int cooperativeLaunch;
        int cooperativeMultiDeviceLaunch;
        c_ulong sharedMemPerBlockOptin;
        int pageableMemoryAccessUsesHostPageTables;
        int directManagedMemAccessFromHost;
    }
    alias cudaUUID_t = CUuuid_st;
    alias CUuuid = CUuuid_st;
    struct CUuuid_st
    {
        char[16] bytes;
    }
    enum cudaDeviceP2PAttr
    {
        cudaDevP2PAttrPerformanceRank = 1,
        cudaDevP2PAttrAccessSupported = 2,
        cudaDevP2PAttrNativeAtomicSupported = 3,
        cudaDevP2PAttrCudaArrayAccessSupported = 4,
    }
    enum cudaDevP2PAttrPerformanceRank = cudaDeviceP2PAttr.cudaDevP2PAttrPerformanceRank;
    enum cudaDevP2PAttrAccessSupported = cudaDeviceP2PAttr.cudaDevP2PAttrAccessSupported;
    enum cudaDevP2PAttrNativeAtomicSupported = cudaDeviceP2PAttr.cudaDevP2PAttrNativeAtomicSupported;
    enum cudaDevP2PAttrCudaArrayAccessSupported = cudaDeviceP2PAttr.cudaDevP2PAttrCudaArrayAccessSupported;
    enum cudaDeviceAttr
    {
        cudaDevAttrMaxThreadsPerBlock = 1,
        cudaDevAttrMaxBlockDimX = 2,
        cudaDevAttrMaxBlockDimY = 3,
        cudaDevAttrMaxBlockDimZ = 4,
        cudaDevAttrMaxGridDimX = 5,
        cudaDevAttrMaxGridDimY = 6,
        cudaDevAttrMaxGridDimZ = 7,
        cudaDevAttrMaxSharedMemoryPerBlock = 8,
        cudaDevAttrTotalConstantMemory = 9,
        cudaDevAttrWarpSize = 10,
        cudaDevAttrMaxPitch = 11,
        cudaDevAttrMaxRegistersPerBlock = 12,
        cudaDevAttrClockRate = 13,
        cudaDevAttrTextureAlignment = 14,
        cudaDevAttrGpuOverlap = 15,
        cudaDevAttrMultiProcessorCount = 16,
        cudaDevAttrKernelExecTimeout = 17,
        cudaDevAttrIntegrated = 18,
        cudaDevAttrCanMapHostMemory = 19,
        cudaDevAttrComputeMode = 20,
        cudaDevAttrMaxTexture1DWidth = 21,
        cudaDevAttrMaxTexture2DWidth = 22,
        cudaDevAttrMaxTexture2DHeight = 23,
        cudaDevAttrMaxTexture3DWidth = 24,
        cudaDevAttrMaxTexture3DHeight = 25,
        cudaDevAttrMaxTexture3DDepth = 26,
        cudaDevAttrMaxTexture2DLayeredWidth = 27,
        cudaDevAttrMaxTexture2DLayeredHeight = 28,
        cudaDevAttrMaxTexture2DLayeredLayers = 29,
        cudaDevAttrSurfaceAlignment = 30,
        cudaDevAttrConcurrentKernels = 31,
        cudaDevAttrEccEnabled = 32,
        cudaDevAttrPciBusId = 33,
        cudaDevAttrPciDeviceId = 34,
        cudaDevAttrTccDriver = 35,
        cudaDevAttrMemoryClockRate = 36,
        cudaDevAttrGlobalMemoryBusWidth = 37,
        cudaDevAttrL2CacheSize = 38,
        cudaDevAttrMaxThreadsPerMultiProcessor = 39,
        cudaDevAttrAsyncEngineCount = 40,
        cudaDevAttrUnifiedAddressing = 41,
        cudaDevAttrMaxTexture1DLayeredWidth = 42,
        cudaDevAttrMaxTexture1DLayeredLayers = 43,
        cudaDevAttrMaxTexture2DGatherWidth = 45,
        cudaDevAttrMaxTexture2DGatherHeight = 46,
        cudaDevAttrMaxTexture3DWidthAlt = 47,
        cudaDevAttrMaxTexture3DHeightAlt = 48,
        cudaDevAttrMaxTexture3DDepthAlt = 49,
        cudaDevAttrPciDomainId = 50,
        cudaDevAttrTexturePitchAlignment = 51,
        cudaDevAttrMaxTextureCubemapWidth = 52,
        cudaDevAttrMaxTextureCubemapLayeredWidth = 53,
        cudaDevAttrMaxTextureCubemapLayeredLayers = 54,
        cudaDevAttrMaxSurface1DWidth = 55,
        cudaDevAttrMaxSurface2DWidth = 56,
        cudaDevAttrMaxSurface2DHeight = 57,
        cudaDevAttrMaxSurface3DWidth = 58,
        cudaDevAttrMaxSurface3DHeight = 59,
        cudaDevAttrMaxSurface3DDepth = 60,
        cudaDevAttrMaxSurface1DLayeredWidth = 61,
        cudaDevAttrMaxSurface1DLayeredLayers = 62,
        cudaDevAttrMaxSurface2DLayeredWidth = 63,
        cudaDevAttrMaxSurface2DLayeredHeight = 64,
        cudaDevAttrMaxSurface2DLayeredLayers = 65,
        cudaDevAttrMaxSurfaceCubemapWidth = 66,
        cudaDevAttrMaxSurfaceCubemapLayeredWidth = 67,
        cudaDevAttrMaxSurfaceCubemapLayeredLayers = 68,
        cudaDevAttrMaxTexture1DLinearWidth = 69,
        cudaDevAttrMaxTexture2DLinearWidth = 70,
        cudaDevAttrMaxTexture2DLinearHeight = 71,
        cudaDevAttrMaxTexture2DLinearPitch = 72,
        cudaDevAttrMaxTexture2DMipmappedWidth = 73,
        cudaDevAttrMaxTexture2DMipmappedHeight = 74,
        cudaDevAttrComputeCapabilityMajor = 75,
        cudaDevAttrComputeCapabilityMinor = 76,
        cudaDevAttrMaxTexture1DMipmappedWidth = 77,
        cudaDevAttrStreamPrioritiesSupported = 78,
        cudaDevAttrGlobalL1CacheSupported = 79,
        cudaDevAttrLocalL1CacheSupported = 80,
        cudaDevAttrMaxSharedMemoryPerMultiprocessor = 81,
        cudaDevAttrMaxRegistersPerMultiprocessor = 82,
        cudaDevAttrManagedMemory = 83,
        cudaDevAttrIsMultiGpuBoard = 84,
        cudaDevAttrMultiGpuBoardGroupID = 85,
        cudaDevAttrHostNativeAtomicSupported = 86,
        cudaDevAttrSingleToDoublePrecisionPerfRatio = 87,
        cudaDevAttrPageableMemoryAccess = 88,
        cudaDevAttrConcurrentManagedAccess = 89,
        cudaDevAttrComputePreemptionSupported = 90,
        cudaDevAttrCanUseHostPointerForRegisteredMem = 91,
        cudaDevAttrReserved92 = 92,
        cudaDevAttrReserved93 = 93,
        cudaDevAttrReserved94 = 94,
        cudaDevAttrCooperativeLaunch = 95,
        cudaDevAttrCooperativeMultiDeviceLaunch = 96,
        cudaDevAttrMaxSharedMemoryPerBlockOptin = 97,
        cudaDevAttrCanFlushRemoteWrites = 98,
        cudaDevAttrHostRegisterSupported = 99,
        cudaDevAttrPageableMemoryAccessUsesHostPageTables = 100,
        cudaDevAttrDirectManagedMemAccessFromHost = 101,
    }
    enum cudaDevAttrMaxThreadsPerBlock = cudaDeviceAttr.cudaDevAttrMaxThreadsPerBlock;
    enum cudaDevAttrMaxBlockDimX = cudaDeviceAttr.cudaDevAttrMaxBlockDimX;
    enum cudaDevAttrMaxBlockDimY = cudaDeviceAttr.cudaDevAttrMaxBlockDimY;
    enum cudaDevAttrMaxBlockDimZ = cudaDeviceAttr.cudaDevAttrMaxBlockDimZ;
    enum cudaDevAttrMaxGridDimX = cudaDeviceAttr.cudaDevAttrMaxGridDimX;
    enum cudaDevAttrMaxGridDimY = cudaDeviceAttr.cudaDevAttrMaxGridDimY;
    enum cudaDevAttrMaxGridDimZ = cudaDeviceAttr.cudaDevAttrMaxGridDimZ;
    enum cudaDevAttrMaxSharedMemoryPerBlock = cudaDeviceAttr.cudaDevAttrMaxSharedMemoryPerBlock;
    enum cudaDevAttrTotalConstantMemory = cudaDeviceAttr.cudaDevAttrTotalConstantMemory;
    enum cudaDevAttrWarpSize = cudaDeviceAttr.cudaDevAttrWarpSize;
    enum cudaDevAttrMaxPitch = cudaDeviceAttr.cudaDevAttrMaxPitch;
    enum cudaDevAttrMaxRegistersPerBlock = cudaDeviceAttr.cudaDevAttrMaxRegistersPerBlock;
    enum cudaDevAttrClockRate = cudaDeviceAttr.cudaDevAttrClockRate;
    enum cudaDevAttrTextureAlignment = cudaDeviceAttr.cudaDevAttrTextureAlignment;
    enum cudaDevAttrGpuOverlap = cudaDeviceAttr.cudaDevAttrGpuOverlap;
    enum cudaDevAttrMultiProcessorCount = cudaDeviceAttr.cudaDevAttrMultiProcessorCount;
    enum cudaDevAttrKernelExecTimeout = cudaDeviceAttr.cudaDevAttrKernelExecTimeout;
    enum cudaDevAttrIntegrated = cudaDeviceAttr.cudaDevAttrIntegrated;
    enum cudaDevAttrCanMapHostMemory = cudaDeviceAttr.cudaDevAttrCanMapHostMemory;
    enum cudaDevAttrComputeMode = cudaDeviceAttr.cudaDevAttrComputeMode;
    enum cudaDevAttrMaxTexture1DWidth = cudaDeviceAttr.cudaDevAttrMaxTexture1DWidth;
    enum cudaDevAttrMaxTexture2DWidth = cudaDeviceAttr.cudaDevAttrMaxTexture2DWidth;
    enum cudaDevAttrMaxTexture2DHeight = cudaDeviceAttr.cudaDevAttrMaxTexture2DHeight;
    enum cudaDevAttrMaxTexture3DWidth = cudaDeviceAttr.cudaDevAttrMaxTexture3DWidth;
    enum cudaDevAttrMaxTexture3DHeight = cudaDeviceAttr.cudaDevAttrMaxTexture3DHeight;
    enum cudaDevAttrMaxTexture3DDepth = cudaDeviceAttr.cudaDevAttrMaxTexture3DDepth;
    enum cudaDevAttrMaxTexture2DLayeredWidth = cudaDeviceAttr.cudaDevAttrMaxTexture2DLayeredWidth;
    enum cudaDevAttrMaxTexture2DLayeredHeight = cudaDeviceAttr.cudaDevAttrMaxTexture2DLayeredHeight;
    enum cudaDevAttrMaxTexture2DLayeredLayers = cudaDeviceAttr.cudaDevAttrMaxTexture2DLayeredLayers;
    enum cudaDevAttrSurfaceAlignment = cudaDeviceAttr.cudaDevAttrSurfaceAlignment;
    enum cudaDevAttrConcurrentKernels = cudaDeviceAttr.cudaDevAttrConcurrentKernels;
    enum cudaDevAttrEccEnabled = cudaDeviceAttr.cudaDevAttrEccEnabled;
    enum cudaDevAttrPciBusId = cudaDeviceAttr.cudaDevAttrPciBusId;
    enum cudaDevAttrPciDeviceId = cudaDeviceAttr.cudaDevAttrPciDeviceId;
    enum cudaDevAttrTccDriver = cudaDeviceAttr.cudaDevAttrTccDriver;
    enum cudaDevAttrMemoryClockRate = cudaDeviceAttr.cudaDevAttrMemoryClockRate;
    enum cudaDevAttrGlobalMemoryBusWidth = cudaDeviceAttr.cudaDevAttrGlobalMemoryBusWidth;
    enum cudaDevAttrL2CacheSize = cudaDeviceAttr.cudaDevAttrL2CacheSize;
    enum cudaDevAttrMaxThreadsPerMultiProcessor = cudaDeviceAttr.cudaDevAttrMaxThreadsPerMultiProcessor;
    enum cudaDevAttrAsyncEngineCount = cudaDeviceAttr.cudaDevAttrAsyncEngineCount;
    enum cudaDevAttrUnifiedAddressing = cudaDeviceAttr.cudaDevAttrUnifiedAddressing;
    enum cudaDevAttrMaxTexture1DLayeredWidth = cudaDeviceAttr.cudaDevAttrMaxTexture1DLayeredWidth;
    enum cudaDevAttrMaxTexture1DLayeredLayers = cudaDeviceAttr.cudaDevAttrMaxTexture1DLayeredLayers;
    enum cudaDevAttrMaxTexture2DGatherWidth = cudaDeviceAttr.cudaDevAttrMaxTexture2DGatherWidth;
    enum cudaDevAttrMaxTexture2DGatherHeight = cudaDeviceAttr.cudaDevAttrMaxTexture2DGatherHeight;
    enum cudaDevAttrMaxTexture3DWidthAlt = cudaDeviceAttr.cudaDevAttrMaxTexture3DWidthAlt;
    enum cudaDevAttrMaxTexture3DHeightAlt = cudaDeviceAttr.cudaDevAttrMaxTexture3DHeightAlt;
    enum cudaDevAttrMaxTexture3DDepthAlt = cudaDeviceAttr.cudaDevAttrMaxTexture3DDepthAlt;
    enum cudaDevAttrPciDomainId = cudaDeviceAttr.cudaDevAttrPciDomainId;
    enum cudaDevAttrTexturePitchAlignment = cudaDeviceAttr.cudaDevAttrTexturePitchAlignment;
    enum cudaDevAttrMaxTextureCubemapWidth = cudaDeviceAttr.cudaDevAttrMaxTextureCubemapWidth;
    enum cudaDevAttrMaxTextureCubemapLayeredWidth = cudaDeviceAttr.cudaDevAttrMaxTextureCubemapLayeredWidth;
    enum cudaDevAttrMaxTextureCubemapLayeredLayers = cudaDeviceAttr.cudaDevAttrMaxTextureCubemapLayeredLayers;
    enum cudaDevAttrMaxSurface1DWidth = cudaDeviceAttr.cudaDevAttrMaxSurface1DWidth;
    enum cudaDevAttrMaxSurface2DWidth = cudaDeviceAttr.cudaDevAttrMaxSurface2DWidth;
    enum cudaDevAttrMaxSurface2DHeight = cudaDeviceAttr.cudaDevAttrMaxSurface2DHeight;
    enum cudaDevAttrMaxSurface3DWidth = cudaDeviceAttr.cudaDevAttrMaxSurface3DWidth;
    enum cudaDevAttrMaxSurface3DHeight = cudaDeviceAttr.cudaDevAttrMaxSurface3DHeight;
    enum cudaDevAttrMaxSurface3DDepth = cudaDeviceAttr.cudaDevAttrMaxSurface3DDepth;
    enum cudaDevAttrMaxSurface1DLayeredWidth = cudaDeviceAttr.cudaDevAttrMaxSurface1DLayeredWidth;
    enum cudaDevAttrMaxSurface1DLayeredLayers = cudaDeviceAttr.cudaDevAttrMaxSurface1DLayeredLayers;
    enum cudaDevAttrMaxSurface2DLayeredWidth = cudaDeviceAttr.cudaDevAttrMaxSurface2DLayeredWidth;
    enum cudaDevAttrMaxSurface2DLayeredHeight = cudaDeviceAttr.cudaDevAttrMaxSurface2DLayeredHeight;
    enum cudaDevAttrMaxSurface2DLayeredLayers = cudaDeviceAttr.cudaDevAttrMaxSurface2DLayeredLayers;
    enum cudaDevAttrMaxSurfaceCubemapWidth = cudaDeviceAttr.cudaDevAttrMaxSurfaceCubemapWidth;
    enum cudaDevAttrMaxSurfaceCubemapLayeredWidth = cudaDeviceAttr.cudaDevAttrMaxSurfaceCubemapLayeredWidth;
    enum cudaDevAttrMaxSurfaceCubemapLayeredLayers = cudaDeviceAttr.cudaDevAttrMaxSurfaceCubemapLayeredLayers;
    enum cudaDevAttrMaxTexture1DLinearWidth = cudaDeviceAttr.cudaDevAttrMaxTexture1DLinearWidth;
    enum cudaDevAttrMaxTexture2DLinearWidth = cudaDeviceAttr.cudaDevAttrMaxTexture2DLinearWidth;
    enum cudaDevAttrMaxTexture2DLinearHeight = cudaDeviceAttr.cudaDevAttrMaxTexture2DLinearHeight;
    enum cudaDevAttrMaxTexture2DLinearPitch = cudaDeviceAttr.cudaDevAttrMaxTexture2DLinearPitch;
    enum cudaDevAttrMaxTexture2DMipmappedWidth = cudaDeviceAttr.cudaDevAttrMaxTexture2DMipmappedWidth;
    enum cudaDevAttrMaxTexture2DMipmappedHeight = cudaDeviceAttr.cudaDevAttrMaxTexture2DMipmappedHeight;
    enum cudaDevAttrComputeCapabilityMajor = cudaDeviceAttr.cudaDevAttrComputeCapabilityMajor;
    enum cudaDevAttrComputeCapabilityMinor = cudaDeviceAttr.cudaDevAttrComputeCapabilityMinor;
    enum cudaDevAttrMaxTexture1DMipmappedWidth = cudaDeviceAttr.cudaDevAttrMaxTexture1DMipmappedWidth;
    enum cudaDevAttrStreamPrioritiesSupported = cudaDeviceAttr.cudaDevAttrStreamPrioritiesSupported;
    enum cudaDevAttrGlobalL1CacheSupported = cudaDeviceAttr.cudaDevAttrGlobalL1CacheSupported;
    enum cudaDevAttrLocalL1CacheSupported = cudaDeviceAttr.cudaDevAttrLocalL1CacheSupported;
    enum cudaDevAttrMaxSharedMemoryPerMultiprocessor = cudaDeviceAttr.cudaDevAttrMaxSharedMemoryPerMultiprocessor;
    enum cudaDevAttrMaxRegistersPerMultiprocessor = cudaDeviceAttr.cudaDevAttrMaxRegistersPerMultiprocessor;
    enum cudaDevAttrManagedMemory = cudaDeviceAttr.cudaDevAttrManagedMemory;
    enum cudaDevAttrIsMultiGpuBoard = cudaDeviceAttr.cudaDevAttrIsMultiGpuBoard;
    enum cudaDevAttrMultiGpuBoardGroupID = cudaDeviceAttr.cudaDevAttrMultiGpuBoardGroupID;
    enum cudaDevAttrHostNativeAtomicSupported = cudaDeviceAttr.cudaDevAttrHostNativeAtomicSupported;
    enum cudaDevAttrSingleToDoublePrecisionPerfRatio = cudaDeviceAttr.cudaDevAttrSingleToDoublePrecisionPerfRatio;
    enum cudaDevAttrPageableMemoryAccess = cudaDeviceAttr.cudaDevAttrPageableMemoryAccess;
    enum cudaDevAttrConcurrentManagedAccess = cudaDeviceAttr.cudaDevAttrConcurrentManagedAccess;
    enum cudaDevAttrComputePreemptionSupported = cudaDeviceAttr.cudaDevAttrComputePreemptionSupported;
    enum cudaDevAttrCanUseHostPointerForRegisteredMem = cudaDeviceAttr.cudaDevAttrCanUseHostPointerForRegisteredMem;
    enum cudaDevAttrReserved92 = cudaDeviceAttr.cudaDevAttrReserved92;
    enum cudaDevAttrReserved93 = cudaDeviceAttr.cudaDevAttrReserved93;
    enum cudaDevAttrReserved94 = cudaDeviceAttr.cudaDevAttrReserved94;
    enum cudaDevAttrCooperativeLaunch = cudaDeviceAttr.cudaDevAttrCooperativeLaunch;
    enum cudaDevAttrCooperativeMultiDeviceLaunch = cudaDeviceAttr.cudaDevAttrCooperativeMultiDeviceLaunch;
    enum cudaDevAttrMaxSharedMemoryPerBlockOptin = cudaDeviceAttr.cudaDevAttrMaxSharedMemoryPerBlockOptin;
    enum cudaDevAttrCanFlushRemoteWrites = cudaDeviceAttr.cudaDevAttrCanFlushRemoteWrites;
    enum cudaDevAttrHostRegisterSupported = cudaDeviceAttr.cudaDevAttrHostRegisterSupported;
    enum cudaDevAttrPageableMemoryAccessUsesHostPageTables = cudaDeviceAttr.cudaDevAttrPageableMemoryAccessUsesHostPageTables;
    enum cudaDevAttrDirectManagedMemAccessFromHost = cudaDeviceAttr.cudaDevAttrDirectManagedMemAccessFromHost;
    enum cudaOutputMode
    {
        cudaKeyValuePair = 0,
        cudaCSV = 1,
    }
    enum cudaKeyValuePair = cudaOutputMode.cudaKeyValuePair;
    enum cudaCSV = cudaOutputMode.cudaCSV;
    enum cudaMemRangeAttribute
    {
        cudaMemRangeAttributeReadMostly = 1,
        cudaMemRangeAttributePreferredLocation = 2,
        cudaMemRangeAttributeAccessedBy = 3,
        cudaMemRangeAttributeLastPrefetchLocation = 4,
    }
    enum cudaMemRangeAttributeReadMostly = cudaMemRangeAttribute.cudaMemRangeAttributeReadMostly;
    enum cudaMemRangeAttributePreferredLocation = cudaMemRangeAttribute.cudaMemRangeAttributePreferredLocation;
    enum cudaMemRangeAttributeAccessedBy = cudaMemRangeAttribute.cudaMemRangeAttributeAccessedBy;
    enum cudaMemRangeAttributeLastPrefetchLocation = cudaMemRangeAttribute.cudaMemRangeAttributeLastPrefetchLocation;
    enum cudaMemoryAdvise
    {
        cudaMemAdviseSetReadMostly = 1,
        cudaMemAdviseUnsetReadMostly = 2,
        cudaMemAdviseSetPreferredLocation = 3,
        cudaMemAdviseUnsetPreferredLocation = 4,
        cudaMemAdviseSetAccessedBy = 5,
        cudaMemAdviseUnsetAccessedBy = 6,
    }
    enum cudaMemAdviseSetReadMostly = cudaMemoryAdvise.cudaMemAdviseSetReadMostly;
    enum cudaMemAdviseUnsetReadMostly = cudaMemoryAdvise.cudaMemAdviseUnsetReadMostly;
    enum cudaMemAdviseSetPreferredLocation = cudaMemoryAdvise.cudaMemAdviseSetPreferredLocation;
    enum cudaMemAdviseUnsetPreferredLocation = cudaMemoryAdvise.cudaMemAdviseUnsetPreferredLocation;
    enum cudaMemAdviseSetAccessedBy = cudaMemoryAdvise.cudaMemAdviseSetAccessedBy;
    enum cudaMemAdviseUnsetAccessedBy = cudaMemoryAdvise.cudaMemAdviseUnsetAccessedBy;
    enum cudaLimit
    {
        cudaLimitStackSize = 0,
        cudaLimitPrintfFifoSize = 1,
        cudaLimitMallocHeapSize = 2,
        cudaLimitDevRuntimeSyncDepth = 3,
        cudaLimitDevRuntimePendingLaunchCount = 4,
        cudaLimitMaxL2FetchGranularity = 5,
    }
    enum cudaLimitStackSize = cudaLimit.cudaLimitStackSize;
    enum cudaLimitPrintfFifoSize = cudaLimit.cudaLimitPrintfFifoSize;
    enum cudaLimitMallocHeapSize = cudaLimit.cudaLimitMallocHeapSize;
    enum cudaLimitDevRuntimeSyncDepth = cudaLimit.cudaLimitDevRuntimeSyncDepth;
    enum cudaLimitDevRuntimePendingLaunchCount = cudaLimit.cudaLimitDevRuntimePendingLaunchCount;
    enum cudaLimitMaxL2FetchGranularity = cudaLimit.cudaLimitMaxL2FetchGranularity;
    enum cudaComputeMode
    {
        cudaComputeModeDefault = 0,
        cudaComputeModeExclusive = 1,
        cudaComputeModeProhibited = 2,
        cudaComputeModeExclusiveProcess = 3,
    }
    enum cudaComputeModeDefault = cudaComputeMode.cudaComputeModeDefault;
    enum cudaComputeModeExclusive = cudaComputeMode.cudaComputeModeExclusive;
    enum cudaComputeModeProhibited = cudaComputeMode.cudaComputeModeProhibited;
    enum cudaComputeModeExclusiveProcess = cudaComputeMode.cudaComputeModeExclusiveProcess;
    enum cudaSharedCarveout
    {
        cudaSharedmemCarveoutDefault = -1,
        cudaSharedmemCarveoutMaxShared = 100,
        cudaSharedmemCarveoutMaxL1 = 0,
    }
    enum cudaSharedmemCarveoutDefault = cudaSharedCarveout.cudaSharedmemCarveoutDefault;
    enum cudaSharedmemCarveoutMaxShared = cudaSharedCarveout.cudaSharedmemCarveoutMaxShared;
    enum cudaSharedmemCarveoutMaxL1 = cudaSharedCarveout.cudaSharedmemCarveoutMaxL1;
    enum cudaSharedMemConfig
    {
        cudaSharedMemBankSizeDefault = 0,
        cudaSharedMemBankSizeFourByte = 1,
        cudaSharedMemBankSizeEightByte = 2,
    }
    enum cudaSharedMemBankSizeDefault = cudaSharedMemConfig.cudaSharedMemBankSizeDefault;
    enum cudaSharedMemBankSizeFourByte = cudaSharedMemConfig.cudaSharedMemBankSizeFourByte;
    enum cudaSharedMemBankSizeEightByte = cudaSharedMemConfig.cudaSharedMemBankSizeEightByte;
    enum cudaFuncCache
    {
        cudaFuncCachePreferNone = 0,
        cudaFuncCachePreferShared = 1,
        cudaFuncCachePreferL1 = 2,
        cudaFuncCachePreferEqual = 3,
    }
    enum cudaFuncCachePreferNone = cudaFuncCache.cudaFuncCachePreferNone;
    enum cudaFuncCachePreferShared = cudaFuncCache.cudaFuncCachePreferShared;
    enum cudaFuncCachePreferL1 = cudaFuncCache.cudaFuncCachePreferL1;
    enum cudaFuncCachePreferEqual = cudaFuncCache.cudaFuncCachePreferEqual;
    enum cudaFuncAttribute
    {
        cudaFuncAttributeMaxDynamicSharedMemorySize = 8,
        cudaFuncAttributePreferredSharedMemoryCarveout = 9,
        cudaFuncAttributeMax = 10,
    }
    enum cudaFuncAttributeMaxDynamicSharedMemorySize = cudaFuncAttribute.cudaFuncAttributeMaxDynamicSharedMemorySize;
    enum cudaFuncAttributePreferredSharedMemoryCarveout = cudaFuncAttribute.cudaFuncAttributePreferredSharedMemoryCarveout;
    enum cudaFuncAttributeMax = cudaFuncAttribute.cudaFuncAttributeMax;
    struct cudaFuncAttributes
    {
        c_ulong sharedSizeBytes;
        c_ulong constSizeBytes;
        c_ulong localSizeBytes;
        int maxThreadsPerBlock;
        int numRegs;
        int ptxVersion;
        int binaryVersion;
        int cacheModeCA;
        int maxDynamicSharedSizeBytes;
        int preferredShmemCarveout;
    }
    struct cudaPointerAttributes
    {
        cudaMemoryType memoryType;
        cudaMemoryType type;
        int device;
        void* devicePointer;
        void* hostPointer;
        int isManaged;
    }
    struct cudaResourceViewDesc
    {
        cudaResourceViewFormat format;
        c_ulong width;
        c_ulong height;
        c_ulong depth;
        uint firstMipmapLevel;
        uint lastMipmapLevel;
        uint firstLayer;
        uint lastLayer;
    }
    struct cudaResourceDesc
    {
        cudaResourceType resType;
        static union _Anonymous_8
        {
            static struct _Anonymous_9
            {
                cudaArray* array;
            }
            _Anonymous_9 array;
            static struct _Anonymous_10
            {
                cudaMipmappedArray* mipmap;
            }
            _Anonymous_10 mipmap;
            static struct _Anonymous_11
            {
                void* devPtr;
                cudaChannelFormatDesc desc;
                c_ulong sizeInBytes;
            }
            _Anonymous_11 linear;
            static struct _Anonymous_12
            {
                void* devPtr;
                cudaChannelFormatDesc desc;
                c_ulong width;
                c_ulong height;
                c_ulong pitchInBytes;
            }
            _Anonymous_12 pitch2D;
        }
        _Anonymous_8 res;
    }
    enum cudaResourceViewFormat
    {
        cudaResViewFormatNone = 0,
        cudaResViewFormatUnsignedChar1 = 1,
        cudaResViewFormatUnsignedChar2 = 2,
        cudaResViewFormatUnsignedChar4 = 3,
        cudaResViewFormatSignedChar1 = 4,
        cudaResViewFormatSignedChar2 = 5,
        cudaResViewFormatSignedChar4 = 6,
        cudaResViewFormatUnsignedShort1 = 7,
        cudaResViewFormatUnsignedShort2 = 8,
        cudaResViewFormatUnsignedShort4 = 9,
        cudaResViewFormatSignedShort1 = 10,
        cudaResViewFormatSignedShort2 = 11,
        cudaResViewFormatSignedShort4 = 12,
        cudaResViewFormatUnsignedInt1 = 13,
        cudaResViewFormatUnsignedInt2 = 14,
        cudaResViewFormatUnsignedInt4 = 15,
        cudaResViewFormatSignedInt1 = 16,
        cudaResViewFormatSignedInt2 = 17,
        cudaResViewFormatSignedInt4 = 18,
        cudaResViewFormatHalf1 = 19,
        cudaResViewFormatHalf2 = 20,
        cudaResViewFormatHalf4 = 21,
        cudaResViewFormatFloat1 = 22,
        cudaResViewFormatFloat2 = 23,
        cudaResViewFormatFloat4 = 24,
        cudaResViewFormatUnsignedBlockCompressed1 = 25,
        cudaResViewFormatUnsignedBlockCompressed2 = 26,
        cudaResViewFormatUnsignedBlockCompressed3 = 27,
        cudaResViewFormatUnsignedBlockCompressed4 = 28,
        cudaResViewFormatSignedBlockCompressed4 = 29,
        cudaResViewFormatUnsignedBlockCompressed5 = 30,
        cudaResViewFormatSignedBlockCompressed5 = 31,
        cudaResViewFormatUnsignedBlockCompressed6H = 32,
        cudaResViewFormatSignedBlockCompressed6H = 33,
        cudaResViewFormatUnsignedBlockCompressed7 = 34,
    }
    enum cudaResViewFormatNone = cudaResourceViewFormat.cudaResViewFormatNone;
    enum cudaResViewFormatUnsignedChar1 = cudaResourceViewFormat.cudaResViewFormatUnsignedChar1;
    enum cudaResViewFormatUnsignedChar2 = cudaResourceViewFormat.cudaResViewFormatUnsignedChar2;
    enum cudaResViewFormatUnsignedChar4 = cudaResourceViewFormat.cudaResViewFormatUnsignedChar4;
    enum cudaResViewFormatSignedChar1 = cudaResourceViewFormat.cudaResViewFormatSignedChar1;
    enum cudaResViewFormatSignedChar2 = cudaResourceViewFormat.cudaResViewFormatSignedChar2;
    enum cudaResViewFormatSignedChar4 = cudaResourceViewFormat.cudaResViewFormatSignedChar4;
    enum cudaResViewFormatUnsignedShort1 = cudaResourceViewFormat.cudaResViewFormatUnsignedShort1;
    enum cudaResViewFormatUnsignedShort2 = cudaResourceViewFormat.cudaResViewFormatUnsignedShort2;
    enum cudaResViewFormatUnsignedShort4 = cudaResourceViewFormat.cudaResViewFormatUnsignedShort4;
    enum cudaResViewFormatSignedShort1 = cudaResourceViewFormat.cudaResViewFormatSignedShort1;
    enum cudaResViewFormatSignedShort2 = cudaResourceViewFormat.cudaResViewFormatSignedShort2;
    enum cudaResViewFormatSignedShort4 = cudaResourceViewFormat.cudaResViewFormatSignedShort4;
    enum cudaResViewFormatUnsignedInt1 = cudaResourceViewFormat.cudaResViewFormatUnsignedInt1;
    enum cudaResViewFormatUnsignedInt2 = cudaResourceViewFormat.cudaResViewFormatUnsignedInt2;
    enum cudaResViewFormatUnsignedInt4 = cudaResourceViewFormat.cudaResViewFormatUnsignedInt4;
    enum cudaResViewFormatSignedInt1 = cudaResourceViewFormat.cudaResViewFormatSignedInt1;
    enum cudaResViewFormatSignedInt2 = cudaResourceViewFormat.cudaResViewFormatSignedInt2;
    enum cudaResViewFormatSignedInt4 = cudaResourceViewFormat.cudaResViewFormatSignedInt4;
    enum cudaResViewFormatHalf1 = cudaResourceViewFormat.cudaResViewFormatHalf1;
    enum cudaResViewFormatHalf2 = cudaResourceViewFormat.cudaResViewFormatHalf2;
    enum cudaResViewFormatHalf4 = cudaResourceViewFormat.cudaResViewFormatHalf4;
    enum cudaResViewFormatFloat1 = cudaResourceViewFormat.cudaResViewFormatFloat1;
    enum cudaResViewFormatFloat2 = cudaResourceViewFormat.cudaResViewFormatFloat2;
    enum cudaResViewFormatFloat4 = cudaResourceViewFormat.cudaResViewFormatFloat4;
    enum cudaResViewFormatUnsignedBlockCompressed1 = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed1;
    enum cudaResViewFormatUnsignedBlockCompressed2 = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed2;
    enum cudaResViewFormatUnsignedBlockCompressed3 = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed3;
    enum cudaResViewFormatUnsignedBlockCompressed4 = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed4;
    enum cudaResViewFormatSignedBlockCompressed4 = cudaResourceViewFormat.cudaResViewFormatSignedBlockCompressed4;
    enum cudaResViewFormatUnsignedBlockCompressed5 = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed5;
    enum cudaResViewFormatSignedBlockCompressed5 = cudaResourceViewFormat.cudaResViewFormatSignedBlockCompressed5;
    enum cudaResViewFormatUnsignedBlockCompressed6H = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed6H;
    enum cudaResViewFormatSignedBlockCompressed6H = cudaResourceViewFormat.cudaResViewFormatSignedBlockCompressed6H;
    enum cudaResViewFormatUnsignedBlockCompressed7 = cudaResourceViewFormat.cudaResViewFormatUnsignedBlockCompressed7;
    enum cudaResourceType
    {
        cudaResourceTypeArray = 0,
        cudaResourceTypeMipmappedArray = 1,
        cudaResourceTypeLinear = 2,
        cudaResourceTypePitch2D = 3,
    }
    enum cudaResourceTypeArray = cudaResourceType.cudaResourceTypeArray;
    enum cudaResourceTypeMipmappedArray = cudaResourceType.cudaResourceTypeMipmappedArray;
    enum cudaResourceTypeLinear = cudaResourceType.cudaResourceTypeLinear;
    enum cudaResourceTypePitch2D = cudaResourceType.cudaResourceTypePitch2D;
    enum cudaGraphicsCubeFace
    {
        cudaGraphicsCubeFacePositiveX = 0,
        cudaGraphicsCubeFaceNegativeX = 1,
        cudaGraphicsCubeFacePositiveY = 2,
        cudaGraphicsCubeFaceNegativeY = 3,
        cudaGraphicsCubeFacePositiveZ = 4,
        cudaGraphicsCubeFaceNegativeZ = 5,
    }
    enum cudaGraphicsCubeFacePositiveX = cudaGraphicsCubeFace.cudaGraphicsCubeFacePositiveX;
    enum cudaGraphicsCubeFaceNegativeX = cudaGraphicsCubeFace.cudaGraphicsCubeFaceNegativeX;
    enum cudaGraphicsCubeFacePositiveY = cudaGraphicsCubeFace.cudaGraphicsCubeFacePositiveY;
    enum cudaGraphicsCubeFaceNegativeY = cudaGraphicsCubeFace.cudaGraphicsCubeFaceNegativeY;
    enum cudaGraphicsCubeFacePositiveZ = cudaGraphicsCubeFace.cudaGraphicsCubeFacePositiveZ;
    enum cudaGraphicsCubeFaceNegativeZ = cudaGraphicsCubeFace.cudaGraphicsCubeFaceNegativeZ;
    enum cudaGraphicsMapFlags
    {
        cudaGraphicsMapFlagsNone = 0,
        cudaGraphicsMapFlagsReadOnly = 1,
        cudaGraphicsMapFlagsWriteDiscard = 2,
    }
    enum cudaGraphicsMapFlagsNone = cudaGraphicsMapFlags.cudaGraphicsMapFlagsNone;
    enum cudaGraphicsMapFlagsReadOnly = cudaGraphicsMapFlags.cudaGraphicsMapFlagsReadOnly;
    enum cudaGraphicsMapFlagsWriteDiscard = cudaGraphicsMapFlags.cudaGraphicsMapFlagsWriteDiscard;
    enum cudaGraphicsRegisterFlags
    {
        cudaGraphicsRegisterFlagsNone = 0,
        cudaGraphicsRegisterFlagsReadOnly = 1,
        cudaGraphicsRegisterFlagsWriteDiscard = 2,
        cudaGraphicsRegisterFlagsSurfaceLoadStore = 4,
        cudaGraphicsRegisterFlagsTextureGather = 8,
    }
    enum cudaGraphicsRegisterFlagsNone = cudaGraphicsRegisterFlags.cudaGraphicsRegisterFlagsNone;
    enum cudaGraphicsRegisterFlagsReadOnly = cudaGraphicsRegisterFlags.cudaGraphicsRegisterFlagsReadOnly;
    enum cudaGraphicsRegisterFlagsWriteDiscard = cudaGraphicsRegisterFlags.cudaGraphicsRegisterFlagsWriteDiscard;
    enum cudaGraphicsRegisterFlagsSurfaceLoadStore = cudaGraphicsRegisterFlags.cudaGraphicsRegisterFlagsSurfaceLoadStore;
    enum cudaGraphicsRegisterFlagsTextureGather = cudaGraphicsRegisterFlags.cudaGraphicsRegisterFlagsTextureGather;
    struct cudaGraphicsResource;
    enum cudaStreamCaptureStatus
    {
        cudaStreamCaptureStatusNone = 0,
        cudaStreamCaptureStatusActive = 1,
        cudaStreamCaptureStatusInvalidated = 2,
    }
    enum cudaStreamCaptureStatusNone = cudaStreamCaptureStatus.cudaStreamCaptureStatusNone;
    enum cudaStreamCaptureStatusActive = cudaStreamCaptureStatus.cudaStreamCaptureStatusActive;
    enum cudaStreamCaptureStatusInvalidated = cudaStreamCaptureStatus.cudaStreamCaptureStatusInvalidated;
    struct cudaHostNodeParams
    {
        void function(void*) fn;
        void* userData;
    }
    alias cudaHostFn_t = void function(void*);
    struct cudaMemsetParams
    {
        void* dst;
        c_ulong pitch;
        uint value;
        uint elementSize;
        c_ulong width;
        c_ulong height;
    }
    struct cudaMemcpy3DPeerParms
    {
        cudaArray* srcArray;
        cudaPos srcPos;
        cudaPitchedPtr srcPtr;
        int srcDevice;
        cudaArray* dstArray;
        cudaPos dstPos;
        cudaPitchedPtr dstPtr;
        int dstDevice;
        cudaExtent extent;
    }
    struct cudaMemcpy3DParms
    {
        cudaArray* srcArray;
        cudaPos srcPos;
        cudaPitchedPtr srcPtr;
        cudaArray* dstArray;
        cudaPos dstPos;
        cudaPitchedPtr dstPtr;
        cudaExtent extent;
        cudaMemcpyKind kind;
    }
    struct cudaPos
    {
        c_ulong x;
        c_ulong y;
        c_ulong z;
    }
    struct max_align_t
    {
        long __clang_max_align_nonce1;
        real __clang_max_align_nonce2;
    }
    struct cudaExtent
    {
        c_ulong width;
        c_ulong height;
        c_ulong depth;
    }
    struct cudaPitchedPtr
    {
        void* ptr;
        c_ulong pitch;
        c_ulong xsize;
        c_ulong ysize;
    }
    enum cudaMemcpyKind
    {
        cudaMemcpyHostToHost = 0,
        cudaMemcpyHostToDevice = 1,
        cudaMemcpyDeviceToHost = 2,
        cudaMemcpyDeviceToDevice = 3,
        cudaMemcpyDefault = 4,
    }
    enum cudaMemcpyHostToHost = cudaMemcpyKind.cudaMemcpyHostToHost;
    enum cudaMemcpyHostToDevice = cudaMemcpyKind.cudaMemcpyHostToDevice;
    enum cudaMemcpyDeviceToHost = cudaMemcpyKind.cudaMemcpyDeviceToHost;
    enum cudaMemcpyDeviceToDevice = cudaMemcpyKind.cudaMemcpyDeviceToDevice;
    enum cudaMemcpyDefault = cudaMemcpyKind.cudaMemcpyDefault;
    enum cudaMemoryType
    {
        cudaMemoryTypeUnregistered = 0,
        cudaMemoryTypeHost = 1,
        cudaMemoryTypeDevice = 2,
        cudaMemoryTypeManaged = 3,
    }
    enum cudaMemoryTypeUnregistered = cudaMemoryType.cudaMemoryTypeUnregistered;
    enum cudaMemoryTypeHost = cudaMemoryType.cudaMemoryTypeHost;
    enum cudaMemoryTypeDevice = cudaMemoryType.cudaMemoryTypeDevice;
    enum cudaMemoryTypeManaged = cudaMemoryType.cudaMemoryTypeManaged;
    alias cudaMipmappedArray_const_t = const(cudaMipmappedArray)*;
    struct cudaMipmappedArray;
    alias cudaMipmappedArray_t = cudaMipmappedArray*;
    alias cudaArray_const_t = const(cudaArray)*;
    struct cudaArray;
    alias cudaArray_t = cudaArray*;
    struct cudaChannelFormatDesc
    {
        int x;
        int y;
        int z;
        int w;
        cudaChannelFormatKind f;
    }
    enum cudaChannelFormatKind
    {
        cudaChannelFormatKindSigned = 0,
        cudaChannelFormatKindUnsigned = 1,
        cudaChannelFormatKindFloat = 2,
        cudaChannelFormatKindNone = 3,
    }
    enum cudaChannelFormatKindSigned = cudaChannelFormatKind.cudaChannelFormatKindSigned;
    enum cudaChannelFormatKindUnsigned = cudaChannelFormatKind.cudaChannelFormatKindUnsigned;
    enum cudaChannelFormatKindFloat = cudaChannelFormatKind.cudaChannelFormatKindFloat;
    enum cudaChannelFormatKindNone = cudaChannelFormatKind.cudaChannelFormatKindNone;
    enum cudaError
    {
        cudaSuccess = 0,
        cudaErrorMissingConfiguration = 1,
        cudaErrorMemoryAllocation = 2,
        cudaErrorInitializationError = 3,
        cudaErrorLaunchFailure = 4,
        cudaErrorPriorLaunchFailure = 5,
        cudaErrorLaunchTimeout = 6,
        cudaErrorLaunchOutOfResources = 7,
        cudaErrorInvalidDeviceFunction = 8,
        cudaErrorInvalidConfiguration = 9,
        cudaErrorInvalidDevice = 10,
        cudaErrorInvalidValue = 11,
        cudaErrorInvalidPitchValue = 12,
        cudaErrorInvalidSymbol = 13,
        cudaErrorMapBufferObjectFailed = 14,
        cudaErrorUnmapBufferObjectFailed = 15,
        cudaErrorInvalidHostPointer = 16,
        cudaErrorInvalidDevicePointer = 17,
        cudaErrorInvalidTexture = 18,
        cudaErrorInvalidTextureBinding = 19,
        cudaErrorInvalidChannelDescriptor = 20,
        cudaErrorInvalidMemcpyDirection = 21,
        cudaErrorAddressOfConstant = 22,
        cudaErrorTextureFetchFailed = 23,
        cudaErrorTextureNotBound = 24,
        cudaErrorSynchronizationError = 25,
        cudaErrorInvalidFilterSetting = 26,
        cudaErrorInvalidNormSetting = 27,
        cudaErrorMixedDeviceExecution = 28,
        cudaErrorCudartUnloading = 29,
        cudaErrorUnknown = 30,
        cudaErrorNotYetImplemented = 31,
        cudaErrorMemoryValueTooLarge = 32,
        cudaErrorInvalidResourceHandle = 33,
        cudaErrorNotReady = 34,
        cudaErrorInsufficientDriver = 35,
        cudaErrorSetOnActiveProcess = 36,
        cudaErrorInvalidSurface = 37,
        cudaErrorNoDevice = 38,
        cudaErrorECCUncorrectable = 39,
        cudaErrorSharedObjectSymbolNotFound = 40,
        cudaErrorSharedObjectInitFailed = 41,
        cudaErrorUnsupportedLimit = 42,
        cudaErrorDuplicateVariableName = 43,
        cudaErrorDuplicateTextureName = 44,
        cudaErrorDuplicateSurfaceName = 45,
        cudaErrorDevicesUnavailable = 46,
        cudaErrorInvalidKernelImage = 47,
        cudaErrorNoKernelImageForDevice = 48,
        cudaErrorIncompatibleDriverContext = 49,
        cudaErrorPeerAccessAlreadyEnabled = 50,
        cudaErrorPeerAccessNotEnabled = 51,
        cudaErrorDeviceAlreadyInUse = 54,
        cudaErrorProfilerDisabled = 55,
        cudaErrorProfilerNotInitialized = 56,
        cudaErrorProfilerAlreadyStarted = 57,
        cudaErrorProfilerAlreadyStopped = 58,
        cudaErrorAssert = 59,
        cudaErrorTooManyPeers = 60,
        cudaErrorHostMemoryAlreadyRegistered = 61,
        cudaErrorHostMemoryNotRegistered = 62,
        cudaErrorOperatingSystem = 63,
        cudaErrorPeerAccessUnsupported = 64,
        cudaErrorLaunchMaxDepthExceeded = 65,
        cudaErrorLaunchFileScopedTex = 66,
        cudaErrorLaunchFileScopedSurf = 67,
        cudaErrorSyncDepthExceeded = 68,
        cudaErrorLaunchPendingCountExceeded = 69,
        cudaErrorNotPermitted = 70,
        cudaErrorNotSupported = 71,
        cudaErrorHardwareStackError = 72,
        cudaErrorIllegalInstruction = 73,
        cudaErrorMisalignedAddress = 74,
        cudaErrorInvalidAddressSpace = 75,
        cudaErrorInvalidPc = 76,
        cudaErrorIllegalAddress = 77,
        cudaErrorInvalidPtx = 78,
        cudaErrorInvalidGraphicsContext = 79,
        cudaErrorNvlinkUncorrectable = 80,
        cudaErrorJitCompilerNotFound = 81,
        cudaErrorCooperativeLaunchTooLarge = 82,
        cudaErrorSystemNotReady = 83,
        cudaErrorIllegalState = 84,
        cudaErrorStartupFailure = 127,
        cudaErrorStreamCaptureUnsupported = 900,
        cudaErrorStreamCaptureInvalidated = 901,
        cudaErrorStreamCaptureMerge = 902,
        cudaErrorStreamCaptureUnmatched = 903,
        cudaErrorStreamCaptureUnjoined = 904,
        cudaErrorStreamCaptureIsolation = 905,
        cudaErrorStreamCaptureImplicit = 906,
        cudaErrorCapturedEvent = 907,
        cudaErrorApiFailureBase = 10000,
    }
    enum cudaSuccess = cudaError.cudaSuccess;
    enum cudaErrorMissingConfiguration = cudaError.cudaErrorMissingConfiguration;
    enum cudaErrorMemoryAllocation = cudaError.cudaErrorMemoryAllocation;
    enum cudaErrorInitializationError = cudaError.cudaErrorInitializationError;
    enum cudaErrorLaunchFailure = cudaError.cudaErrorLaunchFailure;
    enum cudaErrorPriorLaunchFailure = cudaError.cudaErrorPriorLaunchFailure;
    enum cudaErrorLaunchTimeout = cudaError.cudaErrorLaunchTimeout;
    enum cudaErrorLaunchOutOfResources = cudaError.cudaErrorLaunchOutOfResources;
    enum cudaErrorInvalidDeviceFunction = cudaError.cudaErrorInvalidDeviceFunction;
    enum cudaErrorInvalidConfiguration = cudaError.cudaErrorInvalidConfiguration;
    enum cudaErrorInvalidDevice = cudaError.cudaErrorInvalidDevice;
    enum cudaErrorInvalidValue = cudaError.cudaErrorInvalidValue;
    enum cudaErrorInvalidPitchValue = cudaError.cudaErrorInvalidPitchValue;
    enum cudaErrorInvalidSymbol = cudaError.cudaErrorInvalidSymbol;
    enum cudaErrorMapBufferObjectFailed = cudaError.cudaErrorMapBufferObjectFailed;
    enum cudaErrorUnmapBufferObjectFailed = cudaError.cudaErrorUnmapBufferObjectFailed;
    enum cudaErrorInvalidHostPointer = cudaError.cudaErrorInvalidHostPointer;
    enum cudaErrorInvalidDevicePointer = cudaError.cudaErrorInvalidDevicePointer;
    enum cudaErrorInvalidTexture = cudaError.cudaErrorInvalidTexture;
    enum cudaErrorInvalidTextureBinding = cudaError.cudaErrorInvalidTextureBinding;
    enum cudaErrorInvalidChannelDescriptor = cudaError.cudaErrorInvalidChannelDescriptor;
    enum cudaErrorInvalidMemcpyDirection = cudaError.cudaErrorInvalidMemcpyDirection;
    enum cudaErrorAddressOfConstant = cudaError.cudaErrorAddressOfConstant;
    enum cudaErrorTextureFetchFailed = cudaError.cudaErrorTextureFetchFailed;
    enum cudaErrorTextureNotBound = cudaError.cudaErrorTextureNotBound;
    enum cudaErrorSynchronizationError = cudaError.cudaErrorSynchronizationError;
    enum cudaErrorInvalidFilterSetting = cudaError.cudaErrorInvalidFilterSetting;
    enum cudaErrorInvalidNormSetting = cudaError.cudaErrorInvalidNormSetting;
    enum cudaErrorMixedDeviceExecution = cudaError.cudaErrorMixedDeviceExecution;
    enum cudaErrorCudartUnloading = cudaError.cudaErrorCudartUnloading;
    enum cudaErrorUnknown = cudaError.cudaErrorUnknown;
    enum cudaErrorNotYetImplemented = cudaError.cudaErrorNotYetImplemented;
    enum cudaErrorMemoryValueTooLarge = cudaError.cudaErrorMemoryValueTooLarge;
    enum cudaErrorInvalidResourceHandle = cudaError.cudaErrorInvalidResourceHandle;
    enum cudaErrorNotReady = cudaError.cudaErrorNotReady;
    enum cudaErrorInsufficientDriver = cudaError.cudaErrorInsufficientDriver;
    enum cudaErrorSetOnActiveProcess = cudaError.cudaErrorSetOnActiveProcess;
    enum cudaErrorInvalidSurface = cudaError.cudaErrorInvalidSurface;
    enum cudaErrorNoDevice = cudaError.cudaErrorNoDevice;
    enum cudaErrorECCUncorrectable = cudaError.cudaErrorECCUncorrectable;
    enum cudaErrorSharedObjectSymbolNotFound = cudaError.cudaErrorSharedObjectSymbolNotFound;
    enum cudaErrorSharedObjectInitFailed = cudaError.cudaErrorSharedObjectInitFailed;
    enum cudaErrorUnsupportedLimit = cudaError.cudaErrorUnsupportedLimit;
    enum cudaErrorDuplicateVariableName = cudaError.cudaErrorDuplicateVariableName;
    enum cudaErrorDuplicateTextureName = cudaError.cudaErrorDuplicateTextureName;
    enum cudaErrorDuplicateSurfaceName = cudaError.cudaErrorDuplicateSurfaceName;
    enum cudaErrorDevicesUnavailable = cudaError.cudaErrorDevicesUnavailable;
    enum cudaErrorInvalidKernelImage = cudaError.cudaErrorInvalidKernelImage;
    enum cudaErrorNoKernelImageForDevice = cudaError.cudaErrorNoKernelImageForDevice;
    enum cudaErrorIncompatibleDriverContext = cudaError.cudaErrorIncompatibleDriverContext;
    enum cudaErrorPeerAccessAlreadyEnabled = cudaError.cudaErrorPeerAccessAlreadyEnabled;
    enum cudaErrorPeerAccessNotEnabled = cudaError.cudaErrorPeerAccessNotEnabled;
    enum cudaErrorDeviceAlreadyInUse = cudaError.cudaErrorDeviceAlreadyInUse;
    enum cudaErrorProfilerDisabled = cudaError.cudaErrorProfilerDisabled;
    enum cudaErrorProfilerNotInitialized = cudaError.cudaErrorProfilerNotInitialized;
    enum cudaErrorProfilerAlreadyStarted = cudaError.cudaErrorProfilerAlreadyStarted;
    enum cudaErrorProfilerAlreadyStopped = cudaError.cudaErrorProfilerAlreadyStopped;
    enum cudaErrorAssert = cudaError.cudaErrorAssert;
    enum cudaErrorTooManyPeers = cudaError.cudaErrorTooManyPeers;
    enum cudaErrorHostMemoryAlreadyRegistered = cudaError.cudaErrorHostMemoryAlreadyRegistered;
    enum cudaErrorHostMemoryNotRegistered = cudaError.cudaErrorHostMemoryNotRegistered;
    enum cudaErrorOperatingSystem = cudaError.cudaErrorOperatingSystem;
    enum cudaErrorPeerAccessUnsupported = cudaError.cudaErrorPeerAccessUnsupported;
    enum cudaErrorLaunchMaxDepthExceeded = cudaError.cudaErrorLaunchMaxDepthExceeded;
    enum cudaErrorLaunchFileScopedTex = cudaError.cudaErrorLaunchFileScopedTex;
    enum cudaErrorLaunchFileScopedSurf = cudaError.cudaErrorLaunchFileScopedSurf;
    enum cudaErrorSyncDepthExceeded = cudaError.cudaErrorSyncDepthExceeded;
    enum cudaErrorLaunchPendingCountExceeded = cudaError.cudaErrorLaunchPendingCountExceeded;
    enum cudaErrorNotPermitted = cudaError.cudaErrorNotPermitted;
    enum cudaErrorNotSupported = cudaError.cudaErrorNotSupported;
    enum cudaErrorHardwareStackError = cudaError.cudaErrorHardwareStackError;
    enum cudaErrorIllegalInstruction = cudaError.cudaErrorIllegalInstruction;
    enum cudaErrorMisalignedAddress = cudaError.cudaErrorMisalignedAddress;
    enum cudaErrorInvalidAddressSpace = cudaError.cudaErrorInvalidAddressSpace;
    enum cudaErrorInvalidPc = cudaError.cudaErrorInvalidPc;
    enum cudaErrorIllegalAddress = cudaError.cudaErrorIllegalAddress;
    enum cudaErrorInvalidPtx = cudaError.cudaErrorInvalidPtx;
    enum cudaErrorInvalidGraphicsContext = cudaError.cudaErrorInvalidGraphicsContext;
    enum cudaErrorNvlinkUncorrectable = cudaError.cudaErrorNvlinkUncorrectable;
    enum cudaErrorJitCompilerNotFound = cudaError.cudaErrorJitCompilerNotFound;
    enum cudaErrorCooperativeLaunchTooLarge = cudaError.cudaErrorCooperativeLaunchTooLarge;
    enum cudaErrorSystemNotReady = cudaError.cudaErrorSystemNotReady;
    enum cudaErrorIllegalState = cudaError.cudaErrorIllegalState;
    enum cudaErrorStartupFailure = cudaError.cudaErrorStartupFailure;
    enum cudaErrorStreamCaptureUnsupported = cudaError.cudaErrorStreamCaptureUnsupported;
    enum cudaErrorStreamCaptureInvalidated = cudaError.cudaErrorStreamCaptureInvalidated;
    enum cudaErrorStreamCaptureMerge = cudaError.cudaErrorStreamCaptureMerge;
    enum cudaErrorStreamCaptureUnmatched = cudaError.cudaErrorStreamCaptureUnmatched;
    enum cudaErrorStreamCaptureUnjoined = cudaError.cudaErrorStreamCaptureUnjoined;
    enum cudaErrorStreamCaptureIsolation = cudaError.cudaErrorStreamCaptureIsolation;
    enum cudaErrorStreamCaptureImplicit = cudaError.cudaErrorStreamCaptureImplicit;
    enum cudaErrorCapturedEvent = cudaError.cudaErrorCapturedEvent;
    enum cudaErrorApiFailureBase = cudaError.cudaErrorApiFailureBase;
    alias ptrdiff_t = c_long;
    struct __half2_raw
    {
        ushort x;
        ushort y;
    }
    alias size_t = c_ulong;
    alias wchar_t = int;
    struct __half_raw
    {
        ushort x;
    }
    cublasStatus_t cublasZtrttp(cublasContext*, cublasFillMode_t, int, const(double2)*, int, double2*) @nogc nothrow;
    cublasStatus_t cublasCtrttp(cublasContext*, cublasFillMode_t, int, const(float2)*, int, float2*) @nogc nothrow;
    cublasStatus_t cublasDtrttp(cublasContext*, cublasFillMode_t, int, const(double)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasStrttp(cublasContext*, cublasFillMode_t, int, const(float)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasZtpttr(cublasContext*, cublasFillMode_t, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCtpttr(cublasContext*, cublasFillMode_t, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDtpttr(cublasContext*, cublasFillMode_t, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasStpttr(cublasContext*, cublasFillMode_t, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasZdgmm(cublasContext*, cublasSideMode_t, int, int, const(double2)*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCdgmm(cublasContext*, cublasSideMode_t, int, int, const(float2)*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDdgmm(cublasContext*, cublasSideMode_t, int, int, const(double)*, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasSdgmm(cublasContext*, cublasSideMode_t, int, int, const(float)*, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasZgelsBatched(cublasContext*, cublasOperation_t, int, int, int, double2**, int, double2**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasCgelsBatched(cublasContext*, cublasOperation_t, int, int, int, float2**, int, float2**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasDgelsBatched(cublasContext*, cublasOperation_t, int, int, int, double**, int, double**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasSgelsBatched(cublasContext*, cublasOperation_t, int, int, int, float**, int, float**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasZgeqrfBatched(cublasContext*, int, int, double2**, int, double2**, int*, int) @nogc nothrow;
    cublasStatus_t cublasCgeqrfBatched(cublasContext*, int, int, float2**, int, float2**, int*, int) @nogc nothrow;
    cublasStatus_t cublasDgeqrfBatched(cublasContext*, int, int, double**, int, double**, int*, int) @nogc nothrow;
    cublasStatus_t cublasSgeqrfBatched(cublasContext*, int, int, float**, int, float**, int*, int) @nogc nothrow;
    cublasStatus_t cublasZmatinvBatched(cublasContext*, int, const(const(double2)*)*, int, double2**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasCmatinvBatched(cublasContext*, int, const(const(float2)*)*, int, float2**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasDmatinvBatched(cublasContext*, int, const(const(double)*)*, int, double**, int, int*, int) @nogc nothrow;
    extern __gshared int signgam;
    enum _Anonymous_13
    {
        FP_NAN = 0,
        FP_INFINITE = 1,
        FP_ZERO = 2,
        FP_SUBNORMAL = 3,
        FP_NORMAL = 4,
    }
    enum FP_NAN = _Anonymous_13.FP_NAN;
    enum FP_INFINITE = _Anonymous_13.FP_INFINITE;
    enum FP_ZERO = _Anonymous_13.FP_ZERO;
    enum FP_SUBNORMAL = _Anonymous_13.FP_SUBNORMAL;
    enum FP_NORMAL = _Anonymous_13.FP_NORMAL;
    cublasStatus_t cublasSmatinvBatched(cublasContext*, int, const(const(float)*)*, int, float**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasZtrsmBatched(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double2)*, const(const(double2)*)*, int, double2**, int, int) @nogc nothrow;
    cublasStatus_t cublasCtrsmBatched(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float2)*, const(const(float2)*)*, int, float2**, int, int) @nogc nothrow;
    cublasStatus_t cublasDtrsmBatched(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double)*, const(const(double)*)*, int, double**, int, int) @nogc nothrow;
    alias _LIB_VERSION_TYPE = _Anonymous_14;
    enum _Anonymous_14
    {
        _IEEE_ = -1,
        _SVID_ = 0,
        _XOPEN_ = 1,
        _POSIX_ = 2,
        _ISOC_ = 3,
    }
    enum _IEEE_ = _Anonymous_14._IEEE_;
    enum _SVID_ = _Anonymous_14._SVID_;
    enum _XOPEN_ = _Anonymous_14._XOPEN_;
    enum _POSIX_ = _Anonymous_14._POSIX_;
    enum _ISOC_ = _Anonymous_14._ISOC_;
    extern __gshared _LIB_VERSION_TYPE _LIB_VERSION;
    struct exception
    {
        int type;
        char* name;
        double arg1;
        double arg2;
        double retval;
    }
    int matherr(exception*) @nogc nothrow;
    cublasStatus_t cublasStrsmBatched(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float)*, const(const(float)*)*, int, float**, int, int) @nogc nothrow;
    cublasStatus_t cublasZgetrsBatched(cublasContext*, cublasOperation_t, int, int, const(const(double2)*)*, int, const(int)*, double2**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasCgetrsBatched(cublasContext*, cublasOperation_t, int, int, const(const(float2)*)*, int, const(int)*, float2**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasDgetrsBatched(cublasContext*, cublasOperation_t, int, int, const(const(double)*)*, int, const(int)*, double**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasSgetrsBatched(cublasContext*, cublasOperation_t, int, int, const(const(float)*)*, int, const(int)*, float**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasZgetriBatched(cublasContext*, int, const(const(double2)*)*, int, const(int)*, double2**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasCgetriBatched(cublasContext*, int, const(const(float2)*)*, int, const(int)*, float2**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasDgetriBatched(cublasContext*, int, const(const(double)*)*, int, const(int)*, double**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasSgetriBatched(cublasContext*, int, const(const(float)*)*, int, const(int)*, float**, int, int*, int) @nogc nothrow;
    cublasStatus_t cublasZgetrfBatched(cublasContext*, int, double2**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasCgetrfBatched(cublasContext*, int, float2**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasDgetrfBatched(cublasContext*, int, double**, int, int*, int*, int) @nogc nothrow;
    void* memcpy(void*, const(void)*, c_ulong) @nogc nothrow;
    void* memmove(void*, const(void)*, c_ulong) @nogc nothrow;
    void* memccpy(void*, const(void)*, int, c_ulong) @nogc nothrow;
    void* memset(void*, int, c_ulong) @nogc nothrow;
    int memcmp(const(void)*, const(void)*, c_ulong) @nogc nothrow;
    void* memchr(const(void)*, int, c_ulong) @nogc nothrow;
    char* strcpy(char*, const(char)*) @nogc nothrow;
    char* strncpy(char*, const(char)*, c_ulong) @nogc nothrow;
    char* strcat(char*, const(char)*) @nogc nothrow;
    char* strncat(char*, const(char)*, c_ulong) @nogc nothrow;
    int strcmp(const(char)*, const(char)*) @nogc nothrow;
    int strncmp(const(char)*, const(char)*, c_ulong) @nogc nothrow;
    int strcoll(const(char)*, const(char)*) @nogc nothrow;
    c_ulong strxfrm(char*, const(char)*, c_ulong) @nogc nothrow;
    int strcoll_l(const(char)*, const(char)*, __locale_struct*) @nogc nothrow;
    c_ulong strxfrm_l(char*, const(char)*, c_ulong, __locale_struct*) @nogc nothrow;
    char* strdup(const(char)*) @nogc nothrow;
    char* strndup(const(char)*, c_ulong) @nogc nothrow;
    char* strchr(const(char)*, int) @nogc nothrow;
    char* strrchr(const(char)*, int) @nogc nothrow;
    c_ulong strcspn(const(char)*, const(char)*) @nogc nothrow;
    c_ulong strspn(const(char)*, const(char)*) @nogc nothrow;
    char* strpbrk(const(char)*, const(char)*) @nogc nothrow;
    char* strstr(const(char)*, const(char)*) @nogc nothrow;
    char* strtok(char*, const(char)*) @nogc nothrow;
    char* __strtok_r(char*, const(char)*, char**) @nogc nothrow;
    char* strtok_r(char*, const(char)*, char**) @nogc nothrow;
    c_ulong strlen(const(char)*) @nogc nothrow;
    c_ulong strnlen(const(char)*, c_ulong) @nogc nothrow;
    char* strerror(int) @nogc nothrow;
    int strerror_r(int, char*, c_ulong) @nogc nothrow;
    char* strerror_l(int, __locale_struct*) @nogc nothrow;
    void __bzero(void*, c_ulong) @nogc nothrow;
    void bcopy(const(void)*, void*, c_ulong) @nogc nothrow;
    void bzero(void*, c_ulong) @nogc nothrow;
    int bcmp(const(void)*, const(void)*, c_ulong) @nogc nothrow;
    char* index(const(char)*, int) @nogc nothrow;
    char* rindex(const(char)*, int) @nogc nothrow;
    int ffs(int) @nogc nothrow;
    int strcasecmp(const(char)*, const(char)*) @nogc nothrow;
    int strncasecmp(const(char)*, const(char)*, c_ulong) @nogc nothrow;
    char* strsep(char**, const(char)*) @nogc nothrow;
    char* strsignal(int) @nogc nothrow;
    char* __stpcpy(char*, const(char)*) @nogc nothrow;
    char* stpcpy(char*, const(char)*) @nogc nothrow;
    char* __stpncpy(char*, const(char)*, c_ulong) @nogc nothrow;
    char* stpncpy(char*, const(char)*, c_ulong) @nogc nothrow;
    cublasStatus_t cublasSgetrfBatched(cublasContext*, int, float**, int, int*, int*, int) @nogc nothrow;
    cublasStatus_t cublasZgeam(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCgeam(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDgeam(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, const(double)*, const(double)*, int, const(double)*, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasSgeam(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, const(float)*, const(float)*, int, const(float)*, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasZgemmStridedBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double2)*, const(double2)*, int, long, const(double2)*, int, long, const(double2)*, double2*, int, long, int) @nogc nothrow;
    cublasStatus_t cublasCgemm3mStridedBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(float2)*, int, long, const(float2)*, int, long, const(float2)*, float2*, int, long, int) @nogc nothrow;
    cublasStatus_t cublasCgemmStridedBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(float2)*, int, long, const(float2)*, int, long, const(float2)*, float2*, int, long, int) @nogc nothrow;
    cublasStatus_t cublasDgemmStridedBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double)*, const(double)*, int, long, const(double)*, int, long, const(double)*, double*, int, long, int) @nogc nothrow;
    cublasStatus_t cublasSgemmStridedBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float)*, const(float)*, int, long, const(float)*, int, long, const(float)*, float*, int, long, int) @nogc nothrow;
    cublasStatus_t cublasGemmStridedBatchedEx(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(void)*, const(void)*, cudaDataType_t, int, long, const(void)*, cudaDataType_t, int, long, const(void)*, void*, cudaDataType_t, int, long, int, cudaDataType_t, cublasGemmAlgo_t) @nogc nothrow;
    cublasStatus_t cublasGemmBatchedEx(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(void)*, const(const(void)*)*, cudaDataType_t, int, const(const(void)*)*, cudaDataType_t, int, const(void)*, void**, cudaDataType_t, int, int, cudaDataType_t, cublasGemmAlgo_t) @nogc nothrow;
    cublasStatus_t cublasZgemmBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double2)*, const(const(double2)*)*, int, const(const(double2)*)*, int, const(double2)*, double2**, int, int) @nogc nothrow;
    real __acosl(real) @nogc nothrow;
    real acosl(real) @nogc nothrow;
    double __acos(double) @nogc nothrow;
    float acosf(float) @nogc nothrow;
    float __acosf(float) @nogc nothrow;
    double acos(double) @nogc nothrow;
    real __asinl(real) @nogc nothrow;
    real asinl(real) @nogc nothrow;
    double __asin(double) @nogc nothrow;
    float __asinf(float) @nogc nothrow;
    float asinf(float) @nogc nothrow;
    double asin(double) @nogc nothrow;
    float atanf(float) @nogc nothrow;
    float __atanf(float) @nogc nothrow;
    double __atan(double) @nogc nothrow;
    real atanl(real) @nogc nothrow;
    real __atanl(real) @nogc nothrow;
    double atan(double) @nogc nothrow;
    float __atan2f(float, float) @nogc nothrow;
    float atan2f(float, float) @nogc nothrow;
    real __atan2l(real, real) @nogc nothrow;
    real atan2l(real, real) @nogc nothrow;
    double __atan2(double, double) @nogc nothrow;
    double atan2(double, double) @nogc nothrow;
    float __cosf(float) @nogc nothrow;
    float cosf(float) @nogc nothrow;
    real __cosl(real) @nogc nothrow;
    real cosl(real) @nogc nothrow;
    double __cos(double) @nogc nothrow;
    double cos(double) @nogc nothrow;
    float sinf(float) @nogc nothrow;
    float __sinf(float) @nogc nothrow;
    real __sinl(real) @nogc nothrow;
    real sinl(real) @nogc nothrow;
    double __sin(double) @nogc nothrow;
    double sin(double) @nogc nothrow;
    real tanl(real) @nogc nothrow;
    real __tanl(real) @nogc nothrow;
    float tanf(float) @nogc nothrow;
    float __tanf(float) @nogc nothrow;
    double __tan(double) @nogc nothrow;
    double tan(double) @nogc nothrow;
    float __coshf(float) @nogc nothrow;
    float coshf(float) @nogc nothrow;
    real __coshl(real) @nogc nothrow;
    real coshl(real) @nogc nothrow;
    double __cosh(double) @nogc nothrow;
    double cosh(double) @nogc nothrow;
    double __sinh(double) @nogc nothrow;
    float sinhf(float) @nogc nothrow;
    float __sinhf(float) @nogc nothrow;
    real sinhl(real) @nogc nothrow;
    real __sinhl(real) @nogc nothrow;
    double sinh(double) @nogc nothrow;
    float __tanhf(float) @nogc nothrow;
    float tanhf(float) @nogc nothrow;
    real tanhl(real) @nogc nothrow;
    real __tanhl(real) @nogc nothrow;
    double __tanh(double) @nogc nothrow;
    double tanh(double) @nogc nothrow;
    real __acoshl(real) @nogc nothrow;
    real acoshl(real) @nogc nothrow;
    double __acosh(double) @nogc nothrow;
    float acoshf(float) @nogc nothrow;
    float __acoshf(float) @nogc nothrow;
    double acosh(double) @nogc nothrow;
    double __asinh(double) @nogc nothrow;
    float asinhf(float) @nogc nothrow;
    float __asinhf(float) @nogc nothrow;
    real asinhl(real) @nogc nothrow;
    real __asinhl(real) @nogc nothrow;
    double asinh(double) @nogc nothrow;
    float atanhf(float) @nogc nothrow;
    float __atanhf(float) @nogc nothrow;
    double __atanh(double) @nogc nothrow;
    real atanhl(real) @nogc nothrow;
    real __atanhl(real) @nogc nothrow;
    double atanh(double) @nogc nothrow;
    double __exp(double) @nogc nothrow;
    float __expf(float) @nogc nothrow;
    float expf(float) @nogc nothrow;
    real expl(real) @nogc nothrow;
    real __expl(real) @nogc nothrow;
    double exp(double) @nogc nothrow;
    real __frexpl(real, int*) @nogc nothrow;
    double __frexp(double, int*) @nogc nothrow;
    float __frexpf(float, int*) @nogc nothrow;
    float frexpf(float, int*) @nogc nothrow;
    real frexpl(real, int*) @nogc nothrow;
    double frexp(double, int*) @nogc nothrow;
    real __ldexpl(real, int) @nogc nothrow;
    float ldexpf(float, int) @nogc nothrow;
    double __ldexp(double, int) @nogc nothrow;
    float __ldexpf(float, int) @nogc nothrow;
    real ldexpl(real, int) @nogc nothrow;
    double ldexp(double, int) @nogc nothrow;
    real __logl(real) @nogc nothrow;
    double __log(double) @nogc nothrow;
    float logf(float) @nogc nothrow;
    float __logf(float) @nogc nothrow;
    real logl(real) @nogc nothrow;
    double log(double) @nogc nothrow;
    double __log10(double) @nogc nothrow;
    real log10l(real) @nogc nothrow;
    float log10f(float) @nogc nothrow;
    real __log10l(real) @nogc nothrow;
    float __log10f(float) @nogc nothrow;
    double log10(double) @nogc nothrow;
    double __modf(double, double*) @nogc nothrow;
    float __modff(float, float*) @nogc nothrow;
    real __modfl(real, real*) @nogc nothrow;
    real modfl(real, real*) @nogc nothrow;
    float modff(float, float*) @nogc nothrow;
    double modf(double, double*) @nogc nothrow;
    real expm1l(real) @nogc nothrow;
    real __expm1l(real) @nogc nothrow;
    double __expm1(double) @nogc nothrow;
    float expm1f(float) @nogc nothrow;
    float __expm1f(float) @nogc nothrow;
    double expm1(double) @nogc nothrow;
    real log1pl(real) @nogc nothrow;
    real __log1pl(real) @nogc nothrow;
    float log1pf(float) @nogc nothrow;
    float __log1pf(float) @nogc nothrow;
    double __log1p(double) @nogc nothrow;
    double log1p(double) @nogc nothrow;
    real logbl(real) @nogc nothrow;
    real __logbl(real) @nogc nothrow;
    float logbf(float) @nogc nothrow;
    float __logbf(float) @nogc nothrow;
    double __logb(double) @nogc nothrow;
    double logb(double) @nogc nothrow;
    double __exp2(double) @nogc nothrow;
    float __exp2f(float) @nogc nothrow;
    float exp2f(float) @nogc nothrow;
    real exp2l(real) @nogc nothrow;
    real __exp2l(real) @nogc nothrow;
    double exp2(double) @nogc nothrow;
    real log2l(real) @nogc nothrow;
    float log2f(float) @nogc nothrow;
    float __log2f(float) @nogc nothrow;
    real __log2l(real) @nogc nothrow;
    double __log2(double) @nogc nothrow;
    double log2(double) @nogc nothrow;
    real __powl(real, real) @nogc nothrow;
    real powl(real, real) @nogc nothrow;
    float powf(float, float) @nogc nothrow;
    float __powf(float, float) @nogc nothrow;
    double __pow(double, double) @nogc nothrow;
    double pow(double, double) @nogc nothrow;
    real __sqrtl(real) @nogc nothrow;
    real sqrtl(real) @nogc nothrow;
    float sqrtf(float) @nogc nothrow;
    double __sqrt(double) @nogc nothrow;
    float __sqrtf(float) @nogc nothrow;
    double sqrt(double) @nogc nothrow;
    double __hypot(double, double) @nogc nothrow;
    float hypotf(float, float) @nogc nothrow;
    float __hypotf(float, float) @nogc nothrow;
    real __hypotl(real, real) @nogc nothrow;
    real hypotl(real, real) @nogc nothrow;
    double hypot(double, double) @nogc nothrow;
    real cbrtl(real) @nogc nothrow;
    real __cbrtl(real) @nogc nothrow;
    float cbrtf(float) @nogc nothrow;
    double __cbrt(double) @nogc nothrow;
    float __cbrtf(float) @nogc nothrow;
    double cbrt(double) @nogc nothrow;
    double __ceil(double) @nogc nothrow;
    real ceill(real) @nogc nothrow;
    real __ceill(real) @nogc nothrow;
    float ceilf(float) @nogc nothrow;
    float __ceilf(float) @nogc nothrow;
    double ceil(double) @nogc nothrow;
    real fabsl(real) @nogc nothrow;
    double __fabs(double) @nogc nothrow;
    float fabsf(float) @nogc nothrow;
    float __fabsf(float) @nogc nothrow;
    real __fabsl(real) @nogc nothrow;
    double fabs(double) @nogc nothrow;
    double __floor(double) @nogc nothrow;
    real floorl(real) @nogc nothrow;
    float floorf(float) @nogc nothrow;
    float __floorf(float) @nogc nothrow;
    real __floorl(real) @nogc nothrow;
    double floor(double) @nogc nothrow;
    real __fmodl(real, real) @nogc nothrow;
    real fmodl(real, real) @nogc nothrow;
    double __fmod(double, double) @nogc nothrow;
    float __fmodf(float, float) @nogc nothrow;
    float fmodf(float, float) @nogc nothrow;
    double fmod(double, double) @nogc nothrow;
    int __isinfl(real) @nogc nothrow;
    int __isinff(float) @nogc nothrow;
    int __isinf(double) @nogc nothrow;
    int __finitel(real) @nogc nothrow;
    int __finitef(float) @nogc nothrow;
    int __finite(double) @nogc nothrow;
    int isinfl(real) @nogc nothrow;
    int isinff(float) @nogc nothrow;
    pragma(mangle, "isinf") int isinf_(double) @nogc nothrow;
    int finitel(real) @nogc nothrow;
    int finitef(float) @nogc nothrow;
    int finite(double) @nogc nothrow;
    double __drem(double, double) @nogc nothrow;
    double drem(double, double) @nogc nothrow;
    float __dremf(float, float) @nogc nothrow;
    float dremf(float, float) @nogc nothrow;
    real dreml(real, real) @nogc nothrow;
    real __dreml(real, real) @nogc nothrow;
    double __significand(double) @nogc nothrow;
    double significand(double) @nogc nothrow;
    float __significandf(float) @nogc nothrow;
    float significandf(float) @nogc nothrow;
    real significandl(real) @nogc nothrow;
    real __significandl(real) @nogc nothrow;
    real __copysignl(real, real) @nogc nothrow;
    real copysignl(real, real) @nogc nothrow;
    float __copysignf(float, float) @nogc nothrow;
    double __copysign(double, double) @nogc nothrow;
    float copysignf(float, float) @nogc nothrow;
    double copysign(double, double) @nogc nothrow;
    real __nanl(const(char)*) @nogc nothrow;
    real nanl(const(char)*) @nogc nothrow;
    float __nanf(const(char)*) @nogc nothrow;
    double __nan(const(char)*) @nogc nothrow;
    float nanf(const(char)*) @nogc nothrow;
    double nan(const(char)*) @nogc nothrow;
    int __isnanf(float) @nogc nothrow;
    int __isnan(double) @nogc nothrow;
    int __isnanl(real) @nogc nothrow;
    pragma(mangle, "isnan") int isnan_(double) @nogc nothrow;
    int isnanf(float) @nogc nothrow;
    int isnanl(real) @nogc nothrow;
    float __j0f(float) @nogc nothrow;
    float j0f(float) @nogc nothrow;
    real __j0l(real) @nogc nothrow;
    double j0(double) @nogc nothrow;
    double __j0(double) @nogc nothrow;
    real j0l(real) @nogc nothrow;
    real __j1l(real) @nogc nothrow;
    float __j1f(float) @nogc nothrow;
    float j1f(float) @nogc nothrow;
    real j1l(real) @nogc nothrow;
    double j1(double) @nogc nothrow;
    double __j1(double) @nogc nothrow;
    real jnl(int, real) @nogc nothrow;
    float jnf(int, float) @nogc nothrow;
    double __jn(int, double) @nogc nothrow;
    double jn(int, double) @nogc nothrow;
    float __jnf(int, float) @nogc nothrow;
    real __jnl(int, real) @nogc nothrow;
    real __y0l(real) @nogc nothrow;
    float __y0f(float) @nogc nothrow;
    float y0f(float) @nogc nothrow;
    double y0(double) @nogc nothrow;
    double __y0(double) @nogc nothrow;
    real y0l(real) @nogc nothrow;
    real y1l(real) @nogc nothrow;
    real __y1l(real) @nogc nothrow;
    float y1f(float) @nogc nothrow;
    float __y1f(float) @nogc nothrow;
    double y1(double) @nogc nothrow;
    double __y1(double) @nogc nothrow;
    double __yn(int, double) @nogc nothrow;
    double yn(int, double) @nogc nothrow;
    float __ynf(int, float) @nogc nothrow;
    float ynf(int, float) @nogc nothrow;
    real ynl(int, real) @nogc nothrow;
    real __ynl(int, real) @nogc nothrow;
    real __erfl(real) @nogc nothrow;
    real erfl(real) @nogc nothrow;
    float erff(float) @nogc nothrow;
    float __erff(float) @nogc nothrow;
    double __erf(double) @nogc nothrow;
    double erf(double) @nogc nothrow;
    real __erfcl(real) @nogc nothrow;
    real erfcl(real) @nogc nothrow;
    float erfcf(float) @nogc nothrow;
    float __erfcf(float) @nogc nothrow;
    double __erfc(double) @nogc nothrow;
    double erfc(double) @nogc nothrow;
    double __lgamma(double) @nogc nothrow;
    real lgammal(real) @nogc nothrow;
    real __lgammal(real) @nogc nothrow;
    float __lgammaf(float) @nogc nothrow;
    float lgammaf(float) @nogc nothrow;
    double lgamma(double) @nogc nothrow;
    float __tgammaf(float) @nogc nothrow;
    float tgammaf(float) @nogc nothrow;
    real tgammal(real) @nogc nothrow;
    real __tgammal(real) @nogc nothrow;
    double __tgamma(double) @nogc nothrow;
    double tgamma(double) @nogc nothrow;
    float __gammaf(float) @nogc nothrow;
    float gammaf(float) @nogc nothrow;
    real gammal(real) @nogc nothrow;
    real __gammal(real) @nogc nothrow;
    double gamma(double) @nogc nothrow;
    double __gamma(double) @nogc nothrow;
    float __lgammaf_r(float, int*) @nogc nothrow;
    float lgammaf_r(float, int*) @nogc nothrow;
    double __lgamma_r(double, int*) @nogc nothrow;
    double lgamma_r(double, int*) @nogc nothrow;
    real lgammal_r(real, int*) @nogc nothrow;
    real __lgammal_r(real, int*) @nogc nothrow;
    real __rintl(real) @nogc nothrow;
    double __rint(double) @nogc nothrow;
    float rintf(float) @nogc nothrow;
    float __rintf(float) @nogc nothrow;
    real rintl(real) @nogc nothrow;
    double rint(double) @nogc nothrow;
    float __nextafterf(float, float) @nogc nothrow;
    float nextafterf(float, float) @nogc nothrow;
    real __nextafterl(real, real) @nogc nothrow;
    double __nextafter(double, double) @nogc nothrow;
    real nextafterl(real, real) @nogc nothrow;
    double nextafter(double, double) @nogc nothrow;
    float nexttowardf(float, real) @nogc nothrow;
    float __nexttowardf(float, real) @nogc nothrow;
    double __nexttoward(double, real) @nogc nothrow;
    real nexttowardl(real, real) @nogc nothrow;
    real __nexttowardl(real, real) @nogc nothrow;
    double nexttoward(double, real) @nogc nothrow;
    double __remainder(double, double) @nogc nothrow;
    float __remainderf(float, float) @nogc nothrow;
    float remainderf(float, float) @nogc nothrow;
    real __remainderl(real, real) @nogc nothrow;
    real remainderl(real, real) @nogc nothrow;
    double remainder(double, double) @nogc nothrow;
    real scalbnl(real, int) @nogc nothrow;
    real __scalbnl(real, int) @nogc nothrow;
    double __scalbn(double, int) @nogc nothrow;
    float scalbnf(float, int) @nogc nothrow;
    float __scalbnf(float, int) @nogc nothrow;
    double scalbn(double, int) @nogc nothrow;
    int __ilogb(double) @nogc nothrow;
    int ilogbf(float) @nogc nothrow;
    int __ilogbf(float) @nogc nothrow;
    int __ilogbl(real) @nogc nothrow;
    int ilogbl(real) @nogc nothrow;
    int ilogb(double) @nogc nothrow;
    double __scalbln(double, c_long) @nogc nothrow;
    real scalblnl(real, c_long) @nogc nothrow;
    float __scalblnf(float, c_long) @nogc nothrow;
    float scalblnf(float, c_long) @nogc nothrow;
    real __scalblnl(real, c_long) @nogc nothrow;
    double scalbln(double, c_long) @nogc nothrow;
    double __nearbyint(double) @nogc nothrow;
    float __nearbyintf(float) @nogc nothrow;
    float nearbyintf(float) @nogc nothrow;
    real nearbyintl(real) @nogc nothrow;
    real __nearbyintl(real) @nogc nothrow;
    double nearbyint(double) @nogc nothrow;
    double __round(double) @nogc nothrow;
    real __roundl(real) @nogc nothrow;
    real roundl(real) @nogc nothrow;
    float roundf(float) @nogc nothrow;
    float __roundf(float) @nogc nothrow;
    double round(double) @nogc nothrow;
    real __truncl(real) @nogc nothrow;
    real truncl(real) @nogc nothrow;
    double __trunc(double) @nogc nothrow;
    float truncf(float) @nogc nothrow;
    float __truncf(float) @nogc nothrow;
    double trunc(double) @nogc nothrow;
    real __remquol(real, real, int*) @nogc nothrow;
    real remquol(real, real, int*) @nogc nothrow;
    double __remquo(double, double, int*) @nogc nothrow;
    float remquof(float, float, int*) @nogc nothrow;
    float __remquof(float, float, int*) @nogc nothrow;
    double remquo(double, double, int*) @nogc nothrow;
    c_long __lrint(double) @nogc nothrow;
    c_long lrintf(float) @nogc nothrow;
    c_long __lrintf(float) @nogc nothrow;
    c_long __lrintl(real) @nogc nothrow;
    c_long lrintl(real) @nogc nothrow;
    c_long lrint(double) @nogc nothrow;
    long __llrint(double) @nogc nothrow;
    long llrintf(float) @nogc nothrow;
    long __llrintf(float) @nogc nothrow;
    long __llrintl(real) @nogc nothrow;
    long llrintl(real) @nogc nothrow;
    long llrint(double) @nogc nothrow;
    c_long __lroundl(real) @nogc nothrow;
    c_long lroundl(real) @nogc nothrow;
    c_long __lroundf(float) @nogc nothrow;
    c_long lroundf(float) @nogc nothrow;
    c_long __lround(double) @nogc nothrow;
    c_long lround(double) @nogc nothrow;
    long __llroundf(float) @nogc nothrow;
    long llroundf(float) @nogc nothrow;
    long llroundl(real) @nogc nothrow;
    long __llroundl(real) @nogc nothrow;
    long __llround(double) @nogc nothrow;
    long llround(double) @nogc nothrow;
    double __fdim(double, double) @nogc nothrow;
    real __fdiml(real, real) @nogc nothrow;
    real fdiml(real, real) @nogc nothrow;
    float __fdimf(float, float) @nogc nothrow;
    float fdimf(float, float) @nogc nothrow;
    double fdim(double, double) @nogc nothrow;
    float __fmaxf(float, float) @nogc nothrow;
    float fmaxf(float, float) @nogc nothrow;
    real __fmaxl(real, real) @nogc nothrow;
    real fmaxl(real, real) @nogc nothrow;
    double __fmax(double, double) @nogc nothrow;
    double fmax(double, double) @nogc nothrow;
    float __fminf(float, float) @nogc nothrow;
    float fminf(float, float) @nogc nothrow;
    real __fminl(real, real) @nogc nothrow;
    real fminl(real, real) @nogc nothrow;
    double __fmin(double, double) @nogc nothrow;
    double fmin(double, double) @nogc nothrow;
    int __fpclassify(double) @nogc nothrow;
    int __fpclassifyl(real) @nogc nothrow;
    int __fpclassifyf(float) @nogc nothrow;
    int __signbitl(real) @nogc nothrow;
    int __signbitf(float) @nogc nothrow;
    int __signbit(double) @nogc nothrow;
    float fmaf(float, float, float) @nogc nothrow;
    float __fmaf(float, float, float) @nogc nothrow;
    real __fmal(real, real, real) @nogc nothrow;
    real fmal(real, real, real) @nogc nothrow;
    double __fma(double, double, double) @nogc nothrow;
    double fma(double, double, double) @nogc nothrow;
    float __scalbf(float, float) @nogc nothrow;
    float scalbf(float, float) @nogc nothrow;
    double __scalb(double, double) @nogc nothrow;
    real __scalbl(real, real) @nogc nothrow;
    double scalb(double, double) @nogc nothrow;
    real scalbl(real, real) @nogc nothrow;
    cublasStatus_t cublasCgemm3mBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(const(float2)*)*, int, const(const(float2)*)*, int, const(float2)*, float2**, int, int) @nogc nothrow;
    alias float_t = float;
    alias double_t = double;
    cublasStatus_t cublasCgemmBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(const(float2)*)*, int, const(const(float2)*)*, int, const(float2)*, float2**, int, int) @nogc nothrow;
    cublasStatus_t cublasDgemmBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double)*, const(const(double)*)*, int, const(const(double)*)*, int, const(double)*, double**, int, int) @nogc nothrow;
    cublasStatus_t cublasSgemmBatched(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float)*, const(const(float)*)*, int, const(const(float)*)*, int, const(float)*, float**, int, int) @nogc nothrow;
    cublasStatus_t cublasZtrmm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCtrmm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDtrmm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double)*, const(double)*, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasStrmm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float)*, const(float)*, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasZtrsm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double2)*, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCtrsm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float2)*, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDtrsm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double)*, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasStrsm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float)*, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasZhemm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasChemm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZsymm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCsymm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDsymm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasSsymm_v2(cublasContext*, cublasSideMode_t, cublasFillMode_t, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasZherkx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCherkx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZsyrkx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCsyrkx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDsyrkx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasSsyrkx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasZher2k_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCher2k_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZsyr2k_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCsyr2k_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDsyr2k_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasSsyr2k_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasCherk3mEx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float)*, const(void)*, cudaDataType_t, int, const(float)*, void*, cudaDataType_t, int) @nogc nothrow;
    cublasStatus_t cublasCherkEx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float)*, const(void)*, cudaDataType_t, int, const(float)*, void*, cudaDataType_t, int) @nogc nothrow;
    cublasStatus_t cublasZherk_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double)*, const(double2)*, int, const(double)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCherk_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float)*, const(float2)*, int, const(float)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasCsyrk3mEx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(void)*, cudaDataType_t, int, const(float2)*, void*, cudaDataType_t, int) @nogc nothrow;
    cublasStatus_t cublasCsyrkEx(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(void)*, cudaDataType_t, int, const(float2)*, void*, cudaDataType_t, int) @nogc nothrow;
    cublasStatus_t cublasZsyrk_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCsyrk_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDsyrk_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(double)*, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasSsyrk_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, int, int, const(float)*, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasUint8gemmBias(cublasContext*, cublasOperation_t, cublasOperation_t, cublasOperation_t, int, int, int, const(ubyte)*, int, int, const(ubyte)*, int, int, ubyte*, int, int, int, int) @nogc nothrow;
    cublasStatus_t cublasCgemmEx(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(void)*, cudaDataType_t, int, const(void)*, cudaDataType_t, int, const(float2)*, void*, cudaDataType_t, int) @nogc nothrow;
    cublasStatus_t cublasGemmEx(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(void)*, const(void)*, cudaDataType_t, int, const(void)*, cudaDataType_t, int, const(void)*, void*, cudaDataType_t, int, cudaDataType_t, cublasGemmAlgo_t) @nogc nothrow;
    cublasStatus_t cublasSgemmEx(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float)*, const(void)*, cudaDataType_t, int, const(void)*, cudaDataType_t, int, const(float)*, void*, cudaDataType_t, int) @nogc nothrow;
    alias __locale_t = __locale_struct*;
    struct __locale_struct
    {
        __locale_data*[13] __locales;
        const(ushort)* __ctype_b;
        const(int)* __ctype_tolower;
        const(int)* __ctype_toupper;
        const(char)*[13] __names;
    }
    alias locale_t = __locale_struct*;
    cublasStatus_t cublasZgemm3m(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasZgemm_v2(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCgemm3mEx(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(void)*, cudaDataType_t, int, const(void)*, cudaDataType_t, int, const(float2)*, void*, cudaDataType_t, int) @nogc nothrow;
    cublasStatus_t cublasCgemm3m(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasCgemm_v2(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasDgemm_v2(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasSgemm_v2(cublasContext*, cublasOperation_t, cublasOperation_t, int, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasZhpr2_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, int, const(double2)*, int, double2*) @nogc nothrow;
    alias cuFloatComplex = float2;
    static float cuCrealf(float2) @nogc nothrow;
    static float cuCimagf(float2) @nogc nothrow;
    static float2 make_cuFloatComplex(float, float) @nogc nothrow;
    static float2 cuConjf(float2) @nogc nothrow;
    static float2 cuCaddf(float2, float2) @nogc nothrow;
    static float2 cuCsubf(float2, float2) @nogc nothrow;
    static float2 cuCmulf(float2, float2) @nogc nothrow;
    static float2 cuCdivf(float2, float2) @nogc nothrow;
    static float cuCabsf(float2) @nogc nothrow;
    alias cuDoubleComplex = double2;
    static double cuCreal(double2) @nogc nothrow;
    static double cuCimag(double2) @nogc nothrow;
    static double2 make_cuDoubleComplex(double, double) @nogc nothrow;
    static double2 cuConj(double2) @nogc nothrow;
    static double2 cuCadd(double2, double2) @nogc nothrow;
    static double2 cuCsub(double2, double2) @nogc nothrow;
    static double2 cuCmul(double2, double2) @nogc nothrow;
    static double2 cuCdiv(double2, double2) @nogc nothrow;
    static double cuCabs(double2) @nogc nothrow;
    alias cuComplex = float2;
    static float2 make_cuComplex(float, float) @nogc nothrow;
    static double2 cuComplexFloatToDouble(float2) @nogc nothrow;
    static float2 cuComplexDoubleToFloat(double2) @nogc nothrow;
    static float2 cuCfmaf(float2, float2, float2) @nogc nothrow;
    static double2 cuCfma(double2, double2, double2) @nogc nothrow;
    cublasStatus_t cublasChpr2_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, int, const(float2)*, int, float2*) @nogc nothrow;
    alias cublasStatus_t = _Anonymous_15;
    enum _Anonymous_15
    {
        CUBLAS_STATUS_SUCCESS = 0,
        CUBLAS_STATUS_NOT_INITIALIZED = 1,
        CUBLAS_STATUS_ALLOC_FAILED = 3,
        CUBLAS_STATUS_INVALID_VALUE = 7,
        CUBLAS_STATUS_ARCH_MISMATCH = 8,
        CUBLAS_STATUS_MAPPING_ERROR = 11,
        CUBLAS_STATUS_EXECUTION_FAILED = 13,
        CUBLAS_STATUS_INTERNAL_ERROR = 14,
        CUBLAS_STATUS_NOT_SUPPORTED = 15,
        CUBLAS_STATUS_LICENSE_ERROR = 16,
    }
    enum CUBLAS_STATUS_SUCCESS = _Anonymous_15.CUBLAS_STATUS_SUCCESS;
    enum CUBLAS_STATUS_NOT_INITIALIZED = _Anonymous_15.CUBLAS_STATUS_NOT_INITIALIZED;
    enum CUBLAS_STATUS_ALLOC_FAILED = _Anonymous_15.CUBLAS_STATUS_ALLOC_FAILED;
    enum CUBLAS_STATUS_INVALID_VALUE = _Anonymous_15.CUBLAS_STATUS_INVALID_VALUE;
    enum CUBLAS_STATUS_ARCH_MISMATCH = _Anonymous_15.CUBLAS_STATUS_ARCH_MISMATCH;
    enum CUBLAS_STATUS_MAPPING_ERROR = _Anonymous_15.CUBLAS_STATUS_MAPPING_ERROR;
    enum CUBLAS_STATUS_EXECUTION_FAILED = _Anonymous_15.CUBLAS_STATUS_EXECUTION_FAILED;
    enum CUBLAS_STATUS_INTERNAL_ERROR = _Anonymous_15.CUBLAS_STATUS_INTERNAL_ERROR;
    enum CUBLAS_STATUS_NOT_SUPPORTED = _Anonymous_15.CUBLAS_STATUS_NOT_SUPPORTED;
    enum CUBLAS_STATUS_LICENSE_ERROR = _Anonymous_15.CUBLAS_STATUS_LICENSE_ERROR;
    alias cublasFillMode_t = _Anonymous_16;
    enum _Anonymous_16
    {
        CUBLAS_FILL_MODE_LOWER = 0,
        CUBLAS_FILL_MODE_UPPER = 1,
    }
    enum CUBLAS_FILL_MODE_LOWER = _Anonymous_16.CUBLAS_FILL_MODE_LOWER;
    enum CUBLAS_FILL_MODE_UPPER = _Anonymous_16.CUBLAS_FILL_MODE_UPPER;
    alias cublasDiagType_t = _Anonymous_17;
    enum _Anonymous_17
    {
        CUBLAS_DIAG_NON_UNIT = 0,
        CUBLAS_DIAG_UNIT = 1,
    }
    enum CUBLAS_DIAG_NON_UNIT = _Anonymous_17.CUBLAS_DIAG_NON_UNIT;
    enum CUBLAS_DIAG_UNIT = _Anonymous_17.CUBLAS_DIAG_UNIT;
    alias cublasSideMode_t = _Anonymous_18;
    enum _Anonymous_18
    {
        CUBLAS_SIDE_LEFT = 0,
        CUBLAS_SIDE_RIGHT = 1,
    }
    enum CUBLAS_SIDE_LEFT = _Anonymous_18.CUBLAS_SIDE_LEFT;
    enum CUBLAS_SIDE_RIGHT = _Anonymous_18.CUBLAS_SIDE_RIGHT;
    alias cublasOperation_t = _Anonymous_19;
    enum _Anonymous_19
    {
        CUBLAS_OP_N = 0,
        CUBLAS_OP_T = 1,
        CUBLAS_OP_C = 2,
    }
    enum CUBLAS_OP_N = _Anonymous_19.CUBLAS_OP_N;
    enum CUBLAS_OP_T = _Anonymous_19.CUBLAS_OP_T;
    enum CUBLAS_OP_C = _Anonymous_19.CUBLAS_OP_C;
    alias cublasPointerMode_t = _Anonymous_20;
    enum _Anonymous_20
    {
        CUBLAS_POINTER_MODE_HOST = 0,
        CUBLAS_POINTER_MODE_DEVICE = 1,
    }
    enum CUBLAS_POINTER_MODE_HOST = _Anonymous_20.CUBLAS_POINTER_MODE_HOST;
    enum CUBLAS_POINTER_MODE_DEVICE = _Anonymous_20.CUBLAS_POINTER_MODE_DEVICE;
    alias cublasAtomicsMode_t = _Anonymous_21;
    enum _Anonymous_21
    {
        CUBLAS_ATOMICS_NOT_ALLOWED = 0,
        CUBLAS_ATOMICS_ALLOWED = 1,
    }
    enum CUBLAS_ATOMICS_NOT_ALLOWED = _Anonymous_21.CUBLAS_ATOMICS_NOT_ALLOWED;
    enum CUBLAS_ATOMICS_ALLOWED = _Anonymous_21.CUBLAS_ATOMICS_ALLOWED;
    alias cublasGemmAlgo_t = _Anonymous_22;
    enum _Anonymous_22
    {
        CUBLAS_GEMM_DFALT = -1,
        CUBLAS_GEMM_DEFAULT = -1,
        CUBLAS_GEMM_ALGO0 = 0,
        CUBLAS_GEMM_ALGO1 = 1,
        CUBLAS_GEMM_ALGO2 = 2,
        CUBLAS_GEMM_ALGO3 = 3,
        CUBLAS_GEMM_ALGO4 = 4,
        CUBLAS_GEMM_ALGO5 = 5,
        CUBLAS_GEMM_ALGO6 = 6,
        CUBLAS_GEMM_ALGO7 = 7,
        CUBLAS_GEMM_ALGO8 = 8,
        CUBLAS_GEMM_ALGO9 = 9,
        CUBLAS_GEMM_ALGO10 = 10,
        CUBLAS_GEMM_ALGO11 = 11,
        CUBLAS_GEMM_ALGO12 = 12,
        CUBLAS_GEMM_ALGO13 = 13,
        CUBLAS_GEMM_ALGO14 = 14,
        CUBLAS_GEMM_ALGO15 = 15,
        CUBLAS_GEMM_ALGO16 = 16,
        CUBLAS_GEMM_ALGO17 = 17,
        CUBLAS_GEMM_ALGO18 = 18,
        CUBLAS_GEMM_ALGO19 = 19,
        CUBLAS_GEMM_ALGO20 = 20,
        CUBLAS_GEMM_ALGO21 = 21,
        CUBLAS_GEMM_ALGO22 = 22,
        CUBLAS_GEMM_ALGO23 = 23,
        CUBLAS_GEMM_DEFAULT_TENSOR_OP = 99,
        CUBLAS_GEMM_DFALT_TENSOR_OP = 99,
        CUBLAS_GEMM_ALGO0_TENSOR_OP = 100,
        CUBLAS_GEMM_ALGO1_TENSOR_OP = 101,
        CUBLAS_GEMM_ALGO2_TENSOR_OP = 102,
        CUBLAS_GEMM_ALGO3_TENSOR_OP = 103,
        CUBLAS_GEMM_ALGO4_TENSOR_OP = 104,
        CUBLAS_GEMM_ALGO5_TENSOR_OP = 105,
        CUBLAS_GEMM_ALGO6_TENSOR_OP = 106,
        CUBLAS_GEMM_ALGO7_TENSOR_OP = 107,
        CUBLAS_GEMM_ALGO8_TENSOR_OP = 108,
        CUBLAS_GEMM_ALGO9_TENSOR_OP = 109,
        CUBLAS_GEMM_ALGO10_TENSOR_OP = 110,
        CUBLAS_GEMM_ALGO11_TENSOR_OP = 111,
        CUBLAS_GEMM_ALGO12_TENSOR_OP = 112,
        CUBLAS_GEMM_ALGO13_TENSOR_OP = 113,
        CUBLAS_GEMM_ALGO14_TENSOR_OP = 114,
        CUBLAS_GEMM_ALGO15_TENSOR_OP = 115,
    }
    enum CUBLAS_GEMM_DFALT = _Anonymous_22.CUBLAS_GEMM_DFALT;
    enum CUBLAS_GEMM_DEFAULT = _Anonymous_22.CUBLAS_GEMM_DEFAULT;
    enum CUBLAS_GEMM_ALGO0 = _Anonymous_22.CUBLAS_GEMM_ALGO0;
    enum CUBLAS_GEMM_ALGO1 = _Anonymous_22.CUBLAS_GEMM_ALGO1;
    enum CUBLAS_GEMM_ALGO2 = _Anonymous_22.CUBLAS_GEMM_ALGO2;
    enum CUBLAS_GEMM_ALGO3 = _Anonymous_22.CUBLAS_GEMM_ALGO3;
    enum CUBLAS_GEMM_ALGO4 = _Anonymous_22.CUBLAS_GEMM_ALGO4;
    enum CUBLAS_GEMM_ALGO5 = _Anonymous_22.CUBLAS_GEMM_ALGO5;
    enum CUBLAS_GEMM_ALGO6 = _Anonymous_22.CUBLAS_GEMM_ALGO6;
    enum CUBLAS_GEMM_ALGO7 = _Anonymous_22.CUBLAS_GEMM_ALGO7;
    enum CUBLAS_GEMM_ALGO8 = _Anonymous_22.CUBLAS_GEMM_ALGO8;
    enum CUBLAS_GEMM_ALGO9 = _Anonymous_22.CUBLAS_GEMM_ALGO9;
    enum CUBLAS_GEMM_ALGO10 = _Anonymous_22.CUBLAS_GEMM_ALGO10;
    enum CUBLAS_GEMM_ALGO11 = _Anonymous_22.CUBLAS_GEMM_ALGO11;
    enum CUBLAS_GEMM_ALGO12 = _Anonymous_22.CUBLAS_GEMM_ALGO12;
    enum CUBLAS_GEMM_ALGO13 = _Anonymous_22.CUBLAS_GEMM_ALGO13;
    enum CUBLAS_GEMM_ALGO14 = _Anonymous_22.CUBLAS_GEMM_ALGO14;
    enum CUBLAS_GEMM_ALGO15 = _Anonymous_22.CUBLAS_GEMM_ALGO15;
    enum CUBLAS_GEMM_ALGO16 = _Anonymous_22.CUBLAS_GEMM_ALGO16;
    enum CUBLAS_GEMM_ALGO17 = _Anonymous_22.CUBLAS_GEMM_ALGO17;
    enum CUBLAS_GEMM_ALGO18 = _Anonymous_22.CUBLAS_GEMM_ALGO18;
    enum CUBLAS_GEMM_ALGO19 = _Anonymous_22.CUBLAS_GEMM_ALGO19;
    enum CUBLAS_GEMM_ALGO20 = _Anonymous_22.CUBLAS_GEMM_ALGO20;
    enum CUBLAS_GEMM_ALGO21 = _Anonymous_22.CUBLAS_GEMM_ALGO21;
    enum CUBLAS_GEMM_ALGO22 = _Anonymous_22.CUBLAS_GEMM_ALGO22;
    enum CUBLAS_GEMM_ALGO23 = _Anonymous_22.CUBLAS_GEMM_ALGO23;
    enum CUBLAS_GEMM_DEFAULT_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_DEFAULT_TENSOR_OP;
    enum CUBLAS_GEMM_DFALT_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_DFALT_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO0_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO0_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO1_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO1_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO2_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO2_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO3_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO3_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO4_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO4_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO5_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO5_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO6_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO6_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO7_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO7_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO8_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO8_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO9_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO9_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO10_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO10_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO11_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO11_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO12_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO12_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO13_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO13_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO14_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO14_TENSOR_OP;
    enum CUBLAS_GEMM_ALGO15_TENSOR_OP = _Anonymous_22.CUBLAS_GEMM_ALGO15_TENSOR_OP;
    alias cublasMath_t = _Anonymous_23;
    enum _Anonymous_23
    {
        CUBLAS_DEFAULT_MATH = 0,
        CUBLAS_TENSOR_OP_MATH = 1,
    }
    enum CUBLAS_DEFAULT_MATH = _Anonymous_23.CUBLAS_DEFAULT_MATH;
    enum CUBLAS_TENSOR_OP_MATH = _Anonymous_23.CUBLAS_TENSOR_OP_MATH;
    alias cublasDataType_t = cudaDataType_t;
    struct cublasContext;
    alias cublasHandle_t = cublasContext*;
    cublasStatus_t cublasCreate_v2(cublasContext**) @nogc nothrow;
    cublasStatus_t cublasDestroy_v2(cublasContext*) @nogc nothrow;
    cublasStatus_t cublasGetVersion_v2(cublasContext*, int*) @nogc nothrow;
    cublasStatus_t cublasGetProperty(libraryPropertyType_t, int*) @nogc nothrow;
    cublasStatus_t cublasSetStream_v2(cublasContext*, CUstream_st*) @nogc nothrow;
    cublasStatus_t cublasGetStream_v2(cublasContext*, CUstream_st**) @nogc nothrow;
    cublasStatus_t cublasGetPointerMode_v2(cublasContext*, cublasPointerMode_t*) @nogc nothrow;
    cublasStatus_t cublasSetPointerMode_v2(cublasContext*, cublasPointerMode_t) @nogc nothrow;
    cublasStatus_t cublasGetAtomicsMode(cublasContext*, cublasAtomicsMode_t*) @nogc nothrow;
    cublasStatus_t cublasSetAtomicsMode(cublasContext*, cublasAtomicsMode_t) @nogc nothrow;
    cublasStatus_t cublasGetMathMode(cublasContext*, cublasMath_t*) @nogc nothrow;
    cublasStatus_t cublasSetMathMode(cublasContext*, cublasMath_t) @nogc nothrow;
    alias cublasLogCallback = void function(const(char)*);
    cublasStatus_t cublasLoggerConfigure(int, int, int, const(char)*) @nogc nothrow;
    cublasStatus_t cublasSetLoggerCallback(void function(const(char)*)) @nogc nothrow;
    cublasStatus_t cublasGetLoggerCallback(void function(const(char)*)*) @nogc nothrow;
    cublasStatus_t cublasSetVector(int, int, const(void)*, int, void*, int) @nogc nothrow;
    cublasStatus_t cublasGetVector(int, int, const(void)*, int, void*, int) @nogc nothrow;
    cublasStatus_t cublasSetMatrix(int, int, int, const(void)*, int, void*, int) @nogc nothrow;
    cublasStatus_t cublasGetMatrix(int, int, int, const(void)*, int, void*, int) @nogc nothrow;
    cublasStatus_t cublasSetVectorAsync(int, int, const(void)*, int, void*, int, CUstream_st*) @nogc nothrow;
    cublasStatus_t cublasGetVectorAsync(int, int, const(void)*, int, void*, int, CUstream_st*) @nogc nothrow;
    cublasStatus_t cublasSetMatrixAsync(int, int, int, const(void)*, int, void*, int, CUstream_st*) @nogc nothrow;
    cublasStatus_t cublasGetMatrixAsync(int, int, int, const(void)*, int, void*, int, CUstream_st*) @nogc nothrow;
    void cublasXerbla(const(char)*, int) @nogc nothrow;
    cublasStatus_t cublasNrm2Ex(cublasContext*, int, const(void)*, cudaDataType_t, int, void*, cudaDataType_t, cudaDataType_t) @nogc nothrow;
    cublasStatus_t cublasSnrm2_v2(cublasContext*, int, const(float)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDnrm2_v2(cublasContext*, int, const(double)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasScnrm2_v2(cublasContext*, int, const(float2)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDznrm2_v2(cublasContext*, int, const(double2)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasDotEx(cublasContext*, int, const(void)*, cudaDataType_t, int, const(void)*, cudaDataType_t, int, void*, cudaDataType_t, cudaDataType_t) @nogc nothrow;
    cublasStatus_t cublasDotcEx(cublasContext*, int, const(void)*, cudaDataType_t, int, const(void)*, cudaDataType_t, int, void*, cudaDataType_t, cudaDataType_t) @nogc nothrow;
    cublasStatus_t cublasSdot_v2(cublasContext*, int, const(float)*, int, const(float)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDdot_v2(cublasContext*, int, const(double)*, int, const(double)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasCdotu_v2(cublasContext*, int, const(float2)*, int, const(float2)*, int, float2*) @nogc nothrow;
    cublasStatus_t cublasCdotc_v2(cublasContext*, int, const(float2)*, int, const(float2)*, int, float2*) @nogc nothrow;
    cublasStatus_t cublasZdotu_v2(cublasContext*, int, const(double2)*, int, const(double2)*, int, double2*) @nogc nothrow;
    cublasStatus_t cublasZdotc_v2(cublasContext*, int, const(double2)*, int, const(double2)*, int, double2*) @nogc nothrow;
    cublasStatus_t cublasScalEx(cublasContext*, int, const(void)*, cudaDataType_t, void*, cudaDataType_t, int, cudaDataType_t) @nogc nothrow;
    cublasStatus_t cublasSscal_v2(cublasContext*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDscal_v2(cublasContext*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasCscal_v2(cublasContext*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasCsscal_v2(cublasContext*, int, const(float)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZscal_v2(cublasContext*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasZdscal_v2(cublasContext*, int, const(double)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasAxpyEx(cublasContext*, int, const(void)*, cudaDataType_t, const(void)*, cudaDataType_t, int, void*, cudaDataType_t, int, cudaDataType_t) @nogc nothrow;
    cublasStatus_t cublasSaxpy_v2(cublasContext*, int, const(float)*, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDaxpy_v2(cublasContext*, int, const(double)*, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCaxpy_v2(cublasContext*, int, const(float2)*, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZaxpy_v2(cublasContext*, int, const(double2)*, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasScopy_v2(cublasContext*, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDcopy_v2(cublasContext*, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCcopy_v2(cublasContext*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZcopy_v2(cublasContext*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSswap_v2(cublasContext*, int, float*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDswap_v2(cublasContext*, int, double*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCswap_v2(cublasContext*, int, float2*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZswap_v2(cublasContext*, int, double2*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasIsamax_v2(cublasContext*, int, const(float)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIdamax_v2(cublasContext*, int, const(double)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIcamax_v2(cublasContext*, int, const(float2)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIzamax_v2(cublasContext*, int, const(double2)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIsamin_v2(cublasContext*, int, const(float)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIdamin_v2(cublasContext*, int, const(double)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIcamin_v2(cublasContext*, int, const(float2)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasIzamin_v2(cublasContext*, int, const(double2)*, int, int*) @nogc nothrow;
    cublasStatus_t cublasSasum_v2(cublasContext*, int, const(float)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDasum_v2(cublasContext*, int, const(double)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasScasum_v2(cublasContext*, int, const(float2)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDzasum_v2(cublasContext*, int, const(double2)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasSrot_v2(cublasContext*, int, float*, int, float*, int, const(float)*, const(float)*) @nogc nothrow;
    cublasStatus_t cublasDrot_v2(cublasContext*, int, double*, int, double*, int, const(double)*, const(double)*) @nogc nothrow;
    cublasStatus_t cublasCrot_v2(cublasContext*, int, float2*, int, float2*, int, const(float)*, const(float2)*) @nogc nothrow;
    cublasStatus_t cublasCsrot_v2(cublasContext*, int, float2*, int, float2*, int, const(float)*, const(float)*) @nogc nothrow;
    cublasStatus_t cublasZrot_v2(cublasContext*, int, double2*, int, double2*, int, const(double)*, const(double2)*) @nogc nothrow;
    cublasStatus_t cublasZdrot_v2(cublasContext*, int, double2*, int, double2*, int, const(double)*, const(double)*) @nogc nothrow;
    cublasStatus_t cublasSrotg_v2(cublasContext*, float*, float*, float*, float*) @nogc nothrow;
    cublasStatus_t cublasDrotg_v2(cublasContext*, double*, double*, double*, double*) @nogc nothrow;
    cublasStatus_t cublasCrotg_v2(cublasContext*, float2*, float2*, float*, float2*) @nogc nothrow;
    cublasStatus_t cublasZrotg_v2(cublasContext*, double2*, double2*, double*, double2*) @nogc nothrow;
    cublasStatus_t cublasSrotm_v2(cublasContext*, int, float*, int, float*, int, const(float)*) @nogc nothrow;
    cublasStatus_t cublasDrotm_v2(cublasContext*, int, double*, int, double*, int, const(double)*) @nogc nothrow;
    cublasStatus_t cublasSrotmg_v2(cublasContext*, float*, float*, float*, const(float)*, float*) @nogc nothrow;
    cublasStatus_t cublasDrotmg_v2(cublasContext*, double*, double*, double*, const(double)*, double*) @nogc nothrow;
    cublasStatus_t cublasSgemv_v2(cublasContext*, cublasOperation_t, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDgemv_v2(cublasContext*, cublasOperation_t, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasCgemv_v2(cublasContext*, cublasOperation_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZgemv_v2(cublasContext*, cublasOperation_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSgbmv_v2(cublasContext*, cublasOperation_t, int, int, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDgbmv_v2(cublasContext*, cublasOperation_t, int, int, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasCgbmv_v2(cublasContext*, cublasOperation_t, int, int, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZgbmv_v2(cublasContext*, cublasOperation_t, int, int, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasStrmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDtrmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCtrmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZtrmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasStbmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDtbmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCtbmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZtbmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasStpmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDtpmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasCtpmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZtpmv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasStrsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDtrsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCtrsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZtrsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasStpsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDtpsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasCtpsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZtpsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasStbsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDtbsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCtbsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZtbsv_v2(cublasContext*, cublasFillMode_t, cublasOperation_t, cublasDiagType_t, int, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSsymv_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDsymv_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasCsymv_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZsymv_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasChemv_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZhemv_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSsbmv_v2(cublasContext*, cublasFillMode_t, int, int, const(float)*, const(float)*, int, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDsbmv_v2(cublasContext*, cublasFillMode_t, int, int, const(double)*, const(double)*, int, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasChbmv_v2(cublasContext*, cublasFillMode_t, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZhbmv_v2(cublasContext*, cublasFillMode_t, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSspmv_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float)*, const(float)*, int, const(float)*, float*, int) @nogc nothrow;
    cublasStatus_t cublasDspmv_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double)*, const(double)*, int, const(double)*, double*, int) @nogc nothrow;
    cublasStatus_t cublasChpmv_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, const(float2)*, int, const(float2)*, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZhpmv_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, const(double2)*, int, const(double2)*, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSger_v2(cublasContext*, int, int, const(float)*, const(float)*, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDger_v2(cublasContext*, int, int, const(double)*, const(double)*, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCgeru_v2(cublasContext*, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasCgerc_v2(cublasContext*, int, int, const(float2)*, const(float2)*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZgeru_v2(cublasContext*, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasZgerc_v2(cublasContext*, int, int, const(double2)*, const(double2)*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSsyr_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDsyr_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCsyr_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZsyr_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCher_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZher_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSspr_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDspr_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double)*, int, double*) @nogc nothrow;
    cublasStatus_t cublasChpr_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float2)*, int, float2*) @nogc nothrow;
    cublasStatus_t cublasZhpr_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double2)*, int, double2*) @nogc nothrow;
    cublasStatus_t cublasSsyr2_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float)*, int, const(float)*, int, float*, int) @nogc nothrow;
    cublasStatus_t cublasDsyr2_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double)*, int, const(double)*, int, double*, int) @nogc nothrow;
    cublasStatus_t cublasCsyr2_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZsyr2_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasCher2_v2(cublasContext*, cublasFillMode_t, int, const(float2)*, const(float2)*, int, const(float2)*, int, float2*, int) @nogc nothrow;
    cublasStatus_t cublasZher2_v2(cublasContext*, cublasFillMode_t, int, const(double2)*, const(double2)*, int, const(double2)*, int, double2*, int) @nogc nothrow;
    cublasStatus_t cublasSspr2_v2(cublasContext*, cublasFillMode_t, int, const(float)*, const(float)*, int, const(float)*, int, float*) @nogc nothrow;
    cublasStatus_t cublasDspr2_v2(cublasContext*, cublasFillMode_t, int, const(double)*, const(double)*, int, const(double)*, int, double*) @nogc nothrow;
    static if(!is(typeof(_XLOCALE_H))) {
        enum _XLOCALE_H = 1;
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        enum _SYS_CDEFS_H = 1;
    }
    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        enum __SYSCALL_WORDSIZE = 64;
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        enum __WORDSIZE_TIME64_COMPAT32 = 1;
    }




    static if(!is(typeof(__WORDSIZE))) {
        enum __WORDSIZE = 64;
    }






    static if(!is(typeof(CHARCLASS_NAME_MAX))) {
        enum CHARCLASS_NAME_MAX = 2048;
    }
    static if(!is(typeof(COLL_WEIGHTS_MAX))) {
        enum COLL_WEIGHTS_MAX = 255;
    }
    static if(!is(typeof(_POSIX2_CHARCLASS_NAME_MAX))) {
        enum _POSIX2_CHARCLASS_NAME_MAX = 14;
    }




    static if(!is(typeof(_POSIX2_RE_DUP_MAX))) {
        enum _POSIX2_RE_DUP_MAX = 255;
    }




    static if(!is(typeof(_POSIX2_LINE_MAX))) {
        enum _POSIX2_LINE_MAX = 2048;
    }




    static if(!is(typeof(_POSIX2_EXPR_NEST_MAX))) {
        enum _POSIX2_EXPR_NEST_MAX = 32;
    }




    static if(!is(typeof(_POSIX2_COLL_WEIGHTS_MAX))) {
        enum _POSIX2_COLL_WEIGHTS_MAX = 2;
    }




    static if(!is(typeof(_POSIX2_BC_STRING_MAX))) {
        enum _POSIX2_BC_STRING_MAX = 1000;
    }




    static if(!is(typeof(_POSIX2_BC_SCALE_MAX))) {
        enum _POSIX2_BC_SCALE_MAX = 99;
    }




    static if(!is(typeof(_POSIX2_BC_DIM_MAX))) {
        enum _POSIX2_BC_DIM_MAX = 2048;
    }




    static if(!is(typeof(_POSIX2_BC_BASE_MAX))) {
        enum _POSIX2_BC_BASE_MAX = 99;
    }




    static if(!is(typeof(_BITS_POSIX2_LIM_H))) {
        enum _BITS_POSIX2_LIM_H = 1;
    }






    static if(!is(typeof(_POSIX_CLOCKRES_MIN))) {
        enum _POSIX_CLOCKRES_MIN = 20000000;
    }




    static if(!is(typeof(_POSIX_TZNAME_MAX))) {
        enum _POSIX_TZNAME_MAX = 6;
    }




    static if(!is(typeof(_POSIX_TTY_NAME_MAX))) {
        enum _POSIX_TTY_NAME_MAX = 9;
    }




    static if(!is(typeof(_POSIX_TIMER_MAX))) {
        enum _POSIX_TIMER_MAX = 32;
    }




    static if(!is(typeof(_POSIX_SYMLOOP_MAX))) {
        enum _POSIX_SYMLOOP_MAX = 8;
    }




    static if(!is(typeof(_POSIX_SYMLINK_MAX))) {
        enum _POSIX_SYMLINK_MAX = 255;
    }




    static if(!is(typeof(_POSIX_STREAM_MAX))) {
        enum _POSIX_STREAM_MAX = 8;
    }




    static if(!is(typeof(_POSIX_SSIZE_MAX))) {
        enum _POSIX_SSIZE_MAX = 32767;
    }




    static if(!is(typeof(_POSIX_SIGQUEUE_MAX))) {
        enum _POSIX_SIGQUEUE_MAX = 32;
    }




    static if(!is(typeof(_POSIX_SEM_VALUE_MAX))) {
        enum _POSIX_SEM_VALUE_MAX = 32767;
    }




    static if(!is(typeof(_POSIX_SEM_NSEMS_MAX))) {
        enum _POSIX_SEM_NSEMS_MAX = 256;
    }




    static if(!is(typeof(_POSIX_RTSIG_MAX))) {
        enum _POSIX_RTSIG_MAX = 8;
    }




    static if(!is(typeof(_POSIX_RE_DUP_MAX))) {
        enum _POSIX_RE_DUP_MAX = 255;
    }




    static if(!is(typeof(_POSIX_PIPE_BUF))) {
        enum _POSIX_PIPE_BUF = 512;
    }




    static if(!is(typeof(_POSIX_PATH_MAX))) {
        enum _POSIX_PATH_MAX = 256;
    }




    static if(!is(typeof(_POSIX_OPEN_MAX))) {
        enum _POSIX_OPEN_MAX = 20;
    }




    static if(!is(typeof(_POSIX_NGROUPS_MAX))) {
        enum _POSIX_NGROUPS_MAX = 8;
    }




    static if(!is(typeof(_POSIX_NAME_MAX))) {
        enum _POSIX_NAME_MAX = 14;
    }




    static if(!is(typeof(_POSIX_MQ_PRIO_MAX))) {
        enum _POSIX_MQ_PRIO_MAX = 32;
    }




    static if(!is(typeof(_POSIX_MQ_OPEN_MAX))) {
        enum _POSIX_MQ_OPEN_MAX = 8;
    }




    static if(!is(typeof(_POSIX_MAX_INPUT))) {
        enum _POSIX_MAX_INPUT = 255;
    }




    static if(!is(typeof(_POSIX_MAX_CANON))) {
        enum _POSIX_MAX_CANON = 255;
    }




    static if(!is(typeof(_POSIX_LOGIN_NAME_MAX))) {
        enum _POSIX_LOGIN_NAME_MAX = 9;
    }




    static if(!is(typeof(_POSIX_LINK_MAX))) {
        enum _POSIX_LINK_MAX = 8;
    }




    static if(!is(typeof(_POSIX_HOST_NAME_MAX))) {
        enum _POSIX_HOST_NAME_MAX = 255;
    }




    static if(!is(typeof(_POSIX_DELAYTIMER_MAX))) {
        enum _POSIX_DELAYTIMER_MAX = 32;
    }




    static if(!is(typeof(_POSIX_CHILD_MAX))) {
        enum _POSIX_CHILD_MAX = 25;
    }




    static if(!is(typeof(_POSIX_ARG_MAX))) {
        enum _POSIX_ARG_MAX = 4096;
    }




    static if(!is(typeof(_POSIX_AIO_MAX))) {
        enum _POSIX_AIO_MAX = 1;
    }




    static if(!is(typeof(_POSIX_AIO_LISTIO_MAX))) {
        enum _POSIX_AIO_LISTIO_MAX = 2;
    }




    static if(!is(typeof(_BITS_POSIX1_LIM_H))) {
        enum _BITS_POSIX1_LIM_H = 1;
    }
    static if(!is(typeof(_MATH_H_MATHDEF))) {
        enum _MATH_H_MATHDEF = 1;
    }






    static if(!is(typeof(MQ_PRIO_MAX))) {
        enum MQ_PRIO_MAX = 32768;
    }




    static if(!is(typeof(HOST_NAME_MAX))) {
        enum HOST_NAME_MAX = 64;
    }




    static if(!is(typeof(LOGIN_NAME_MAX))) {
        enum LOGIN_NAME_MAX = 256;
    }




    static if(!is(typeof(TTY_NAME_MAX))) {
        enum TTY_NAME_MAX = 32;
    }




    static if(!is(typeof(DELAYTIMER_MAX))) {
        enum DELAYTIMER_MAX = 2147483647;
    }




    static if(!is(typeof(PTHREAD_STACK_MIN))) {
        enum PTHREAD_STACK_MIN = 16384;
    }




    static if(!is(typeof(AIO_PRIO_DELTA_MAX))) {
        enum AIO_PRIO_DELTA_MAX = 20;
    }




    static if(!is(typeof(_POSIX_THREAD_THREADS_MAX))) {
        enum _POSIX_THREAD_THREADS_MAX = 64;
    }






    static if(!is(typeof(_POSIX_THREAD_DESTRUCTOR_ITERATIONS))) {
        enum _POSIX_THREAD_DESTRUCTOR_ITERATIONS = 4;
    }




    static if(!is(typeof(PTHREAD_KEYS_MAX))) {
        enum PTHREAD_KEYS_MAX = 1024;
    }




    static if(!is(typeof(_POSIX_THREAD_KEYS_MAX))) {
        enum _POSIX_THREAD_KEYS_MAX = 128;
    }
    static if(!is(typeof(_BITS_LIBM_SIMD_DECL_STUBS_H))) {
        enum _BITS_LIBM_SIMD_DECL_STUBS_H = 1;
    }
    static if(!is(typeof(_STRING_H))) {
        enum _STRING_H = 1;
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        enum _STDC_PREDEF_H = 1;
    }
    static if(!is(typeof(M_SQRT1_2))) {
        enum M_SQRT1_2 = 0.70710678118654752440;
    }




    static if(!is(typeof(M_SQRT2))) {
        enum M_SQRT2 = 1.41421356237309504880;
    }




    static if(!is(typeof(M_2_SQRTPI))) {
        enum M_2_SQRTPI = 1.12837916709551257390;
    }




    static if(!is(typeof(M_2_PI))) {
        enum M_2_PI = 0.63661977236758134308;
    }




    static if(!is(typeof(M_1_PI))) {
        enum M_1_PI = 0.31830988618379067154;
    }




    static if(!is(typeof(M_PI_4))) {
        enum M_PI_4 = 0.78539816339744830962;
    }




    static if(!is(typeof(M_PI_2))) {
        enum M_PI_2 = 1.57079632679489661923;
    }




    static if(!is(typeof(M_PI))) {
        enum M_PI = 3.14159265358979323846;
    }




    static if(!is(typeof(M_LN10))) {
        enum M_LN10 = 2.30258509299404568402;
    }




    static if(!is(typeof(M_LN2))) {
        enum M_LN2 = 0.69314718055994530942;
    }




    static if(!is(typeof(M_LOG10E))) {
        enum M_LOG10E = 0.43429448190325182765;
    }




    static if(!is(typeof(M_LOG2E))) {
        enum M_LOG2E = 1.4426950408889634074;
    }




    static if(!is(typeof(M_E))) {
        enum M_E = 2.7182818284590452354;
    }




    static if(!is(typeof(HUGE))) {
        enum HUGE = 3.40282347e+38F;
    }




    static if(!is(typeof(PLOSS))) {
        enum PLOSS = 6;
    }




    static if(!is(typeof(TLOSS))) {
        enum TLOSS = 5;
    }




    static if(!is(typeof(UNDERFLOW))) {
        enum UNDERFLOW = 4;
    }




    static if(!is(typeof(OVERFLOW))) {
        enum OVERFLOW = 3;
    }




    static if(!is(typeof(SING))) {
        enum SING = 2;
    }




    static if(!is(typeof(DOMAIN))) {
        enum DOMAIN = 1;
    }




    static if(!is(typeof(X_TLOSS))) {
        enum X_TLOSS = 1.41484755040568800000e+16;
    }






    static if(!is(typeof(MATH_ERREXCEPT))) {
        enum MATH_ERREXCEPT = 2;
    }




    static if(!is(typeof(MATH_ERRNO))) {
        enum MATH_ERRNO = 1;
    }
    static if(!is(typeof(FP_NORMAL))) {
        enum FP_NORMAL = 4;
    }




    static if(!is(typeof(FP_SUBNORMAL))) {
        enum FP_SUBNORMAL = 3;
    }




    static if(!is(typeof(FP_ZERO))) {
        enum FP_ZERO = 2;
    }




    static if(!is(typeof(FP_INFINITE))) {
        enum FP_INFINITE = 1;
    }




    static if(!is(typeof(FP_NAN))) {
        enum FP_NAN = 0;
    }




    static if(!is(typeof(__MATH_DECLARE_LDOUBLE))) {
        enum __MATH_DECLARE_LDOUBLE = 1;
    }
    static if(!is(typeof(__MATH_DECLARING_DOUBLE))) {
        enum __MATH_DECLARING_DOUBLE = 0;
    }
    static if(!is(typeof(_MATH_H))) {
        enum _MATH_H = 1;
    }




    static if(!is(typeof(RTSIG_MAX))) {
        enum RTSIG_MAX = 32;
    }




    static if(!is(typeof(XATTR_LIST_MAX))) {
        enum XATTR_LIST_MAX = 65536;
    }




    static if(!is(typeof(XATTR_SIZE_MAX))) {
        enum XATTR_SIZE_MAX = 65536;
    }




    static if(!is(typeof(XATTR_NAME_MAX))) {
        enum XATTR_NAME_MAX = 255;
    }




    static if(!is(typeof(PIPE_BUF))) {
        enum PIPE_BUF = 4096;
    }




    static if(!is(typeof(PATH_MAX))) {
        enum PATH_MAX = 4096;
    }




    static if(!is(typeof(NAME_MAX))) {
        enum NAME_MAX = 255;
    }




    static if(!is(typeof(MAX_INPUT))) {
        enum MAX_INPUT = 255;
    }




    static if(!is(typeof(MAX_CANON))) {
        enum MAX_CANON = 255;
    }




    static if(!is(typeof(LINK_MAX))) {
        enum LINK_MAX = 127;
    }




    static if(!is(typeof(ARG_MAX))) {
        enum ARG_MAX = 131072;
    }




    static if(!is(typeof(NGROUPS_MAX))) {
        enum NGROUPS_MAX = 65536;
    }




    static if(!is(typeof(NR_OPEN))) {
        enum NR_OPEN = 1024;
    }
    static if(!is(typeof(MB_LEN_MAX))) {
        enum MB_LEN_MAX = 16;
    }




    static if(!is(typeof(_LIBC_LIMITS_H_))) {
        enum _LIBC_LIMITS_H_ = 1;
    }






    static if(!is(typeof(__GLIBC_MINOR__))) {
        enum __GLIBC_MINOR__ = 23;
    }




    static if(!is(typeof(__GLIBC__))) {
        enum __GLIBC__ = 2;
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        enum __GNU_LIBRARY__ = 6;
    }




    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        enum __USE_FORTIFY_LEVEL = 0;
    }




    static if(!is(typeof(__USE_ATFILE))) {
        enum __USE_ATFILE = 1;
    }




    static if(!is(typeof(__USE_MISC))) {
        enum __USE_MISC = 1;
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        enum _ATFILE_SOURCE = 1;
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        enum __USE_XOPEN2K8 = 1;
    }




    static if(!is(typeof(__USE_ISOC99))) {
        enum __USE_ISOC99 = 1;
    }




    static if(!is(typeof(__USE_ISOC95))) {
        enum __USE_ISOC95 = 1;
    }




    static if(!is(typeof(__USE_XOPEN2K))) {
        enum __USE_XOPEN2K = 1;
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        enum __USE_POSIX199506 = 1;
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        enum __USE_POSIX199309 = 1;
    }




    static if(!is(typeof(__USE_POSIX2))) {
        enum __USE_POSIX2 = 1;
    }




    static if(!is(typeof(__USE_POSIX))) {
        enum __USE_POSIX = 1;
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        enum _POSIX_C_SOURCE = 200809L;
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        enum _POSIX_SOURCE = 1;
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        enum __USE_POSIX_IMPLICITLY = 1;
    }




    static if(!is(typeof(__USE_ISOC11))) {
        enum __USE_ISOC11 = 1;
    }
    static if(!is(typeof(_DEFAULT_SOURCE))) {
        enum _DEFAULT_SOURCE = 1;
    }
    static if(!is(typeof(_FEATURES_H))) {
        enum _FEATURES_H = 1;
    }
    static if(!is(typeof(cudaHostAllocDefault))) {
        enum cudaHostAllocDefault = 0x00;
    }




    static if(!is(typeof(cudaHostAllocPortable))) {
        enum cudaHostAllocPortable = 0x01;
    }




    static if(!is(typeof(cudaHostAllocMapped))) {
        enum cudaHostAllocMapped = 0x02;
    }




    static if(!is(typeof(cudaHostAllocWriteCombined))) {
        enum cudaHostAllocWriteCombined = 0x04;
    }




    static if(!is(typeof(cudaHostRegisterDefault))) {
        enum cudaHostRegisterDefault = 0x00;
    }




    static if(!is(typeof(cudaHostRegisterPortable))) {
        enum cudaHostRegisterPortable = 0x01;
    }




    static if(!is(typeof(cudaHostRegisterMapped))) {
        enum cudaHostRegisterMapped = 0x02;
    }




    static if(!is(typeof(cudaHostRegisterIoMemory))) {
        enum cudaHostRegisterIoMemory = 0x04;
    }




    static if(!is(typeof(cudaPeerAccessDefault))) {
        enum cudaPeerAccessDefault = 0x00;
    }




    static if(!is(typeof(cudaStreamDefault))) {
        enum cudaStreamDefault = 0x00;
    }




    static if(!is(typeof(cudaStreamNonBlocking))) {
        enum cudaStreamNonBlocking = 0x01;
    }
    static if(!is(typeof(cudaEventDefault))) {
        enum cudaEventDefault = 0x00;
    }




    static if(!is(typeof(cudaEventBlockingSync))) {
        enum cudaEventBlockingSync = 0x01;
    }




    static if(!is(typeof(cudaEventDisableTiming))) {
        enum cudaEventDisableTiming = 0x02;
    }




    static if(!is(typeof(cudaEventInterprocess))) {
        enum cudaEventInterprocess = 0x04;
    }




    static if(!is(typeof(cudaDeviceScheduleAuto))) {
        enum cudaDeviceScheduleAuto = 0x00;
    }




    static if(!is(typeof(cudaDeviceScheduleSpin))) {
        enum cudaDeviceScheduleSpin = 0x01;
    }




    static if(!is(typeof(cudaDeviceScheduleYield))) {
        enum cudaDeviceScheduleYield = 0x02;
    }




    static if(!is(typeof(cudaDeviceScheduleBlockingSync))) {
        enum cudaDeviceScheduleBlockingSync = 0x04;
    }




    static if(!is(typeof(cudaDeviceBlockingSync))) {
        enum cudaDeviceBlockingSync = 0x04;
    }




    static if(!is(typeof(cudaDeviceScheduleMask))) {
        enum cudaDeviceScheduleMask = 0x07;
    }




    static if(!is(typeof(cudaDeviceMapHost))) {
        enum cudaDeviceMapHost = 0x08;
    }




    static if(!is(typeof(cudaDeviceLmemResizeToMax))) {
        enum cudaDeviceLmemResizeToMax = 0x10;
    }




    static if(!is(typeof(cudaDeviceMask))) {
        enum cudaDeviceMask = 0x1f;
    }




    static if(!is(typeof(cudaArrayDefault))) {
        enum cudaArrayDefault = 0x00;
    }




    static if(!is(typeof(cudaArrayLayered))) {
        enum cudaArrayLayered = 0x01;
    }




    static if(!is(typeof(cudaArraySurfaceLoadStore))) {
        enum cudaArraySurfaceLoadStore = 0x02;
    }




    static if(!is(typeof(cudaArrayCubemap))) {
        enum cudaArrayCubemap = 0x04;
    }




    static if(!is(typeof(cudaArrayTextureGather))) {
        enum cudaArrayTextureGather = 0x08;
    }




    static if(!is(typeof(cudaArrayColorAttachment))) {
        enum cudaArrayColorAttachment = 0x20;
    }




    static if(!is(typeof(cudaIpcMemLazyEnablePeerAccess))) {
        enum cudaIpcMemLazyEnablePeerAccess = 0x01;
    }




    static if(!is(typeof(cudaMemAttachGlobal))) {
        enum cudaMemAttachGlobal = 0x01;
    }




    static if(!is(typeof(cudaMemAttachHost))) {
        enum cudaMemAttachHost = 0x02;
    }




    static if(!is(typeof(cudaMemAttachSingle))) {
        enum cudaMemAttachSingle = 0x04;
    }




    static if(!is(typeof(cudaOccupancyDefault))) {
        enum cudaOccupancyDefault = 0x00;
    }




    static if(!is(typeof(cudaOccupancyDisableCachingOverride))) {
        enum cudaOccupancyDisableCachingOverride = 0x01;
    }
    static if(!is(typeof(cudaCooperativeLaunchMultiDeviceNoPreSync))) {
        enum cudaCooperativeLaunchMultiDeviceNoPreSync = 0x01;
    }




    static if(!is(typeof(cudaCooperativeLaunchMultiDeviceNoPostSync))) {
        enum cudaCooperativeLaunchMultiDeviceNoPostSync = 0x02;
    }
    static if(!is(typeof(CUDA_IPC_HANDLE_SIZE))) {
        enum CUDA_IPC_HANDLE_SIZE = 64;
    }




    static if(!is(typeof(cudaExternalMemoryDedicated))) {
        enum cudaExternalMemoryDedicated = 0x1;
    }
}
