# Ansible Role: socks

## Description

Install and configure an SSH Socks Proxy using ansible.

## Requirements

- Ansible >= 2.5 (It might work on previous versions, but we cannot guarantee it)

## Role Variables

All variables which can be overridden are stored in [defaults/main.yml](defaults/main.yml) file as well as in table below.

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `socks_loglevel` | DEBUG1 | Socks Log Level |
| `socks_serveraliveinterval` | 60 | Socks server alive interval |
| `socks_serveralivecountmax` | 3 | Socks server alive count max |
| `socks_port` | 1080 | Socks port |
| `socks_system_user` | ssh-tunnel | Socks local user |
| `socks_system_group` | ssh-tunnel | Socks loval group |
| `socks_src_ip` | [] | Socks IPtables allowed ip-addresses |
| `socks_end` | 1 | Socks last +1 allowed ip-addresses for deny all other |
| `socks_caddy_generate_html_output` | false | Caddy generate config as html (require: ansible-role-caddyserver) |
| `socks_caddy_webserver_path` | /var/www/ | Caddy html output path with socks.html (require: ansible-role-caddyserver) |
| `socks_caddy_user` | caddy | Caddy user (require: ansible-role-caddyserver) |
| `socks_caddy_group` | caddy | Caddy group (require: ansible-role-caddyserver) |


## Example in Group Vars

```yaml
---
# playbooks/infra_client.yml
socks_src_ip:
  - ip: 192.168.1.30
    name: "Client 1"
    id: 1
  - ip: 192.168.1.31
    name: "Client 2"
    id: 2
  - ip: 192.168.1.32
    name: "Client 3"
    id: 3
socks_end: 4
```

### Playbook

```yaml
---
- hosts: all
  roles:
  - ansible-role-socks
```

## Contributing

See [contributor guideline](CONTRIBUTING.md).

## License

This project is licensed under MIT License. See [LICENSE](/LICENSE) for more details.
