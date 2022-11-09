set -gxp PATH /usr/local/sbin $HOME/go/bin $HOME/.cargo/bin /usr/local/opt/ruby/bin /usr/local/lib/ruby/gems/3.0.0/bin
set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/library
set -gx GOPATH $HOME/go
set -gx GOBIN $HOME/go/bin
set -gx NVIMRC $HOME/.vimrc
set -gx NVM_DIR $HOME/.nvm
set -gx EDITOR nvim
set -gx FZF_CTRL_T_COMMAND vim

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

# nord theme
set nord0 2e3440
set nord1 3b4252
set nord2 434c5e
set nord3 4c566a
set nord4 d8dee9
set nord5 e5e9f0
set nord6 eceff4
set nord7 8fbcbb
set nord8 88c0d0
set nord9 81a1c1
set nord10 5e81ac
set nord11 bf616a
set nord12 d08770
set nord13 ebcb8b
set nord14 a3be8c
set nord15 b48ead

set fish_color_normal $nord4
set fish_color_command $nord9
set fish_color_quote $nord14
set fish_color_redirection $nord9
set fish_color_end $nord6
set fish_color_error $nord11
set fish_color_param $nord4
set fish_color_comment $nord3
set fish_color_match $nord8
set fish_color_search_match $nord8
set fish_color_operator $nord9
set fish_color_escape $nord13
set fish_color_cwd $nord8
set fish_color_autosuggestion $nord6
set fish_color_user $nord4
set fish_color_host $nord9
set fish_color_cancel $nord15
set fish_pager_color_prefix $nord13
set fish_pager_color_completion $nord6
set fish_pager_color_description $nord10
set fish_pager_color_progress $nord12
set fish_pager_color_secondary $nord1

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
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
fish_add_path /usr/local/opt/python@3.9/bin

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
alias vi 'nvim'
alias vim 'nvim'
alias e 'emacsclient -t'

switch (uname)
    case Darwin
        alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed'
        alias ls='ls -GpF' # Mac OSX specific
        alias ll='ls -alGpF' # Mac OSX specific
    case Linux
        alias ll='ls -al'
        alias ls='ls --color=auto'
end


set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS '
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
