#!/bin/sh
set -e

if [ -f /usr/src/app/tmp/pids/server.pid ]; then
  rm /usr/src/app/tmp/pids/server.pid
fi

bundle exec rails db:migrate

dockerize -wait tcp://db:5432 -timeout 60s "bundle exec $@"
