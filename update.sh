#!/bin/bash

# This script updates all git repositories in the current directory and its subdirectories.
# It also prunes the git repository to remove old objects and compress the repository.
echo "Running script..." | tee -a processed.log

logf=processed.log
dt=$(date '+%d/%m/%Y %H:%M:%S'); echo "$dt" | tee -a "$logf"

find . -maxdepth 2 -type d | while IFS= read -r i; do
    echo "$i"  | tee -a "$logf"           
     rm -f "$i"FETCH_HEAD                    # Deleting FETCH_HEAD file in each directory so git will reassess the remote
      [ -e "$i"noupdate ] || {
        git -C "$i" ls-remote --get-url | tee -a  "$logf" &&
        {
            git -C "$i" -c gc.auto=0 remote update -p 
            git -C "$i" -c gc.bigpackthreshold=0 -c pack.packsizelimit=0 gc --prune=now --keep-largest-pack 2>&1
        } | tee -a "$logf"
    }
done

echo "done..." | tee -a "$logf"