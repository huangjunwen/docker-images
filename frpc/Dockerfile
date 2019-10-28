FROM alpine:3.10

ENV FRP_VERSION=0.29.0

RUN apk update && \
      apk add --no-cache ca-certificates tzdata && \
      cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
      echo "Asia/Shanghai" > /etc/timezone && \
      cd /tmp && \
      wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
      tar xfz frp_${FRP_VERSION}_linux_amd64.tar.gz && \
      mv frp_${FRP_VERSION}_linux_amd64/frpc /bin && \
      mkdir -p /conf && \
      mv frp_${FRP_VERSION}_linux_amd64/frpc_full.ini /conf/frpc.ini.example && \
      rm -rf frp_${FRP_VERSION}_linux_amd64*

CMD ["/bin/frpc", "-c", "/conf/frpc.ini"]

