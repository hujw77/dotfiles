set -gxp PATH $HOME/.cargo/bin $HOME/go/bin /usr/local/sbin /opt/homebrew/bin
# set -gx RUST_SC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/library
set -gx GOPATH $HOME/go
set -gx GOBIN $HOME/go/bin
set -gx NVIMRC $HOME/.vimrc
set -gx NVM_DIR $HOME/.nvm
set -gx EDITOR nvim
set -gx FZF_CTRL_T_COMMAND nvim

set -x GPG_TTY (tty)

set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# don't show any greetings
set fish_greeting ""

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command; end

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# Senstive functions which are not pushed to Github
# It contains work related stuff, some functions, aliases etc...
# source ~/.config/fish/private.fish
#
# fish_add_path /usr/local/opt/node@18/bin
# fish_add_path /usr/local/opt/python@3.11/bin
# fish_add_path /usr/local/opt/ruby/bin
# fish_add_path /usr/local/lib/ruby/gems/3.0.0/bin
# fish_add_path /usr/local/opt/openssl@1.1/bin
# fish_add_path /usr/local/opt/mysql-client/bin

set -gx LSCOLORS cxBxhxDxfxhxhxhxhxcxcx
set -gx CLICOLOR 1

# support colors in less
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;31m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;44;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[01;32m'

# =============
#    ALIAS
# =============
alias e 'emacsclient -t'
alias python python3

switch (uname)
    case Darwin
        alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed'
        alias ls='ls -GpF' # Mac OSX specific
        alias ll='ls -alGpF' # Mac OSX specific
    case Linux
        alias ll='ls -al'
        alias ls='ls --color=auto'
end

# export PATH="$PATH:/Users/echo/.ityfuz/z/bin"

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH

fish_add_path -a /Users/hujingwei/.foundry/bin

# Created by `pipx` on 2024-12-06 01:58:34
fish_add_path /Users/hujingwei/.local/bin

fish_add_path /Users/hujingwei/.pyenv/bin
pyenv init - fish | source

fish_add_path /opt/homebrew/opt/libpq/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniconda/base/bin/conda
    eval /opt/homebrew/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/homebrew/Caskroom/miniconda/base/bin" $PATH
    end
end
# <<< conda initialize <<<

set -gx E /Volumes/Samsung
set -gx EHOME $E/$HOME


set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
