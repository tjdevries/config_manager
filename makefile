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
