# Get elixir latest image from docker
FROM elixir:latest

# Set DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Set Node version
ENV NODE_VERSION=6.10.3

# Update package control
RUN apt-get update

# Get NodeJS
RUN curl -sSL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar xfJ - -C /usr/local --strip-components=1 && \
  npm install npm -g

# Install Hex
RUN mix local.hex --force

# Install Rebar
RUN mix local.rebar --force
