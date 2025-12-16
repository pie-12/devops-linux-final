# Configure and Deploy DevOps Services in Linux

This repo is the **final project workspace** for our Linux/DevOps group.

## Target Architecture (3 VMs)
- **VM1 (jenkins)**: Jenkins CI/CD (port 8080) + Docker build/push
- **VM2 (web)**: Nginx reverse proxy (port 80) + App container
- **VM3 (monitor)**: Prometheus (port 9090) + Grafana (proxied via VM2)

## Repo Structure
- `app/` — demo web app + Dockerfile
- `jenkins/` — Jenkinsfile + build/deploy scripts
- `infra/` — nginx configs, firewall notes, backup scripts
- `monitoring/` — Prometheus/Grafana configs, alert rules, dashboards
- `docs/` — report-ready notes + evidence checklist
- `docs/evidence/` — screenshots and command outputs

## Quick Start (workflow)
1. Infra: bring up 3 VMs + host-only network (`docs/01-stage1-infra.md`)
2. App manual run on VM2
3. Jenkins automation on VM1
4. Monitoring on VM3
5. Collect evidence + write report/slide

## Evidence (screenshots + command logs)
See `docs/00-evidence-checklist.md` and `scripts/capture_evidence.sh`.
