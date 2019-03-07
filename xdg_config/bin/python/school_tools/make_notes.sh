#!/bin/bash

# TODO: Make the gimli.css somehow not hard coded
gimli -stylesheet ../gimli.css -file $1\.md -outputfilename $1

# This puts it into a temp folder so I can look at it in my Chromebook
cp $1\.pdf ~/Downloads/temp.pdf

# Moves it to the compiled section of the pdfs, so I don't have tons of pdfs
#   cluttering up my markdown folders
mv $1\.pdf ./compiled/


