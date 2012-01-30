
foreach i in ~/.zsh/conf/[0-9]*
do
    [[ -f $i ]] && source $i
done
