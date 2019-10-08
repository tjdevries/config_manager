#!/bin/bash

print '> Setting up sourceress env'

if [[ $PYENV_VERSION != 'sourceress' ]]; then
    print ' ==> Changing pyenv'
    pyenv activate sourceress
fi

# Set the default environment variables
if [[ $SOURCERESS_URL == '' ]]; then
    print ' ==> Sourcing default env variables'
    source ~/sourceress/scripts/use_environment.sh default
fi

# Set PYTHONPATH
if [[ $PYTHONPATH == '' ]]; then
    print ' ==> setting PYTHONPATH'
    export PYTHONPATH=web:core:deploy
fi

if [[ $(hostname) -eq "LAPTOP-FGR7UJ0D" ]]; then
    return
fi


if python -c 'import envdir'; then
else
    # For some reason cython isn't included...
    pip install --upgrade cython

    pip install -r requirements.txt
    pip install -r requirements_dev.txt
fi

service postgresql status
if [[ $? -ne 0 ]]; then
    print ' ==> Starting postgresql'
    sudo service postgresql start
fi


