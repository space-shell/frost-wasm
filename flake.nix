{
  description = "Frostr";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems; 
    in
    {
      devShell = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
          pkgs.mkShell {
            buildInputs = with pkgs; [
              clippy
              rustc
              cargo
              rustfmt
              rust-analyzer
              rustup
              cargo-make
              cargo-binutils
              deno
              pkg-config
              openssl
              wasm-pack
              wasm-bindgen-cli
              yarn
              esbuild
              nodejs_20
              rustc.llvmPackages.llvm
              rustc.llvmPackages.bintools
              nodePackages.typescript-language-server
            ];

            CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld";
            RUST_BACKTRACE = 1;
          });
    };
}

