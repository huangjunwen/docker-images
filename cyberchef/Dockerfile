FROM nginx:1.17.8-alpine

ENV CYBER_CHEF_VERSION=9.21.0

ADD https://github.com/gchq/CyberChef/releases/download/v9.21.0/CyberChef_v${CYBER_CHEF_VERSION}.zip /usr/share/nginx/html

RUN cd /usr/share/nginx/html && \
      unzip CyberChef_v${CYBER_CHEF_VERSION}.zip && \
      ln -sf /usr/share/nginx/html/CyberChef_v9.21.0.html /usr/share/nginx/html/index.html && \
      rm CyberChef_v{CYBER_CHEF_VERSION}.zip
