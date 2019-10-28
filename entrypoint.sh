#!/bin/bash
export BUNDLE_PATH=./gems

bundle check || bundle install

bundle exec "$@"
