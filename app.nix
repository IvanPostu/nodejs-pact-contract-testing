let 
  pkgs = import <nixpkgs> { config = { allowUnfree = false; }; };
  PROJECT_ROOT = builtins.toString ./.;
in
pkgs.mkShell {
  name = "app-shell";

  buildInputs = [
    pkgs.nodejs_24
    # required by ruby -> @pact-foundation cli tool to upload contracts
    pkgs.libxcrypt-legacy
  ];

  LANG = "en_US.UTF-8";
  LC_ALL = "en_US.UTF-8";

  shellHook = ''
    export PROJECT_ROOT=${PROJECT_ROOT}
    export LD_LIBRARY_PATH="${pkgs.libxcrypt-legacy}/lib:$LD_LIBRARY_PATH"

    export JAVA_HOME=${pkgs.jdk21}
    export PATH=${pkgs.jdk21}/bin:$PATH
  '';
}