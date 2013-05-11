# rbenv
# https://github.com/sstephenson/rbenv#section_2
export PATH="$HOME/.rbenv/bin:$PATH"
R=`which rbenv`
if [ $? -eq 0 ]; then
    eval "$(rbenv init -)"
fi

# End of lines configured by zsh-newuser-install
