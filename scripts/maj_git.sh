#!/bin/bash

function pdot
{
    length=$(( $COLUMNS - ${#1} - 8))
    for (( i = 0; i < $length; i++ )); do
        echo -n "."
    done
    echo -n " "
}

function pinf
{
    if [[ $? -eq 0 ]]; then
        echo "${C_GREEN}Ok${C_NO} "
    else
        echo "${C_RED}No${C_NO} "
    fi
}

function cmd
{
    echo -n " - $2 "
    pdot $2
    eval "$1 -R $2 $3 2> /dev/null"
    pinf
}

# Var {
COLUMNS=$(tput cols)
C_RED=$(tput setaf 1)
C_GREEN=$(tput setaf 2)
C_NO=$(tput op)

save_dir="$HOME/docs/dotfiles"
files=(.zshrc .screenrc .vimrc .Xdefaults .rtorrent.rc .xbindkeysrc 
     docs/scripts .vim .ncmpcpp .weechat .config/awesome .muttrc)
del=(.vim/view .vim/backup .weechat/logs .weechat/weechat.log 
     .weechat/weechat_fifo_*)
# }

cd $save_dir
find . -maxdepth 1 -not -name ".git" -exec rm -rf '{}' \; 2>/tmp/NULL

echo "Copie des fichiers : "
for i in ${!files[@]}; do
    cmd "cp" "$HOME/${files[i]}" .
done

echo "Nettoyage des fichiers : "
for i in ${!del[@]}; do
    cmd "rm" ${del[i]}
done
sed -i 's/password = "[^ ]*"/password = xxx/' .weechat/irc.conf
sed -i 's/pass = "[^ ]*"/pass = xxx/' .muttrc
sed -i 's/[^ ]*@[^ ]*/email/g' .muttrc

echo "Envoi :"
git add .
git commit -a
if [[ $? -eq 0 ]]; then
    git push git@github.com:b0b/dotfiles.git
else
    echo "Tous les fichiers sont à jour"
fi
