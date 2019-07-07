# grain2

Autograd and GPGPU library for dynamic neural networks in D.
This project is a successor of [grain](https://github.com/ShigekiKarita/grain).

## features

- @nogc support
- heterogeneous device (CPU/CUDA) support


## roadmap

- [x] heterogeneous multi-dimentional structure (grain.tensor.Tensor)
- [x] reference count-based memory management
- [ ] core autograd (forward/backward chain)
- [ ] dataset API (MNIST, PTB, etc)
- [ ] more memory manegement policy (garbage collection, memory pool)
- [ ] JIT compilation of computational graph
- [ ] OpenCL/HIP support
