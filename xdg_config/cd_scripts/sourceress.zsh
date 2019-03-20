
print '> Setting up sourceress env'

if [[ $PYENV_VERSION != 'sourceress' ]]; then
    print ' ==> Changing pyenv'
    pyenv activate sourceress
fi

_psql_status=`service postgresql status`
if [[ $_psql_status == *"down"* ]]; then
    print ' ==> Starting postgresql'
    sudo service postgresql start
fi

# Set the default environment variables
if [[ $SOURCERESS_URL == '' ]]; then
    print ' ==> Sourcing default env variables'
    source ~/sourceress/scripts/use_environment.sh default
fi
