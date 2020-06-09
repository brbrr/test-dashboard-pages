#!/bin/bash

date=$(date -v-1m +%d-%m-%Y)
echo $date
git ls-files | while read path
do
  if [ "$(git log --since \"$date\" -- $path)" == "" ]
  then
    if [[ $file == "cleanup.sh" || $file == "static.json" ]]; then
        continue
    fi
    echo "removing $path"

    rm -rf $path
  fi
done
