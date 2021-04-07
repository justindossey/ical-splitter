#!/bin/sh
set -e
bundle check >/dev/null 2>&1 || bundle install --path=vendor
bundle exec ruby split-calendar.rb "$@"
