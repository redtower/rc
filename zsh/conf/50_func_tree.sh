#
# tree �R�}���h

if is_cygwin ; then
    function tree()
    {
        tree.com $@ | iconv -f sjis -t utf-8
    }
fi
