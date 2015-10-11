#!/usr/bin/env python3.4

# Imports
import random

# Define the tips
tips = ["The last command entered with ':' can be repeated with @: and further repeats can be done with @@",
        "Using the * key searches for the word under the cursor. Use # to do the same thing backwards",
        "`:Tab /{Pattern}` will align the current paragraph on that pattern"
        ]

# Print a random tip!
print(tips[int(random.random()*len(tips))])
