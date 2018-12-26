#!/usr/bin/env bash

set -x

sudo ip netns add tor
for IFACE in $(ls -1 /sys/class/net | grep ^e); do
    sudo ip link set dev $IFACE netns tor
    sudo ip netns exec tor macchanger -A $IFACE
done
sudo ip netns exec tor ip link add tor0 type veth peer name tor0 netns 1
sudo ip addr add 10.0.0.1/24 dev tor0
sudo ip netns exec tor ip addr add 10.0.0.2/24 dev tor0
sudo ip link set tor0 up
sudo ip netns exec tor ip link set tor0 up
sudo ip netns exec tor ip link set lo up
sudo ip route add default via 10.0.0.2
sudo ip netns exec tor iptables -F
sudo ip netns exec tor iptables -t nat -F
sudo ip netns exec tor iptables -t nat -A PREROUTING -i tor0 -p udp --dport 53 -j REDIRECT --to-ports 53
sudo ip netns exec tor iptables -t nat -A PREROUTING -i tor0 -p tcp --syn -j REDIRECT --to-ports 9040
sudo sysctl -w net.ipv4.conf.all.forwarding=1
sudo bash -c 'cat << EOF > /etc/dhcp/dhclient.conf
supersede domain-name-servers 10.0.0.2;
EOF'
sudo bash -c 'cat << EOF > /etc/resolv.conf
nameserver 10.0.0.2
EOF'
sudo bash -c 'cat << EOF > /etc/tor/torrc
RunAsDaemon 1
VirtualAddrNetwork 10.192.0.0/10
AutomapHostsOnResolve 1
TransPort 10.0.0.2:9040
DNSPort 10.0.0.2:53
SocksPort 10.0.0.2:9050
ControlPort 127.0.0.1:9051
EOF'
sudo ip netns exec tor tor
sudo ip netns exec tor dhclient
