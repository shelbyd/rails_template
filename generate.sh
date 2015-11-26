#! /usr/bin/env bash

set -e


export SCAFFOLD_DIRECTORY=$(pwd)/scaffold

rails new $@ \
  -m ./template.rb \
  --skip-keeps \
  --skip-spring \
  --database=postgresql \
  --javascript=angularjs \
  --skip-turbolinks \
  --skip-test-unit \
  --force \
