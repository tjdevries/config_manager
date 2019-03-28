CONFIG_HOME := $(HOME)/.config/
ZPLUG_HOME := $(CONFIG_HOME)/zplug
ZSH_HOME := $(CONFIG_HOME)/zplug
ZSH_ENV_HOME := $(HOME)/
NVIM_HOME := $(CONFIG_HOME)/nvim

help: ## Print help message
	@# Thanks tweekmonster ;) Saw this no your gist too.
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\033[36m\1\\033[m:\2/' | column -c2 -t -s :)"

install: export CONFIG_HOME = $(CONFIG_HOME)
install: export ZPLUG_HOME = $(ZPLUG_HOME)
install: export ZSH_HOME = $(ZSH_HOME)
install: export ZSH_ENV_HOME = $(ZSH_ENV_HOME)
install: ## Install dotfiles
	@echo "Installing dotfiles..."
	./link_dirs.sh

.PHONY: all zsh nvim build_reqs pyenv

all: zsh nvim
	@echo "All done"

zsh:
	@echo "========================================"
	@echo "Installing Zsh..."
	sudo apt install zsh -y
	chsh -s $(shell which zsh)
	@echo "========================================"

build_reqs:
	sudo apt-get install -y make cmake git xclip
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
		libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
		xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
	sudo apt-get install -y gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

sourceress: pyenv
	pyenv install 3.6.2
	pyenv virtualenv 3.6.2 sourceress

dirs:
	mkdir -p ~/git
	mkdir -p ~/build


pyenv:
	curl https://pyenv.run | bash

nvim_pyenv: pyenv
	pyenv install 3.7.2
	pyenv virtualenv 3.7.2 neovim
	pyenv activate; pip install pynvim; pyenv deactivate;

nvim: dirs build_reqs nvim_pyenv
	if [ -d ~/git/neovim ]; then echo "[nvim]: git/neovim Already found"; else git clone https://github.com/neovim/neovim ~/git/neovim; fi
	if [ -d ~/build/neovim ]; then cd ~/build/neovim && git pull; else git clone https://github.com/neovim/neovim ~/build/neovim; fi
	cd ~/build/neovim/ && make -j2 -s --no-print-directory && sudo make install -s
