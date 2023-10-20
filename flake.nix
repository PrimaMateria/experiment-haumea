{
  inputs = {
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = { self, haumea, nixpkgs }: {
    product = {
      default = haumea.lib.load {
        src = ./examples/default;
        inputs = {
          inherit (nixpkgs) lib;
          bar = "bar";
        };
      };
      path = haumea.lib.load {
        src = ./examples/default;
        loader = haumea.lib.loaders.path;
      };
      scoped = haumea.lib.load {
        src = ./examples/scoped;
        loader = haumea.lib.loaders.scoped;
        inputs = {
          inherit (nixpkgs) lib;
        };
      };
      hoistAttrs = haumea.lib.load {
        src = ./examples/hoistAttrs;
        transformer = haumea.lib.transformers.hoistAttrs "foo" "hitchhiker";
      };
      hoistLists = haumea.lib.load {
        src = ./examples/hoistLists;
        transformer = haumea.lib.transformers.hoistLists "foo" "hitchiker.question";
      };
    };
  };
}
