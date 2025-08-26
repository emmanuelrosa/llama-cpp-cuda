{
  description = "llama.cpp built with NVIDIA CUDA support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
  };

  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {

    packages.x86_64-linux.default = self.packages.x86_64-linux.llama-cpp-cuda;

    packages.x86_64-linux.llama-cpp-cuda = pkgs.llama-cpp.override {
      cudaSupport = true;
    };

    packages.x86_64-linux.nvtop = pkgs.nvtopPackages.nvidia;

  };
}
