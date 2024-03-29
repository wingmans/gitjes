#!/bin/bash

# presumes the password is stored in BB_KEY and the username in BB_USER and BB_HOST=https://bitbucket...
# assumes jq exists on the system

 # 1st page: http://host:port/context/rest/api-name/api-version/path/to/resource?limit={desired size of page}

outfile=kloon.sh
echo generating $outfile...
echo "echo cloning all repositories from $BB_HOST that BB_USER has access to" > $outfile

echo "passed filename is $1"
[ -f "$1" ] && {
    projfile=$1
    echo "using $projfile"
} || {
    projfile=projects.json
    echo "using default $projfile"
}

[[ ! $(command -v jq) ]] && {
    echo "jq is not installed or not in the PATH."
    exit 1
}

echo "echo started > processed.log" >> $outfile
[ -f "$projfile" ] || {
    curl -s --user "$BB_USER:$BB_KEY" $BB_HOST/rest/api/1.0/projects?limit=100 |\
          jq -n '[inputs.values[] | {key: .key, id: .id  ,name: .name, href: .links.self[0].href}]' > "$projfile"
        }

        json_data=$(cat "$projfile")
        for row in $(echo "${json_data}" | jq -r '.[] | @base64'); do
            _jq() {
              echo ${row} | base64 --decode | jq -r ${1}
            }
            key=$(_jq '.key')

            echo "mkdir $key >/dev/null 2>&1" >> $outfile
            echo "(" >> $outfile
            echo "   echo $i >/dev/null"  >> $outfile      # prevents a syntax error in the generated script

             ## levert een of meerdere urls op
              curl -s --user "$BB_USER:$BB_KEY" $BB_HOST/rest/api/1.0/projects/$key/repos?limit=100 |\
                jq '.values[].links.clone[] | select(.name=="http") | .href' |\
                   while read -r href; do
                      echo "   git -C $key clone $href >> processed.log 2>&1" >> $outfile
                  done
            
            echo ")" >> $outfile
        done

echo "echo done... " >> $outfile
echo "done..." 
