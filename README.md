<p align="center">
  <h1 align="center">RafzHost · Lightweight Ubuntu SSH</h1>
</p>

<p align="center">
  <b>Ultra-light Ubuntu 24.04 SSH server for Railway</b><br/>
  Root access · Fast deploy · Minimal image · Perfect simple VPS container
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Railway-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Ubuntu-24.04-orange" alt="Ubuntu">
  <img src="https://img.shields.io/badge/SSH-OpenSSH-green" alt="SSH">
  <img src="https://img.shields.io/badge/size-minimal-success" alt="Minimal">
  <img src="https://img.shields.io/badge/license-MIT-blue" alt="License">
</p>

<p align="center">
  <a href="https://railway.com/new/template"><img src="https://railway.com/button.svg" alt="Deploy on Railway"></a>
</p>

---

Super lightweight Docker image for **Railway** based on **Ubuntu 24.04** with SSH enabled.  
No bloat. No Claude. No heavy packages. Just clean root SSH access.

## Features

- Ubuntu 24.04 base
- Root login enabled
- Mandatory `ROOT_PASSWORD` (safe fail if missing)
- Optional custom `HOSTNAME`
- Optional secondary user (`SSH_USERNAME` + `SSH_PASSWORD`)
- Optional `AUTHORIZED_KEYS` for key login
- Tiny package set → fast build & deploy
- Clean welcome banner

## Quick Start (Railway)

1. Deploy this repo on Railway
2. Go to **Variables** and set:
   - `ROOT_PASSWORD` → your strong password (**required**)
3. Open **Settings → Networking** and add **TCP Proxy** on port `22`
4. Connect:

```bash
ssh root@<your-railway-domain> -p <port>
```

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `ROOT_PASSWORD` | **Yes** | Root password. Container refuses to start without it |
| `HOSTNAME` | No | Custom hostname |
| `SSH_USERNAME` | No | Secondary user name |
| `SSH_PASSWORD` | No | Password for secondary user |
| `AUTHORIZED_KEYS` | No | Public key(s) for root (key-based auth) |

## Example

```bash
# after deploy
ssh root@xxx.up.railway.app -p 12345
```

## Notes

- This is a **container**, not a real VPS. Data is lost on redeploy unless you attach a Volume.
- Change the root password after first login if needed.
- Keep `ROOT_PASSWORD` secret.

## Links

- Main account: [t.me/Rafzbotz](https://t.me/Rafzbotz)
- Channel: [t.me/RafzHost](https://t.me/RafzHost)

---

<p align="center">
  © RafzHost · Built for Railway
</p>
