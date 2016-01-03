#!/usr/bin/env python3.4

# Imports
import random

# Define the tips
tips = ["The last command entered with ':' can be repeated with @: and further repeats can be done with @@",
        "Using the * key searches for the word under the cursor. Use # to do the same thing backwards",
        "`:Tab /{Pattern}` will align the current paragraph on that pattern",
        "<C-p> will complete words that are used in your current file",
        "`:verbose set <name>?` tells you where a variable was set",
        "<C-a> will increment a number that the cursor is over",
        "<C-x> will decrement a number that the cursor is over"
        ]

# Print a random tip!
print(tips[int(random.random()*len(tips))])
