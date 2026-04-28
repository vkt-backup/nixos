{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "music-presence";
  version = "2.3.5";

  src = pkgs.fetchurl {
    url = "https://github.com/ungive/discord-music-presence/releases/download/v2.3.5/musicpresence-2.3.5-linux-x86_64.tar.gz";
    sha256 = "04380cd527f21170b4a16f89df79982b0a91aef657ddccbf5fd93b62e938912f";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.qt6.wrapQtAppsHook
  ];

  buildInputs = [
    pkgs.qt6.qtbase
    pkgs.qt6.qtsvg
    pkgs.qt6.qtwayland

    pkgs.zlib
    pkgs.fontconfig
    pkgs.freetype
    pkgs.glib
    pkgs.libgpg-error
    pkgs.krb5
    pkgs.e2fsprogs
    pkgs.libGL

	pkgs.libxcb
    pkgs.libX11
    pkgs.libXext
    pkgs.libXrender
	pkgs.xkeyboard_config
    pkgs.libxkbcommon
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/musicpresence
    cp -r usr/share/musicpresence/* $out/share/musicpresence/

    mkdir -p $out/share/applications
    cp -r usr/share/applications/* $out/share/applications/ || true

    mkdir -p $out/share/icons
    cp -r usr/share/icons/* $out/share/icons/ || true

    mkdir -p $out/bin
    ln -s $out/share/musicpresence/bin/musicpresence $out/bin/musicpresence

    runHook postInstall
  '';

  # ajuda o autoPatchelf a priorizar libs do próprio bundle
  preFixup = ''
    addAutoPatchelfSearchPath $out/share/musicpresence/lib
	wrapProgram $out/bin/musicpresence \
      --set QT_PLUGIN_PATH "$out/share/musicpresence/plugins" \
      --set LD_LIBRARY_PATH "$out/share/musicpresence/lib" \
      --set XKB_CONFIG_ROOT "${pkgs.xkeyboard_config}/share/X11/xkb"
  '';

  meta = with pkgs.lib; {
    description = "Discord Rich Presence for music players";
    homepage = "https://github.com/ungive/discord-music-presence";
    platforms = platforms.linux;
  };
}

/*{ stdenv , fetchurl, makeWrapper, autoPatchelfHook, libGL, wayland }:

stdenv.mkDerivation rec {
  name = "Music Presence";
  version = "2.3.5";

  src = fetchurl {
    url = "https://github.com/ungive/discord-music-presence/releases/download/v2.3.5/musicpresence-2.3.5-linux-x86_64.tar.gz";
	sha256 = "04380cd527f21170b4a16f89df79982b0a91aef657ddccbf5fd93b62e938912f";
  };

  nativeBuildInputs = [ makeWrapper ];

  #buildInputs = [ 
  #  libGL 
  #  wayland 
  #  stdenv.cc.cc.lib
  #  zlib
  #  fontconfig
  #  freetype
  #  glib
  #  libgpg-error
  #  krb5
  #  e2fsprogs

  #  qt6.base
  #];

  installPhase = ''
    mkdir -p $out/share/musicpresence
	cp -r usr/share/musicpresence/. $out/share/musicpresence

	cp -r usr/share/icons $out/share
	cp -r usr/share/applications $out/share/

	mkdir -p $out/bin
	makeWrapper $out/share/musicpresence/bin/musicpresence $out/bin/musicpresence \
	  --set QT_PLUGIN_PATH "$out/share/musicpresence/plugins"
  '';

  autoPatchelfIgnoreMissingDeps = true;
  postFixup = ''
    patchelf --set-rpath "$out/share/musicpresence/lib:${libGL}/lib:${wayland}/lib" \
	  $out/share/musicpresence/bin/musicpresence
  '';
}*/
