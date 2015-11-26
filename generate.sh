#! /usr/bin/env bash

set -e

rails new $@ \
  -m ./template.rb \
  --skip-keeps \
  --skip-spring \
  --database=postgresql \
  --javascript=angularjs \
  --skip-turbolinks \
  --skip-test-unit \
  --force \
