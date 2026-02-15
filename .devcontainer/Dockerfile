FROM ruby:3.0-bullseye

RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.3.26

SHELL ["/bin/bash", "-c"]

WORKDIR /workspace
