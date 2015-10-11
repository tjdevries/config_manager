#!/usr/bin/env python3.4

# Standard Imports
import os

# Declarations
search = 'tips.py'

# Code begins ehre
files = os.listdir()

# Iterate through the files
for f in files:
    # If what we're searching for is exactly the last characters of the file name
    if search == f[-len(search):]:
        with open(f) as current_file:
            print('Tip from `{0}`: '.format(f), end="\n\t")
            code = compile(current_file.read(), f, 'exec')
            exec(code)
