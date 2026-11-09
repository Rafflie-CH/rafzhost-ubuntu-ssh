# ============================================================
# RafzHost — Lightweight Railway Ubuntu SSH
# Ultra-minimal Ubuntu 24.04 SSH server for Railway VPS
# Telegram: t.me/Rafzbotz | t.me/RafzHost
# ============================================================

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color

# Remove default ubuntu user so UID 1000 is free
RUN userdel -r ubuntu 2>/dev/null || true

# Enable universe + resilient apt (Railway network sometimes flakes)
RUN sed -i 's/^Components: .*/Components: main restricted universe multiverse/' /etc/apt/sources.list.d/ubuntu.sources 2>/dev/null || true \
    && printf 'Acquire::Retries "5";\nAcquire::http::Timeout "30";\nAcquire::https::Timeout "30";\n' > /etc/apt/apt.conf.d/80-retries

# Base packages (retry-friendly)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        gnupg \
        locales \
        openssh-server \
        sudo \
        git \
        vim \
        nano \
        net-tools \
        iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Extra tools (separate layer so base still builds if universe is flaky)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        htop \
        tmux \
        neofetch \
    || apt-get install -y --no-install-recommends htop tmux \
    || true \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# SSH config
RUN mkdir -p /run/sshd \
    && chmod 755 /run/sshd \
    && ssh-keygen -A \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && locale-gen en_US.UTF-8

# Node.js 26 LTS (NodeSource) + latest npm + pm2
RUN curl -fsSL https://deb.nodesource.com/setup_26.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g npm@latest pm2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && node -v && npm -v && pm2 -v

# Welcome banner + entrypoint
COPY rafz-welcome.sh /etc/profile.d/rafz-welcome.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /etc/profile.d/rafz-welcome.sh /usr/local/bin/entrypoint.sh

EXPOSE 22

CMD ["/usr/local/bin/entrypoint.sh"]
