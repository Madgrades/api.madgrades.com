#!/bin/bash
rm tmp/pids/server.pid -rf
bundle exec rake assets:precompile
bundle exec rake seed:corrections
rails server
