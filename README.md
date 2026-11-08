<p align="center">
  <h1 align="center">RafzHost · Lightweight Ubuntu SSH</h1>
</p>

<p align="center">
  <b>Ultra-light Ubuntu 24.04 SSH server for Railway</b><br/>
  Root access · Node.js 22 + PM2 · Fast deploy · Minimal image
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Railway-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Ubuntu-24.04-orange" alt="Ubuntu">
  <img src="https://img.shields.io/badge/SSH-OpenSSH-green" alt="SSH">
  <img src="https://img.shields.io/badge/Node.js-22.x-brightgreen" alt="Node">
  <img src="https://img.shields.io/badge/PM2-included-success" alt="PM2">
  <img src="https://img.shields.io/badge/license-MIT-blue" alt="License">
</p>

---

Super lightweight Docker image for **Railway** based on **Ubuntu 24.04** with SSH enabled.  
Clean root access + latest Node.js + PM2 ready out of the box.

## Features

- Ubuntu 24.04 base
- Root login enabled
- Mandatory `ROOT_PASSWORD` (container refuses to start if missing)
- Optional custom `HOSTNAME`
- Optional secondary sudo user (`SSH_USERNAME` + `SSH_PASSWORD`)
- Optional `AUTHORIZED_KEYS` for key login
- **Node.js 22.x** (latest LTS from NodeSource)
- **PM2** pre-installed globally
- **neofetch** included
- Clean welcome banner showing Node & PM2 version

## Quick Start (Railway)

### 1. Deploy
Deploy this repo on Railway (from GitHub).

### 2. Set Variables (WAJIB)
Buka tab **Variables** → klik **+ New Variable**:

| Name | Value | Wajib? |
|------|-------|--------|
| `ROOT_PASSWORD` | password kuat lu | **YA** |
| `HOSTNAME` | nama host bebas | tidak |
| `SSH_USERNAME` | user tambahan | tidak |
| `SSH_PASSWORD` | password user tambahan | tidak |
| `AUTHORIZED_KEYS` | public key SSH | tidak |

Tanpa `ROOT_PASSWORD` container **ga akan start**.

### 3. Buka TCP Proxy
Settings → **Networking** → **TCP Proxy** → port **22**

### 4. Connect

```bash
ssh root@<domain-railway-lu> -p <port>
```

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ROOT_PASSWORD` | **Yes** | Root password. Container refuses to start without it |
| `HOSTNAME` | No | Custom hostname |
| `SSH_USERNAME` | No | Secondary user name |
| `SSH_PASSWORD` | No | Password for secondary user |
| `AUTHORIZED_KEYS` | No | Public key(s) for root (key-based auth) |

## Included Tools

- `node` / `npm` (Node.js 22.x)
- `pm2` (process manager)
- `neofetch`
- `git`, `curl`, `wget`, `vim`, `nano`, `htop`, `tmux`, `sudo`

### Quick PM2 example

```bash
# after ssh in
npm init -y
# buat app.js atau bot lu
pm2 start app.js --name mybot
pm2 save
pm2 list
neofetch
```

## Notes

- Ini **container**, bukan VPS beneran. Data hilang kalau redeploy (kecuali pakai Volume).
- Ganti `ROOT_PASSWORD` setelah first login kalau perlu.
- Jangan share `ROOT_PASSWORD`.

## Links

- Main: [t.me/Rafzbotz](https://t.me/Rafzbotz)
- Channel: [t.me/RafzHost](https://t.me/RafzHost)

---

<p align="center">
  © RafzHost · Built for Railway
</p>
