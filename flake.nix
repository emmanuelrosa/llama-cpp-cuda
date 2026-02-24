{
  description = "llama.cpp built with NVIDIA CUDA support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nix-appimage.url = "github:ralismark/nix-appimage";
    nix-appimage.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-appimage }: let
    forAllSystems = func: nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ] (system:
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
        nvidia_x11 = pkgs.linuxPackages.nvidia_x11;
      };

      llama-cpp-shell-appimage = nix-appimage.bundlers."${system}".default self.packages."${system}".llama-cpp-shell;
    });
  };
}
