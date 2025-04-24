{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            dotnetCorePackages.sdk_9_0
            dotnetCorePackages.runtime_9_0

            docker
            git
          ];

          shellHook = ''
            export DOTNET_CLI_TELEMETRY_OPTOUT=1
            export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
            echo "✅ .NET dev environment ready"
          '';
        };
      }
    );
}
