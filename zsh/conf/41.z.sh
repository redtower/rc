[[ -f ~/.zsh/plugin/z/z.sh ]] && source ~/.zsh/plugin/z/z.sh

function precmd () {
    _z --add "$(pwd -P)"
}


# in zaw
# ref. http://arataka.github.com/2011/04/14/zaw-zsh-or-canything-with-mendeley-gisty-and-j-z.html
zmodload zsh/parameter

function zaw-src-z() {
    # see http://stackoverflow.com/questions/452290/ for IFS trick
    IFS=$(echo -n -e "\0")
    : ${(A)candidates::=$(z \
        | sed -e 's/^[0-9\\. ]*//' -e 's/ /\\ /g' -e "s#^$HOME#~#" \
        | tac | tr '\n' '\0')}
    unset IFS
    actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
    act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
}

zaw-register-src -n z zaw-src-z

bindkey '^X@' zaw-z
