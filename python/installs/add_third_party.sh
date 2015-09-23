#!/bin/bash

# Add the python addins folder
if [ ! -d ~/python_addins/  ]
then
    echo "Adding ~/python_addins/ folder"
    mkdir ~/python_addins/
fi

# Add and install PyPDF2
if [ "$(python -c \
"try:
    import PyPDF2
except:
    print('hello')")" ]
then
    echo "Installing PyPDF2"
    # Download or pull the latest repository
    if [ ! -d ~/python_addins/pypdf2/  ]
    then
        git clone https://github.com/mstamy2/PyPDF2 ~/python_addins/pypdf2
    else
        cd ~/python_addins/pydpdf2
        git pull
    fi

    # Move to the correct folder
    cd ~/python_addins/pypdf2

    # Have python install the module
    sudo python setup.py install
else
    echo "We found PyPDF2"
fi
