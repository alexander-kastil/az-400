FROM ubuntu:latest

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive 

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install runtime dependencies (compatible with ubuntu:latest)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    sudo \
    jq \
    git \
    iputils-ping \
    libcurl4 \
    libicu-dev \
    libunwind8 \
    netcat-openbsd \
    xz-utils \
    libssl3 \
  && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
  && rm -rf /var/lib/apt/lists/*

ARG TARGETARCH=amd64
ARG AGENT_VERSION=4.266.2
ARG NODE_VERSION=22.14.0

WORKDIR /azp
RUN if [ "$TARGETARCH" = "amd64" ]; then ARCHIVE_ARCH=x64; else ARCHIVE_ARCH=$TARGETARCH; fi; \
    AZP_AGENTPACKAGE_URL=https://download.agent.dev.azure.com/agent/${AGENT_VERSION}/vsts-agent-linux-${ARCHIVE_ARCH}-${AGENT_VERSION}.tar.gz; \
    AZP_AGENTPACKAGE_URL_GH=https://github.com/microsoft/azure-pipelines-agent/releases/download/v${AGENT_VERSION}/vsts-agent-linux-${ARCHIVE_ARCH}-${AGENT_VERSION}.tar.gz; \
    echo "Downloading AZP agent from $AZP_AGENTPACKAGE_URL (fallback: $AZP_AGENTPACKAGE_URL_GH)"; \
    for i in 1 2 3 4 5; do \
      echo "Attempting primary URL (try $i)..."; \
      if curl -fsS --retry 3 --retry-connrefused --retry-delay 5 -o agent.tar.gz "$AZP_AGENTPACKAGE_URL"; then \
        tar -xzf agent.tar.gz && rm agent.tar.gz && break; \
      fi; \
      echo "Primary failed, attempting GitHub fallback (try $i)..."; \
      if curl -fsS --retry 3 --retry-connrefused --retry-delay 5 -o agent.tar.gz "$AZP_AGENTPACKAGE_URL_GH"; then \
        tar -xzf agent.tar.gz && rm agent.tar.gz && break; \
      fi; \
      echo "Attempt $i failed, retrying..." && sleep 5; \
    done; \
    if [ ! -d ./bin ]; then echo "Failed to download and extract AZP agent from primary and fallback locations" >&2; exit 1; fi

COPY ./start.sh .
COPY installers /installers

# Normalize line endings on installer scripts (fixes CRLF issues from Windows mounts)
RUN sed -i 's/\r$//' /installers/*.sh

# Make installer scripts executable
RUN chmod +x /installers/nodetools.sh /installers/netcore.sh

# Ensure npm global packages install to /usr/local
ENV NPM_CONFIG_PREFIX=/usr/local

# Install Node 22.12.0 exactly (tarball) and verify
RUN curl -fsSLO https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz \
  && tar -xJf node-v${NODE_VERSION}-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-v${NODE_VERSION}-linux-x64.tar.xz \
  && node -v

# Install global npm tools (Angular CLI pinned in /installers/nodetools.sh)
RUN bash /installers/nodetools.sh

# Install .NET SDK 10 (installer script will add MS package repository)
RUN bash /installers/netcore.sh

RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]