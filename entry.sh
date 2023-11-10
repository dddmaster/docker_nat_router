#!/bin/ash
res=$(ip link add dummy0 type dummy 2>&1)
res=$(echo $res | grep "Operation not permitted" )


if [[ "$res" == "" ]]; then
	res=$(ip link delete dummy0 2>&1)
else
        echo "NOT PRIVILEGED"
	exit
fi

run_pppoe() {
	if [[ "$PPPOE_USER" == "" ]]; then
		echo "missing env PPPOE_USER"
		exit
	fi

	if [[ "$PPPOE_PASS" == "" ]]; then
		echo "missing env PPPOE_PASS"
		exit
	fi

	if [[ "$PPPOE_IFACE" == "" ]]; then
		echo "missing env PPPOE_IFACE"
		exit
	fi

	mkdir -p /run/ppp
	modprobe pppoe

	echo "$PPPOE_USER * $PPPOE_PASS * " > /etc/ppp/chap-secrets
	echo "user $PPPOE_USER" > /etc/ppp/peers/example
	echo "plugin pppoe.so $PPPOE_IFACE" >> /etc/ppp/options

	pon example &

	ip route del default
	ip route add default dev pppoe-wan

	tail -f /var/log/ppp/ppp.log	
}

run_iptables_and_route() {
	modprobe ip_tables
	modprobe ip_conntrack
	modprobe ip_conntrack_irc
	modprobe ip_conntrack_ftp

	iptabes -a INPUT -i $IFACE_OUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	iptables -t nat -A POSTROUTING -o $IFACE_OUT -j MASUQERADE
	iptables -I FORWARD -i $IFACE_IN -j ACCEPT

	iptables -A OUTPUT -j ACCEPT
	iptables -P FORWARD ACCEPT
}

run_vpn() {
	
}


tail -f /dev/null
