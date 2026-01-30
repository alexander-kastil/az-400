#!/usr/bin/env bash

# Fix CRLF issues when run from Windows-mounted filesystems (WSL/Docker contexts)
sed -i 's/\r$//' "$0" || true

# Ensure npm global installs to /usr/local when run as non-root or under different npm config
export NPM_CONFIG_PREFIX=/usr/local

npm install -g typescript@^5.3.3 @rushstack/heft yo
npm install -g @microsoft/generator-sharepoint@next
npm install -g @angular/cli@21.1
npm install -g @pnp/cli-microsoft365

