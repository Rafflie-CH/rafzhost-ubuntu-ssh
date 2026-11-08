# ============================================================
# RafzHost — Lightweight Railway Ubuntu SSH
# Ultra-minimal Ubuntu 24.04 SSH server for Railway VPS
# Telegram: t.me/Rafzbotz | t.me/RafzHost
# ============================================================

FROM ubuntu:24.04

# Remove default ubuntu user so UID 1000 is free
RUN userdel -r ubuntu 2>/dev/null || true

# Minimal packages only — keep image light & deploy fast
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        openssh-server \
        ca-certificates \
        curl \
        wget \
        git \
        vim \
        nano \
        htop \
        tmux \
        net-tools \
        iputils-ping \
        locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /run/sshd \
    && chmod 755 /run/sshd \
    && ssh-keygen -A \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color

# Welcome banner
COPY rafz-welcome.sh /etc/profile.d/rafz-welcome.sh
RUN chmod +x /etc/profile.d/rafz-welcome.sh

# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 22

CMD ["/usr/local/bin/entrypoint.sh"]
