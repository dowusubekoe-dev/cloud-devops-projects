FROM ubuntu:22.04
RUN apt-get update && apt-get install -y iproute2 iputils-ping net-tools curl sudo
WORKDIR /root
COPY configs/branch2.routes /root/branch2.routes
COPY branch2/entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh
CMD ["/root/entrypoint.sh"]
