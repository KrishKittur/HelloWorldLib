{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }:
        let
            hellolib_overlay = final: prev: rec {
                hellolib = final.callPackage ./default.nix { };
            };

            my_overlays = [ hellolib_overlay ];

            pkgs = import nixpkgs {
                system = "aarch64-darwin";
                overlays = [ self.overlays.default ];
            };
        in
        {
            overlays.default = nixpkgs.lib.composeManyExtensions my_overlays;
            packages.aarch64-darwin.default = pkgs.hellolib;
        };

}