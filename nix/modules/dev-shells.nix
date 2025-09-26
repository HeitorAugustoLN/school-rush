{
  perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.blender
          pkgs.godot-mono
        ];

        shellHook = config.pre-commit.installationScript;
      };
    };
}
