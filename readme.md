各種設定ファイル
==========
zsh,emacs,vim,git,vimperator等の設定ファイル

init
----------
### ダウンロードする。 ###

    $ cd ~
    $ git clone https://github.com/redtower/rc.git
    $ cd rc
    $ git submodule init
    $ git submodule update

### セットアップする。（Linux,Mac OSX）-ホームディレクトリから設定ファイルにリンクを張ります。 ###

    $ cd ~
    $ ./rc/setup.sh

#### セットアップで作成されるファイル一覧。 ####
##### Firefox Plugin Vimperator #####
* .vimperatorrc
* .vimperator/

##### Vim #####
* .vimrc
* .gvimrc
* .vim/

##### zsh #####
* .zsh/
* .zshrc

##### Git #####
* .gitconfig
* .gitignore

##### Emacs #####
* .emacs.d/

caution
----------
・実際はここに「private」ディレクトリがあり、内緒の情報が記述されています。影響するのは、vimでのchangelogの設定、Emacsでのhowm,Tumble,wp-emacs,Mew,changelogの設定、Gitの設定、Muttの設定などです。（セットアップで作成している、.gitconfig、howm/はprivateに存在しています）
