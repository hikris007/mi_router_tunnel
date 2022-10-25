#!/bin/sh

# Include the config script.
source ./config.sh

# Match specific ip not defined in ipset.
iptables -t mangle -I $chain_name -m set ! --match-set $ipset_name dst -j MARK --set-mark $mark_tag

# Citation chain "tunnel".
# All the packet from lan needs to handle in chain "tunnel" and the packet from local is also do the same.
iptables -t mangle -C PREROUTING -i br-lan -j $chain_name || iptables -t mangle -I PREROUTING -i br-lan -j $chain_name
iptables -t mangle -C OUTPUT -j $chain_name || iptables -t mangle -I OUTPUT -j $chain_name

# Allow packets forward between interface.
iptables -t filter -I OUTPUT -o $1 -j ACCEPT
iptables -t filter -I INPUT -i $1 -j ACCEPT
iptables -t filter -I FORWARD -i br-lan -o $1 -j ACCEPT
iptables -t filter -I FORWARD -i $1 -o br-lan -j ACCEPT

# Add route rule.
ip route add default dev $1 table $route_table
ip rule add fwmark $mark_tag table $route_table