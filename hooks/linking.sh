#!/bin/bash

echo "This file only works on linux."
echo -e "\tIt must be run from the \$GIT/hooks folder"
echo -e "\tIt will link all of the hooks we're using to the correct location\n"

CURRENT_DIR="$(pwd)"

for f in *; do
    if [[ "$f" == "linking.sh" ]]; then
        echo "Does not link \`linking.sh\`"
    else
        ln -sfv $CURRENT_DIR/$f ../.git/hooks/ 
    fi
done
