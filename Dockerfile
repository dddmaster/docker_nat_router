FROM alpine
RUN apk add iptables
COPY entry.sh /entry.sh
RUN chmod u+x /entry.sh
CMD /entry.sh
