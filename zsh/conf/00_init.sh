## OS judge function
## Mac OS X
function is_darwin(){
    [[ $OSTYPE == darwin* ]] && return 0
    return 1
}
## Cygwin
function is_cygwin(){
    [[ $OSTYPE == cygwin ]] && return 0
    return 1
}
## Emacs
function is_emacs(){
    [[ "$EMACS" != "" ]] && return 0
    return 1
}
