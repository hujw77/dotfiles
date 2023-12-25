all: sync

sync:
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/fish
	mkdir -p ~/.tmux/
	mkdir -p ~/.emacs.d
	mkdir -p ~/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch

	[ -f ~/.config/alacritty/alacritty.yml ]                                     || ln -s $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.config/alacritty/color.yml ]                                         || ln -s $(PWD)/color.yml ~/.config/alacritty/color.yml
	[ -f ~/.config/fish/config.fish  ]                                           || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -d ~/.config/fish/functions/ ]                                             || ln -s $(PWD)/fish/functions ~/.config/fish/functions
	[ -d ~/.config/fish/conf.d ]                                                 || ln -s $(PWD)/fish/conf.d ~/.config/fish/conf.d
	[ -d ~/.config/nixpkgs ]                                                     || ln -s $(PWD)/nixpkgs ~/.config/nixpkgs
	[ -f ~/.config/nvim/init.lua ]                                               || ln -s $(PWD)/init.lua ~/.config/nvim/init.lua
	[ -f ~/.vimrc ]                                                              || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.bashrc ]                                                             || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.zshrc ]                                                              || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ]                                                          || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tmux/tmux-dark.conf ]                                                || ln -s $(PWD)/tmux-dark.conf ~/.tmux/tmux-dark.conf
	[ -f ~/.tmux/tmux-light.conf ]                                               || ln -s $(PWD)/tmux-light.conf ~/.tmux/tmux-light.conf
	[ -f ~/.tigrc ]                                                              || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.git-prompt.sh ]                                                      || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.gitconfig ]                                                          || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.agignore ]                                                           || ln -s $(PWD)/agignore ~/.agignore
	# [ -f ~/.emacs ]                                                              || ln -s $(PWD)/emacs ~/.emacs
	[ -f ~/Library/LaunchAgents/io.echo.notify.plist ]                           || ln -s $(PWD)/io.echo.notify.plist ~/Library/LaunchAgents/io.echo.notify.plist
	[ -f ~/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch/iterm2_auto.py ] || ln -s $(PWD)/iterm2_auto.py ~/Library/ApplicationSupport/iTerm2/Scripts/AutoLaunch/iterm2_auto.py

	# don't show last login message
	touch ~/.hushlogin

clean:
	rm -f ~/.vimrc
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/init.lua
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.config/alacritty/color.yml
	rm -f ~/.config/fish/config.fish
	rm -rf ~/.config/fish/functions
	rm -rf ~/.config/fish/conf.d
	rm -rf ~/.vim/lua
	rm -f ~/.bashrc
	rm -f ~/.zshrc
	rm -rf ~/.tmux.conf
	rm -f ~/.tmux/tmux-dark.conf
	rm -f ~/.tmux/tmux-light.conf
	rm -f ~/.tigrc
	rm -f ~/.git-prompt.sh
	rm -f ~/.gitconfig
	rm -f ~/.agignore
	rm -f ~/.ssh/config
	# rm -f ~/.emacs
	rm -f ~/Library/LaunchAgents/io.echo.notify.plist

.PHONY: all clean sync build run kill
