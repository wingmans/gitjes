## gitjes

github/bitbucket helper(s) to clone and update all repos living in a bitbucket account.

`git-clone.sh` generates a script `kloon.sh` that can be executed. An intermediate file `projects.json` that contains all the repositories in bitbucket and `kloon.sh` is created. `kloon.sh` clones all the repositories into the current directory. Repositories will be cloned in a subfolder per project. Editing the project list in `projects.json` will allow to clone only a subset of the repositories. When `update.sh` is executed from the root of the repository list, it will update all the repositories. Execution output is written into a log file `processed.log`.

`git-clone` accepts a single argument, a filename. The file should be a json array of project names. It will clone all the
repositories for the projects defined in this file. The script will create a `kloon.sh` that will clone all the repositories for the projects() in the current directory. 

assumes JQ exists on the system ...
install: brew install jq

assumes in the environment:
BB_KEY:    access token (password) is stored in BB_KEY
BB_USER:   username
BB_HOST:   bitbucket hostname
