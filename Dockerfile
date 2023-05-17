FROM alpine
RUN apk update
RUN apk add iptables
RUN apk add openvpn
# chmod 666 /dev/net/tun
COPY entry.sh /entry.sh
RUN chmod u+x /entry.sh
CMD /entry.sh
