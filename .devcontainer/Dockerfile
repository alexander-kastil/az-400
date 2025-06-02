FROM mcr.microsoft.com/devcontainers/dotnet:9.0

# Install Node.js 20.12.2
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && node --version \
    && npm --version

# Install Angular CLI 19
RUN npm install -g @angular/cli@19

# Install Python 3.11 and development tools
RUN apt-get update \
    && apt-get install -y \
        wget \
        build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libgdbm-dev \
        libnss3-dev \
        libssl-dev \
        libreadline-dev \
        libffi-dev \
        libsqlite3-dev \
        libbz2-dev \
        liblzma-dev \
        python3-pip \
        software-properties-common \
    && cd /tmp \
    && wget https://www.python.org/ftp/python/3.11.7/Python-3.11.7.tgz \
    && tar -xzf Python-3.11.7.tgz \
    && cd Python-3.11.7 \
    && ./configure --enable-optimizations --with-ensurepip=install \
    && make -j$(nproc) \
    && make altinstall \
    && cd / \
    && rm -rf /tmp/Python-3.11.7* \
    && update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.11 1 \
    && update-alternatives --install /usr/bin/python python /usr/local/bin/python3.11 1 \
    && ln -sf /usr/local/bin/python3.11 /usr/bin/python3.11 \
    && python3 --version \
    && pip3 install --upgrade pip

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install Azure Developer CLI (azd)
RUN curl -fsSL https://aka.ms/install-azd.sh | bash

# Install Azure Functions Core Tools v4
RUN npm install -g azure-functions-core-tools@4 --unsafe-perm true

# Install SQLite
RUN apt-get update \
    && apt-get install -y sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Set timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone