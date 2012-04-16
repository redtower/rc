# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 色付け
autoload -Uz colors
colors

# プロンプトの設定 
PUS="%{${fg[magenta]}%}%n%{${reset_color}%}"
PHO="%{${fg[yellow]}%}%m%{${reset_color}%}"
PVC="%1(v|%F{green}%1v%f|)%{${reset_color}%}"
PPR="%b%(!.#.$)"
PROMPT="[${PHO}${PVC}]${PPR} "

PPW="%{${fg[red]}%}%~%{${reset_color}%}"
PDT="%{${fg_bold[blue]}%}%D %T%{${reset_color}%}"
RPROMPT="[${PPW}]:[${PDT}]"

SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "

# vcs_infoがzsh4.3.7以上に含まれるためバージョンをチェックする。
autoload -Uz is-at-least
if is-at-least 4.3.7; then
# バージョン管理システムの情報を取得する zsh の関数
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable svn git
zstyle ':vcs_info:*' branchformat '%b:r%r'
zstyle ':vcs_info:*' formats ':(%s)%b'
zstyle ':vcs_info:*' actionformats ':(%s)%b|%a'

# Gitの作業コピーに変更があるかどうかをプロンプトに表示する。
# ref. http://d.hatena.ne.jp/mollifier/20100906/p1
#autoload -Uz is-at-least
#if is-at-least 4.3.10; then
#  zstyle ':vcs_info:git*:*' check-for-changes true
#  zstyle ':vcs_info:git*:*' stagedstr "+"
#  zstyle ':vcs_info:git*:*' unstagedstr "-"
#  zstyle ':vcs_info:git*:*' formats '(%s)%b%c%u'
#  zstyle ':vcs_info:git*:*' actionformats '(%s)%b|%a%c%u'
#fi

# バージョン管理システムの情報表示
function _update_vcs_info_msg() {
    psvar=()
    LANG=C vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info_msg
fi
