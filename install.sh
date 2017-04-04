#!/bin/bash
############################
dir="~/.dotfiles"
files="zshrc gitconfig fonts"     # list of files/folders to symlink in homedir
platform=${uname};

cd ${HOME}

########## File Management

# If there exists any old dotfiles, save them and replace them with the new ones.
echo "Saving old dotfiles..."

mkdir ${dir}/.dotfiles.old
oldFiles=${dir}/.dotfiles.old

echo "Caching files..."
for file in ${files}; do
  mv .${file} ${oldFiles}
done
echo "Completed caching. Your files are safe :)"

# Update symlinked dotfiles in home directory with files located in ~/.dotfiles.
for file in ${files}; do
  echo "Copying .${file} to home directory."
  cp ${dir}/${file} ${HOME}
  mv ${file} .${file}
  echo "Creating symlink to ${file} in home directory."
  ln -s ${dir}/${file} ${HOME}/.${file}
done

cd ${dir}

########## Ubuntu Specific

if [[ "$(lsb_release -si)" == "Ubuntu" ]]; then
  # Powerline fonts
  git clone https://github.com/pdf/ubuntu-mono-powerline-ttf.git fonts/ubuntu &&
  mv fonts/ubuntu &&
  sudo cp -f *.ttf /usr/share/fonts &&
  fc-cache -vf &&
  cd ${dir}
  
  # Useful tools and libraries
  sudo apt-get install zsh cmake wget curl libncurses-dev
fi

########## OS X Specific

if [[ $platform == 'Darwin' ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install brew-cask zsh cmake wget
  brew linkapps
fi

########## Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

echo "done"
