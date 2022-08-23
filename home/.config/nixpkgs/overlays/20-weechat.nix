self: super:
rec {
  weechat = super.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with super.weechatScripts; [
        wee-slack
        weechat-autosort
        weechat-go
        weechat-matrix
        multiline
        edit
      ] ++ [
        weechat-notification-center
        colorize_lines
      ];
    };
  };

  weechat-notification-center = super.pkgs.python3Packages.callPackage ../pkgs/weechat-scripts/weechat-notification-center { };
  colorize_lines = super.pkgs.callPackage ../pkgs/weechat-scripts/colorize_lines { };
}
