FROM debian:10.2

RUN apt-get update && apt-get install -y \
      ca-certificates \
      vim-tiny \
      wget \
      default-mysql-server \
      redis-server \
      default-jre && \
      cd /tmp && wget https://github.com/zendesk/maxwell/releases/download/v1.23.5/maxwell-1.23.5.tar.gz


