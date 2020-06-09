#!/bin/bash

date=$(date -v-1m +%d-%m-%Y)
echo $date
git ls-files | while read path
do
  echo checking $path $(git log -1 --format=" %ad" -- $path)
if [[ $path == docs* ]]; then
        continue
    fi
if [ "$(git log --since \"$date\" -- $path)" == "" ]
  then
    if [[ $path == "cleanup.sh" || $path == "static.json" ]]; then
        continue
    fi
    echo "removing $path"

    rm -rf $path
  fi
done
