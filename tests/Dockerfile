# docker build . --tag test:latest --tag test:{{short}}
FROM debian:bookworm

# based on https://gist.github.com/remarkablemark/aacf14c29b3f01d6900d13137b21db3a
# and on comments from this gist

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=22.14.0

# install nvm
# https://github.com/creationix/nvm#install-script
RUN mkdir -p "$NVM_DIR";
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /app
