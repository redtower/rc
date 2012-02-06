if [ -e ~/.zsh/plugin/zaw/zaw.zsh ] ; then
    source ~/.zsh/plugin/zaw/zaw.zsh

    zsh-history() {
      zaw zsh-src-history
    }

    zle -N zsh-history
    bindkey '^Xh' zaw-history
fi
