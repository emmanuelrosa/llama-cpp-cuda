{ writeShellApplication
, symlinkJoin
, llama-cpp
, bash
, makeDesktopItem
}: let
  name = "llama-cpp-shell";

  desktopItem = (makeDesktopItem {
    name = name;
    exec = name;
    desktopName = "LLaMA.cpp Shell";
    terminal = true;
    categories = [ "Development" "Building" ];
  });

  shell =  writeShellApplication {
    inherit name;

    runtimeInputs = [
      llama-cpp
      bash
    ];

    text = ''
      echo "Welcome to ${name}, a BASH shell containing llama-cpp v${llama-cpp.version}."
      echo "When you're finished, don't forget to run 'exit' to leave the shell."
      bash -i
    '';
  };
in symlinkJoin {
  name = "${name}-${llama-cpp.version}";

  paths = [ shell desktopItem ];
}
