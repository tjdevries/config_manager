#!/bin/bash

echo "Choose option:"


options=("1. Encode" "2. Decode")
select opt in "${options[@]}"
do
    case $opt in
        "1. Encode")
            echo "You chose to encode your user file"
            openssl aes-128-cbc -in users.no -out users.enc
            break
            ;;
        "2. Decode")
            echo "You chose to decode your user file"
            openssl aes-128-cbc -d -in users.enc -out users.no
            break
            ;;
        *)
            echo "Bad option";;
    esac
done
