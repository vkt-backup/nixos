{ lib, stdenv, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {
  pname = "mt7902-bt";
  version = "unstable-2025";

  src = fetchFromGitHub {
    owner = "OnlineLearningTutorials";
    repo = "mt7902_temp";
    rev = "d47026d2817d86a52c58ede5494db32b1548f440";
    hash = "sha256-ab3d8cwJ7OLQmzBfwNIwdkJWNi6AMiM7FR5u1/4vLXc=";
  }; 

  sourceRoot = "source/linux-${lib.versions.majorMinor kernel.version}/drivers/bluetooth";

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
