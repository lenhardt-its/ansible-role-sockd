#!/bin/bash
{{ ansible_managed | comment }}
if [[ $1 = "start" ]]
then
{% if socks_src_ip | length > 0 %}
{%   for address in socks_src_ip %}
{{ address.name | comment }}
/usr/sbin/iptables -I INPUT {{ address.id }} -p tcp -s {{ address.ip }} --dport 1080 -j ACCEPT
{%   endfor %}
/usr/sbin/iptables -I INPUT {{ socks_end }} -p tcp --dport 1080 -j REJECT
{% endif %}
fi

if [[ $1 = "stop" ]]
then
{% if socks_src_ip | length > 0 %}
/usr/sbin/iptables -D INPUT {{ socks_end }}
{%   for address in socks_src_ip |reverse %}
{{ address.name | comment }}
/usr/sbin/iptables -D INPUT {{ address.id }}
{%   endfor %}
{% endif %}
fi

if [[ $1 = "restart" ]]
then
{% if socks_src_ip | length > 0 %}
/usr/sbin/iptables -D INPUT {{ socks_end }}
{%   for address in socks_src_ip |reverse %}
{{ address.name | comment }}
/usr/sbin/iptables -D INPUT {{ address.id }}
{%   endfor %}
{% endif %}
{% if socks_src_ip | length > 0 %}
{%   for address in socks_src_ip %}
{{ address.name | comment }}
/usr/sbin/iptables -I INPUT {{ address.id }} -p tcp -s {{ address.ip }} --dport 1080 -j ACCEPT
{%   endfor %}
/usr/sbin/iptables -I INPUT {{ socks_end }} -p tcp --dport 1080 -j REJECT
{% endif %}
fi
