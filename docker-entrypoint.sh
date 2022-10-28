#!/bin/bash

set -e

if [ -f tmp/pids/server.pid ]; then
    rm -rf tmp/pids/server.pid
fi

bundle check || bundle install

exec "$@"
