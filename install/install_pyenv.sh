# Pyenv
curl https://pyenv.run | bash

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
	libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
	xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

# Do the stuff you'd normally do to get pyenv running.
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


