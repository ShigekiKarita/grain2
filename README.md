# grain2

Autograd and GPGPU library for dynamic neural networks in D.
This project is a successor of [grain](https://github.com/ShigekiKarita/grain).

## features

- @nogc support
- heterogeneous device (CPU/CUDA) support
- multiple CUDA device support

## requirements

- CPU backend
  - BLAS library (e.g., OpenBLAS, MKL)
- CUDA backend
  - CUDA header/library v10-
  - CUDNN header/library v7-
- OpenCL backend
  - OpenCL header/library v1.2

## roadmap

- [x] heterogeneous multi-dimentional structure (grain.tensor.Tensor)
- [x] reference count-based memory management
- [x] multiple CUDA devices support
- [ ] core autograd (forward/backward chain)
- [ ] dataset API (MNIST, PTB, etc)
- [ ] more memory manegement policy (garbage collection, memory pool)
- [ ] JIT compilation of computational graph
- [ ] OpenCL/HIP support

## trouble shooting

- Q. My local CUDA/OpenCL libraries are different from files under `grain2/dpp/build`
  - A. Install [dpp](https://github.com/atilaneves/dpp) (commit 821a5d4) and regenerate them by `$ cd dpp; make -j cuda (or opencl)`
