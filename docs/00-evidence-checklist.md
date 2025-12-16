# Evidence Checklist (for report)

Take **screenshots** of CLI + confirm outputs.

## Networking / OS
- `ip a`
- `hostnamectl`
- `ping -c 3 192.168.56.11/12/13`
- `ssh -i <key> user@<ip>` (no password)

## Services (systemd)
- `systemctl status ssh`
- `systemctl status nginx`
- `systemctl status jenkins`
- `systemctl status prometheus`
- `systemctl status grafana-server`
- `systemctl status node_exporter`

## Ports
- `ss -tulpn` (or `netstat -tulpn`)
- `curl -I http://localhost` where relevant

## Security
- `ufw status verbose` (or firewalld equivalent)
- show only required ports open

## Docker
- `docker version`
- `docker ps`
- `docker images`

## CI/CD
- Jenkins job console output showing:
  - webhook triggered
  - build ok
  - deploy ok

## Monitoring
- Prometheus targets page shows UP for all exporters
- Grafana dashboard panels updating

## Troubleshooting chapter
Keep a list of:
- Error message (copy)
- Root cause
- Fix + command used
