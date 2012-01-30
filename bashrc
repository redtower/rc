for i in ~/.bash/conf/[0-9]*
do
    [[ -f $i ]] && source $i
done
