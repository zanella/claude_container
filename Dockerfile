FROM node:lts-slim

# Core utilities
RUN apt-get update && apt-get install -y \
    bash curl wget git jq tree unzip zip tar \
    openssh-client ca-certificates gnupg sudo vim \
    build-essential procps findutils diffutils libicu-dev

# Python
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv

# Java 21
RUN apt-get install -y extrepo
RUN extrepo enable zulu-openjdk
RUN apt-get update
RUN apt-get install -y zulu21-jdk

### Docker
RUN apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)
# Add Docker's official GPG key:
RUN apt update
RUN apt install -y ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

RUN apt update
RUN apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#RUN useradd -ms /bin/bash dev
USER node

### set up secrets
COPY --chmod=755 secrets.sh /home/node/secrets.sh
COPY .env /home/node/.env
RUN /home/node/secrets.sh

# Claude Code itself
#RUN npm install -g @anthropic-ai/claude-code
RUN curl -fsSL https://claude.ai/install.sh | bash

RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# EOF

