{ lib, pkgs, config, vix, ... }: rec {

  shellDirenv = name: shell:
    pkgs.runCommand "${name}-shell-direnv" {
      shell_input_derivation = shell.inputDerivation;
    } (builtins.readFile ./shell-direnv.bash);

  nivSources = import "${vix}/nix/sources.nix";

  nivApp = name:
    let
      src = nivSources."${name}App";
      meta = {
        inherit name;
        description = "${name} App";
      } // src;
    in pkgs.stdenvNoCC.mkDerivation rec {
      inherit (meta) version;
      inherit src meta;
      pname = meta.name;
      sourceRoot = ".";
      preferLocalBuild = true;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p mnt $out/Applications
        ${hdiutil} attach -readonly -mountpoint mnt $src
        cp -r mnt/*.app $out/Applications/
        ${hdiutil} detach -force mnt
      '';
    };

}
