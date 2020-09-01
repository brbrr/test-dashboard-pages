#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    date=$(date -v-20d +%Y-%m-%d)       
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    date=$(date --date="20 days ago" +%Y-%m-%d)
fi

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
