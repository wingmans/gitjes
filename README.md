## gitjes

github/bitbucket helper(s) to clone and update all repos

assumes JQ exists on the system 
install: brew install jq

assumes in environment:
* BB_KEY access token (password) is stored in BB_KEY
* BB_USER username
* BB_HOST bitbucket hostname


paging
#### 1st page: http://host:port/context/rest/api-name/api-version/path/to/resource?limit={desired size of page}
