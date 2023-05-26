#!/bin/bash
xcode-select --install

if [ -d ~/.oh-my-zsh ]; then
	echo zsh installed
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! brew help &>/dev/null; then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/annemacedo/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
	echo brew installed
fi

brew bundle

if fzf -h ; then
	echo setting up fuzzy completion
	$(brew --prefix)/opt/fzf/install
fi

if test -f $HOME/.vim/bundle/Vundle.vim ; then
	echo vundle installed
else
	echo installing vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if test -f $HOME/.ssh/id_ed25519 ; then
	echo ssh already set up
else
	echo generating ssh key
	ssh-keygen -t ed25519 -C "retpolanne"
fi

echo setting up vimrc
cp vimrc $HOME/.vimrc

echo setting up gh
gh auth login -p ssh -w
