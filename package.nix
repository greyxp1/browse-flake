{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}: let
  source = lib.importJSON ./sources.json;
in
  stdenv.mkDerivation {
    pname = "opencode-browse";
    inherit (source) version;
    src = fetchurl {
      inherit (source.${stdenv.hostPlatform.system}) url sha256;
    };

    nativeBuildInputs = [autoPatchelfHook];
    dontBuild = true;
    dontStrip = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 bin/browse "$out/bin/browse"
      install -Dm444 LICENSE "$out/share/licenses/opencode-browse/LICENSE"
      runHook postInstall
    '';

    meta = {
      description = "Browser automation for MCP clients through a Chromium extension";
      homepage = "https://github.com/anomalyco/browse";
      license = lib.licenses.mit;
      mainProgram = "browse";
      platforms = ["x86_64-linux" "aarch64-linux"];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }
