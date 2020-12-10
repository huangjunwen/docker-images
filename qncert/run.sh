#!/bin/sh

if [ -z "$DOMAIN" ]; then
  echo "Missing \$DOMAIN"
  exit 1
fi

if [ -z "$EMAIL" ]; then
  echo "Missing \$EMAIL"
  exit 1
fi

if [ -z "$QINIU_ACCESSKEY" ]; then
  echo "Missing \$QINIU_ACCESSKEY"
  exit 1
fi

if [ -z "$QINIU_SECRETKEY" ]; then
  echo "Missing \$QINIU_SECRETKEY"
  exit 1
fi

if [ -z "$DNS_PROVIDER" ]; then
  echo "Missing \$DNS_PROVIDER"
  exit 1
fi

# TODO: dns provider's environments

/bin/qiniu-auto-cert ${DOMAIN} ${EMAIL}
