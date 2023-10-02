FROM alpine:3

RUN apk update && apk upgrade && \
    apk add --no-cache python3 py3-pip git \
    ca-certificates iptables iproute2 bash openssh curl jq

RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
COPY sshd_config /etc/ssh/

ADD run_sshd.sh /usr/local/bin
EXPOSE 22
CMD ["/usr/local/bin/run_sshd.sh"]
