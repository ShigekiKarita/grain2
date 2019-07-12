# grain2

[![CircleCI](https://circleci.com/gh/ShigekiKarita/grain2.svg?style=svg)](https://circleci.com/gh/ShigekiKarita/grain2)
[![Build status](https://ci.appveyor.com/api/projects/status/xd6ux9097brdbs61?svg=true)](https://ci.appveyor.com/project/ShigekiKarita/grain2)
[![codecov](https://codecov.io/gh/ShigekiKarita/grain2/branch/master/graph/badge.svg)](https://codecov.io/gh/ShigekiKarita/grain2)

Autograd and GPGPU library for dynamic neural networks in D.
This project is a successor of [grain](https://github.com/ShigekiKarita/grain).

## features

- @nogc support
- heterogeneous device (CPU/CUDA/OpenCL) support
- multiple CUDA device support
- see also [document]([![CircleCI](https://circleci.com/gh/ShigekiKarita/grain2.svg?style=svg)](https://circleci.com/gh/ShigekiKarita/grain2))

## requirements

- [dpp](https://github.com/atilaneves/dpp) master
- CPU backend
  - BLAS library (e.g., OpenBLAS, MKL)
- CUDA backend
  - CUDA header/library v10-
  - CUDNN header/library v7-
- OpenCL backend
  - OpenCL header/library v1.2

## development

- test `dub test grain2:core` and `dub test grain2:cuda`
- generate ddoc `make doc`

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

