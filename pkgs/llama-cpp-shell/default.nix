{ lib
, writeShellApplication
, writeText
, symlinkJoin
, coreutils
, llama-cpp
, bash
, nvidia_x11
, makeDesktopItem

# The BASH shell produced by this package is quite minimal.
# Use this to add more commands to the shell; ex. [ less which ]
, extraPackages ? [] 

# Use this to add more libraries to LD_LIBRARY_PATH. You probably DON'T need this.
, extraLibraries ? [] 
}: let
  name = "llama-cpp-shell";

  runtimeInputs = [
    llama-cpp
    bash
    coreutils
  ] ++ extraPackages;

  desktopItem = (makeDesktopItem {
    name = name;
    exec = name;
    desktopName = "LLaMA.cpp Shell";
    terminal = true;
    categories = [ "Development" "Building" ];
  });

  rcfile = writeText "${name}.rc" ''
    export PATH=$PATH:${lib.makeBinPath runtimeInputs}
    export PS1="${name} v${llama-cpp.version}> "
    export LD_LIBRARY_PATH=${
      lib.makeLibraryPath ([ nvidia_x11 ] ++ extraLibraries)
    }"''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  '';

  shell =  writeShellApplication rec {
    inherit name;
    inherit runtimeInputs;

    text = ''
      echo "Welcome to ${name}, a BASH shell containing LLaMA.cpp v${llama-cpp.version}."
      echo "When you're finished, don't forget to run 'exit' to leave the shell."
      bash --rcfile ${rcfile} -i
    '';
  };
in symlinkJoin {
  name = "${name}-${llama-cpp.version}";

  paths = [ shell desktopItem ];

  meta.mainProgram = "llama-cpp-shell";
}
