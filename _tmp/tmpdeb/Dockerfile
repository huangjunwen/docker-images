FROM debian:buster-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      vim-tiny \
      wget \
      default-jre \
      default-mysql-server \
      redis-server && \
      cd /tmp && wget https://github.com/zendesk/maxwell/releases/download/v1.23.5/maxwell-1.23.5.tar.gz
