# llama-cpp-cuda

This minimal Nix flake simply provides a package for [llama.cpp](https://github.com/ggml-org/llama.cpp) with NVIDIA cuda support enabled. It simply references the existing llama.cpp package in [Nixpkgs](https://github.com/NixOS/nixpkgs) and uses an `override` to enable CUDA support; That's it.

NOTE: By using these packages you agree with NVIDIA's proprietary license.
