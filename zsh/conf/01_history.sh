# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

# ヒストリに追加する条件の設定
zshaddhistory() {
	local line=${1%%$'\n'}
	local cmd=${line%% *}

#	[[ ${#line} -ge 5			# 4文字以下は追加しない
#		&& ${cmd} != (l|l[sal])	# コマンドが l,ls,la,ll は追加しない
#		&& ${cmd} != (c|cd)		# コマンドが c,cd は追加しない
#		&& ${cmd} != (m|man)	# コマンドが m,man は追加しない
#	]]
}
