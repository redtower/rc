# ホスト名とユーザ名の先頭 2文字をとりだす。全部だと長いので。
#h2=`expr $HOSTNAME : '\(..\).*'`
#u2=`expr $USER : '\(..\).*'`
# 現在のホストによってプロンプトの色を変える。
if [[ "$EMACS" ]]; then
# emacs の shell モードでは制御文字を使わない簡単なプロンプト
PS1="$u2@$h2\w\$ "
else
# プロンプトの設定
if [[ "$SHELLTYPE" = session ]]; then
  # ある端末では短いプロンプトにする。
  PS1='$h2$ ';
  unset SHELLTYPE
else
  PS1="$u2@$h2\[\e[${col}m\]\w[\!]\$\[\e[m\] "
fi
# 通常のプロンプト PS1 に加えて PS0 という変数を設定する。
# (これは bash は何も関知しない、あとで述べる px というコマンドが使う)
# 通常のプロンプトでは現在のカレントディレクトリのフルパス名を
# 表示するようになっているが、これが長すぎるときに PS1 と PS0 を
# 一時的に切り換えて使う。
PS0="$u2@$h2:\[\e[${col}m\]\W[\!]\$\[\e[m\] "

# 端末の設定
eval `SHELL=sh tset -sQI`
stty dec crt erase ^H eof ^D quit ^\\ start ^- stop ^-
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    cygwin) color_prompt=yes;;
    screen) color_prompt=yes;;
    vt100) color_prompt=yes;;
    emacs) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\[\033[m\]@\[\033[01;33m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac