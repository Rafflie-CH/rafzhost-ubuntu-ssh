#!/bin/bash
# ============================================================
# RafzHost — SSH Entrypoint
# Telegram: t.me/Rafzbotz | t.me/RafzHost
# ============================================================

set -e

# ---------- ROOT PASSWORD (REQUIRED) ----------
if [ -z "${ROOT_PASSWORD}" ]; then
    echo "Error: ROOT_PASSWORD is required. Set it in Railway Variables." >&2
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
    else
        useradd -m -s /bin/bash -G sudo "${SSH_USERNAME}" 2>/dev/null || \
        useradd -m -s /bin/bash "${SSH_USERNAME}"
        echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
        # give sudo without password for convenience in container
        echo "${SSH_USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${SSH_USERNAME}
        chmod 440 /etc/sudoers.d/${SSH_USERNAME}
    fi
    echo "[RafzHost] user ${SSH_USERNAME} ready"
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
echo "[RafzHost] starting SSH server..."
ssh-keygen -A 2>/dev/null || true
exec /usr/sbin/sshd -D -e
