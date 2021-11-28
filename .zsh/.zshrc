[ -d $ZDOTDIR/.zplugins/zsh-defer ] && source $ZDOTDIR/.zplugins/zsh-defer/zsh-defer.plugin.zsh

autoload -Uz compinit
zsh-defer compinit

zsh-defer source "/usr/local/opt/fzf/shell/completion.zsh"
zsh-defer source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# zstyle
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

zstyle ':completion:*:*:*:*:*' menu select=2
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:correct:' prompt 'correct to: %e'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}0 matches for:%{\e[0m%} %d'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZDOTDIR/.zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true
zstyle ':completion:*:expand:*' tag-order all-expansions

# setopt
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_NO_STORE
setopt HASH_LIST_ALL
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD
setopt NOCORRECT
setopt LIST_AMBIGUOUS
setopt NOLISTTYPES
setopt LISTPACKED
setopt AUTOMENU
unsetopt BEEP

# history
[ -z "$HISTFILE" ] && HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=290000
SAVEHIST=$HISTSIZE
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# aliases and functions
alias brewup='brew update; brew upgrade; brew cleanup -s; brew doctor'

# set vimode
bindkey -v
export KEYTIMEOUT=1

# load plugins
plugins=(fzf-tab zsh-autosuggestions zsh-history-substring-search fast-syntax-highlighting)

for p in "${plugins[@]}"; do zsh-defer source $ZDOTDIR/.zplugins/$p/${p}.plugin.zsh; done
unset p

# adjust fpath
fpath+=($ZDOTDIR/.zfuncs $fpath)

# autoload zfuncs
for f in $ZDOTDIR/.zfuncs/*; do autoload -Uz $f; done
unset f

# call zfuncs that need to be called
cursor_mode
lazy_load pyenv_init pyenv python python3 pip pip3
