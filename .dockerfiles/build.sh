#!/bin/bash
# Install dependencies.
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y \
  build-essential \
  default-libmysqlclient-dev \
  tzdata \
  nodejs

# Install bundler
gem install bundler -v 4.0.6
bundle install
