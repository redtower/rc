#
# tree ƒRƒ}ƒ“ƒh

if is_cygwin ; then
    function tree()
    {
        tree.com $@ | iconv -f sjis -t utf-8
    }
fi
