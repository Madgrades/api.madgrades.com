FROM ruby:3.2-bookworm

RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 4.0.6

SHELL ["/bin/bash", "-c"]

WORKDIR /workspace
