if [[ ! -f $ZDOTDIR/.zinit/zinit.zsh ]]; then
    git clone https://github.com/zdharma-continuum/zinit.git $ZDOTDIR/.zinit
fi

source "${ZDOTDIR}/.zinit/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### Plugins
zinit wait'!0' lucid light-mode for \
  as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh" atload'starship_precmd' \
      starship/starship \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
     zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down" \
      zsh-users/zsh-history-substring-search \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  from'gh-r' as'program' \
      junegunn/fzf \
  Aloxaf/fzf-tab




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


# adjust fpath
fpath+=($ZDOTDIR/.zfuncs $fpath)

# autoload zfuncs
for f in $ZDOTDIR/.zfuncs/*; do autoload -Uz $f; done; unset f;

# call zfuncs that need to be called
cursor_mode
lazy_load pyenv_init pyenv python python3 pip pip3
