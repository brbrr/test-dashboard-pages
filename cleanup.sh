#!/bin/bash

date=$(date -v-20d +%d-%m-%Y)
echo $date
git ls-files | while read path
do
  echo checking $path $(git log -1 --format=" %ad" -- $path)
if [ "$(git log --since \"$date\" -- $path)" == "" ]
  then
    if [[ $path == "cleanup.sh" || $path == "static.json" ]]; then
        continue
    fi
    echo "removing $path"

    rm -rf $path
  fi
done
