#!/bin/sh
iptables -F
iptables -X
iptables -Z
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
# allow dev from categories ALL
iptables -A INPUT -p tcp -s 210.65.10.110 --dport 22 -j ACCEPT
# allow loadbalancer, mainpage, node from categories mysql
iptables -A INPUT -p tcp -s 210.65.10.110 --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -s 210.65.11.137 --dport 3306 -j ACCEPT
# allow all from categories pgsql
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
# allow node, mainpage from categories elastic_search
iptables -A INPUT -p tcp -s 210.65.11.137 --dport 9200 -j ACCEPT
iptables -A INPUT -p tcp -s 210.65.10.110 --dport 9200 -j ACCEPT
sleep 30
iptables -F
iptables -X
iptables -Z
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT