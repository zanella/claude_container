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

#RUN useradd -ms /bin/bash dev
USER node

# Claude Code itself
#RUN npm install -g @anthropic-ai/claude-code
RUN curl -fsSL https://claude.ai/install.sh | bash

RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# EOF

