{ stdenv, cmake, hellolib }:

stdenv.mkDerivation rec {
    pname = "hellolib";
    version = "0.1.0";
    src = ./.;
    nativeBuildInputs = [ cmake ];

    preConfigure = ''
    rm -rf build CMakeCache.txt
    mkdir -p build
    cd build
  '';

  configurePhase = ''
    cmake ${src} .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$out
  '';

  buildPhase = ''
    cmake --build .
  '';

  installPhase = ''
    cmake --install .
  '';
}