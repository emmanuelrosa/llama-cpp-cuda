{
  description = "llama.cpp built with NVIDIA CUDA support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.default = self.packages.x86_64-linux.llama-cpp-cuda;

    packages.x86_64-linux.llama-cpp-cuda = nixpkgs.legacyPackages.x86_64-linux.llama-cpp.override {
      cudaSupport = true;
    };

    packages.x86_64-linux.nvtop = nixpkgs.legacyPackages.x86_64-linux.nvtopPackages.nvidia;

  };
}
