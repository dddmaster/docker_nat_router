#!/bin/ash
res=$(ip link add dummy0 type dummy 2>&1)
res=$(echo $res | grep "Operation not permitted" )

if [[ "$res" == "" ]]; then
        echo "PRIVILEGED"
else
        echo "NOT PRIVILEGED"
fi


#iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE --random
#iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
#iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -j DROP
