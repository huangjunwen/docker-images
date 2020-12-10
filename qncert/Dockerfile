FROM alpine:3.10

ENV QINIU_AUTO_CERT_VERSION=0.2.0

ADD run.sh /bin

RUN apk update && \
      apk add --no-cache ca-certificates tzdata && \
      cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
      echo "Asia/Shanghai" > /etc/timezone && \
      cd /tmp && \
      wget https://github.com/tuotoo/qiniu-auto-cert/releases/download/v${QINIU_AUTO_CERT_VERSION}/qiniu-auto-cert_${QINIU_AUTO_CERT_VERSION}_linux_amd64.gz && \
      gunzip qiniu-auto-cert_${QINIU_AUTO_CERT_VERSION}_linux_amd64.gz && \
      mv qiniu-auto-cert_${QINIU_AUTO_CERT_VERSION}_linux_amd64 qiniu-auto-cert && \
      chmod +x qiniu-auto-cert && \
      mv qiniu-auto-cert /bin && \
      rm -rf /tmp/*

CMD ["/bin/run.sh"]

