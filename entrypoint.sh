#!/bin/bash
# ============================================================
# RafzHost — SSH Entrypoint
# Telegram: t.me/Rafzbotz | t.me/RafzHost
# ============================================================

set -e

# ---------- ROOT PASSWORD (REQUIRED) ----------
if [ -z "${ROOT_PASSWORD}" ]; then
    echo "==========================================" >&2
    echo "Error: ROOT_PASSWORD is required!" >&2
    echo "Go to Railway → Variables → + New Variable" >&2
    echo "Name: ROOT_PASSWORD" >&2
    echo "Value: your-strong-password" >&2
    echo "Then redeploy." >&2
    echo "==========================================" >&2
    exit 1
fi
echo "root:${ROOT_PASSWORD}" | chpasswd
echo "[RafzHost] root password set"

# ---------- HOSTNAME (OPTIONAL) ----------
if [ -n "${HOSTNAME}" ]; then
    echo "${HOSTNAME}" > /etc/hostname
    hostname "${HOSTNAME}" 2>/dev/null || true
    echo "[RafzHost] hostname set to ${HOSTNAME}"
fi

# ---------- OPTIONAL SECONDARY USER ----------
if [ -n "${SSH_USERNAME}" ] && [ -n "${SSH_PASSWORD}" ]; then
    if id "${SSH_USERNAME}" &>/dev/null; then
        echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
        echo "[RafzHost] user ${SSH_USERNAME} password updated"
    else
        useradd -m -s /bin/bash "${SSH_USERNAME}"
        echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
        usermod -aG sudo "${SSH_USERNAME}" 2>/dev/null || true
        echo "${SSH_USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${SSH_USERNAME}
        chmod 440 /etc/sudoers.d/${SSH_USERNAME}
        echo "[RafzHost] user ${SSH_USERNAME} created with sudo"
    fi
fi

# ---------- AUTHORIZED KEYS (OPTIONAL) ----------
if [ -n "${AUTHORIZED_KEYS}" ]; then
    mkdir -p /root/.ssh
    echo "${AUTHORIZED_KEYS}" > /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys
    echo "[RafzHost] authorized_keys installed for root"
fi

# ---------- START SSHD ----------
echo "[RafzHost] starting SSH server on port 22..."
ssh-keygen -A 2>/dev/null || true
exec /usr/sbin/sshd -D -e
