#!/bin/sh

echo "delete default rules"
iptables -F
ip6tables -F
echo "allow outgoing traffic"
iptables -P OUTPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
echo "allow loopback interface"
iptables -A INPUT -i lo -j ACCEPT
ip6tables -A INPUT -i lo -j ACCEPT
echo "allow established connections"
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
echo "allow ssh (port 22 tcp)"
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
echo "allow mumble (port 64738 tcp & udp)"
iptables -A INPUT -p tcp --dport 64738 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 64738 -j ACCEPT
iptables -A INPUT -p udp --dport 64738 -j ACCEPT
ip6tables -A INPUT -p udp --dport 64738 -j ACCEPT
echo "add simple DDoS protection"
iptables -A INPUT -m limit --limit 5/s --limit-burst 50 -j ACCEPT
ip6tables -A INPUT -m limit --limit 5/s --limit-burst 50 -j ACCEPT
iptables -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 2 -j DROP
ip6tables -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 2 -j DROP
echo "drop other incoming traffic and forwarding"
iptables -P INPUT DROP
ip6tables -P INPUT DROP
iptables -P FORWARD DROP
ip6tables -P FORWARD DROP
echo "finished"
