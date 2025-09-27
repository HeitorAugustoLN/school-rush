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
          pkgs.godot
          pkgs.godot-export-templates-bin
        ];

        shellHook = config.pre-commit.installationScript;
      };
    };
}
