{ lib, stdenv, fetchgit, kernel, kmod }:

stdenv.mkDerivation rec {
  pname = "mt7902-bt";
  version = "unstable-2025";

  src = fetchgit {
    url = "https://github.com/OnlineLearningTutorials/mt7902_temp";
    rev = "main";
	sha256 = "0aljvyqicq01phvd8v4c9mdq44zx3gwppliywaqqwbjvlj4wigiy"; #lib.fakeSha256; #"";
  };

  sourceRoot = "mt7902_temp/linux-${lib.versions.majorMinor kernel.version}/drivers/bluetooth";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
	M=$(pwd) \
	modules
  '';

  #makeFlags = [
	#"KERNELRELEASE=${kernel.modDirVersion}"
	#"KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  #];

  installPhase = ''
    install -D -m 0644 btmtk.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/bluetooth/btmtk.ko
    install -D -m 0644 btusb.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/bluetooth/btusb.ko
  '';

  meta = {
    description = "Community bluetooth driver for Mediatek MT7902";
    license = lib.licenses.gpl3;
	platforms = lib.platforms.linux;
  };
}
