# Conventions

## VM naming + IP plan (Host-only)
Subnet: `192.168.56.0/24`
- VM1: `jenkins` — `192.168.56.11`
- VM2: `web`     — `192.168.56.12`
- VM3: `monitor` — `192.168.56.13`

> Adapter 1: NAT (internet)  
> Adapter 2: Host-only (ping/ssh internal)

## Branching
- Default branch: `main`
- Feature work: `feat/<topic>` (optional)
- Infra changes: `infra/<topic>` (optional)

## Commit message
`<area>: <short message>`
Examples:
- `infra: set host-only static IPs`
- `jenkins: add pipeline build+deploy`
- `monitoring: add node_exporter targets`

## Evidence filenames
Put screenshots into `docs/evidence/` using:
`YYYYMMDD_<vm>_<topic>_<tool>.png`
Examples:
- `20251216_vm1_jenkins_install_systemctl.png`
- `20251216_vm2_nginx_proxy_curl.png`
