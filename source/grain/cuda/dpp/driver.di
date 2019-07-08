module grain.cuda.dpp.driver;


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
    cudaError_enum cuGetExportTable(const(void)**, const(CUuuid_st)*) @nogc nothrow;
    cudaError_enum cuGraphicsUnmapResources(uint, CUgraphicsResource_st**, CUstream_st*) @nogc nothrow;
    cudaError_enum cuGraphicsMapResources(uint, CUgraphicsResource_st**, CUstream_st*) @nogc nothrow;
    cudaError_enum cuGraphicsResourceSetMapFlags_v2(CUgraphicsResource_st*, uint) @nogc nothrow;
    cudaError_enum cuGraphicsResourceGetMappedPointer_v2(ulong*, c_ulong*, CUgraphicsResource_st*) @nogc nothrow;
    cudaError_enum cuGraphicsResourceGetMappedMipmappedArray(CUmipmappedArray_st**, CUgraphicsResource_st*) @nogc nothrow;
    cudaError_enum cuGraphicsSubResourceGetMappedArray(CUarray_st**, CUgraphicsResource_st*, uint, uint) @nogc nothrow;
    cudaError_enum cuGraphicsUnregisterResource(CUgraphicsResource_st*) @nogc nothrow;
    cudaError_enum cuDeviceGetP2PAttribute(int*, CUdevice_P2PAttribute_enum, int, int) @nogc nothrow;
    cudaError_enum cuCtxDisablePeerAccess(CUctx_st*) @nogc nothrow;
    cudaError_enum cuCtxEnablePeerAccess(CUctx_st*, uint) @nogc nothrow;
    cudaError_enum cuDeviceCanAccessPeer(int*, int, int) @nogc nothrow;
    cudaError_enum cuSurfObjectGetResourceDesc(CUDA_RESOURCE_DESC_st*, ulong) @nogc nothrow;
    cudaError_enum cuSurfObjectDestroy(ulong) @nogc nothrow;
    cudaError_enum cuSurfObjectCreate(ulong*, const(CUDA_RESOURCE_DESC_st)*) @nogc nothrow;
    cudaError_enum cuTexObjectGetResourceViewDesc(CUDA_RESOURCE_VIEW_DESC_st*, ulong) @nogc nothrow;
    cudaError_enum cuTexObjectGetTextureDesc(CUDA_TEXTURE_DESC_st*, ulong) @nogc nothrow;
    cudaError_enum cuTexObjectGetResourceDesc(CUDA_RESOURCE_DESC_st*, ulong) @nogc nothrow;
    cudaError_enum cuTexObjectDestroy(ulong) @nogc nothrow;
    cudaError_enum cuTexObjectCreate(ulong*, const(CUDA_RESOURCE_DESC_st)*, const(CUDA_TEXTURE_DESC_st)*, const(CUDA_RESOURCE_VIEW_DESC_st)*) @nogc nothrow;
    cudaError_enum cuSurfRefGetArray(CUarray_st**, CUsurfref_st*) @nogc nothrow;
    cudaError_enum cuSurfRefSetArray(CUsurfref_st*, CUarray_st*, uint) @nogc nothrow;
    cudaError_enum cuTexRefDestroy(CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefCreate(CUtexref_st**) @nogc nothrow;
    cudaError_enum cuTexRefGetFlags(uint*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetBorderColor(float*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetMaxAnisotropy(int*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetMipmapLevelClamp(float*, float*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetMipmapLevelBias(float*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetMipmapFilterMode(CUfilter_mode_enum*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetFormat(CUarray_format_enum*, int*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetFilterMode(CUfilter_mode_enum*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetAddressMode(CUaddress_mode_enum*, CUtexref_st*, int) @nogc nothrow;
    cudaError_enum cuTexRefGetMipmappedArray(CUmipmappedArray_st**, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetArray(CUarray_st**, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefGetAddress_v2(ulong*, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuTexRefSetFlags(CUtexref_st*, uint) @nogc nothrow;
    cudaError_enum cuTexRefSetBorderColor(CUtexref_st*, float*) @nogc nothrow;
    cudaError_enum cuTexRefSetMaxAnisotropy(CUtexref_st*, uint) @nogc nothrow;
    cudaError_enum cuTexRefSetMipmapLevelClamp(CUtexref_st*, float, float) @nogc nothrow;
    cudaError_enum cuTexRefSetMipmapLevelBias(CUtexref_st*, float) @nogc nothrow;
    cudaError_enum cuTexRefSetMipmapFilterMode(CUtexref_st*, CUfilter_mode_enum) @nogc nothrow;
    cudaError_enum cuTexRefSetFilterMode(CUtexref_st*, CUfilter_mode_enum) @nogc nothrow;
    cudaError_enum cuTexRefSetAddressMode(CUtexref_st*, int, CUaddress_mode_enum) @nogc nothrow;
    cudaError_enum cuTexRefSetFormat(CUtexref_st*, CUarray_format_enum, int) @nogc nothrow;
    cudaError_enum cuTexRefSetAddress2D_v3(CUtexref_st*, const(CUDA_ARRAY_DESCRIPTOR_st)*, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuTexRefSetAddress_v2(c_ulong*, CUtexref_st*, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuTexRefSetMipmappedArray(CUtexref_st*, CUmipmappedArray_st*, uint) @nogc nothrow;
    cudaError_enum cuTexRefSetArray(CUtexref_st*, CUarray_st*, uint) @nogc nothrow;
    cudaError_enum cuOccupancyMaxPotentialBlockSizeWithFlags(int*, int*, CUfunc_st*, c_ulong function(int), c_ulong, int, uint) @nogc nothrow;
    cudaError_enum cuOccupancyMaxPotentialBlockSize(int*, int*, CUfunc_st*, c_ulong function(int), c_ulong, int) @nogc nothrow;
    cudaError_enum cuOccupancyMaxActiveBlocksPerMultiprocessorWithFlags(int*, CUfunc_st*, int, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuOccupancyMaxActiveBlocksPerMultiprocessor(int*, CUfunc_st*, int, c_ulong) @nogc nothrow;
    cudaError_enum cuGraphDestroy(CUgraph_st*) @nogc nothrow;
    cudaError_enum cuGraphExecDestroy(CUgraphExec_st*) @nogc nothrow;
    cudaError_enum cuGraphLaunch(CUgraphExec_st*, CUstream_st*) @nogc nothrow;
    cudaError_enum cuGraphInstantiate(CUgraphExec_st**, CUgraph_st*, CUgraphNode_st**, char*, c_ulong) @nogc nothrow;
    cudaError_enum cuGraphDestroyNode(CUgraphNode_st*) @nogc nothrow;
    cudaError_enum cuGraphRemoveDependencies(CUgraph_st*, CUgraphNode_st**, CUgraphNode_st**, c_ulong) @nogc nothrow;
    cudaError_enum cuGraphAddDependencies(CUgraph_st*, CUgraphNode_st**, CUgraphNode_st**, c_ulong) @nogc nothrow;
    cudaError_enum cuGraphNodeGetDependentNodes(CUgraphNode_st*, CUgraphNode_st**, c_ulong*) @nogc nothrow;
    cudaError_enum cuGraphNodeGetDependencies(CUgraphNode_st*, CUgraphNode_st**, c_ulong*) @nogc nothrow;
    cudaError_enum cuGraphGetEdges(CUgraph_st*, CUgraphNode_st**, CUgraphNode_st**, c_ulong*) @nogc nothrow;
    cudaError_enum cuGraphGetRootNodes(CUgraph_st*, CUgraphNode_st**, c_ulong*) @nogc nothrow;
    cudaError_enum cuGraphGetNodes(CUgraph_st*, CUgraphNode_st**, c_ulong*) @nogc nothrow;
    cudaError_enum cuGraphNodeGetType(CUgraphNode_st*, CUgraphNodeType_enum*) @nogc nothrow;
    cudaError_enum cuGraphNodeFindInClone(CUgraphNode_st**, CUgraphNode_st*, CUgraph_st*) @nogc nothrow;
    cudaError_enum cuGraphClone(CUgraph_st**, CUgraph_st*) @nogc nothrow;
    cudaError_enum cuGraphAddEmptyNode(CUgraphNode_st**, CUgraph_st*, CUgraphNode_st**, c_ulong) @nogc nothrow;
    cudaError_enum cuGraphChildGraphNodeGetGraph(CUgraphNode_st*, CUgraph_st**) @nogc nothrow;
    cudaError_enum cuGraphAddChildGraphNode(CUgraphNode_st**, CUgraph_st*, CUgraphNode_st**, c_ulong, CUgraph_st*) @nogc nothrow;
    cudaError_enum cuGraphHostNodeSetParams(CUgraphNode_st*, const(CUDA_HOST_NODE_PARAMS_st)*) @nogc nothrow;
    cudaError_enum cuGraphHostNodeGetParams(CUgraphNode_st*, CUDA_HOST_NODE_PARAMS_st*) @nogc nothrow;
    cudaError_enum cuGraphAddHostNode(CUgraphNode_st**, CUgraph_st*, CUgraphNode_st**, c_ulong, const(CUDA_HOST_NODE_PARAMS_st)*) @nogc nothrow;
    cudaError_enum cuGraphMemsetNodeSetParams(CUgraphNode_st*, const(CUDA_MEMSET_NODE_PARAMS_st)*) @nogc nothrow;
    cudaError_enum cuGraphMemsetNodeGetParams(CUgraphNode_st*, CUDA_MEMSET_NODE_PARAMS_st*) @nogc nothrow;
    cudaError_enum cuGraphAddMemsetNode(CUgraphNode_st**, CUgraph_st*, CUgraphNode_st**, c_ulong, const(CUDA_MEMSET_NODE_PARAMS_st)*, CUctx_st*) @nogc nothrow;
    cudaError_enum cuGraphMemcpyNodeSetParams(CUgraphNode_st*, const(CUDA_MEMCPY3D_st)*) @nogc nothrow;
    cudaError_enum cuGraphMemcpyNodeGetParams(CUgraphNode_st*, CUDA_MEMCPY3D_st*) @nogc nothrow;
    cudaError_enum cuGraphAddMemcpyNode(CUgraphNode_st**, CUgraph_st*, CUgraphNode_st**, c_ulong, const(CUDA_MEMCPY3D_st)*, CUctx_st*) @nogc nothrow;
    cudaError_enum cuGraphKernelNodeSetParams(CUgraphNode_st*, const(CUDA_KERNEL_NODE_PARAMS_st)*) @nogc nothrow;
    cudaError_enum cuGraphKernelNodeGetParams(CUgraphNode_st*, CUDA_KERNEL_NODE_PARAMS_st*) @nogc nothrow;
    cudaError_enum cuGraphAddKernelNode(CUgraphNode_st**, CUgraph_st*, CUgraphNode_st**, c_ulong, const(CUDA_KERNEL_NODE_PARAMS_st)*) @nogc nothrow;
    cudaError_enum cuGraphCreate(CUgraph_st**, uint) @nogc nothrow;
    cudaError_enum cuParamSetTexRef(CUfunc_st*, int, CUtexref_st*) @nogc nothrow;
    cudaError_enum cuLaunchGridAsync(CUfunc_st*, int, int, CUstream_st*) @nogc nothrow;
    cudaError_enum cuLaunchGrid(CUfunc_st*, int, int) @nogc nothrow;
    cudaError_enum cuLaunch(CUfunc_st*) @nogc nothrow;
    cudaError_enum cuParamSetv(CUfunc_st*, int, void*, uint) @nogc nothrow;
    cudaError_enum cuParamSetf(CUfunc_st*, int, float) @nogc nothrow;
    cudaError_enum cuParamSeti(CUfunc_st*, int, uint) @nogc nothrow;
    cudaError_enum cuParamSetSize(CUfunc_st*, uint) @nogc nothrow;
    cudaError_enum cuFuncSetSharedSize(CUfunc_st*, uint) @nogc nothrow;
    cudaError_enum cuFuncSetBlockShape(CUfunc_st*, int, int, int) @nogc nothrow;
    cudaError_enum cuLaunchHostFunc(CUstream_st*, void function(void*), void*) @nogc nothrow;
    cudaError_enum cuLaunchCooperativeKernelMultiDevice(CUDA_LAUNCH_PARAMS_st*, uint, uint) @nogc nothrow;
    cudaError_enum cuLaunchCooperativeKernel(CUfunc_st*, uint, uint, uint, uint, uint, uint, uint, CUstream_st*, void**) @nogc nothrow;
    cudaError_enum cuLaunchKernel(CUfunc_st*, uint, uint, uint, uint, uint, uint, uint, CUstream_st*, void**, void**) @nogc nothrow;
    cudaError_enum cuFuncSetSharedMemConfig(CUfunc_st*, CUsharedconfig_enum) @nogc nothrow;
    cudaError_enum cuFuncSetCacheConfig(CUfunc_st*, CUfunc_cache_enum) @nogc nothrow;
    cudaError_enum cuFuncSetAttribute(CUfunc_st*, CUfunction_attribute_enum, int) @nogc nothrow;
    cudaError_enum cuFuncGetAttribute(int*, CUfunction_attribute_enum, CUfunc_st*) @nogc nothrow;
    cudaError_enum cuStreamBatchMemOp(CUstream_st*, uint, CUstreamBatchMemOpParams_union*, uint) @nogc nothrow;
    cudaError_enum cuStreamWriteValue64(CUstream_st*, ulong, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuStreamWriteValue32(CUstream_st*, ulong, uint, uint) @nogc nothrow;
    cudaError_enum cuStreamWaitValue64(CUstream_st*, ulong, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuStreamWaitValue32(CUstream_st*, ulong, uint, uint) @nogc nothrow;
    cudaError_enum cuDestroyExternalSemaphore(CUextSemaphore_st*) @nogc nothrow;
    cudaError_enum cuWaitExternalSemaphoresAsync(const(CUextSemaphore_st*)*, const(CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st)*, uint, CUstream_st*) @nogc nothrow;
    cudaError_enum cuSignalExternalSemaphoresAsync(const(CUextSemaphore_st*)*, const(CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st)*, uint, CUstream_st*) @nogc nothrow;
    cudaError_enum cuImportExternalSemaphore(CUextSemaphore_st**, const(CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st)*) @nogc nothrow;
    cudaError_enum cuDestroyExternalMemory(CUextMemory_st*) @nogc nothrow;
    cudaError_enum cuExternalMemoryGetMappedMipmappedArray(CUmipmappedArray_st**, CUextMemory_st*, const(CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st)*) @nogc nothrow;
    cudaError_enum cuExternalMemoryGetMappedBuffer(ulong*, CUextMemory_st*, const(CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st)*) @nogc nothrow;
    cudaError_enum cuImportExternalMemory(CUextMemory_st**, const(CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st)*) @nogc nothrow;
    cudaError_enum cuEventElapsedTime(float*, CUevent_st*, CUevent_st*) @nogc nothrow;
    cudaError_enum cuEventDestroy_v2(CUevent_st*) @nogc nothrow;
    cudaError_enum cuEventSynchronize(CUevent_st*) @nogc nothrow;
    cudaError_enum cuEventQuery(CUevent_st*) @nogc nothrow;
    cudaError_enum cuEventRecord(CUevent_st*, CUstream_st*) @nogc nothrow;
    cudaError_enum cuEventCreate(CUevent_st**, uint) @nogc nothrow;
    cudaError_enum cuStreamDestroy_v2(CUstream_st*) @nogc nothrow;
    cudaError_enum cuStreamSynchronize(CUstream_st*) @nogc nothrow;
    cudaError_enum cuStreamQuery(CUstream_st*) @nogc nothrow;
    cudaError_enum cuStreamAttachMemAsync(CUstream_st*, ulong, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuStreamIsCapturing(CUstream_st*, CUstreamCaptureStatus_enum*) @nogc nothrow;
    cudaError_enum cuStreamEndCapture(CUstream_st*, CUgraph_st**) @nogc nothrow;
    cudaError_enum cuStreamBeginCapture(CUstream_st*) @nogc nothrow;
    cudaError_enum cuStreamAddCallback(CUstream_st*, void function(CUstream_st*, cudaError_enum, void*), void*, uint) @nogc nothrow;
    cudaError_enum cuStreamWaitEvent(CUstream_st*, CUevent_st*, uint) @nogc nothrow;
    cudaError_enum cuStreamGetCtx(CUstream_st*, CUctx_st**) @nogc nothrow;
    cudaError_enum cuStreamGetFlags(CUstream_st*, uint*) @nogc nothrow;
    cudaError_enum cuStreamGetPriority(CUstream_st*, int*) @nogc nothrow;
    cudaError_enum cuStreamCreateWithPriority(CUstream_st**, uint, int) @nogc nothrow;
    cudaError_enum cuStreamCreate(CUstream_st**, uint) @nogc nothrow;
    cudaError_enum cuPointerGetAttributes(uint, CUpointer_attribute_enum*, void**, ulong) @nogc nothrow;
    cudaError_enum cuPointerSetAttribute(const(void)*, CUpointer_attribute_enum, ulong) @nogc nothrow;
    cudaError_enum cuMemRangeGetAttributes(void**, c_ulong*, CUmem_range_attribute_enum*, c_ulong, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemRangeGetAttribute(void*, c_ulong, CUmem_range_attribute_enum, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemAdvise(ulong, c_ulong, CUmem_advise_enum, int) @nogc nothrow;
    cudaError_enum cuMemPrefetchAsync(ulong, c_ulong, int, CUstream_st*) @nogc nothrow;
    cudaError_enum cuPointerGetAttribute(void*, CUpointer_attribute_enum, ulong) @nogc nothrow;
    cudaError_enum cuMipmappedArrayDestroy(CUmipmappedArray_st*) @nogc nothrow;
    cudaError_enum cuMipmappedArrayGetLevel(CUarray_st**, CUmipmappedArray_st*, uint) @nogc nothrow;
    cudaError_enum cuMipmappedArrayCreate(CUmipmappedArray_st**, const(CUDA_ARRAY3D_DESCRIPTOR_st)*, uint) @nogc nothrow;
    cudaError_enum cuArray3DGetDescriptor_v2(CUDA_ARRAY3D_DESCRIPTOR_st*, CUarray_st*) @nogc nothrow;
    cudaError_enum cuArray3DCreate_v2(CUarray_st**, const(CUDA_ARRAY3D_DESCRIPTOR_st)*) @nogc nothrow;
    pragma(mangle, "alloca") void* alloca_(c_ulong) @nogc nothrow;
    alias size_t = c_ulong;
    cudaError_enum cuArrayDestroy(CUarray_st*) @nogc nothrow;
    alias wchar_t = int;
    cudaError_enum cuArrayGetDescriptor_v2(CUDA_ARRAY_DESCRIPTOR_st*, CUarray_st*) @nogc nothrow;
    cudaError_enum cuArrayCreate_v2(CUarray_st**, const(CUDA_ARRAY_DESCRIPTOR_st)*) @nogc nothrow;
    cudaError_enum cuMemsetD2D32Async(ulong, c_ulong, uint, c_ulong, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemsetD2D16Async(ulong, c_ulong, ushort, c_ulong, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemsetD2D8Async(ulong, c_ulong, ubyte, c_ulong, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemsetD32Async(ulong, uint, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemsetD16Async(ulong, ushort, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemsetD8Async(ulong, ubyte, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemsetD2D32_v2(ulong, c_ulong, uint, c_ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemsetD2D16_v2(ulong, c_ulong, ushort, c_ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemsetD2D8_v2(ulong, c_ulong, ubyte, c_ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemsetD32_v2(ulong, uint, c_ulong) @nogc nothrow;
    cudaError_enum cuMemsetD16_v2(ulong, ushort, c_ulong) @nogc nothrow;
    cudaError_enum cuMemsetD8_v2(ulong, ubyte, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpy3DPeerAsync(const(CUDA_MEMCPY3D_PEER_st)*, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpy3DAsync_v2(const(CUDA_MEMCPY3D_st)*, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpy2DAsync_v2(const(CUDA_MEMCPY2D_st)*, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpyAtoHAsync_v2(void*, CUarray_st*, c_ulong, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpyHtoAAsync_v2(CUarray_st*, c_ulong, const(void)*, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpyDtoDAsync_v2(ulong, ulong, c_ulong, CUstream_st*) @nogc nothrow;
    alias uint8_t = ubyte;
    alias uint16_t = ushort;
    alias uint32_t = uint;
    alias uint64_t = ulong;
    alias int_least8_t = byte;
    alias int_least16_t = short;
    alias int_least32_t = int;
    alias int_least64_t = c_long;
    alias uint_least8_t = ubyte;
    alias uint_least16_t = ushort;
    alias uint_least32_t = uint;
    alias uint_least64_t = c_ulong;
    alias int_fast8_t = byte;
    alias int_fast16_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast64_t = c_long;
    alias uint_fast8_t = ubyte;
    alias uint_fast16_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast64_t = c_ulong;
    alias intptr_t = c_long;
    alias uintptr_t = c_ulong;
    alias intmax_t = c_long;
    alias uintmax_t = c_ulong;
    cudaError_enum cuMemcpyDtoHAsync_v2(void*, ulong, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpyHtoDAsync_v2(ulong, const(void)*, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpyPeerAsync(ulong, CUctx_st*, ulong, CUctx_st*, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpyAsync(ulong, ulong, c_ulong, CUstream_st*) @nogc nothrow;
    cudaError_enum cuMemcpy3DPeer(const(CUDA_MEMCPY3D_PEER_st)*) @nogc nothrow;
    cudaError_enum cuMemcpy3D_v2(const(CUDA_MEMCPY3D_st)*) @nogc nothrow;
    cudaError_enum cuMemcpy2DUnaligned_v2(const(CUDA_MEMCPY2D_st)*) @nogc nothrow;
    cudaError_enum cuMemcpy2D_v2(const(CUDA_MEMCPY2D_st)*) @nogc nothrow;
    cudaError_enum cuMemcpyAtoA_v2(CUarray_st*, c_ulong, CUarray_st*, c_ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyAtoH_v2(void*, CUarray_st*, c_ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyHtoA_v2(CUarray_st*, c_ulong, const(void)*, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyAtoD_v2(ulong, CUarray_st*, c_ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyDtoA_v2(CUarray_st*, c_ulong, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyDtoD_v2(ulong, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyDtoH_v2(void*, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyHtoD_v2(ulong, const(void)*, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpyPeer(ulong, CUctx_st*, ulong, CUctx_st*, c_ulong) @nogc nothrow;
    cudaError_enum cuMemcpy(ulong, ulong, c_ulong) @nogc nothrow;
    cudaError_enum cuMemHostUnregister(void*) @nogc nothrow;
    cudaError_enum cuMemHostRegister_v2(void*, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuIpcCloseMemHandle(ulong) @nogc nothrow;
    cudaError_enum cuIpcOpenMemHandle(ulong*, CUipcMemHandle_st, uint) @nogc nothrow;
    cudaError_enum cuIpcGetMemHandle(CUipcMemHandle_st*, ulong) @nogc nothrow;
    cudaError_enum cuIpcOpenEventHandle(CUevent_st**, CUipcEventHandle_st) @nogc nothrow;
    cudaError_enum cuIpcGetEventHandle(CUipcEventHandle_st*, CUevent_st*) @nogc nothrow;
    cudaError_enum cuDeviceGetPCIBusId(char*, int, int) @nogc nothrow;
    union __WAIT_STATUS
    {
        wait* __uptr;
        int* __iptr;
    }
    cudaError_enum cuDeviceGetByPCIBusId(int*, const(char)*) @nogc nothrow;
    cudaError_enum cuMemAllocManaged(ulong*, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuMemHostGetFlags(uint*, void*) @nogc nothrow;
    struct div_t
    {
        int quot;
        int rem;
    }
    struct ldiv_t
    {
        c_long quot;
        c_long rem;
    }
    struct lldiv_t
    {
        long quot;
        long rem;
    }
    cudaError_enum cuMemHostGetDevicePointer_v2(ulong*, void*, uint) @nogc nothrow;
    cudaError_enum cuMemHostAlloc(void**, c_ulong, uint) @nogc nothrow;
    c_ulong __ctype_get_mb_cur_max() @nogc nothrow;
    double atof(const(char)*) @nogc nothrow;
    int atoi(const(char)*) @nogc nothrow;
    c_long atol(const(char)*) @nogc nothrow;
    long atoll(const(char)*) @nogc nothrow;
    double strtod(const(char)*, char**) @nogc nothrow;
    float strtof(const(char)*, char**) @nogc nothrow;
    real strtold(const(char)*, char**) @nogc nothrow;
    c_long strtol(const(char)*, char**, int) @nogc nothrow;
    c_ulong strtoul(const(char)*, char**, int) @nogc nothrow;
    long strtoq(const(char)*, char**, int) @nogc nothrow;
    ulong strtouq(const(char)*, char**, int) @nogc nothrow;
    long strtoll(const(char)*, char**, int) @nogc nothrow;
    ulong strtoull(const(char)*, char**, int) @nogc nothrow;
    char* l64a(c_long) @nogc nothrow;
    c_long a64l(const(char)*) @nogc nothrow;
    c_long random() @nogc nothrow;
    void srandom(uint) @nogc nothrow;
    char* initstate(uint, char*, c_ulong) @nogc nothrow;
    char* setstate(char*) @nogc nothrow;
    struct random_data
    {
        int* fptr;
        int* rptr;
        int* state;
        int rand_type;
        int rand_deg;
        int rand_sep;
        int* end_ptr;
    }
    int random_r(random_data*, int*) @nogc nothrow;
    int srandom_r(uint, random_data*) @nogc nothrow;
    int initstate_r(uint, char*, c_ulong, random_data*) @nogc nothrow;
    int setstate_r(char*, random_data*) @nogc nothrow;
    int rand() @nogc nothrow;
    void srand(uint) @nogc nothrow;
    int rand_r(uint*) @nogc nothrow;
    double drand48() @nogc nothrow;
    double erand48(ushort*) @nogc nothrow;
    c_long lrand48() @nogc nothrow;
    c_long nrand48(ushort*) @nogc nothrow;
    c_long mrand48() @nogc nothrow;
    c_long jrand48(ushort*) @nogc nothrow;
    void srand48(c_long) @nogc nothrow;
    ushort* seed48(ushort*) @nogc nothrow;
    void lcong48(ushort*) @nogc nothrow;
    struct drand48_data
    {
        ushort[3] __x;
        ushort[3] __old_x;
        ushort __c;
        ushort __init;
        ulong __a;
    }
    int drand48_r(drand48_data*, double*) @nogc nothrow;
    int erand48_r(ushort*, drand48_data*, double*) @nogc nothrow;
    int lrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int nrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int mrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int jrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int srand48_r(c_long, drand48_data*) @nogc nothrow;
    int seed48_r(ushort*, drand48_data*) @nogc nothrow;
    int lcong48_r(ushort*, drand48_data*) @nogc nothrow;
    void* malloc(c_ulong) @nogc nothrow;
    void* calloc(c_ulong, c_ulong) @nogc nothrow;
    void* realloc(void*, c_ulong) @nogc nothrow;
    void free(void*) @nogc nothrow;
    void cfree(void*) @nogc nothrow;
    void* valloc(c_ulong) @nogc nothrow;
    int posix_memalign(void**, c_ulong, c_ulong) @nogc nothrow;
    void* aligned_alloc(c_ulong, c_ulong) @nogc nothrow;
    void abort() @nogc nothrow;
    int atexit(void function()) @nogc nothrow;
    int at_quick_exit(void function()) @nogc nothrow;
    int on_exit(void function(int, void*), void*) @nogc nothrow;
    void exit(int) @nogc nothrow;
    void quick_exit(int) @nogc nothrow;
    void _Exit(int) @nogc nothrow;
    char* getenv(const(char)*) @nogc nothrow;
    int putenv(char*) @nogc nothrow;
    int setenv(const(char)*, const(char)*, int) @nogc nothrow;
    int unsetenv(const(char)*) @nogc nothrow;
    int clearenv() @nogc nothrow;
    char* mktemp(char*) @nogc nothrow;
    int mkstemp(char*) @nogc nothrow;
    int mkstemps(char*, int) @nogc nothrow;
    char* mkdtemp(char*) @nogc nothrow;
    int system(const(char)*) @nogc nothrow;
    char* realpath(const(char)*, char*) @nogc nothrow;
    cudaError_enum cuMemFreeHost(void*) @nogc nothrow;
    alias __compar_fn_t = int function(const(void)*, const(void)*);
    void* bsearch(const(void)*, const(void)*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    void qsort(void*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    int abs(int) @nogc nothrow;
    c_long labs(c_long) @nogc nothrow;
    long llabs(long) @nogc nothrow;
    div_t div(int, int) @nogc nothrow;
    ldiv_t ldiv(c_long, c_long) @nogc nothrow;
    lldiv_t lldiv(long, long) @nogc nothrow;
    char* ecvt(double, int, int*, int*) @nogc nothrow;
    char* fcvt(double, int, int*, int*) @nogc nothrow;
    char* gcvt(double, int, char*) @nogc nothrow;
    char* qecvt(real, int, int*, int*) @nogc nothrow;
    char* qfcvt(real, int, int*, int*) @nogc nothrow;
    char* qgcvt(real, int, char*) @nogc nothrow;
    int ecvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int fcvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int qecvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int qfcvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int mblen(const(char)*, c_ulong) @nogc nothrow;
    int mbtowc(int*, const(char)*, c_ulong) @nogc nothrow;
    int wctomb(char*, int) @nogc nothrow;
    c_ulong mbstowcs(int*, const(char)*, c_ulong) @nogc nothrow;
    c_ulong wcstombs(char*, const(int)*, c_ulong) @nogc nothrow;
    int rpmatch(const(char)*) @nogc nothrow;
    int getsubopt(char**, char**, char**) @nogc nothrow;
    int getloadavg(double*, int) @nogc nothrow;
    alias clock_t = c_long;
    alias time_t = c_long;
    cudaError_enum cuMemAllocHost_v2(void**, c_ulong) @nogc nothrow;
    alias clockid_t = int;
    alias timer_t = void*;
    struct timespec
    {
        c_long tv_sec;
        c_long tv_nsec;
    }
    cudaError_enum cuMemGetAddressRange_v2(ulong*, c_ulong*, ulong) @nogc nothrow;
    cudaError_enum cuMemFree_v2(ulong) @nogc nothrow;
    cudaError_enum cuMemAllocPitch_v2(ulong*, c_ulong*, c_ulong, c_ulong, uint) @nogc nothrow;
    cudaError_enum cuMemAlloc_v2(ulong*, c_ulong) @nogc nothrow;
    cudaError_enum cuMemGetInfo_v2(c_ulong*, c_ulong*) @nogc nothrow;
    cudaError_enum cuLinkDestroy(CUlinkState_st*) @nogc nothrow;
    cudaError_enum cuLinkComplete(CUlinkState_st*, void**, c_ulong*) @nogc nothrow;
    alias pthread_t = c_ulong;
    union pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }
    alias __pthread_list_t = __pthread_internal_list;
    struct __pthread_internal_list
    {
        __pthread_internal_list* __prev;
        __pthread_internal_list* __next;
    }
    union pthread_mutex_t
    {
        struct __pthread_mutex_s
        {
            int __lock;
            uint __count;
            int __owner;
            uint __nusers;
            int __kind;
            short __spins;
            short __elision;
            __pthread_internal_list __list;
        }
        __pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }
    cudaError_enum cuLinkAddFile_v2(CUlinkState_st*, CUjitInputType_enum, const(char)*, uint, CUjit_option_enum*, void**) @nogc nothrow;
    union pthread_mutexattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_cond_t
    {
        static struct _Anonymous_0
        {
            int __lock;
            uint __futex;
            ulong __total_seq;
            ulong __wakeup_seq;
            ulong __woken_seq;
            void* __mutex;
            uint __nwaiters;
            uint __broadcast_seq;
        }
        _Anonymous_0 __data;
        char[48] __size;
        long __align;
    }
    union pthread_condattr_t
    {
        char[4] __size;
        int __align;
    }
    alias pthread_key_t = uint;
    alias pthread_once_t = int;
    union pthread_rwlock_t
    {
        static struct _Anonymous_1
        {
            int __lock;
            uint __nr_readers;
            uint __readers_wakeup;
            uint __writer_wakeup;
            uint __nr_readers_queued;
            uint __nr_writers_queued;
            int __writer;
            int __shared;
            byte __rwelision;
            ubyte[7] __pad1;
            c_ulong __pad2;
            uint __flags;
        }
        _Anonymous_1 __data;
        char[56] __size;
        c_long __align;
    }
    union pthread_rwlockattr_t
    {
        char[8] __size;
        c_long __align;
    }
    alias pthread_spinlock_t = int;
    union pthread_barrier_t
    {
        char[32] __size;
        c_long __align;
    }
    union pthread_barrierattr_t
    {
        char[4] __size;
        int __align;
    }
    cudaError_enum cuLinkAddData_v2(CUlinkState_st*, CUjitInputType_enum, void*, c_ulong, const(char)*, uint, CUjit_option_enum*, void**) @nogc nothrow;
    cudaError_enum cuLinkCreate_v2(uint, CUjit_option_enum*, void**, CUlinkState_st**) @nogc nothrow;
    alias __sig_atomic_t = int;
    cudaError_enum cuModuleGetSurfRef(CUsurfref_st**, CUmod_st*, const(char)*) @nogc nothrow;
    struct __sigset_t
    {
        c_ulong[16] __val;
    }
    struct timeval
    {
        c_long tv_sec;
        c_long tv_usec;
    }
    cudaError_enum cuModuleGetTexRef(CUtexref_st**, CUmod_st*, const(char)*) @nogc nothrow;
    alias __u_char = ubyte;
    alias __u_short = ushort;
    alias __u_int = uint;
    alias __u_long = c_ulong;
    alias __int8_t = byte;
    alias __uint8_t = ubyte;
    alias __int16_t = short;
    alias __uint16_t = ushort;
    alias __int32_t = int;
    alias __uint32_t = uint;
    alias __int64_t = c_long;
    alias __uint64_t = c_ulong;
    alias __quad_t = c_long;
    alias __u_quad_t = c_ulong;
    cudaError_enum cuModuleGetGlobal_v2(ulong*, c_ulong*, CUmod_st*, const(char)*) @nogc nothrow;
    cudaError_enum cuModuleGetFunction(CUfunc_st**, CUmod_st*, const(char)*) @nogc nothrow;
    cudaError_enum cuModuleUnload(CUmod_st*) @nogc nothrow;
    cudaError_enum cuModuleLoadFatBinary(CUmod_st**, const(void)*) @nogc nothrow;
    cudaError_enum cuModuleLoadDataEx(CUmod_st**, const(void)*, uint, CUjit_option_enum*, void**) @nogc nothrow;
    cudaError_enum cuModuleLoadData(CUmod_st**, const(void)*) @nogc nothrow;
    alias __dev_t = c_ulong;
    alias __uid_t = uint;
    alias __gid_t = uint;
    alias __ino_t = c_ulong;
    alias __ino64_t = c_ulong;
    alias __mode_t = uint;
    alias __nlink_t = c_ulong;
    alias __off_t = c_long;
    alias __off64_t = c_long;
    alias __pid_t = int;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __clock_t = c_long;
    alias __rlim_t = c_ulong;
    alias __rlim64_t = c_ulong;
    alias __id_t = uint;
    alias __time_t = c_long;
    alias __useconds_t = uint;
    alias __suseconds_t = c_long;
    alias __daddr_t = int;
    alias __key_t = int;
    alias __clockid_t = int;
    alias __timer_t = void*;
    alias __blksize_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blkcnt64_t = c_long;
    alias __fsblkcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsword_t = c_long;
    alias __ssize_t = c_long;
    alias __syscall_slong_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __loff_t = c_long;
    alias __qaddr_t = c_long*;
    alias __caddr_t = char*;
    alias __intptr_t = c_long;
    alias __socklen_t = uint;
    cudaError_enum cuModuleLoad(CUmod_st**, const(char)*) @nogc nothrow;
    cudaError_enum cuCtxDetach(CUctx_st*) @nogc nothrow;
    cudaError_enum cuCtxAttach(CUctx_st**, uint) @nogc nothrow;
    cudaError_enum cuCtxGetStreamPriorityRange(int*, int*) @nogc nothrow;
    cudaError_enum cuCtxGetApiVersion(CUctx_st*, uint*) @nogc nothrow;
    cudaError_enum cuCtxSetSharedMemConfig(CUsharedconfig_enum) @nogc nothrow;
    cudaError_enum cuCtxGetSharedMemConfig(CUsharedconfig_enum*) @nogc nothrow;
    cudaError_enum cuCtxSetCacheConfig(CUfunc_cache_enum) @nogc nothrow;
    cudaError_enum cuCtxGetCacheConfig(CUfunc_cache_enum*) @nogc nothrow;
    cudaError_enum cuCtxGetLimit(c_ulong*, CUlimit_enum) @nogc nothrow;
    cudaError_enum cuCtxSetLimit(CUlimit_enum, c_ulong) @nogc nothrow;
    cudaError_enum cuCtxSynchronize() @nogc nothrow;
    cudaError_enum cuCtxGetFlags(uint*) @nogc nothrow;
    cudaError_enum cuCtxGetDevice(int*) @nogc nothrow;
    cudaError_enum cuCtxGetCurrent(CUctx_st**) @nogc nothrow;
    cudaError_enum cuCtxSetCurrent(CUctx_st*) @nogc nothrow;
    cudaError_enum cuCtxPopCurrent_v2(CUctx_st**) @nogc nothrow;
    cudaError_enum cuCtxPushCurrent_v2(CUctx_st*) @nogc nothrow;
    cudaError_enum cuCtxDestroy_v2(CUctx_st*) @nogc nothrow;
    alias idtype_t = _Anonymous_2;
    enum _Anonymous_2
    {
        P_ALL = 0,
        P_PID = 1,
        P_PGID = 2,
    }
    enum P_ALL = _Anonymous_2.P_ALL;
    enum P_PID = _Anonymous_2.P_PID;
    enum P_PGID = _Anonymous_2.P_PGID;
    cudaError_enum cuCtxCreate_v2(CUctx_st**, uint, int) @nogc nothrow;
    cudaError_enum cuDevicePrimaryCtxReset(int) @nogc nothrow;
    cudaError_enum cuDevicePrimaryCtxGetState(int, uint*, int*) @nogc nothrow;
    cudaError_enum cuDevicePrimaryCtxSetFlags(int, uint) @nogc nothrow;
    cudaError_enum cuDevicePrimaryCtxRelease(int) @nogc nothrow;
    cudaError_enum cuDevicePrimaryCtxRetain(CUctx_st**, int) @nogc nothrow;
    union wait
    {
        int w_status;
        static struct _Anonymous_3
        {
            import std.bitmanip: bitfields;

            align(4):
            mixin(bitfields!(
                uint, "__w_termsig", 7,
                uint, "__w_coredump", 1,
                uint, "__w_retcode", 8,
                uint, "_anonymous_4", 16,
            ));
        }
        _Anonymous_3 __wait_terminated;
        static struct _Anonymous_5
        {
            import std.bitmanip: bitfields;

            align(4):
            mixin(bitfields!(
                uint, "__w_stopval", 8,
                uint, "__w_stopsig", 8,
                uint, "_anonymous_6", 16,
            ));
        }
        _Anonymous_5 __wait_stopped;
    }
    cudaError_enum cuDeviceComputeCapability(int*, int*, int) @nogc nothrow;
    cudaError_enum cuDeviceGetProperties(CUdevprop_st*, int) @nogc nothrow;
    cudaError_enum cuDeviceGetAttribute(int*, CUdevice_attribute_enum, int) @nogc nothrow;
    cudaError_enum cuDeviceTotalMem_v2(c_ulong*, int) @nogc nothrow;
    cudaError_enum cuDeviceGetUuid(CUuuid_st*, int) @nogc nothrow;
    cudaError_enum cuDeviceGetName(char*, int, int) @nogc nothrow;
    cudaError_enum cuDeviceGetCount(int*) @nogc nothrow;
    cudaError_enum cuDeviceGet(int*, int) @nogc nothrow;
    cudaError_enum cuDriverGetVersion(int*) @nogc nothrow;
    cudaError_enum cuInit(uint) @nogc nothrow;
    cudaError_enum cuGetErrorName(cudaError_enum, const(char)**) @nogc nothrow;
    cudaError_enum cuGetErrorString(cudaError_enum, const(char)**) @nogc nothrow;
    struct CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st
    {
        static struct _Anonymous_7
        {
            static struct _Anonymous_8
            {
                ulong value;
            }
            _Anonymous_8 fence;
            uint[16] reserved;
        }
        _Anonymous_7 params;
        uint flags;
        uint[16] reserved;
    }
    alias CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS = CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_st;
    struct CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st
    {
        static struct _Anonymous_9
        {
            static struct _Anonymous_10
            {
                ulong value;
            }
            _Anonymous_10 fence;
            uint[16] reserved;
        }
        _Anonymous_9 params;
        uint flags;
        uint[16] reserved;
    }
    alias CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS = CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_st;
    struct CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st
    {
        CUexternalSemaphoreHandleType_enum type;
        static union _Anonymous_11
        {
            int fd;
            static struct _Anonymous_12
            {
                void* handle;
                const(void)* name;
            }
            _Anonymous_12 win32;
        }
        _Anonymous_11 handle;
        uint flags;
        uint[16] reserved;
    }
    alias CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC = CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_st;
    enum CUexternalSemaphoreHandleType_enum
    {
        CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD = 1,
        CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32 = 2,
        CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT = 3,
        CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE = 4,
    }
    enum CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD = CUexternalSemaphoreHandleType_enum.CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD;
    enum CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32 = CUexternalSemaphoreHandleType_enum.CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32;
    enum CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT = CUexternalSemaphoreHandleType_enum.CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT;
    enum CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE = CUexternalSemaphoreHandleType_enum.CU_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE;
    alias CUexternalSemaphoreHandleType = CUexternalSemaphoreHandleType_enum;
    struct CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st
    {
        ulong offset;
        CUDA_ARRAY3D_DESCRIPTOR_st arrayDesc;
        uint numLevels;
        uint[16] reserved;
    }
    alias CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC = CUDA_EXTERNAL_MEMORY_MIPMAPPED_ARRAY_DESC_st;
    struct CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st
    {
        ulong offset;
        ulong size;
        uint flags;
        uint[16] reserved;
    }
    alias CUDA_EXTERNAL_MEMORY_BUFFER_DESC = CUDA_EXTERNAL_MEMORY_BUFFER_DESC_st;
    struct CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st
    {
        CUexternalMemoryHandleType_enum type;
        static union _Anonymous_13
        {
            int fd;
            static struct _Anonymous_14
            {
                void* handle;
                const(void)* name;
            }
            _Anonymous_14 win32;
        }
        _Anonymous_13 handle;
        ulong size;
        uint flags;
        uint[16] reserved;
    }
    alias CUDA_EXTERNAL_MEMORY_HANDLE_DESC = CUDA_EXTERNAL_MEMORY_HANDLE_DESC_st;
    enum CUexternalMemoryHandleType_enum
    {
        CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD = 1,
        CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32 = 2,
        CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT = 3,
        CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP = 4,
        CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE = 5,
    }
    enum CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD = CUexternalMemoryHandleType_enum.CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD;
    enum CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32 = CUexternalMemoryHandleType_enum.CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32;
    enum CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT = CUexternalMemoryHandleType_enum.CU_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_WIN32_KMT;
    enum CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP = CUexternalMemoryHandleType_enum.CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_HEAP;
    enum CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE = CUexternalMemoryHandleType_enum.CU_EXTERNAL_MEMORY_HANDLE_TYPE_D3D12_RESOURCE;
    alias CUexternalMemoryHandleType = CUexternalMemoryHandleType_enum;
    struct CUDA_LAUNCH_PARAMS_st
    {
        CUfunc_st* function_;
        uint gridDimX;
        uint gridDimY;
        uint gridDimZ;
        uint blockDimX;
        uint blockDimY;
        uint blockDimZ;
        uint sharedMemBytes;
        CUstream_st* hStream;
        void** kernelParams;
    }
    alias CUDA_LAUNCH_PARAMS = CUDA_LAUNCH_PARAMS_st;
    struct CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st
    {
        ulong p2pToken;
        uint vaSpaceToken;
    }
    alias CUDA_POINTER_ATTRIBUTE_P2P_TOKENS = CUDA_POINTER_ATTRIBUTE_P2P_TOKENS_st;
    struct CUDA_RESOURCE_VIEW_DESC_st
    {
        CUresourceViewFormat_enum format;
        c_ulong width;
        c_ulong height;
        c_ulong depth;
        uint firstMipmapLevel;
        uint lastMipmapLevel;
        uint firstLayer;
        uint lastLayer;
        uint[16] reserved;
    }
    alias CUDA_RESOURCE_VIEW_DESC = CUDA_RESOURCE_VIEW_DESC_st;
    enum CUresourceViewFormat_enum
    {
        CU_RES_VIEW_FORMAT_NONE = 0,
        CU_RES_VIEW_FORMAT_UINT_1X8 = 1,
        CU_RES_VIEW_FORMAT_UINT_2X8 = 2,
        CU_RES_VIEW_FORMAT_UINT_4X8 = 3,
        CU_RES_VIEW_FORMAT_SINT_1X8 = 4,
        CU_RES_VIEW_FORMAT_SINT_2X8 = 5,
        CU_RES_VIEW_FORMAT_SINT_4X8 = 6,
        CU_RES_VIEW_FORMAT_UINT_1X16 = 7,
        CU_RES_VIEW_FORMAT_UINT_2X16 = 8,
        CU_RES_VIEW_FORMAT_UINT_4X16 = 9,
        CU_RES_VIEW_FORMAT_SINT_1X16 = 10,
        CU_RES_VIEW_FORMAT_SINT_2X16 = 11,
        CU_RES_VIEW_FORMAT_SINT_4X16 = 12,
        CU_RES_VIEW_FORMAT_UINT_1X32 = 13,
        CU_RES_VIEW_FORMAT_UINT_2X32 = 14,
        CU_RES_VIEW_FORMAT_UINT_4X32 = 15,
        CU_RES_VIEW_FORMAT_SINT_1X32 = 16,
        CU_RES_VIEW_FORMAT_SINT_2X32 = 17,
        CU_RES_VIEW_FORMAT_SINT_4X32 = 18,
        CU_RES_VIEW_FORMAT_FLOAT_1X16 = 19,
        CU_RES_VIEW_FORMAT_FLOAT_2X16 = 20,
        CU_RES_VIEW_FORMAT_FLOAT_4X16 = 21,
        CU_RES_VIEW_FORMAT_FLOAT_1X32 = 22,
        CU_RES_VIEW_FORMAT_FLOAT_2X32 = 23,
        CU_RES_VIEW_FORMAT_FLOAT_4X32 = 24,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC1 = 25,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC2 = 26,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC3 = 27,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC4 = 28,
        CU_RES_VIEW_FORMAT_SIGNED_BC4 = 29,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC5 = 30,
        CU_RES_VIEW_FORMAT_SIGNED_BC5 = 31,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC6H = 32,
        CU_RES_VIEW_FORMAT_SIGNED_BC6H = 33,
        CU_RES_VIEW_FORMAT_UNSIGNED_BC7 = 34,
    }
    enum CU_RES_VIEW_FORMAT_NONE = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_NONE;
    enum CU_RES_VIEW_FORMAT_UINT_1X8 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_1X8;
    enum CU_RES_VIEW_FORMAT_UINT_2X8 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_2X8;
    enum CU_RES_VIEW_FORMAT_UINT_4X8 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_4X8;
    enum CU_RES_VIEW_FORMAT_SINT_1X8 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_1X8;
    enum CU_RES_VIEW_FORMAT_SINT_2X8 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_2X8;
    enum CU_RES_VIEW_FORMAT_SINT_4X8 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_4X8;
    enum CU_RES_VIEW_FORMAT_UINT_1X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_1X16;
    enum CU_RES_VIEW_FORMAT_UINT_2X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_2X16;
    enum CU_RES_VIEW_FORMAT_UINT_4X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_4X16;
    enum CU_RES_VIEW_FORMAT_SINT_1X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_1X16;
    enum CU_RES_VIEW_FORMAT_SINT_2X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_2X16;
    enum CU_RES_VIEW_FORMAT_SINT_4X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_4X16;
    enum CU_RES_VIEW_FORMAT_UINT_1X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_1X32;
    enum CU_RES_VIEW_FORMAT_UINT_2X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_2X32;
    enum CU_RES_VIEW_FORMAT_UINT_4X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UINT_4X32;
    enum CU_RES_VIEW_FORMAT_SINT_1X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_1X32;
    enum CU_RES_VIEW_FORMAT_SINT_2X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_2X32;
    enum CU_RES_VIEW_FORMAT_SINT_4X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SINT_4X32;
    enum CU_RES_VIEW_FORMAT_FLOAT_1X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_FLOAT_1X16;
    enum CU_RES_VIEW_FORMAT_FLOAT_2X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_FLOAT_2X16;
    enum CU_RES_VIEW_FORMAT_FLOAT_4X16 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_FLOAT_4X16;
    enum CU_RES_VIEW_FORMAT_FLOAT_1X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_FLOAT_1X32;
    enum CU_RES_VIEW_FORMAT_FLOAT_2X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_FLOAT_2X32;
    enum CU_RES_VIEW_FORMAT_FLOAT_4X32 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_FLOAT_4X32;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC1 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC1;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC2 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC2;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC3 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC3;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC4 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC4;
    enum CU_RES_VIEW_FORMAT_SIGNED_BC4 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SIGNED_BC4;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC5 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC5;
    enum CU_RES_VIEW_FORMAT_SIGNED_BC5 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SIGNED_BC5;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC6H = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC6H;
    enum CU_RES_VIEW_FORMAT_SIGNED_BC6H = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_SIGNED_BC6H;
    enum CU_RES_VIEW_FORMAT_UNSIGNED_BC7 = CUresourceViewFormat_enum.CU_RES_VIEW_FORMAT_UNSIGNED_BC7;
    alias CUresourceViewFormat = CUresourceViewFormat_enum;
    struct CUDA_TEXTURE_DESC_st
    {
        CUaddress_mode_enum[3] addressMode;
        CUfilter_mode_enum filterMode;
        uint flags;
        uint maxAnisotropy;
        CUfilter_mode_enum mipmapFilterMode;
        float mipmapLevelBias;
        float minMipmapLevelClamp;
        float maxMipmapLevelClamp;
        float[4] borderColor;
        int[12] reserved;
    }
    alias CUDA_TEXTURE_DESC = CUDA_TEXTURE_DESC_st;
    struct CUDA_RESOURCE_DESC_st
    {
        CUresourcetype_enum resType;
        static union _Anonymous_15
        {
            static struct _Anonymous_16
            {
                CUarray_st* hArray;
            }
            _Anonymous_16 array;
            static struct _Anonymous_17
            {
                CUmipmappedArray_st* hMipmappedArray;
            }
            _Anonymous_17 mipmap;
            static struct _Anonymous_18
            {
                ulong devPtr;
                CUarray_format_enum format;
                uint numChannels;
                c_ulong sizeInBytes;
            }
            _Anonymous_18 linear;
            static struct _Anonymous_19
            {
                ulong devPtr;
                CUarray_format_enum format;
                uint numChannels;
                c_ulong width;
                c_ulong height;
                c_ulong pitchInBytes;
            }
            _Anonymous_19 pitch2D;
            static struct _Anonymous_20
            {
                int[32] reserved;
            }
            _Anonymous_20 reserved;
        }
        _Anonymous_15 res;
        uint flags;
    }
    alias CUDA_RESOURCE_DESC = CUDA_RESOURCE_DESC_st;
    struct CUDA_ARRAY3D_DESCRIPTOR_st
    {
        c_ulong Width;
        c_ulong Height;
        c_ulong Depth;
        CUarray_format_enum Format;
        uint NumChannels;
        uint Flags;
    }
    alias CUDA_ARRAY3D_DESCRIPTOR = CUDA_ARRAY3D_DESCRIPTOR_st;
    struct CUDA_ARRAY_DESCRIPTOR_st
    {
        c_ulong Width;
        c_ulong Height;
        CUarray_format_enum Format;
        uint NumChannels;
    }
    alias CUDA_ARRAY_DESCRIPTOR = CUDA_ARRAY_DESCRIPTOR_st;
    struct CUDA_MEMCPY3D_PEER_st
    {
        c_ulong srcXInBytes;
        c_ulong srcY;
        c_ulong srcZ;
        c_ulong srcLOD;
        CUmemorytype_enum srcMemoryType;
        const(void)* srcHost;
        ulong srcDevice;
        CUarray_st* srcArray;
        CUctx_st* srcContext;
        c_ulong srcPitch;
        c_ulong srcHeight;
        c_ulong dstXInBytes;
        c_ulong dstY;
        c_ulong dstZ;
        c_ulong dstLOD;
        CUmemorytype_enum dstMemoryType;
        void* dstHost;
        ulong dstDevice;
        CUarray_st* dstArray;
        CUctx_st* dstContext;
        c_ulong dstPitch;
        c_ulong dstHeight;
        c_ulong WidthInBytes;
        c_ulong Height;
        c_ulong Depth;
    }
    alias CUDA_MEMCPY3D_PEER = CUDA_MEMCPY3D_PEER_st;
    struct CUDA_MEMCPY3D_st
    {
        c_ulong srcXInBytes;
        c_ulong srcY;
        c_ulong srcZ;
        c_ulong srcLOD;
        CUmemorytype_enum srcMemoryType;
        const(void)* srcHost;
        ulong srcDevice;
        CUarray_st* srcArray;
        void* reserved0;
        c_ulong srcPitch;
        c_ulong srcHeight;
        c_ulong dstXInBytes;
        c_ulong dstY;
        c_ulong dstZ;
        c_ulong dstLOD;
        CUmemorytype_enum dstMemoryType;
        void* dstHost;
        ulong dstDevice;
        CUarray_st* dstArray;
        void* reserved1;
        c_ulong dstPitch;
        c_ulong dstHeight;
        c_ulong WidthInBytes;
        c_ulong Height;
        c_ulong Depth;
    }
    alias CUDA_MEMCPY3D = CUDA_MEMCPY3D_st;
    struct CUDA_MEMCPY2D_st
    {
        c_ulong srcXInBytes;
        c_ulong srcY;
        CUmemorytype_enum srcMemoryType;
        const(void)* srcHost;
        ulong srcDevice;
        CUarray_st* srcArray;
        c_ulong srcPitch;
        c_ulong dstXInBytes;
        c_ulong dstY;
        CUmemorytype_enum dstMemoryType;
        void* dstHost;
        ulong dstDevice;
        CUarray_st* dstArray;
        c_ulong dstPitch;
        c_ulong WidthInBytes;
        c_ulong Height;
    }
    alias CUDA_MEMCPY2D = CUDA_MEMCPY2D_st;
    alias CUoccupancyB2DSize = c_ulong function(int);
    alias CUstreamCallback = void function(CUstream_st*, cudaError_enum, void*);
    enum CUdevice_P2PAttribute_enum
    {
        CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK = 1,
        CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED = 2,
        CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED = 3,
        CU_DEVICE_P2P_ATTRIBUTE_ARRAY_ACCESS_ACCESS_SUPPORTED = 4,
        CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED = 4,
    }
    enum CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK = CUdevice_P2PAttribute_enum.CU_DEVICE_P2P_ATTRIBUTE_PERFORMANCE_RANK;
    enum CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED = CUdevice_P2PAttribute_enum.CU_DEVICE_P2P_ATTRIBUTE_ACCESS_SUPPORTED;
    enum CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED = CUdevice_P2PAttribute_enum.CU_DEVICE_P2P_ATTRIBUTE_NATIVE_ATOMIC_SUPPORTED;
    enum CU_DEVICE_P2P_ATTRIBUTE_ARRAY_ACCESS_ACCESS_SUPPORTED = CUdevice_P2PAttribute_enum.CU_DEVICE_P2P_ATTRIBUTE_ARRAY_ACCESS_ACCESS_SUPPORTED;
    enum CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED = CUdevice_P2PAttribute_enum.CU_DEVICE_P2P_ATTRIBUTE_CUDA_ARRAY_ACCESS_SUPPORTED;
    alias CUdevice_P2PAttribute = CUdevice_P2PAttribute_enum;
    enum cudaError_enum
    {
        CUDA_SUCCESS = 0,
        CUDA_ERROR_INVALID_VALUE = 1,
        CUDA_ERROR_OUT_OF_MEMORY = 2,
        CUDA_ERROR_NOT_INITIALIZED = 3,
        CUDA_ERROR_DEINITIALIZED = 4,
        CUDA_ERROR_PROFILER_DISABLED = 5,
        CUDA_ERROR_PROFILER_NOT_INITIALIZED = 6,
        CUDA_ERROR_PROFILER_ALREADY_STARTED = 7,
        CUDA_ERROR_PROFILER_ALREADY_STOPPED = 8,
        CUDA_ERROR_NO_DEVICE = 100,
        CUDA_ERROR_INVALID_DEVICE = 101,
        CUDA_ERROR_INVALID_IMAGE = 200,
        CUDA_ERROR_INVALID_CONTEXT = 201,
        CUDA_ERROR_CONTEXT_ALREADY_CURRENT = 202,
        CUDA_ERROR_MAP_FAILED = 205,
        CUDA_ERROR_UNMAP_FAILED = 206,
        CUDA_ERROR_ARRAY_IS_MAPPED = 207,
        CUDA_ERROR_ALREADY_MAPPED = 208,
        CUDA_ERROR_NO_BINARY_FOR_GPU = 209,
        CUDA_ERROR_ALREADY_ACQUIRED = 210,
        CUDA_ERROR_NOT_MAPPED = 211,
        CUDA_ERROR_NOT_MAPPED_AS_ARRAY = 212,
        CUDA_ERROR_NOT_MAPPED_AS_POINTER = 213,
        CUDA_ERROR_ECC_UNCORRECTABLE = 214,
        CUDA_ERROR_UNSUPPORTED_LIMIT = 215,
        CUDA_ERROR_CONTEXT_ALREADY_IN_USE = 216,
        CUDA_ERROR_PEER_ACCESS_UNSUPPORTED = 217,
        CUDA_ERROR_INVALID_PTX = 218,
        CUDA_ERROR_INVALID_GRAPHICS_CONTEXT = 219,
        CUDA_ERROR_NVLINK_UNCORRECTABLE = 220,
        CUDA_ERROR_JIT_COMPILER_NOT_FOUND = 221,
        CUDA_ERROR_INVALID_SOURCE = 300,
        CUDA_ERROR_FILE_NOT_FOUND = 301,
        CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND = 302,
        CUDA_ERROR_SHARED_OBJECT_INIT_FAILED = 303,
        CUDA_ERROR_OPERATING_SYSTEM = 304,
        CUDA_ERROR_INVALID_HANDLE = 400,
        CUDA_ERROR_ILLEGAL_STATE = 401,
        CUDA_ERROR_NOT_FOUND = 500,
        CUDA_ERROR_NOT_READY = 600,
        CUDA_ERROR_ILLEGAL_ADDRESS = 700,
        CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES = 701,
        CUDA_ERROR_LAUNCH_TIMEOUT = 702,
        CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING = 703,
        CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED = 704,
        CUDA_ERROR_PEER_ACCESS_NOT_ENABLED = 705,
        CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE = 708,
        CUDA_ERROR_CONTEXT_IS_DESTROYED = 709,
        CUDA_ERROR_ASSERT = 710,
        CUDA_ERROR_TOO_MANY_PEERS = 711,
        CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED = 712,
        CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED = 713,
        CUDA_ERROR_HARDWARE_STACK_ERROR = 714,
        CUDA_ERROR_ILLEGAL_INSTRUCTION = 715,
        CUDA_ERROR_MISALIGNED_ADDRESS = 716,
        CUDA_ERROR_INVALID_ADDRESS_SPACE = 717,
        CUDA_ERROR_INVALID_PC = 718,
        CUDA_ERROR_LAUNCH_FAILED = 719,
        CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE = 720,
        CUDA_ERROR_NOT_PERMITTED = 800,
        CUDA_ERROR_NOT_SUPPORTED = 801,
        CUDA_ERROR_SYSTEM_NOT_READY = 802,
        CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED = 900,
        CUDA_ERROR_STREAM_CAPTURE_INVALIDATED = 901,
        CUDA_ERROR_STREAM_CAPTURE_MERGE = 902,
        CUDA_ERROR_STREAM_CAPTURE_UNMATCHED = 903,
        CUDA_ERROR_STREAM_CAPTURE_UNJOINED = 904,
        CUDA_ERROR_STREAM_CAPTURE_ISOLATION = 905,
        CUDA_ERROR_STREAM_CAPTURE_IMPLICIT = 906,
        CUDA_ERROR_CAPTURED_EVENT = 907,
        CUDA_ERROR_UNKNOWN = 999,
    }
    enum CUDA_SUCCESS = cudaError_enum.CUDA_SUCCESS;
    enum CUDA_ERROR_INVALID_VALUE = cudaError_enum.CUDA_ERROR_INVALID_VALUE;
    enum CUDA_ERROR_OUT_OF_MEMORY = cudaError_enum.CUDA_ERROR_OUT_OF_MEMORY;
    enum CUDA_ERROR_NOT_INITIALIZED = cudaError_enum.CUDA_ERROR_NOT_INITIALIZED;
    enum CUDA_ERROR_DEINITIALIZED = cudaError_enum.CUDA_ERROR_DEINITIALIZED;
    enum CUDA_ERROR_PROFILER_DISABLED = cudaError_enum.CUDA_ERROR_PROFILER_DISABLED;
    enum CUDA_ERROR_PROFILER_NOT_INITIALIZED = cudaError_enum.CUDA_ERROR_PROFILER_NOT_INITIALIZED;
    enum CUDA_ERROR_PROFILER_ALREADY_STARTED = cudaError_enum.CUDA_ERROR_PROFILER_ALREADY_STARTED;
    enum CUDA_ERROR_PROFILER_ALREADY_STOPPED = cudaError_enum.CUDA_ERROR_PROFILER_ALREADY_STOPPED;
    enum CUDA_ERROR_NO_DEVICE = cudaError_enum.CUDA_ERROR_NO_DEVICE;
    enum CUDA_ERROR_INVALID_DEVICE = cudaError_enum.CUDA_ERROR_INVALID_DEVICE;
    enum CUDA_ERROR_INVALID_IMAGE = cudaError_enum.CUDA_ERROR_INVALID_IMAGE;
    enum CUDA_ERROR_INVALID_CONTEXT = cudaError_enum.CUDA_ERROR_INVALID_CONTEXT;
    enum CUDA_ERROR_CONTEXT_ALREADY_CURRENT = cudaError_enum.CUDA_ERROR_CONTEXT_ALREADY_CURRENT;
    enum CUDA_ERROR_MAP_FAILED = cudaError_enum.CUDA_ERROR_MAP_FAILED;
    enum CUDA_ERROR_UNMAP_FAILED = cudaError_enum.CUDA_ERROR_UNMAP_FAILED;
    enum CUDA_ERROR_ARRAY_IS_MAPPED = cudaError_enum.CUDA_ERROR_ARRAY_IS_MAPPED;
    enum CUDA_ERROR_ALREADY_MAPPED = cudaError_enum.CUDA_ERROR_ALREADY_MAPPED;
    enum CUDA_ERROR_NO_BINARY_FOR_GPU = cudaError_enum.CUDA_ERROR_NO_BINARY_FOR_GPU;
    enum CUDA_ERROR_ALREADY_ACQUIRED = cudaError_enum.CUDA_ERROR_ALREADY_ACQUIRED;
    enum CUDA_ERROR_NOT_MAPPED = cudaError_enum.CUDA_ERROR_NOT_MAPPED;
    enum CUDA_ERROR_NOT_MAPPED_AS_ARRAY = cudaError_enum.CUDA_ERROR_NOT_MAPPED_AS_ARRAY;
    enum CUDA_ERROR_NOT_MAPPED_AS_POINTER = cudaError_enum.CUDA_ERROR_NOT_MAPPED_AS_POINTER;
    enum CUDA_ERROR_ECC_UNCORRECTABLE = cudaError_enum.CUDA_ERROR_ECC_UNCORRECTABLE;
    enum CUDA_ERROR_UNSUPPORTED_LIMIT = cudaError_enum.CUDA_ERROR_UNSUPPORTED_LIMIT;
    enum CUDA_ERROR_CONTEXT_ALREADY_IN_USE = cudaError_enum.CUDA_ERROR_CONTEXT_ALREADY_IN_USE;
    enum CUDA_ERROR_PEER_ACCESS_UNSUPPORTED = cudaError_enum.CUDA_ERROR_PEER_ACCESS_UNSUPPORTED;
    enum CUDA_ERROR_INVALID_PTX = cudaError_enum.CUDA_ERROR_INVALID_PTX;
    enum CUDA_ERROR_INVALID_GRAPHICS_CONTEXT = cudaError_enum.CUDA_ERROR_INVALID_GRAPHICS_CONTEXT;
    enum CUDA_ERROR_NVLINK_UNCORRECTABLE = cudaError_enum.CUDA_ERROR_NVLINK_UNCORRECTABLE;
    enum CUDA_ERROR_JIT_COMPILER_NOT_FOUND = cudaError_enum.CUDA_ERROR_JIT_COMPILER_NOT_FOUND;
    enum CUDA_ERROR_INVALID_SOURCE = cudaError_enum.CUDA_ERROR_INVALID_SOURCE;
    enum CUDA_ERROR_FILE_NOT_FOUND = cudaError_enum.CUDA_ERROR_FILE_NOT_FOUND;
    enum CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND = cudaError_enum.CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND;
    enum CUDA_ERROR_SHARED_OBJECT_INIT_FAILED = cudaError_enum.CUDA_ERROR_SHARED_OBJECT_INIT_FAILED;
    enum CUDA_ERROR_OPERATING_SYSTEM = cudaError_enum.CUDA_ERROR_OPERATING_SYSTEM;
    enum CUDA_ERROR_INVALID_HANDLE = cudaError_enum.CUDA_ERROR_INVALID_HANDLE;
    enum CUDA_ERROR_ILLEGAL_STATE = cudaError_enum.CUDA_ERROR_ILLEGAL_STATE;
    enum CUDA_ERROR_NOT_FOUND = cudaError_enum.CUDA_ERROR_NOT_FOUND;
    enum CUDA_ERROR_NOT_READY = cudaError_enum.CUDA_ERROR_NOT_READY;
    enum CUDA_ERROR_ILLEGAL_ADDRESS = cudaError_enum.CUDA_ERROR_ILLEGAL_ADDRESS;
    enum CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES = cudaError_enum.CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES;
    enum CUDA_ERROR_LAUNCH_TIMEOUT = cudaError_enum.CUDA_ERROR_LAUNCH_TIMEOUT;
    enum CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING = cudaError_enum.CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING;
    enum CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED = cudaError_enum.CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED;
    enum CUDA_ERROR_PEER_ACCESS_NOT_ENABLED = cudaError_enum.CUDA_ERROR_PEER_ACCESS_NOT_ENABLED;
    enum CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE = cudaError_enum.CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE;
    enum CUDA_ERROR_CONTEXT_IS_DESTROYED = cudaError_enum.CUDA_ERROR_CONTEXT_IS_DESTROYED;
    enum CUDA_ERROR_ASSERT = cudaError_enum.CUDA_ERROR_ASSERT;
    enum CUDA_ERROR_TOO_MANY_PEERS = cudaError_enum.CUDA_ERROR_TOO_MANY_PEERS;
    enum CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED = cudaError_enum.CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED;
    enum CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED = cudaError_enum.CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED;
    enum CUDA_ERROR_HARDWARE_STACK_ERROR = cudaError_enum.CUDA_ERROR_HARDWARE_STACK_ERROR;
    enum CUDA_ERROR_ILLEGAL_INSTRUCTION = cudaError_enum.CUDA_ERROR_ILLEGAL_INSTRUCTION;
    enum CUDA_ERROR_MISALIGNED_ADDRESS = cudaError_enum.CUDA_ERROR_MISALIGNED_ADDRESS;
    enum CUDA_ERROR_INVALID_ADDRESS_SPACE = cudaError_enum.CUDA_ERROR_INVALID_ADDRESS_SPACE;
    enum CUDA_ERROR_INVALID_PC = cudaError_enum.CUDA_ERROR_INVALID_PC;
    enum CUDA_ERROR_LAUNCH_FAILED = cudaError_enum.CUDA_ERROR_LAUNCH_FAILED;
    enum CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE = cudaError_enum.CUDA_ERROR_COOPERATIVE_LAUNCH_TOO_LARGE;
    enum CUDA_ERROR_NOT_PERMITTED = cudaError_enum.CUDA_ERROR_NOT_PERMITTED;
    enum CUDA_ERROR_NOT_SUPPORTED = cudaError_enum.CUDA_ERROR_NOT_SUPPORTED;
    enum CUDA_ERROR_SYSTEM_NOT_READY = cudaError_enum.CUDA_ERROR_SYSTEM_NOT_READY;
    enum CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_UNSUPPORTED;
    enum CUDA_ERROR_STREAM_CAPTURE_INVALIDATED = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_INVALIDATED;
    enum CUDA_ERROR_STREAM_CAPTURE_MERGE = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_MERGE;
    enum CUDA_ERROR_STREAM_CAPTURE_UNMATCHED = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_UNMATCHED;
    enum CUDA_ERROR_STREAM_CAPTURE_UNJOINED = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_UNJOINED;
    enum CUDA_ERROR_STREAM_CAPTURE_ISOLATION = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_ISOLATION;
    enum CUDA_ERROR_STREAM_CAPTURE_IMPLICIT = cudaError_enum.CUDA_ERROR_STREAM_CAPTURE_IMPLICIT;
    enum CUDA_ERROR_CAPTURED_EVENT = cudaError_enum.CUDA_ERROR_CAPTURED_EVENT;
    enum CUDA_ERROR_UNKNOWN = cudaError_enum.CUDA_ERROR_UNKNOWN;
    alias CUresult = cudaError_enum;
    enum CUstreamCaptureStatus_enum
    {
        CU_STREAM_CAPTURE_STATUS_NONE = 0,
        CU_STREAM_CAPTURE_STATUS_ACTIVE = 1,
        CU_STREAM_CAPTURE_STATUS_INVALIDATED = 2,
    }
    enum CU_STREAM_CAPTURE_STATUS_NONE = CUstreamCaptureStatus_enum.CU_STREAM_CAPTURE_STATUS_NONE;
    enum CU_STREAM_CAPTURE_STATUS_ACTIVE = CUstreamCaptureStatus_enum.CU_STREAM_CAPTURE_STATUS_ACTIVE;
    enum CU_STREAM_CAPTURE_STATUS_INVALIDATED = CUstreamCaptureStatus_enum.CU_STREAM_CAPTURE_STATUS_INVALIDATED;
    alias CUstreamCaptureStatus = CUstreamCaptureStatus_enum;
    enum CUgraphNodeType_enum
    {
        CU_GRAPH_NODE_TYPE_KERNEL = 0,
        CU_GRAPH_NODE_TYPE_MEMCPY = 1,
        CU_GRAPH_NODE_TYPE_MEMSET = 2,
        CU_GRAPH_NODE_TYPE_HOST = 3,
        CU_GRAPH_NODE_TYPE_GRAPH = 4,
        CU_GRAPH_NODE_TYPE_EMPTY = 5,
        CU_GRAPH_NODE_TYPE_COUNT = 6,
    }
    enum CU_GRAPH_NODE_TYPE_KERNEL = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_KERNEL;
    enum CU_GRAPH_NODE_TYPE_MEMCPY = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_MEMCPY;
    enum CU_GRAPH_NODE_TYPE_MEMSET = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_MEMSET;
    enum CU_GRAPH_NODE_TYPE_HOST = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_HOST;
    enum CU_GRAPH_NODE_TYPE_GRAPH = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_GRAPH;
    enum CU_GRAPH_NODE_TYPE_EMPTY = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_EMPTY;
    enum CU_GRAPH_NODE_TYPE_COUNT = CUgraphNodeType_enum.CU_GRAPH_NODE_TYPE_COUNT;
    alias CUgraphNodeType = CUgraphNodeType_enum;
    struct CUDA_HOST_NODE_PARAMS_st
    {
        void function(void*) fn;
        void* userData;
    }
    alias CUDA_HOST_NODE_PARAMS = CUDA_HOST_NODE_PARAMS_st;
    struct CUDA_MEMSET_NODE_PARAMS_st
    {
        ulong dst;
        c_ulong pitch;
        uint value;
        uint elementSize;
        c_ulong width;
        c_ulong height;
    }
    alias CUDA_MEMSET_NODE_PARAMS = CUDA_MEMSET_NODE_PARAMS_st;
    struct CUDA_KERNEL_NODE_PARAMS_st
    {
        CUfunc_st* func;
        uint gridDimX;
        uint gridDimY;
        uint gridDimZ;
        uint blockDimX;
        uint blockDimY;
        uint blockDimZ;
        uint sharedMemBytes;
        void** kernelParams;
        void** extra;
    }
    alias CUDA_KERNEL_NODE_PARAMS = CUDA_KERNEL_NODE_PARAMS_st;
    alias CUhostFn = void function(void*);
    enum CUresourcetype_enum
    {
        CU_RESOURCE_TYPE_ARRAY = 0,
        CU_RESOURCE_TYPE_MIPMAPPED_ARRAY = 1,
        CU_RESOURCE_TYPE_LINEAR = 2,
        CU_RESOURCE_TYPE_PITCH2D = 3,
    }
    enum CU_RESOURCE_TYPE_ARRAY = CUresourcetype_enum.CU_RESOURCE_TYPE_ARRAY;
    enum CU_RESOURCE_TYPE_MIPMAPPED_ARRAY = CUresourcetype_enum.CU_RESOURCE_TYPE_MIPMAPPED_ARRAY;
    enum CU_RESOURCE_TYPE_LINEAR = CUresourcetype_enum.CU_RESOURCE_TYPE_LINEAR;
    enum CU_RESOURCE_TYPE_PITCH2D = CUresourcetype_enum.CU_RESOURCE_TYPE_PITCH2D;
    alias CUresourcetype = CUresourcetype_enum;
    enum CUlimit_enum
    {
        CU_LIMIT_STACK_SIZE = 0,
        CU_LIMIT_PRINTF_FIFO_SIZE = 1,
        CU_LIMIT_MALLOC_HEAP_SIZE = 2,
        CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH = 3,
        CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT = 4,
        CU_LIMIT_MAX_L2_FETCH_GRANULARITY = 5,
        CU_LIMIT_MAX = 6,
    }
    enum CU_LIMIT_STACK_SIZE = CUlimit_enum.CU_LIMIT_STACK_SIZE;
    enum CU_LIMIT_PRINTF_FIFO_SIZE = CUlimit_enum.CU_LIMIT_PRINTF_FIFO_SIZE;
    enum CU_LIMIT_MALLOC_HEAP_SIZE = CUlimit_enum.CU_LIMIT_MALLOC_HEAP_SIZE;
    enum CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH = CUlimit_enum.CU_LIMIT_DEV_RUNTIME_SYNC_DEPTH;
    enum CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT = CUlimit_enum.CU_LIMIT_DEV_RUNTIME_PENDING_LAUNCH_COUNT;
    enum CU_LIMIT_MAX_L2_FETCH_GRANULARITY = CUlimit_enum.CU_LIMIT_MAX_L2_FETCH_GRANULARITY;
    enum CU_LIMIT_MAX = CUlimit_enum.CU_LIMIT_MAX;
    alias CUlimit = CUlimit_enum;
    enum CUarray_cubemap_face_enum
    {
        CU_CUBEMAP_FACE_POSITIVE_X = 0,
        CU_CUBEMAP_FACE_NEGATIVE_X = 1,
        CU_CUBEMAP_FACE_POSITIVE_Y = 2,
        CU_CUBEMAP_FACE_NEGATIVE_Y = 3,
        CU_CUBEMAP_FACE_POSITIVE_Z = 4,
        CU_CUBEMAP_FACE_NEGATIVE_Z = 5,
    }
    enum CU_CUBEMAP_FACE_POSITIVE_X = CUarray_cubemap_face_enum.CU_CUBEMAP_FACE_POSITIVE_X;
    enum CU_CUBEMAP_FACE_NEGATIVE_X = CUarray_cubemap_face_enum.CU_CUBEMAP_FACE_NEGATIVE_X;
    enum CU_CUBEMAP_FACE_POSITIVE_Y = CUarray_cubemap_face_enum.CU_CUBEMAP_FACE_POSITIVE_Y;
    enum CU_CUBEMAP_FACE_NEGATIVE_Y = CUarray_cubemap_face_enum.CU_CUBEMAP_FACE_NEGATIVE_Y;
    enum CU_CUBEMAP_FACE_POSITIVE_Z = CUarray_cubemap_face_enum.CU_CUBEMAP_FACE_POSITIVE_Z;
    enum CU_CUBEMAP_FACE_NEGATIVE_Z = CUarray_cubemap_face_enum.CU_CUBEMAP_FACE_NEGATIVE_Z;
    alias CUarray_cubemap_face = CUarray_cubemap_face_enum;
    alias sigset_t = __sigset_t;
    enum CUgraphicsMapResourceFlags_enum
    {
        CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE = 0,
        CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY = 1,
        CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD = 2,
    }
    enum CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE = CUgraphicsMapResourceFlags_enum.CU_GRAPHICS_MAP_RESOURCE_FLAGS_NONE;
    enum CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY = CUgraphicsMapResourceFlags_enum.CU_GRAPHICS_MAP_RESOURCE_FLAGS_READ_ONLY;
    enum CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD = CUgraphicsMapResourceFlags_enum.CU_GRAPHICS_MAP_RESOURCE_FLAGS_WRITE_DISCARD;
    alias CUgraphicsMapResourceFlags = CUgraphicsMapResourceFlags_enum;
    enum CUgraphicsRegisterFlags_enum
    {
        CU_GRAPHICS_REGISTER_FLAGS_NONE = 0,
        CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY = 1,
        CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD = 2,
        CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST = 4,
        CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER = 8,
    }
    enum CU_GRAPHICS_REGISTER_FLAGS_NONE = CUgraphicsRegisterFlags_enum.CU_GRAPHICS_REGISTER_FLAGS_NONE;
    enum CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY = CUgraphicsRegisterFlags_enum.CU_GRAPHICS_REGISTER_FLAGS_READ_ONLY;
    enum CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD = CUgraphicsRegisterFlags_enum.CU_GRAPHICS_REGISTER_FLAGS_WRITE_DISCARD;
    enum CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST = CUgraphicsRegisterFlags_enum.CU_GRAPHICS_REGISTER_FLAGS_SURFACE_LDST;
    enum CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER = CUgraphicsRegisterFlags_enum.CU_GRAPHICS_REGISTER_FLAGS_TEXTURE_GATHER;
    alias suseconds_t = c_long;
    alias CUgraphicsRegisterFlags = CUgraphicsRegisterFlags_enum;
    alias __fd_mask = c_long;
    struct CUlinkState_st;
    alias CUlinkState = CUlinkState_st*;
    struct fd_set
    {
        c_long[16] __fds_bits;
    }
    enum CUjitInputType_enum
    {
        CU_JIT_INPUT_CUBIN = 0,
        CU_JIT_INPUT_PTX = 1,
        CU_JIT_INPUT_FATBINARY = 2,
        CU_JIT_INPUT_OBJECT = 3,
        CU_JIT_INPUT_LIBRARY = 4,
        CU_JIT_NUM_INPUT_TYPES = 5,
    }
    enum CU_JIT_INPUT_CUBIN = CUjitInputType_enum.CU_JIT_INPUT_CUBIN;
    enum CU_JIT_INPUT_PTX = CUjitInputType_enum.CU_JIT_INPUT_PTX;
    enum CU_JIT_INPUT_FATBINARY = CUjitInputType_enum.CU_JIT_INPUT_FATBINARY;
    enum CU_JIT_INPUT_OBJECT = CUjitInputType_enum.CU_JIT_INPUT_OBJECT;
    enum CU_JIT_INPUT_LIBRARY = CUjitInputType_enum.CU_JIT_INPUT_LIBRARY;
    enum CU_JIT_NUM_INPUT_TYPES = CUjitInputType_enum.CU_JIT_NUM_INPUT_TYPES;
    alias CUjitInputType = CUjitInputType_enum;
    alias fd_mask = c_long;
    enum CUjit_cacheMode_enum
    {
        CU_JIT_CACHE_OPTION_NONE = 0,
        CU_JIT_CACHE_OPTION_CG = 1,
        CU_JIT_CACHE_OPTION_CA = 2,
    }
    enum CU_JIT_CACHE_OPTION_NONE = CUjit_cacheMode_enum.CU_JIT_CACHE_OPTION_NONE;
    enum CU_JIT_CACHE_OPTION_CG = CUjit_cacheMode_enum.CU_JIT_CACHE_OPTION_CG;
    enum CU_JIT_CACHE_OPTION_CA = CUjit_cacheMode_enum.CU_JIT_CACHE_OPTION_CA;
    alias CUjit_cacheMode = CUjit_cacheMode_enum;
    enum CUjit_fallback_enum
    {
        CU_PREFER_PTX = 0,
        CU_PREFER_BINARY = 1,
    }
    enum CU_PREFER_PTX = CUjit_fallback_enum.CU_PREFER_PTX;
    enum CU_PREFER_BINARY = CUjit_fallback_enum.CU_PREFER_BINARY;
    alias CUjit_fallback = CUjit_fallback_enum;
    enum CUjit_target_enum
    {
        CU_TARGET_COMPUTE_20 = 20,
        CU_TARGET_COMPUTE_21 = 21,
        CU_TARGET_COMPUTE_30 = 30,
        CU_TARGET_COMPUTE_32 = 32,
        CU_TARGET_COMPUTE_35 = 35,
        CU_TARGET_COMPUTE_37 = 37,
        CU_TARGET_COMPUTE_50 = 50,
        CU_TARGET_COMPUTE_52 = 52,
        CU_TARGET_COMPUTE_53 = 53,
        CU_TARGET_COMPUTE_60 = 60,
        CU_TARGET_COMPUTE_61 = 61,
        CU_TARGET_COMPUTE_62 = 62,
        CU_TARGET_COMPUTE_70 = 70,
        CU_TARGET_COMPUTE_75 = 75,
    }
    enum CU_TARGET_COMPUTE_20 = CUjit_target_enum.CU_TARGET_COMPUTE_20;
    enum CU_TARGET_COMPUTE_21 = CUjit_target_enum.CU_TARGET_COMPUTE_21;
    enum CU_TARGET_COMPUTE_30 = CUjit_target_enum.CU_TARGET_COMPUTE_30;
    enum CU_TARGET_COMPUTE_32 = CUjit_target_enum.CU_TARGET_COMPUTE_32;
    enum CU_TARGET_COMPUTE_35 = CUjit_target_enum.CU_TARGET_COMPUTE_35;
    enum CU_TARGET_COMPUTE_37 = CUjit_target_enum.CU_TARGET_COMPUTE_37;
    enum CU_TARGET_COMPUTE_50 = CUjit_target_enum.CU_TARGET_COMPUTE_50;
    enum CU_TARGET_COMPUTE_52 = CUjit_target_enum.CU_TARGET_COMPUTE_52;
    enum CU_TARGET_COMPUTE_53 = CUjit_target_enum.CU_TARGET_COMPUTE_53;
    enum CU_TARGET_COMPUTE_60 = CUjit_target_enum.CU_TARGET_COMPUTE_60;
    enum CU_TARGET_COMPUTE_61 = CUjit_target_enum.CU_TARGET_COMPUTE_61;
    enum CU_TARGET_COMPUTE_62 = CUjit_target_enum.CU_TARGET_COMPUTE_62;
    enum CU_TARGET_COMPUTE_70 = CUjit_target_enum.CU_TARGET_COMPUTE_70;
    enum CU_TARGET_COMPUTE_75 = CUjit_target_enum.CU_TARGET_COMPUTE_75;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    alias CUjit_target = CUjit_target_enum;
    uint gnu_dev_major(ulong) @nogc nothrow;
    uint gnu_dev_minor(ulong) @nogc nothrow;
    ulong gnu_dev_makedev(uint, uint) @nogc nothrow;
    enum CUjit_option_enum
    {
        CU_JIT_MAX_REGISTERS = 0,
        CU_JIT_THREADS_PER_BLOCK = 1,
        CU_JIT_WALL_TIME = 2,
        CU_JIT_INFO_LOG_BUFFER = 3,
        CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES = 4,
        CU_JIT_ERROR_LOG_BUFFER = 5,
        CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES = 6,
        CU_JIT_OPTIMIZATION_LEVEL = 7,
        CU_JIT_TARGET_FROM_CUCONTEXT = 8,
        CU_JIT_TARGET = 9,
        CU_JIT_FALLBACK_STRATEGY = 10,
        CU_JIT_GENERATE_DEBUG_INFO = 11,
        CU_JIT_LOG_VERBOSE = 12,
        CU_JIT_GENERATE_LINE_INFO = 13,
        CU_JIT_CACHE_MODE = 14,
        CU_JIT_NEW_SM3X_OPT = 15,
        CU_JIT_FAST_COMPILE = 16,
        CU_JIT_GLOBAL_SYMBOL_NAMES = 17,
        CU_JIT_GLOBAL_SYMBOL_ADDRESSES = 18,
        CU_JIT_GLOBAL_SYMBOL_COUNT = 19,
        CU_JIT_NUM_OPTIONS = 20,
    }
    enum CU_JIT_MAX_REGISTERS = CUjit_option_enum.CU_JIT_MAX_REGISTERS;
    enum CU_JIT_THREADS_PER_BLOCK = CUjit_option_enum.CU_JIT_THREADS_PER_BLOCK;
    enum CU_JIT_WALL_TIME = CUjit_option_enum.CU_JIT_WALL_TIME;
    enum CU_JIT_INFO_LOG_BUFFER = CUjit_option_enum.CU_JIT_INFO_LOG_BUFFER;
    enum CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES = CUjit_option_enum.CU_JIT_INFO_LOG_BUFFER_SIZE_BYTES;
    enum CU_JIT_ERROR_LOG_BUFFER = CUjit_option_enum.CU_JIT_ERROR_LOG_BUFFER;
    enum CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES = CUjit_option_enum.CU_JIT_ERROR_LOG_BUFFER_SIZE_BYTES;
    enum CU_JIT_OPTIMIZATION_LEVEL = CUjit_option_enum.CU_JIT_OPTIMIZATION_LEVEL;
    enum CU_JIT_TARGET_FROM_CUCONTEXT = CUjit_option_enum.CU_JIT_TARGET_FROM_CUCONTEXT;
    enum CU_JIT_TARGET = CUjit_option_enum.CU_JIT_TARGET;
    enum CU_JIT_FALLBACK_STRATEGY = CUjit_option_enum.CU_JIT_FALLBACK_STRATEGY;
    enum CU_JIT_GENERATE_DEBUG_INFO = CUjit_option_enum.CU_JIT_GENERATE_DEBUG_INFO;
    enum CU_JIT_LOG_VERBOSE = CUjit_option_enum.CU_JIT_LOG_VERBOSE;
    enum CU_JIT_GENERATE_LINE_INFO = CUjit_option_enum.CU_JIT_GENERATE_LINE_INFO;
    enum CU_JIT_CACHE_MODE = CUjit_option_enum.CU_JIT_CACHE_MODE;
    enum CU_JIT_NEW_SM3X_OPT = CUjit_option_enum.CU_JIT_NEW_SM3X_OPT;
    enum CU_JIT_FAST_COMPILE = CUjit_option_enum.CU_JIT_FAST_COMPILE;
    enum CU_JIT_GLOBAL_SYMBOL_NAMES = CUjit_option_enum.CU_JIT_GLOBAL_SYMBOL_NAMES;
    enum CU_JIT_GLOBAL_SYMBOL_ADDRESSES = CUjit_option_enum.CU_JIT_GLOBAL_SYMBOL_ADDRESSES;
    enum CU_JIT_GLOBAL_SYMBOL_COUNT = CUjit_option_enum.CU_JIT_GLOBAL_SYMBOL_COUNT;
    enum CU_JIT_NUM_OPTIONS = CUjit_option_enum.CU_JIT_NUM_OPTIONS;
    alias CUjit_option = CUjit_option_enum;
    enum CUmem_range_attribute_enum
    {
        CU_MEM_RANGE_ATTRIBUTE_READ_MOSTLY = 1,
        CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION = 2,
        CU_MEM_RANGE_ATTRIBUTE_ACCESSED_BY = 3,
        CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION = 4,
    }
    enum CU_MEM_RANGE_ATTRIBUTE_READ_MOSTLY = CUmem_range_attribute_enum.CU_MEM_RANGE_ATTRIBUTE_READ_MOSTLY;
    enum CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION = CUmem_range_attribute_enum.CU_MEM_RANGE_ATTRIBUTE_PREFERRED_LOCATION;
    enum CU_MEM_RANGE_ATTRIBUTE_ACCESSED_BY = CUmem_range_attribute_enum.CU_MEM_RANGE_ATTRIBUTE_ACCESSED_BY;
    enum CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION = CUmem_range_attribute_enum.CU_MEM_RANGE_ATTRIBUTE_LAST_PREFETCH_LOCATION;
    alias CUmem_range_attribute = CUmem_range_attribute_enum;
    alias u_char = ubyte;
    alias u_short = ushort;
    alias u_int = uint;
    alias u_long = c_ulong;
    alias quad_t = c_long;
    alias u_quad_t = c_ulong;
    alias fsid_t = __fsid_t;
    enum CUmem_advise_enum
    {
        CU_MEM_ADVISE_SET_READ_MOSTLY = 1,
        CU_MEM_ADVISE_UNSET_READ_MOSTLY = 2,
        CU_MEM_ADVISE_SET_PREFERRED_LOCATION = 3,
        CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION = 4,
        CU_MEM_ADVISE_SET_ACCESSED_BY = 5,
        CU_MEM_ADVISE_UNSET_ACCESSED_BY = 6,
    }
    enum CU_MEM_ADVISE_SET_READ_MOSTLY = CUmem_advise_enum.CU_MEM_ADVISE_SET_READ_MOSTLY;
    enum CU_MEM_ADVISE_UNSET_READ_MOSTLY = CUmem_advise_enum.CU_MEM_ADVISE_UNSET_READ_MOSTLY;
    enum CU_MEM_ADVISE_SET_PREFERRED_LOCATION = CUmem_advise_enum.CU_MEM_ADVISE_SET_PREFERRED_LOCATION;
    enum CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION = CUmem_advise_enum.CU_MEM_ADVISE_UNSET_PREFERRED_LOCATION;
    enum CU_MEM_ADVISE_SET_ACCESSED_BY = CUmem_advise_enum.CU_MEM_ADVISE_SET_ACCESSED_BY;
    enum CU_MEM_ADVISE_UNSET_ACCESSED_BY = CUmem_advise_enum.CU_MEM_ADVISE_UNSET_ACCESSED_BY;
    alias loff_t = c_long;
    alias ino_t = c_ulong;
    alias CUmem_advise = CUmem_advise_enum;
    alias dev_t = c_ulong;
    enum CUcomputemode_enum
    {
        CU_COMPUTEMODE_DEFAULT = 0,
        CU_COMPUTEMODE_PROHIBITED = 2,
        CU_COMPUTEMODE_EXCLUSIVE_PROCESS = 3,
    }
    enum CU_COMPUTEMODE_DEFAULT = CUcomputemode_enum.CU_COMPUTEMODE_DEFAULT;
    enum CU_COMPUTEMODE_PROHIBITED = CUcomputemode_enum.CU_COMPUTEMODE_PROHIBITED;
    enum CU_COMPUTEMODE_EXCLUSIVE_PROCESS = CUcomputemode_enum.CU_COMPUTEMODE_EXCLUSIVE_PROCESS;
    alias gid_t = uint;
    alias CUcomputemode = CUcomputemode_enum;
    alias mode_t = uint;
    enum CUmemorytype_enum
    {
        CU_MEMORYTYPE_HOST = 1,
        CU_MEMORYTYPE_DEVICE = 2,
        CU_MEMORYTYPE_ARRAY = 3,
        CU_MEMORYTYPE_UNIFIED = 4,
    }
    enum CU_MEMORYTYPE_HOST = CUmemorytype_enum.CU_MEMORYTYPE_HOST;
    enum CU_MEMORYTYPE_DEVICE = CUmemorytype_enum.CU_MEMORYTYPE_DEVICE;
    enum CU_MEMORYTYPE_ARRAY = CUmemorytype_enum.CU_MEMORYTYPE_ARRAY;
    enum CU_MEMORYTYPE_UNIFIED = CUmemorytype_enum.CU_MEMORYTYPE_UNIFIED;
    alias nlink_t = c_ulong;
    alias CUmemorytype = CUmemorytype_enum;
    alias uid_t = uint;
    enum CUshared_carveout_enum
    {
        CU_SHAREDMEM_CARVEOUT_DEFAULT = -1,
        CU_SHAREDMEM_CARVEOUT_MAX_SHARED = 100,
        CU_SHAREDMEM_CARVEOUT_MAX_L1 = 0,
    }
    enum CU_SHAREDMEM_CARVEOUT_DEFAULT = CUshared_carveout_enum.CU_SHAREDMEM_CARVEOUT_DEFAULT;
    enum CU_SHAREDMEM_CARVEOUT_MAX_SHARED = CUshared_carveout_enum.CU_SHAREDMEM_CARVEOUT_MAX_SHARED;
    enum CU_SHAREDMEM_CARVEOUT_MAX_L1 = CUshared_carveout_enum.CU_SHAREDMEM_CARVEOUT_MAX_L1;
    alias off_t = c_long;
    alias CUshared_carveout = CUshared_carveout_enum;
    alias pid_t = int;
    enum CUsharedconfig_enum
    {
        CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE = 0,
        CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE = 1,
        CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE = 2,
    }
    enum CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE = CUsharedconfig_enum.CU_SHARED_MEM_CONFIG_DEFAULT_BANK_SIZE;
    enum CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE = CUsharedconfig_enum.CU_SHARED_MEM_CONFIG_FOUR_BYTE_BANK_SIZE;
    enum CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE = CUsharedconfig_enum.CU_SHARED_MEM_CONFIG_EIGHT_BYTE_BANK_SIZE;
    alias id_t = uint;
    alias CUsharedconfig = CUsharedconfig_enum;
    alias ssize_t = c_long;
    enum CUfunc_cache_enum
    {
        CU_FUNC_CACHE_PREFER_NONE = 0,
        CU_FUNC_CACHE_PREFER_SHARED = 1,
        CU_FUNC_CACHE_PREFER_L1 = 2,
        CU_FUNC_CACHE_PREFER_EQUAL = 3,
    }
    enum CU_FUNC_CACHE_PREFER_NONE = CUfunc_cache_enum.CU_FUNC_CACHE_PREFER_NONE;
    enum CU_FUNC_CACHE_PREFER_SHARED = CUfunc_cache_enum.CU_FUNC_CACHE_PREFER_SHARED;
    enum CU_FUNC_CACHE_PREFER_L1 = CUfunc_cache_enum.CU_FUNC_CACHE_PREFER_L1;
    enum CU_FUNC_CACHE_PREFER_EQUAL = CUfunc_cache_enum.CU_FUNC_CACHE_PREFER_EQUAL;
    alias daddr_t = int;
    alias caddr_t = char*;
    alias CUfunc_cache = CUfunc_cache_enum;
    alias key_t = int;
    enum CUfunction_attribute_enum
    {
        CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 0,
        CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES = 1,
        CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES = 2,
        CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES = 3,
        CU_FUNC_ATTRIBUTE_NUM_REGS = 4,
        CU_FUNC_ATTRIBUTE_PTX_VERSION = 5,
        CU_FUNC_ATTRIBUTE_BINARY_VERSION = 6,
        CU_FUNC_ATTRIBUTE_CACHE_MODE_CA = 7,
        CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES = 8,
        CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT = 9,
        CU_FUNC_ATTRIBUTE_MAX = 10,
    }
    enum CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_MAX_THREADS_PER_BLOCK;
    enum CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_SHARED_SIZE_BYTES;
    enum CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_CONST_SIZE_BYTES;
    enum CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES;
    enum CU_FUNC_ATTRIBUTE_NUM_REGS = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_NUM_REGS;
    enum CU_FUNC_ATTRIBUTE_PTX_VERSION = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_PTX_VERSION;
    enum CU_FUNC_ATTRIBUTE_BINARY_VERSION = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_BINARY_VERSION;
    enum CU_FUNC_ATTRIBUTE_CACHE_MODE_CA = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_CACHE_MODE_CA;
    enum CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_MAX_DYNAMIC_SHARED_SIZE_BYTES;
    enum CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_PREFERRED_SHARED_MEMORY_CARVEOUT;
    enum CU_FUNC_ATTRIBUTE_MAX = CUfunction_attribute_enum.CU_FUNC_ATTRIBUTE_MAX;
    alias CUfunction_attribute = CUfunction_attribute_enum;
    enum CUpointer_attribute_enum
    {
        CU_POINTER_ATTRIBUTE_CONTEXT = 1,
        CU_POINTER_ATTRIBUTE_MEMORY_TYPE = 2,
        CU_POINTER_ATTRIBUTE_DEVICE_POINTER = 3,
        CU_POINTER_ATTRIBUTE_HOST_POINTER = 4,
        CU_POINTER_ATTRIBUTE_P2P_TOKENS = 5,
        CU_POINTER_ATTRIBUTE_SYNC_MEMOPS = 6,
        CU_POINTER_ATTRIBUTE_BUFFER_ID = 7,
        CU_POINTER_ATTRIBUTE_IS_MANAGED = 8,
        CU_POINTER_ATTRIBUTE_DEVICE_ORDINAL = 9,
    }
    enum CU_POINTER_ATTRIBUTE_CONTEXT = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_CONTEXT;
    enum CU_POINTER_ATTRIBUTE_MEMORY_TYPE = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_MEMORY_TYPE;
    enum CU_POINTER_ATTRIBUTE_DEVICE_POINTER = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_DEVICE_POINTER;
    enum CU_POINTER_ATTRIBUTE_HOST_POINTER = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_HOST_POINTER;
    enum CU_POINTER_ATTRIBUTE_P2P_TOKENS = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_P2P_TOKENS;
    enum CU_POINTER_ATTRIBUTE_SYNC_MEMOPS = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_SYNC_MEMOPS;
    enum CU_POINTER_ATTRIBUTE_BUFFER_ID = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_BUFFER_ID;
    enum CU_POINTER_ATTRIBUTE_IS_MANAGED = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_IS_MANAGED;
    enum CU_POINTER_ATTRIBUTE_DEVICE_ORDINAL = CUpointer_attribute_enum.CU_POINTER_ATTRIBUTE_DEVICE_ORDINAL;
    alias CUpointer_attribute = CUpointer_attribute_enum;
    struct CUdevprop_st
    {
        int maxThreadsPerBlock;
        int[3] maxThreadsDim;
        int[3] maxGridSize;
        int sharedMemPerBlock;
        int totalConstantMemory;
        int SIMDWidth;
        int memPitch;
        int regsPerBlock;
        int clockRate;
        int textureAlign;
    }
    alias CUdevprop = CUdevprop_st;
    enum CUdevice_attribute_enum
    {
        CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK = 1,
        CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X = 2,
        CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y = 3,
        CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z = 4,
        CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X = 5,
        CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y = 6,
        CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z = 7,
        CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK = 8,
        CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK = 8,
        CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY = 9,
        CU_DEVICE_ATTRIBUTE_WARP_SIZE = 10,
        CU_DEVICE_ATTRIBUTE_MAX_PITCH = 11,
        CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK = 12,
        CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK = 12,
        CU_DEVICE_ATTRIBUTE_CLOCK_RATE = 13,
        CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT = 14,
        CU_DEVICE_ATTRIBUTE_GPU_OVERLAP = 15,
        CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT = 16,
        CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT = 17,
        CU_DEVICE_ATTRIBUTE_INTEGRATED = 18,
        CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY = 19,
        CU_DEVICE_ATTRIBUTE_COMPUTE_MODE = 20,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH = 21,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH = 22,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT = 23,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH = 24,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT = 25,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH = 26,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH = 27,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT = 28,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS = 29,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH = 27,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT = 28,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES = 29,
        CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT = 30,
        CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS = 31,
        CU_DEVICE_ATTRIBUTE_ECC_ENABLED = 32,
        CU_DEVICE_ATTRIBUTE_PCI_BUS_ID = 33,
        CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID = 34,
        CU_DEVICE_ATTRIBUTE_TCC_DRIVER = 35,
        CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE = 36,
        CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH = 37,
        CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE = 38,
        CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR = 39,
        CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT = 40,
        CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING = 41,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH = 42,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS = 43,
        CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER = 44,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH = 45,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT = 46,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE = 47,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE = 48,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE = 49,
        CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID = 50,
        CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT = 51,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH = 52,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH = 53,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS = 54,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH = 55,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH = 56,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT = 57,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH = 58,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT = 59,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH = 60,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH = 61,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS = 62,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH = 63,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT = 64,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS = 65,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH = 66,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH = 67,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS = 68,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH = 69,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH = 70,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT = 71,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH = 72,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH = 73,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT = 74,
        CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR = 75,
        CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR = 76,
        CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_MIPMAPPED_WIDTH = 77,
        CU_DEVICE_ATTRIBUTE_STREAM_PRIORITIES_SUPPORTED = 78,
        CU_DEVICE_ATTRIBUTE_GLOBAL_L1_CACHE_SUPPORTED = 79,
        CU_DEVICE_ATTRIBUTE_LOCAL_L1_CACHE_SUPPORTED = 80,
        CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_MULTIPROCESSOR = 81,
        CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_MULTIPROCESSOR = 82,
        CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY = 83,
        CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD = 84,
        CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD_GROUP_ID = 85,
        CU_DEVICE_ATTRIBUTE_HOST_NATIVE_ATOMIC_SUPPORTED = 86,
        CU_DEVICE_ATTRIBUTE_SINGLE_TO_DOUBLE_PRECISION_PERF_RATIO = 87,
        CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS = 88,
        CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS = 89,
        CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED = 90,
        CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM = 91,
        CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_MEM_OPS = 92,
        CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS = 93,
        CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR = 94,
        CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH = 95,
        CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH = 96,
        CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN = 97,
        CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES = 98,
        CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED = 99,
        CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES = 100,
        CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST = 101,
        CU_DEVICE_ATTRIBUTE_MAX = 102,
    }
    enum CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK;
    enum CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_X;
    enum CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Y;
    enum CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_BLOCK_DIM_Z;
    enum CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_X;
    enum CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Y;
    enum CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_GRID_DIM_Z;
    enum CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK;
    enum CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_SHARED_MEMORY_PER_BLOCK;
    enum CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_TOTAL_CONSTANT_MEMORY;
    enum CU_DEVICE_ATTRIBUTE_WARP_SIZE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_WARP_SIZE;
    enum CU_DEVICE_ATTRIBUTE_MAX_PITCH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_PITCH;
    enum CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_BLOCK;
    enum CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_REGISTERS_PER_BLOCK;
    enum CU_DEVICE_ATTRIBUTE_CLOCK_RATE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CLOCK_RATE;
    enum CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_TEXTURE_ALIGNMENT;
    enum CU_DEVICE_ATTRIBUTE_GPU_OVERLAP = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_GPU_OVERLAP;
    enum CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT;
    enum CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_KERNEL_EXEC_TIMEOUT;
    enum CU_DEVICE_ATTRIBUTE_INTEGRATED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_INTEGRATED;
    enum CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_MAP_HOST_MEMORY;
    enum CU_DEVICE_ATTRIBUTE_COMPUTE_MODE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_COMPUTE_MODE;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LAYERED_LAYERS;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_ARRAY_NUMSLICES;
    enum CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_SURFACE_ALIGNMENT;
    enum CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CONCURRENT_KERNELS;
    enum CU_DEVICE_ATTRIBUTE_ECC_ENABLED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_ECC_ENABLED;
    enum CU_DEVICE_ATTRIBUTE_PCI_BUS_ID = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_PCI_BUS_ID;
    enum CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_PCI_DEVICE_ID;
    enum CU_DEVICE_ATTRIBUTE_TCC_DRIVER = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_TCC_DRIVER;
    enum CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MEMORY_CLOCK_RATE;
    enum CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_GLOBAL_MEMORY_BUS_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_L2_CACHE_SIZE;
    enum CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_THREADS_PER_MULTIPROCESSOR;
    enum CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_ASYNC_ENGINE_COUNT;
    enum CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_UNIFIED_ADDRESSING;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LAYERED_LAYERS;
    enum CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_TEX2D_GATHER;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_GATHER_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_WIDTH_ALTERNATE;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_HEIGHT_ALTERNATE;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE3D_DEPTH_ALTERNATE;
    enum CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_PCI_DOMAIN_ID;
    enum CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_TEXTURE_PITCH_ALIGNMENT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURECUBEMAP_LAYERED_LAYERS;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE3D_DEPTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE1D_LAYERED_LAYERS;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACE2D_LAYERED_LAYERS;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_SURFACECUBEMAP_LAYERED_LAYERS;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_LINEAR_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_LINEAR_PITCH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE2D_MIPMAPPED_HEIGHT;
    enum CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MAJOR;
    enum CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_COMPUTE_CAPABILITY_MINOR;
    enum CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_MIPMAPPED_WIDTH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAXIMUM_TEXTURE1D_MIPMAPPED_WIDTH;
    enum CU_DEVICE_ATTRIBUTE_STREAM_PRIORITIES_SUPPORTED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_STREAM_PRIORITIES_SUPPORTED;
    enum CU_DEVICE_ATTRIBUTE_GLOBAL_L1_CACHE_SUPPORTED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_GLOBAL_L1_CACHE_SUPPORTED;
    enum CU_DEVICE_ATTRIBUTE_LOCAL_L1_CACHE_SUPPORTED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_LOCAL_L1_CACHE_SUPPORTED;
    enum CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_MULTIPROCESSOR = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_MULTIPROCESSOR;
    enum CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_MULTIPROCESSOR = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_REGISTERS_PER_MULTIPROCESSOR;
    enum CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MANAGED_MEMORY;
    enum CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD;
    enum CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD_GROUP_ID = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MULTI_GPU_BOARD_GROUP_ID;
    enum CU_DEVICE_ATTRIBUTE_HOST_NATIVE_ATOMIC_SUPPORTED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_HOST_NATIVE_ATOMIC_SUPPORTED;
    enum CU_DEVICE_ATTRIBUTE_SINGLE_TO_DOUBLE_PRECISION_PERF_RATIO = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_SINGLE_TO_DOUBLE_PRECISION_PERF_RATIO;
    enum CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS;
    enum CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CONCURRENT_MANAGED_ACCESS;
    enum CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_COMPUTE_PREEMPTION_SUPPORTED;
    enum CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_USE_HOST_POINTER_FOR_REGISTERED_MEM;
    enum CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_MEM_OPS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_MEM_OPS;
    enum CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_USE_64_BIT_STREAM_MEM_OPS;
    enum CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_USE_STREAM_WAIT_VALUE_NOR;
    enum CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_COOPERATIVE_LAUNCH;
    enum CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_COOPERATIVE_MULTI_DEVICE_LAUNCH;
    enum CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX_SHARED_MEMORY_PER_BLOCK_OPTIN;
    enum CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_CAN_FLUSH_REMOTE_WRITES;
    enum CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_HOST_REGISTER_SUPPORTED;
    enum CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_PAGEABLE_MEMORY_ACCESS_USES_HOST_PAGE_TABLES;
    enum CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_DIRECT_MANAGED_MEM_ACCESS_FROM_HOST;
    enum CU_DEVICE_ATTRIBUTE_MAX = CUdevice_attribute_enum.CU_DEVICE_ATTRIBUTE_MAX;
    alias CUdevice_attribute = CUdevice_attribute_enum;
    enum CUfilter_mode_enum
    {
        CU_TR_FILTER_MODE_POINT = 0,
        CU_TR_FILTER_MODE_LINEAR = 1,
    }
    enum CU_TR_FILTER_MODE_POINT = CUfilter_mode_enum.CU_TR_FILTER_MODE_POINT;
    enum CU_TR_FILTER_MODE_LINEAR = CUfilter_mode_enum.CU_TR_FILTER_MODE_LINEAR;
    alias int8_t = byte;
    alias int16_t = short;
    alias int32_t = int;
    alias int64_t = c_long;
    alias u_int8_t = ubyte;
    alias u_int16_t = ushort;
    alias u_int32_t = uint;
    alias u_int64_t = c_ulong;
    alias register_t = c_long;
    alias CUfilter_mode = CUfilter_mode_enum;
    alias blksize_t = c_long;
    enum CUaddress_mode_enum
    {
        CU_TR_ADDRESS_MODE_WRAP = 0,
        CU_TR_ADDRESS_MODE_CLAMP = 1,
        CU_TR_ADDRESS_MODE_MIRROR = 2,
        CU_TR_ADDRESS_MODE_BORDER = 3,
    }
    enum CU_TR_ADDRESS_MODE_WRAP = CUaddress_mode_enum.CU_TR_ADDRESS_MODE_WRAP;
    enum CU_TR_ADDRESS_MODE_CLAMP = CUaddress_mode_enum.CU_TR_ADDRESS_MODE_CLAMP;
    enum CU_TR_ADDRESS_MODE_MIRROR = CUaddress_mode_enum.CU_TR_ADDRESS_MODE_MIRROR;
    enum CU_TR_ADDRESS_MODE_BORDER = CUaddress_mode_enum.CU_TR_ADDRESS_MODE_BORDER;
    alias blkcnt_t = c_long;
    alias CUaddress_mode = CUaddress_mode_enum;
    alias fsblkcnt_t = c_ulong;
    enum CUarray_format_enum
    {
        CU_AD_FORMAT_UNSIGNED_INT8 = 1,
        CU_AD_FORMAT_UNSIGNED_INT16 = 2,
        CU_AD_FORMAT_UNSIGNED_INT32 = 3,
        CU_AD_FORMAT_SIGNED_INT8 = 8,
        CU_AD_FORMAT_SIGNED_INT16 = 9,
        CU_AD_FORMAT_SIGNED_INT32 = 10,
        CU_AD_FORMAT_HALF = 16,
        CU_AD_FORMAT_FLOAT = 32,
    }
    enum CU_AD_FORMAT_UNSIGNED_INT8 = CUarray_format_enum.CU_AD_FORMAT_UNSIGNED_INT8;
    enum CU_AD_FORMAT_UNSIGNED_INT16 = CUarray_format_enum.CU_AD_FORMAT_UNSIGNED_INT16;
    enum CU_AD_FORMAT_UNSIGNED_INT32 = CUarray_format_enum.CU_AD_FORMAT_UNSIGNED_INT32;
    enum CU_AD_FORMAT_SIGNED_INT8 = CUarray_format_enum.CU_AD_FORMAT_SIGNED_INT8;
    enum CU_AD_FORMAT_SIGNED_INT16 = CUarray_format_enum.CU_AD_FORMAT_SIGNED_INT16;
    enum CU_AD_FORMAT_SIGNED_INT32 = CUarray_format_enum.CU_AD_FORMAT_SIGNED_INT32;
    enum CU_AD_FORMAT_HALF = CUarray_format_enum.CU_AD_FORMAT_HALF;
    enum CU_AD_FORMAT_FLOAT = CUarray_format_enum.CU_AD_FORMAT_FLOAT;
    alias fsfilcnt_t = c_ulong;
    alias CUarray_format = CUarray_format_enum;
    enum CUoccupancy_flags_enum
    {
        CU_OCCUPANCY_DEFAULT = 0,
        CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE = 1,
    }
    enum CU_OCCUPANCY_DEFAULT = CUoccupancy_flags_enum.CU_OCCUPANCY_DEFAULT;
    enum CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE = CUoccupancy_flags_enum.CU_OCCUPANCY_DISABLE_CACHING_OVERRIDE;
    alias cuuint32_t = uint;
    alias cuuint64_t = c_ulong;
    alias CUoccupancy_flags = CUoccupancy_flags_enum;
    union CUstreamBatchMemOpParams_union
    {
        CUstreamBatchMemOpType_enum operation;
        struct CUstreamMemOpWaitValueParams_st
        {
            CUstreamBatchMemOpType_enum operation;
            ulong address;
            static union _Anonymous_21
            {
                uint value;
                c_ulong value64;
            }
            _Anonymous_21 _anonymous_22;
            auto value() @property @nogc pure nothrow { return _anonymous_22.value; }
            void value(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_22.value = val; }
            auto value64() @property @nogc pure nothrow { return _anonymous_22.value64; }
            void value64(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_22.value64 = val; }
            uint flags;
            ulong alias_;
        }
        CUstreamMemOpWaitValueParams_st waitValue;
        struct CUstreamMemOpWriteValueParams_st
        {
            CUstreamBatchMemOpType_enum operation;
            ulong address;
            static union _Anonymous_23
            {
                uint value;
                c_ulong value64;
            }
            _Anonymous_23 _anonymous_24;
            auto value() @property @nogc pure nothrow { return _anonymous_24.value; }
            void value(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_24.value = val; }
            auto value64() @property @nogc pure nothrow { return _anonymous_24.value64; }
            void value64(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_24.value64 = val; }
            uint flags;
            ulong alias_;
        }
        CUstreamMemOpWriteValueParams_st writeValue;
        struct CUstreamMemOpFlushRemoteWritesParams_st
        {
            CUstreamBatchMemOpType_enum operation;
            uint flags;
        }
        CUstreamMemOpFlushRemoteWritesParams_st flushRemoteWrites;
        c_ulong[6] pad;
    }
    alias CUstreamBatchMemOpParams = CUstreamBatchMemOpParams_union;
    enum CUstreamBatchMemOpType_enum
    {
        CU_STREAM_MEM_OP_WAIT_VALUE_32 = 1,
        CU_STREAM_MEM_OP_WRITE_VALUE_32 = 2,
        CU_STREAM_MEM_OP_WAIT_VALUE_64 = 4,
        CU_STREAM_MEM_OP_WRITE_VALUE_64 = 5,
        CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES = 3,
    }
    enum CU_STREAM_MEM_OP_WAIT_VALUE_32 = CUstreamBatchMemOpType_enum.CU_STREAM_MEM_OP_WAIT_VALUE_32;
    enum CU_STREAM_MEM_OP_WRITE_VALUE_32 = CUstreamBatchMemOpType_enum.CU_STREAM_MEM_OP_WRITE_VALUE_32;
    enum CU_STREAM_MEM_OP_WAIT_VALUE_64 = CUstreamBatchMemOpType_enum.CU_STREAM_MEM_OP_WAIT_VALUE_64;
    enum CU_STREAM_MEM_OP_WRITE_VALUE_64 = CUstreamBatchMemOpType_enum.CU_STREAM_MEM_OP_WRITE_VALUE_64;
    enum CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES = CUstreamBatchMemOpType_enum.CU_STREAM_MEM_OP_FLUSH_REMOTE_WRITES;
    alias CUstreamBatchMemOpType = CUstreamBatchMemOpType_enum;
    enum CUstreamWriteValue_flags_enum
    {
        CU_STREAM_WRITE_VALUE_DEFAULT = 0,
        CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER = 1,
    }
    enum CU_STREAM_WRITE_VALUE_DEFAULT = CUstreamWriteValue_flags_enum.CU_STREAM_WRITE_VALUE_DEFAULT;
    enum CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER = CUstreamWriteValue_flags_enum.CU_STREAM_WRITE_VALUE_NO_MEMORY_BARRIER;
    alias CUstreamWriteValue_flags = CUstreamWriteValue_flags_enum;
    enum CUstreamWaitValue_flags_enum
    {
        CU_STREAM_WAIT_VALUE_GEQ = 0,
        CU_STREAM_WAIT_VALUE_EQ = 1,
        CU_STREAM_WAIT_VALUE_AND = 2,
        CU_STREAM_WAIT_VALUE_NOR = 3,
        CU_STREAM_WAIT_VALUE_FLUSH = 1073741824,
    }
    enum CU_STREAM_WAIT_VALUE_GEQ = CUstreamWaitValue_flags_enum.CU_STREAM_WAIT_VALUE_GEQ;
    enum CU_STREAM_WAIT_VALUE_EQ = CUstreamWaitValue_flags_enum.CU_STREAM_WAIT_VALUE_EQ;
    enum CU_STREAM_WAIT_VALUE_AND = CUstreamWaitValue_flags_enum.CU_STREAM_WAIT_VALUE_AND;
    enum CU_STREAM_WAIT_VALUE_NOR = CUstreamWaitValue_flags_enum.CU_STREAM_WAIT_VALUE_NOR;
    enum CU_STREAM_WAIT_VALUE_FLUSH = CUstreamWaitValue_flags_enum.CU_STREAM_WAIT_VALUE_FLUSH;
    alias CUstreamWaitValue_flags = CUstreamWaitValue_flags_enum;
    enum CUevent_flags_enum
    {
        CU_EVENT_DEFAULT = 0,
        CU_EVENT_BLOCKING_SYNC = 1,
        CU_EVENT_DISABLE_TIMING = 2,
        CU_EVENT_INTERPROCESS = 4,
    }
    enum CU_EVENT_DEFAULT = CUevent_flags_enum.CU_EVENT_DEFAULT;
    enum CU_EVENT_BLOCKING_SYNC = CUevent_flags_enum.CU_EVENT_BLOCKING_SYNC;
    enum CU_EVENT_DISABLE_TIMING = CUevent_flags_enum.CU_EVENT_DISABLE_TIMING;
    enum CU_EVENT_INTERPROCESS = CUevent_flags_enum.CU_EVENT_INTERPROCESS;
    alias CUevent_flags = CUevent_flags_enum;
    enum CUstream_flags_enum
    {
        CU_STREAM_DEFAULT = 0,
        CU_STREAM_NON_BLOCKING = 1,
    }
    enum CU_STREAM_DEFAULT = CUstream_flags_enum.CU_STREAM_DEFAULT;
    enum CU_STREAM_NON_BLOCKING = CUstream_flags_enum.CU_STREAM_NON_BLOCKING;
    alias CUstream_flags = CUstream_flags_enum;
    enum CUctx_flags_enum
    {
        CU_CTX_SCHED_AUTO = 0,
        CU_CTX_SCHED_SPIN = 1,
        CU_CTX_SCHED_YIELD = 2,
        CU_CTX_SCHED_BLOCKING_SYNC = 4,
        CU_CTX_BLOCKING_SYNC = 4,
        CU_CTX_SCHED_MASK = 7,
        CU_CTX_MAP_HOST = 8,
        CU_CTX_LMEM_RESIZE_TO_MAX = 16,
        CU_CTX_FLAGS_MASK = 31,
    }
    enum CU_CTX_SCHED_AUTO = CUctx_flags_enum.CU_CTX_SCHED_AUTO;
    enum CU_CTX_SCHED_SPIN = CUctx_flags_enum.CU_CTX_SCHED_SPIN;
    enum CU_CTX_SCHED_YIELD = CUctx_flags_enum.CU_CTX_SCHED_YIELD;
    enum CU_CTX_SCHED_BLOCKING_SYNC = CUctx_flags_enum.CU_CTX_SCHED_BLOCKING_SYNC;
    enum CU_CTX_BLOCKING_SYNC = CUctx_flags_enum.CU_CTX_BLOCKING_SYNC;
    enum CU_CTX_SCHED_MASK = CUctx_flags_enum.CU_CTX_SCHED_MASK;
    enum CU_CTX_MAP_HOST = CUctx_flags_enum.CU_CTX_MAP_HOST;
    enum CU_CTX_LMEM_RESIZE_TO_MAX = CUctx_flags_enum.CU_CTX_LMEM_RESIZE_TO_MAX;
    enum CU_CTX_FLAGS_MASK = CUctx_flags_enum.CU_CTX_FLAGS_MASK;
    alias CUctx_flags = CUctx_flags_enum;
    enum CUmemAttach_flags_enum
    {
        CU_MEM_ATTACH_GLOBAL = 1,
        CU_MEM_ATTACH_HOST = 2,
        CU_MEM_ATTACH_SINGLE = 4,
    }
    enum CU_MEM_ATTACH_GLOBAL = CUmemAttach_flags_enum.CU_MEM_ATTACH_GLOBAL;
    enum CU_MEM_ATTACH_HOST = CUmemAttach_flags_enum.CU_MEM_ATTACH_HOST;
    enum CU_MEM_ATTACH_SINGLE = CUmemAttach_flags_enum.CU_MEM_ATTACH_SINGLE;
    alias CUmemAttach_flags = CUmemAttach_flags_enum;
    enum CUipcMem_flags_enum
    {
        CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS = 1,
    }
    enum CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS = CUipcMem_flags_enum.CU_IPC_MEM_LAZY_ENABLE_PEER_ACCESS;
    alias CUipcMem_flags = CUipcMem_flags_enum;
    struct CUipcMemHandle_st
    {
        char[64] reserved;
    }
    alias CUipcMemHandle = CUipcMemHandle_st;
    struct CUipcEventHandle_st
    {
        char[64] reserved;
    }
    alias CUipcEventHandle = CUipcEventHandle_st;
    struct CUuuid_st
    {
        char[16] bytes;
    }
    alias CUuuid = CUuuid_st;
    struct CUgraphExec_st;
    alias CUgraphExec = CUgraphExec_st*;
    struct CUgraphNode_st;
    alias CUgraphNode = CUgraphNode_st*;
    struct CUgraph_st;
    alias CUgraph = CUgraph_st*;
    struct CUextSemaphore_st;
    alias CUexternalSemaphore = CUextSemaphore_st*;
    struct CUextMemory_st;
    alias CUexternalMemory = CUextMemory_st*;
    alias CUsurfObject = ulong;
    alias CUtexObject = ulong;
    struct CUgraphicsResource_st;
    alias CUgraphicsResource = CUgraphicsResource_st*;
    struct CUstream_st;
    alias CUstream = CUstream_st*;
    struct CUevent_st;
    alias CUevent = CUevent_st*;
    struct CUsurfref_st;
    alias CUsurfref = CUsurfref_st*;
    struct CUtexref_st;
    alias CUtexref = CUtexref_st*;
    struct CUmipmappedArray_st;
    alias CUmipmappedArray = CUmipmappedArray_st*;
    struct CUarray_st;
    alias CUarray = CUarray_st*;
    struct CUfunc_st;
    alias CUfunction = CUfunc_st*;
    alias CUdeviceptr = ulong;
    alias CUdevice = int;
    alias CUcontext = CUctx_st*;
    struct CUctx_st;
    alias CUmodule = CUmod_st*;
    struct CUmod_st;




    static if(!is(typeof(CUDA_VERSION))) {
        enum CUDA_VERSION = 10000;
    }
    static if(!is(typeof(CU_IPC_HANDLE_SIZE))) {
        enum CU_IPC_HANDLE_SIZE = 64;
    }
    static if(!is(typeof(__CUDA_API_VERSION))) {
        enum __CUDA_API_VERSION = 10000;
    }
    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        enum __BIT_TYPES_DEFINED__ = 1;
    }
    static if(!is(typeof(_SYS_TYPES_H))) {
        enum _SYS_TYPES_H = 1;
    }
    static if(!is(typeof(_SYS_SYSMACROS_H))) {
        enum _SYS_SYSMACROS_H = 1;
    }
    static if(!is(typeof(_SYS_SELECT_H))) {
        enum _SYS_SELECT_H = 1;
    }
    static if(!is(typeof(CU_MEMHOSTALLOC_PORTABLE))) {
        enum CU_MEMHOSTALLOC_PORTABLE = 0x01;
    }




    static if(!is(typeof(CU_MEMHOSTALLOC_DEVICEMAP))) {
        enum CU_MEMHOSTALLOC_DEVICEMAP = 0x02;
    }




    static if(!is(typeof(CU_MEMHOSTALLOC_WRITECOMBINED))) {
        enum CU_MEMHOSTALLOC_WRITECOMBINED = 0x04;
    }




    static if(!is(typeof(CU_MEMHOSTREGISTER_PORTABLE))) {
        enum CU_MEMHOSTREGISTER_PORTABLE = 0x01;
    }




    static if(!is(typeof(CU_MEMHOSTREGISTER_DEVICEMAP))) {
        enum CU_MEMHOSTREGISTER_DEVICEMAP = 0x02;
    }




    static if(!is(typeof(CU_MEMHOSTREGISTER_IOMEMORY))) {
        enum CU_MEMHOSTREGISTER_IOMEMORY = 0x04;
    }
    static if(!is(typeof(CUDA_EXTERNAL_MEMORY_DEDICATED))) {
        enum CUDA_EXTERNAL_MEMORY_DEDICATED = 0x1;
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        enum _SYS_CDEFS_H = 1;
    }
    static if(!is(typeof(CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_PRE_LAUNCH_SYNC))) {
        enum CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_PRE_LAUNCH_SYNC = 0x01;
    }




    static if(!is(typeof(CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_POST_LAUNCH_SYNC))) {
        enum CUDA_COOPERATIVE_LAUNCH_MULTI_DEVICE_NO_POST_LAUNCH_SYNC = 0x02;
    }




    static if(!is(typeof(CUDA_ARRAY3D_LAYERED))) {
        enum CUDA_ARRAY3D_LAYERED = 0x01;
    }




    static if(!is(typeof(CUDA_ARRAY3D_2DARRAY))) {
        enum CUDA_ARRAY3D_2DARRAY = 0x01;
    }




    static if(!is(typeof(CUDA_ARRAY3D_SURFACE_LDST))) {
        enum CUDA_ARRAY3D_SURFACE_LDST = 0x02;
    }




    static if(!is(typeof(CUDA_ARRAY3D_CUBEMAP))) {
        enum CUDA_ARRAY3D_CUBEMAP = 0x04;
    }




    static if(!is(typeof(CUDA_ARRAY3D_TEXTURE_GATHER))) {
        enum CUDA_ARRAY3D_TEXTURE_GATHER = 0x08;
    }




    static if(!is(typeof(CUDA_ARRAY3D_DEPTH_TEXTURE))) {
        enum CUDA_ARRAY3D_DEPTH_TEXTURE = 0x10;
    }




    static if(!is(typeof(CUDA_ARRAY3D_COLOR_ATTACHMENT))) {
        enum CUDA_ARRAY3D_COLOR_ATTACHMENT = 0x20;
    }




    static if(!is(typeof(CU_TRSA_OVERRIDE_FORMAT))) {
        enum CU_TRSA_OVERRIDE_FORMAT = 0x01;
    }




    static if(!is(typeof(CU_TRSF_READ_AS_INTEGER))) {
        enum CU_TRSF_READ_AS_INTEGER = 0x01;
    }




    static if(!is(typeof(CU_TRSF_NORMALIZED_COORDINATES))) {
        enum CU_TRSF_NORMALIZED_COORDINATES = 0x02;
    }




    static if(!is(typeof(CU_TRSF_SRGB))) {
        enum CU_TRSF_SRGB = 0x10;
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
    static if(!is(typeof(_BITS_WCHAR_H))) {
        enum _BITS_WCHAR_H = 1;
    }
    static if(!is(typeof(__WCOREFLAG))) {
        enum __WCOREFLAG = 0x80;
    }




    static if(!is(typeof(__W_CONTINUED))) {
        enum __W_CONTINUED = 0xffff;
    }
    static if(!is(typeof(__ENUM_IDTYPE_T))) {
        enum __ENUM_IDTYPE_T = 1;
    }




    static if(!is(typeof(__WCLONE))) {
        enum __WCLONE = 0x80000000;
    }




    static if(!is(typeof(__WALL))) {
        enum __WALL = 0x40000000;
    }




    static if(!is(typeof(__WNOTHREAD))) {
        enum __WNOTHREAD = 0x20000000;
    }




    static if(!is(typeof(WNOWAIT))) {
        enum WNOWAIT = 0x01000000;
    }




    static if(!is(typeof(WCONTINUED))) {
        enum WCONTINUED = 8;
    }




    static if(!is(typeof(WEXITED))) {
        enum WEXITED = 4;
    }




    static if(!is(typeof(WSTOPPED))) {
        enum WSTOPPED = 2;
    }




    static if(!is(typeof(WUNTRACED))) {
        enum WUNTRACED = 2;
    }




    static if(!is(typeof(WNOHANG))) {
        enum WNOHANG = 1;
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        enum __FD_SETSIZE = 1024;
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        enum __INO_T_MATCHES_INO64_T = 1;
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        enum __OFF_T_MATCHES_OFF64_T = 1;
    }
    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        enum _BITS_TYPESIZES_H = 1;
    }
    static if(!is(typeof(_BITS_TYPES_H))) {
        enum _BITS_TYPES_H = 1;
    }




    static if(!is(typeof(_STRUCT_TIMEVAL))) {
        enum _STRUCT_TIMEVAL = 1;
    }






    static if(!is(typeof(_SIGSET_H_types))) {
        enum _SIGSET_H_types = 1;
    }
    static if(!is(typeof(__FD_ZERO_STOS))) {
        enum __FD_ZERO_STOS = "stosq";
    }




    static if(!is(typeof(__PTHREAD_RWLOCK_INT_FLAGS_SHARED))) {
        enum __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1;
    }
    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        enum __PTHREAD_MUTEX_HAVE_PREV = 1;
    }




    static if(!is(typeof(__have_pthread_attr_t))) {
        enum __have_pthread_attr_t = 1;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        enum __SIZEOF_PTHREAD_BARRIER_T = 32;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        enum __SIZEOF_PTHREAD_RWLOCK_T = 56;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        enum __SIZEOF_PTHREAD_CONDATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        enum __SIZEOF_PTHREAD_COND_T = 48;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        enum __SIZEOF_PTHREAD_MUTEX_T = 40;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        enum __SIZEOF_PTHREAD_ATTR_T = 56;
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_H))) {
        enum _BITS_PTHREADTYPES_H = 1;
    }
    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        enum _BITS_BYTESWAP_H = 1;
    }






    static if(!is(typeof(__timespec_defined))) {
        enum __timespec_defined = 1;
    }




    static if(!is(typeof(__timer_t_defined))) {
        enum __timer_t_defined = 1;
    }




    static if(!is(typeof(__clockid_t_defined))) {
        enum __clockid_t_defined = 1;
    }




    static if(!is(typeof(__time_t_defined))) {
        enum __time_t_defined = 1;
    }




    static if(!is(typeof(__clock_t_defined))) {
        enum __clock_t_defined = 1;
    }
    static if(!is(typeof(EXIT_SUCCESS))) {
        enum EXIT_SUCCESS = 0;
    }




    static if(!is(typeof(EXIT_FAILURE))) {
        enum EXIT_FAILURE = 1;
    }




    static if(!is(typeof(RAND_MAX))) {
        enum RAND_MAX = 2147483647;
    }




    static if(!is(typeof(__lldiv_t_defined))) {
        enum __lldiv_t_defined = 1;
    }




    static if(!is(typeof(__ldiv_t_defined))) {
        enum __ldiv_t_defined = 1;
    }
    static if(!is(typeof(_STDLIB_H))) {
        enum _STDLIB_H = 1;
    }
    static if(!is(typeof(_STDINT_H))) {
        enum _STDINT_H = 1;
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        enum _STDC_PREDEF_H = 1;
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
    static if(!is(typeof(__PDP_ENDIAN))) {
        enum __PDP_ENDIAN = 3412;
    }




    static if(!is(typeof(__BIG_ENDIAN))) {
        enum __BIG_ENDIAN = 4321;
    }




    static if(!is(typeof(__LITTLE_ENDIAN))) {
        enum __LITTLE_ENDIAN = 1234;
    }




    static if(!is(typeof(_ENDIAN_H))) {
        enum _ENDIAN_H = 1;
    }
    static if(!is(typeof(_ALLOCA_H))) {
        enum _ALLOCA_H = 1;
    }
}
