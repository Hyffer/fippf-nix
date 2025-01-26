{
  description = "FIPPF: a Fake-IP Proxy Frontend";

  outputs = { self }: {
    overlays.fippf = final: prev: {
      fippf = prev.callPackage ./default.nix { };
    };

    nixosModules.fippfService = import ./module.nix;
  };
}
