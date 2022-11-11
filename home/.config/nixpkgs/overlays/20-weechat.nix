self: super:
rec {
  weechat = super.weechat.override {
    configure = { availablePlugins, ... }: {
      plugins = builtins.attrValues (builtins.removeAttrs availablePlugins [ "php" ]);
      scripts = with super.weechatScripts; [
        colorize_nicks
        edit
        multiline
        wee-slack
        weechat-autosort
        weechat-go
        weechat-grep
        weechat-matrix
      ] ++ [
        weechat-notification-center
        colorize_lines
      ];
    };
  };

  weechat-notification-center = super.pkgs.python3Packages.callPackage ../pkgs/weechat-scripts/weechat-notification-center { };
  colorize_lines = super.pkgs.callPackage ../pkgs/weechat-scripts/colorize_lines { };
}
