#!/usr/bin/env python3
import sys
import re

if len(sys.argv) != 3:
    print(f"Usage: {sys.argv[0]} <file> <word>")
    sys.exit(1)

file, word = sys.argv[1], sys.argv[2]

try:
    with open(file, 'r') as f:
        for line in f:
            if re.search(word, line):
                print(line.strip())
except FileNotFoundError:
    sys.exit(f"File '{file}' not found.")