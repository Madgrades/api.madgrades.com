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

# Upgrade RubyGems to avoid version warnings
gem update --system 3.2.3

gem install bundler -v 4.0.6
bundle install
