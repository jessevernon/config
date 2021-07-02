#!/bin/bash
git commit -q --allow-empty -m 'BUILD: staged'
git add --all
git commit -q --allow-empty -m 'BUILD: unstaged'
branch_name=$(git rev-parse --abbrev-ref HEAD)
temp_name='jvernon/build'
git push -q --no-verify -f origin $branch_name:$temp_name
git reset -q HEAD~1
git reset -q --soft HEAD~1
ssh jvernon@jvernon-desktop "cd c:\\git\\panopto-core\\ && git stash -q && git fetch -q origin $temp_name && git checkout -q origin/$temp_name && $1" &
pid=$!
wait $pid
