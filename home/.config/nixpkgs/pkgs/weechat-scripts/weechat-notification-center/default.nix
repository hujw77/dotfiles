{ lib, stdenv, substituteAll, buildEnv, fetchFromGitHub, python3Packages }:

stdenv.mkDerivation rec {
  pname = "weechat-notification-center";
  version = "1.5.2";

  src = fetchFromGitHub {
    repo = "weechat-notification-center";
    owner = "sindresorhus";
    rev = "v${version}";
    hash = "sha256-2Np6gAHYgsVT3DqfGayMgP2L416kSE4lJg8beZ6+uio=";
  };

  patches = [
    (substituteAll {
      src = ./libpath.patch;
      env = "${
          buildEnv {
            name = "weechat-notification-center-env";
            paths = with python3Packages; [ pync python-dateutil six ];
          }
        }/${python3Packages.python.sitePackages}";
    })
    ./load_weechat_icon_path.patch
  ];

  postPatch = ''
    substituteInPlace notification_center.py --subst-var out
  '';

  passthru.scripts = [ "notification_center.py" ];

  installPhase = ''
    mkdir -p $out/share
    cp notification_center.py $out/share/notification_center.py
    install -D -m 0444 weechat.png $out/share/weechat.png
  '';

  meta = with lib; {
    homepage = "https://github.com/sindresorhus/weechat-notification-center";
    license = licenses.mit;
    maintainers = with maintainers; [ hujw77 ];
    description = ''
      WeeChat script to pass highlights and private messages to the macOS Notification Center
    '';
  };
}
