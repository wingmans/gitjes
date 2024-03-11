## gitjes

github/bitbucket helper(s) to clone and update all repos living in bitbucket.

`git-clone.sh` generates a script `kloon.sh` that can be executed. It produces an intermediate file `repos.json` that contains all the repositories in bitbucket and `kloon.sh`. This script will clone all the repositories into the current directory. Repositories will be cloned in a subfolder per project. Editing the project list in `repos.json` will allow to clone only a subset of the repositories. When `kloon.sh` is executed, it will update all the repositories.

assumes JQ exists on the system ...
install: brew install jq

assumes in the environment:
BB_KEY:    access token (password) is stored in BB_KEY
BB_USER:   username
BB_HOST:   bitbucket hostname
