#!/bin/bash

# This script updates all git repositories in the current directory and its subdirectories.
dt=$(date '+%d/%m/%Y %H:%M:%S'); echo "$dt"


# Looping over directories. depth 2 omdat de git repositories in subdirectories zittenn per project.
find . -maxdepth 2 -type d | while IFS= read -r i; do
    echo "$i"  >> processed.log        # Logging directory name
     rm -f "$i"FETCH_HEAD              # Deleting FETCH_HEAD file in each directory so git will reassess the remote
      [ -e "$i"noupdate ] || {
        git -C "$i" ls-remote --get-url  >> processed.log &&
        {
            git -C "$i" -c gc.auto=0 remote update -p 
            git -C "$i" -c gc.bigpackthreshold=0 -c pack.packsizelimit=0 gc --prune=now --keep-largest-pack 2>&1
        } >> processed.log
    }
done

 