#!/bin/sh

echo "\033[35mStart SSH Agent, add key and run Git Pull\033[0m"
ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/git_id_rsa
git pull origin master
echo "\033[35mAll is Done!\033[0m"

