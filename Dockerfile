FROM alpine
RUN apk update && \
	apk add iptables
RUN apk add ppp-pppoe rp-pppoe
RUN apk add nano
# RUN apk add openvpn
# chmod 666 /dev/net/tun
COPY entry.sh /entry.sh
COPY pppoe/options /etc/ppp/options
RUN chmod u+x /entry.sh
CMD /entry.sh
