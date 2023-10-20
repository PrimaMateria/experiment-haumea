{
  inputs = {
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nix-community/nixpkgs.lib";
  };

  outputs = { self, haumea, nixpkgs }: {
    checks = haumea.lib.loadEvalTests {
      src = ./tests;
      inputs = {
        inherit (nixpkgs) lib;
        foo = self.lib;
      };
    };
    lib = haumea.lib.load {
      src = ./src;
      inputs = {
        inherit (nixpkgs) lib;
        bar = "bar";
      };
    };
    tree = haumea.lib.load {
      src = ./src;
      loader = haumea.lib.loaders.path;
    };
    libScoped = haumea.lib.load { 
      src = ./srcScoped;
      loader = haumea.lib.loaders.scoped;
      inputs = {
        inherit (nixpkgs) lib;
      }; 
    };
    libHoistAttrs = haumea.lib.load {
      src = ./srcHoistAttrs;
      transformer = haumea.lib.transformers.hoistAttrs "foo" "hitchhiker";
    };
    libHoistLists = haumea.lib.load {
      src = ./srcHoistLists;
      transformer = haumea.lib.transformers.hoistLists "foo" "hitchiker.question";
    };
  };
}
