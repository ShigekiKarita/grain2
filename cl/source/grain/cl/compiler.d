module grain.opencl.compiler;

import grain.cl.testing : checkCl, checkClFun;
import grain.cl.device;
import grain.dpp.cl;
import grain.dpp.cl_enum : CL_DEVICE_TYPE_DEFAULT, CL_MEM_READ_WRITE;


@nogc
unittest
{
    import core.stdc.stdio : printf;
    import core.stdc.stdlib : malloc, free;

    // init device
    auto device_id = ClDevice.get(0);
    auto context = checkClFun!clCreateContext(null, 1, &device_id, null, null);
    scope (exit) checkCl(clReleaseContext(context));
    auto command_queue = checkClFun!clCreateCommandQueue(context, device_id, 0);
    scope (exit)
    {
        checkCl(clFlush(command_queue));
        checkCl(clFinish(command_queue));
        checkCl(clReleaseCommandQueue(command_queue));
    }

    // copy memory from host to device
    float[3] ha, hb;
    ha[] = 1;
    hb[] = 10;

    auto da = checkClFun!clCreateBuffer(context, CL_MEM_READ_WRITE, float.sizeof * ha.length, null);
    scope (exit) checkCl(clReleaseMemObject(da));
    checkCl(clEnqueueWriteBuffer(command_queue, da, CL_TRUE, 0, float.sizeof * ha.length, ha.ptr, 0, null, null));
    auto db = checkClFun!clCreateBuffer(context, CL_MEM_READ_WRITE, float.sizeof * hb.length, null);
    scope (exit) checkCl(clReleaseMemObject(db));
    checkCl(clEnqueueWriteBuffer(command_queue, db, CL_TRUE, 0, float.sizeof * hb.length, hb.ptr, 0, null, null));
    auto dc = checkClFun!clCreateBuffer(context, CL_MEM_READ_WRITE, float.sizeof * hb.length, null);
    scope (exit) checkCl(clReleaseMemObject(dc));

    // compile
    auto name = "vectorAdd";
    auto source_str = q{
        __kernel void vectorAdd(__global float *a, __global float* b, __global float* c) {
            int i = get_global_id(0);
            c[i] = a[i] + b[i];
        }
    };
    const(char)* sptr = source_str.ptr;
    auto source_size = source_str.length;
    auto program = checkClFun!clCreateProgramWithSource(context, 1, &sptr, &source_size);
    scope (exit) checkCl(clReleaseProgram(program));
    checkCl(clBuildProgram(program, 1, &device_id, null, null, null));
    auto kernel = checkClFun!clCreateKernel(program, name.ptr);
    scope (exit) checkCl(clReleaseKernel(kernel));

    // launch
    auto globalWorkSize = ha.length;
    checkCl(clSetKernelArg(kernel, 0, cl_mem.sizeof, &da));
    checkCl(clSetKernelArg(kernel, 1, cl_mem.sizeof, &db));
    checkCl(clSetKernelArg(kernel, 2, cl_mem.sizeof, &dc));
    checkCl(clEnqueueNDRangeKernel(
        command_queue, kernel, 1, null, // this must be null
        &globalWorkSize, null, // auto localWorkSize
        0, null, null // no event config
    ));

    // copy memory from device to host
    float[3] hc;
    checkCl(clEnqueueReadBuffer(command_queue, dc, CL_TRUE, 0,
                                float.sizeof * hc.length, hc.ptr, 0, null, null));
    // result
    assert(hc[0] == 11);
    assert(hc[1] == 11);
    assert(hc[2] == 11);
}
