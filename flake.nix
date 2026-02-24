{
  description = "llama.cpp built with NVIDIA CUDA support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
  };

  outputs = { self, nixpkgs }: let
    forAllSystems = func: nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix (system:
      func (
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      )
      system
    );
  in {
    packages = forAllSystems (pkgs: system: {
      default = self.packages.${system}.llama-cpp-cuda;

      llama-cpp-cuda = pkgs.llama-cpp.override {
        cudaSupport = true;
      };

      nvtop = pkgs.nvtopPackages.nvidia.override { amd = true;};

      llama-cpp-shell = pkgs.callPackage ./pkgs/llama-cpp-shell {
        llama-cpp = self.packages.${system}.llama-cpp-cuda;
      };
    });
  };
}
