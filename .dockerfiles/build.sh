#!/bin/bash
# Install dependencies.
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
  build-essential \
  ruby-full \
  default-libmysqlclient-dev \
  tzdata \
  nodejs
gem install bundler
bundle install