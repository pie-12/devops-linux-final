# Stage 1 — Infrastructure (VirtualBox NAT + Host-only)

This guide assumes **Ubuntu 20.04** on each VM (works similarly on 22.04).

## 1) VirtualBox network (on host machine)
1. VirtualBox → **File → Tools → Network Manager**
2. **Host-only Networks** → Create `vboxnet0`
   - IPv4: `192.168.56.1`
   - Mask: `255.255.255.0`
   - DHCP: OFF (recommended)

## 2) Create 3 VMs
For each VM:
- Adapter 1: NAT
- Adapter 2: Host-only (`vboxnet0`)

VMs:
- VM1 hostname: `jenkins` (IP `192.168.56.11`)
- VM2 hostname: `web`     (IP `192.168.56.12`)
- VM3 hostname: `monitor` (IP `192.168.56.13`)

## 3) Base packages (run on each VM)
```bash
sudo apt update && sudo apt -y upgrade
sudo apt -y install openssh-server curl wget git ufw
sudo systemctl enable --now ssh
```

## 4) Set hostname (each VM)
Example on VM1:
```bash
sudo hostnamectl set-hostname jenkins
sudo reboot
```

## 5) Set static IP for host-only (Netplan)
1) Find the host-only NIC name (often `enp0s8`):
```bash
ip a
```

2) Edit netplan file:
```bash
ls /etc/netplan
sudo nano /etc/netplan/01-netcfg.yaml
```

Example netplan (VM1: 192.168.56.11). **Replace `enp0s8` if needed.**
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s8:
      dhcp4: no
      addresses: [192.168.56.11/24]
```

Apply:
```bash
sudo netplan apply
ip a
```

Do similarly for VM2 (.12) and VM3 (.13).

## 6) /etc/hosts (recommended on all VMs)
```bash
sudo tee -a /etc/hosts >/dev/null << 'EOF'
192.168.56.11 jenkins
192.168.56.12 web
192.168.56.13 monitor
EOF
```

## 7) Ping test
```bash
ping -c 3 192.168.56.12
ping -c 3 192.168.56.13
```

## 8) SSH key (VM1 -> VM2 for deploy)
On VM1:
```bash
ssh-keygen -t ed25519 -C "jenkins-to-web"
ssh-copy-id -i ~/.ssh/id_ed25519.pub $USER@192.168.56.12
ssh $USER@192.168.56.12 'hostname && whoami'
```

## 9) Firewall baseline (UFW) — minimal required ports
**VM1 (jenkins):**
```bash
sudo ufw allow 22/tcp
sudo ufw allow 8080/tcp
sudo ufw --force enable
sudo ufw status verbose
```

**VM2 (web):**
```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw --force enable
sudo ufw status verbose
```

**VM3 (monitor):**
```bash
sudo ufw allow 22/tcp
sudo ufw allow 9090/tcp
sudo ufw --force enable
sudo ufw status verbose
```

> Grafana port 3000: keep closed for now; later we can proxy via Nginx on VM2.

## 10) Evidence to capture
- `ip a`, `hostnamectl`
- ping between VMs
- `systemctl status ssh`
- `ufw status verbose`
