#!/bin/bash
if [ $# -lt 2 ]; then
        echo "Usage: $0 <file> <word>"
        exit 1
fi
grep "$2" "$1"
