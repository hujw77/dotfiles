{ lib, stdenv, fetchurl, weechat }:

stdenv.mkDerivation {
  pname = "colorize_lines";
  version = "4.0";

  src = fetchurl {
    url = "https://weechat.org/files/scripts/colorize_lines.pl";
    sha256 = "sha256-Ow77UIBNmEKh95F7/fiVth43p5yt9m0HFA1kFF3+Thg=";
  };

  dontUnpack = true;

  passthru.scripts = [ "colorize_lines.pl" ];

  installPhase = ''
    runHook preInstall

    install -D $src $out/share/colorize_lines.pl

    runHook postInstall
  '';

  meta = with lib; {
    inherit (weechat.meta) platforms;
    homepage = "https://weechat.org/scripts/source/colorize_lines.pl.html";
    description =
      "colors the channel text with nick color and also highlight the whole line colorize_nicks.py script will be supported";
    license = licenses.gpl3;
    maintainers = with maintainers; [ oakkitten ];
  };
}
