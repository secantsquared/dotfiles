zcompare() {
  if [[ -s ${1} && (! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile -Uz ${1}
  fi
}

zcompare $ZDOTDIR/.zcompdump
zcompare $ZDOTDIR/.zshrc
zcompare $ZDOTDIR/.zprofile
zcompare $ZDOTDIR/.zlogin
zcompare $ZDOTDIR/.zfuncs/cursor_mode
zcompare $ZDOTDIR/.zfuncs/lazy_load
zcompare $ZDOTDIR/.zfuncs/pyenv_init

for zfile in $ZDOTDIR/.zplugins/*/*.{plugin.zsh,zsh}; do zcompare $zfile; done
unset zfile
