#!/bin/bash
git subtree pull --prefix _site/ origin master
bundle install
JEKYLL_ENV=production bundle exec jekyll build
git add .
git commit
git push
git subtree push --prefix _site/ origin master