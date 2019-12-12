FROM ubuntu:disco

RUN apt-get update && apt-get install -y \
      ca-certificates \
      vim-tiny \
      wget \
      mysql-server \
      redis-server \
      default-jre-headless && \
      supervisor && \
      cd /tmp && wget https://github.com/zendesk/maxwell/releases/download/v1.23.5/maxwell-1.23.5.tar.gz


