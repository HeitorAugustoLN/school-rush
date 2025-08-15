{
  description = "School Rush";

  inputs = {
    flake-compat = {
      type = "github";
      owner = "edolstra";
      repo = "flake-compat";
    };
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
    };

    flake-file = {
      type = "github";
      owner = "vic";
      repo = "flake-file";
      ref = "pull/27/head";
    };

    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
    };
    git-hooks = {
      type = "github";
      owner = "cachix";
      repo = "git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    treefmt-nix = {
      type = "github";
      owner = "numtide";
      repo = "treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./nix/modules);
}
