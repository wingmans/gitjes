## gitjes

github/bitbucket helper(s) to clone and update all repos living in bitbucket. 

generates a script kloon.sh that can be executed. 
repositories will be cloned in a subfolder per project

assumes JQ exists on the system 
install: brew install jq

assumes in the environment:
* BB_KEY access token (password) is stored in BB_KEY
* BB_USER username
* BB_HOST bitbucket hostname


paging
#### 1st page: http://host:port/context/rest/api-name/api-version/path/to/resource?limit={desired size of page}
