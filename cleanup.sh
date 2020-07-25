#!/bin/bash

date=$(date -v-20d +%Y-%m-%d)
echo $date
# git ls-files -- . ':!:docs*' | while read file
git ls-tree --name-only master | while read file
do
  if [[ $file == "cleanup.sh" || $file == "static.json" ]]; then
    continue
  fi
  echo checking $file $(git log -1 --format=" %ad" -- $file)
  if [ "$(git log --since \"$date\" -- $file)" == "" ]; then
    echo "removing $file"
    rm -rf $file
  fi
done
