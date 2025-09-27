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
          pkgs.godot-export-templates
        ];

        shellHook = config.pre-commit.installationScript;
      };
    };
}
