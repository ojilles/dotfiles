#! /bin/bash

REPOS="ojilles/data_hacks ojilles/dotfiles ojilles/hadoop-test ojilles/iPhoneTracker ojilles/jilles.net ojilles/Nordea-importer-for-Yunoo";

for repo in $REPOS;
do
   ~/bin/backup-github.com $repo;
done
