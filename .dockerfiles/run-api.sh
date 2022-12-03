#!/bin/bash
rm tmp/pids/server.pid -rf
bundle exec rake assets:precompile
rails server