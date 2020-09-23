#!/bin/bash
for branch in $(git branch --format='%(refname:short)'); do 
    if [ $branch != "master" ]
        then
        echo -e "\n\n"
        echo "Merging... into: $branch";
        git checkout $branch
        git pull
        git merge master -m"Merger master"
    fi
done
git checkout master