# TODO: Maybe remove this file, but it might be useful in debugging

with import <nixpkgs> {};
stdenv.mkDerivation {
  pname = "st";
  version = "0.8.4";

  src = ./.;

  nativeBuildInputs = [
    pkg-config
    ncurses
    fontconfig
    freetype
  ];
  buildInputs = [
    xorg.libX11
    xorg.libXft
  ];

  # TODO: Make patches work on default dist source, and here just apply them
  # Something like 10-patchname.diff 20-patchname.diff, and apply them on
  # original source, with config stored separately
  # This will ease distribution a bit, and updating to new version too
  installPhase = ''
    runHook preInstall
    TERMINFO=$out/share/terminfo make install PREFIX=$out
    runHook postInstall
  '';


  makeFlags = [ "PREFIX=$(out)" ];
}
