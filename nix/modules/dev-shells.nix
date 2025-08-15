{
  perSystem =
    {
      pkgs,
      config,
      self',
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShell {
          packages = [
            pkgs.godot-mono
            self'.packages.write-flake
          ];
          shellHook = config.pre-commit.installationScript;
        };
      };
    };
}
