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
  - CUDA SDK v10-
  - CUDNN Library v7-

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
  A. Install [dpp](https://github.com/atilaneves/dpp) and regenerate them by `$ cd dpp; make -j CUDA_ROOT=... CUDNN_ROOT=...`
