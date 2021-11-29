{ pkgs
, nurFun ? (import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz"))
}: {
  allowUnfree = true;
  allowUnsupportedSystem = true;
  packageOverrides = pkgs: {
    nur = nurFun {
      nurpkgs = pkgs;
      inherit pkgs;
    };
  };
}
