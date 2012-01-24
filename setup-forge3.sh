#!/bin/bash
PROJECT=$1
CURDIR=`pwd`

# clone forge3 to the new project
cd $CURDIR
git clone git@github.com:factore/forge3.git $PROJECT
cd $PROJECT
rm -rf .git
echo "...copied forge 3"

# initialize git repo and commit forge3 dump
git init
git add .
git commit -m 'forge 3 dump'
git remote add origin git@github.com:factore/$PROJECT.git
git push origin master
echo "...first commit to $PROJECT"

# make missing log directory
mkdir log

# bundle gems
bundle install --path vendor --without linux
echo "...bundled gems to vendor"

# create database and do all kinds of rake magics
bundle exec rake forge:setup_database USERNAME=root PASSWORD=root
mkdir "_build"
echo "...forge 3 is set up!"
echo "...start doing stuff"