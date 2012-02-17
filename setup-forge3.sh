#!/bin/bash
PROJECT=$1
GITHUB_USERNAME=
GITHUB_PASSWORD=
GITHUB_COLLABORATORS=(  )
MYSQL_USERNAME=
MYSQL_PASSWORD=
# put path to socket in "" if needed, leave blank otherwise
MYSQL_SOCKET=

# create github repo
curl -s -u "$GITHUB_USERNAME:$GITHUB_PASSWORD" -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d "{\"name\":\"$PROJECT\", \"private\":true}" https://api.github.com/user/repos
# add users to repo
for COLLABORATOR in "${GITHUB_COLLABORATORS[@]}"
do
  curl -s -u "$GITHUB_USERNAME:$GITHUB_PASSWORD" -d "ignore=1" -X PUT https://api.github.com/repos/$GITHUB_USERNAME/$PROJECT/collaborators/$COLLABORATOR
done
echo "...created github repo and added your partners in crime"

# clone forge3 to the new project
git clone git@github.com:factore/forge3.git $PROJECT
cd $PROJECT
echo "...copied forge 3"

# initialize git repo and commit forge3 dump
rm -rf .git
git init
git add .
git commit -m 'Init commit'
git remote add origin git@github.com:factore/$PROJECT.git
git push origin master
echo "...first commit to $PROJECT"

# make missing log directory
mkdir log

# bundle gems
bundle install --path vendor --without linux
echo "...bundled gems to vendor"

# create database and do all kinds of rake magics
bundle exec rake forge:setup_database USERNAME=$MYSQL_USERNAME PASSWORD=$MYSQL_PASSWORD SOCKET=$MYSQL_SOCKET
bundle exec rake forge:load_help
echo "...forge 3 is set up"

# custom stuff
# mkdir _build

echo "...go and make something beautiful!"
echo "...bundle exec rails server"
echo "...bundle exec guard"
