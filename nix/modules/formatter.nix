{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt.programs = {
    deadnix.enable = true;
    gdformat.enable = true;
    nixfmt.enable = true;
    statix.enable = true;
  };
}
