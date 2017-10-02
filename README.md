# mydotfile
This was only tested on Ubuntu 16.04 so might not fit with your environment.

```bash
# To get started
mkdir -p ~/.vim/bundle
mkdir ~/.vim/sessions

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/itisnotdone/mydotfile.git
sudo ln -s ~/mydotfile/.vimrc ~/.vimrc

vim +PluginInstall +qall

# When using sessions
# :mks ~/.vim/sessions/my_sessions1.vim
# :source ~/.vim/sessions/my_sessions1.vim or vim -S ~/.vim/sessions/my_sessions1.vim
```
