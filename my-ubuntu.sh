#!/bin/bash

#Editors repository
sudo add-apt-repository ppa:webupd8team/atom
sudo add-apt-repository ppa:webupd8team/brackets

#Google Chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

#system upgrade
sudo apt-get update && sudo apt-get upgrade -y

#system packages install
sudo apt-get install git tmux atom brackets google-chrome-stable zsh emacs curl -y

#spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

#zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
cp ~/.zshrc ~/.zshrc.orig
sudo chsh -s /bin/zsh echo "$USER"

#oh my tmux
cd ~/
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
echo "set-option -g default-shell /usr/local/bin/zsh" >> ~/.tmux.conf.local

#nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zshrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

source ~/.bashrc
nvm install stable
nvm use node

#opera
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
sudo sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
sudo apt-get update
sudo apt-get install opera -y

#mongodb
sudo apt-get install mongodb -y
sudo systemctl enable mongod
sudo systemctl start mongod

#spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client -y
