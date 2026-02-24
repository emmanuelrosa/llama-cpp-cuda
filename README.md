# llama-cpp-cuda

This minimal Nix flake simply provides a package for [llama.cpp](https://github.com/ggml-org/llama.cpp) with NVIDIA cuda support enabled. It references the existing llama.cpp package in [Nixpkgs](https://github.com/NixOS/nixpkgs) and uses an `override` to enable CUDA support.

NOTE: By using these packages you agree with NVIDIA's proprietary license.

# Packages

- llama-cpp-cuda: LLaMA.cpp with CUDA support.
- llama-cpp-shell: A BASH shell which contains `llama-cpp-cuda` in its environment. You can install this to get LLaMA in an isolated environment, instead of putting all of the llama-* tools in your PATH.
- llama-cpp-shell-appimage: Creates a big-ass (1 GB) [AppImage](https://appimage.org/) of `llama-cpp-shell`.
- nvtop: nvtop built with NVDIA and AMD support.
