function change_background --argument mode_setting
  # change background to the given mode. If mode is missing, 
  # we try to deduct it from the system settings.

  set -l mode "light" # default value
  if test -z $mode_setting
    set -l val (defaults read -g AppleInterfaceStyle) >/dev/null
    if test $status -eq 0
      set mode "dark"
    end
  else
    switch $mode_setting
      case light
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        set mode "light"
      case dark
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
        set mode "dark"
    end
  end

  # change neovim
  for addr in (/opt/homebrew/bin/nvr --serverlist)
    switch $mode
      case dark
        /opt/homebrew/bin/nvr --servername "$addr" -c "set background=dark"
      case light
        /opt/homebrew/bin/nvr --servername "$addr" -c "set background=light"
    end
  end

  # change tmux
  switch $mode
    case dark
      tmux source-file ~/.tmux/tmux-dark.conf
    case light
      tmux source-file ~/.tmux/tmux-light.conf
  end

  # # change alacritty
  function alacritty-theme --argument mode_setting
    pushd /Users/hujingwei/workspace/tools/dotfiles/home/.config

    cp alacritty.toml alacritty.toml.backup
    set -l line "general.import = [\"/Users/hujingwei/.config/alacritty/themes/alacritty-gruvbox-$mode_setting.toml\"]"
    echo $line> alacritty.toml
    
    cat alacritty.toml.backup |tail -n+2>> alacritty.toml
    rm alacritty.toml.backup

    popd
  end

  alacritty-theme $mode
end
