#!/usr/bin/env python3.4

# Standard Imports
import os

# Declarations
search = 'tips.py'

# Code begins here

# Get the directory path
file_path = os.path.realpath(__file__)
directory_path = os.sep.join(file_path.split(os.sep)[0:-1])

# list the files
files = os.listdir(directory_path)

# Iterate through the files
for f in files:
    # If what we're searching for is exactly the last characters of the file name
    if search == f[-len(search):]:
        with open(directory_path + os.sep + f) as current_file:
            print('Tip from `{0}`: '.format(f), end="\n\t")
            code = compile(current_file.read(), f, 'exec')
            exec(code)
