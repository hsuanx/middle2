#!/bin/sh
iptables -F
iptables -X
iptables -Z
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
# allow all from categories ALL, dev, git
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# allow all from categories loadbalancer
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
# allow all from categories loadbalancer
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
# allow loadbalancer, node from categories scribe
iptables -A INPUT -p tcp -s 210.65.11.137 --dport 1426 -j ACCEPT
# allow loadbalancer from categories mainpage
# allow loadbalancer, mainpage from categories private_memcache