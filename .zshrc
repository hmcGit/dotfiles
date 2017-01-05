#
# zplug
#

source ~/.zplug/init.zsh
#インクリメンタル補完
zplug 'zsh-users/zsh-autosuggestions'
#標準サポート外のコマンド補完
zplug 'zsh-users/zsh-completions'
#nice は古い設定
#zplug 'zsh-users/zsh-syntax-highlighting', nice:10
#コマンドラインのシンタックス
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
#anything風コマンドラインインクリメンタル検索
zplug 'mollifier/anyframe'

#zsh visual mode
zplug "b4b4r07/zsh-vimode-visual", defer:3

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

#zplug load --verbose
zplug load

#
# Autoloadings
#

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -u
#URLを自動エスケープ
autoload -Uz url-quote-magic
#vcs_info設定
autoload -Uz vcs_info

#PROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

#
# ZLE settings
#

zle -N self-insert url-quote-magic
#プロンプトに現在のモードを表示
#terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
#left_down_prompt_preexec() {
#    print -rn -- $terminfo[el]
#}
#add-zsh-hook preexec left_down_prompt_preexec

#function zle-keymap-select zle-line-init zle-line-finish
#{
#    case $KEYMAP in
#        main|viins)
#            PROMPT_2="$fg[cyan]-- INSERT --$reset_color"
#            ;;
#        vicmd)
#            PROMPT_2="$fg[white]-- NORMAL --$reset_color"
#            ;;
#        vivis|vivli)
#            PROMPT_2="$fg[yellow]-- VISUAL --$reset_color"
#            ;;
#    esac

#    PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}[%(?.%{${fg[green]}%}.%{${fg[red]}%})%n%{${reset_color}%}]%# "
#    zle reset-prompt
#}

#zle -N zle-line-init
#zle -N zle-line-finish
#zle -N zle-keymap-select
zle -N edit-command-line

#
# General settings
#

setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt rm_star_wait
setopt share_history
setopt transient_rprompt

#
# Exports
#

export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export EDITOR=vim
export HISTFILE=~/.zhistory
export HISTSIZE=1000
export SAVEHIST=1000000
export LANG=ja_JP.UTF-8

#
# Key bindings
#

bindkey -v
bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete
bindkey '^@' anyframe-widget-cd-ghq-repository
bindkey '^r' anyframe-widget-put-history

#viins をemacsのごとく利用

bindkey -M viins '\er' history-incremental-pattern-search-forward
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  down-line-or-history
bindkey -M viins '^P'  up-line-or-history
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

#
# Aliases
#

alias vi='vim'

#
# Module settings
#

# Completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

#path 
typeset -U path cdpath fpath manpath

typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({/usr/local,/usr,}/sbin(N-/))

path=(~/bin(N-/) /usr/local/bin(N-/) ~/Library/Python/2.7/bin/ ${path})

#peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# for powerline
powerline-daemon -q

. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh


#function rprompt-git-current-branch {
#local name st color

#if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#    return
#fi
#name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#if [[ -z $name ]]; then
#    return
#fi
#st=`git status 2> /dev/null`
#if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#    color=${fg[green]}
#elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#    color=${fg[yellow]}
#elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#    color=${fg_bold[red]}
#else
#    color=${fg[red]}
#fi
# %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
# これをしないと右プロンプトの位置がずれる
#echo "[%{$color%}$name%{$reset_color%}]"
#}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
#setopt prompt_subst

#RPROMPT='%40<...<%~`rprompt-git-current-branch`($?)'
