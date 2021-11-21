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
      ] ++ weechat-scripts;
    };
  };

  weechat-scripts = import ../pkgs/weechat-scripts;
}
