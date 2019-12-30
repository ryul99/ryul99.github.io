#!/bin/bash
bundle install
JEKYLL_ENV=production bundle exec jekyll build
git subtree push --prefix _site/ origin master