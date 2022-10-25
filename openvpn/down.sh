#!/bin/sh

# Include the config script.
source ./config.sh

# Clear route rules.
ip rule delete fwmark $mark_tag table $route_table
ip route delete default dev $1 table $route_table

# Clear iptables rules.
iptables -t filter -D FORWARD -i br-lan -o $1 -j ACCEPT
iptables -t filter -D OUTPUT -o $1 -j ACCEPT
iptables -t filter -D FORWARD -i $1 -o br-lan -j ACCEPT
iptables -t filter -D INPUT -i $1 -j ACCEPT

iptables -t mangle -D OUTPUT -j $chain_name
iptables -t mangle -D PREROUTING -i br-lan -j $chain_name

iptables -t mangle -F $chain_name
iptables -t mangle -X $chain_name