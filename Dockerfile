# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    gnupg \
    iproute2 \
    jq \
    tar && \
    apt-get clean

# Install IPFS Kubo
RUN wget https://dist.ipfs.tech/kubo/v0.32.1/kubo_v0.32.1_linux-amd64.tar.gz && \
    tar -xvzf kubo_v0.32.1_linux-amd64.tar.gz && \
    mv kubo/ipfs /usr/local/bin/ipfs && \
    rm -rf kubo kubo_v0.32.1_linux-amd64.tar.gz

# Add entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose IPFS API and Gateway ports
EXPOSE 8080

# Entry point
ENTRYPOINT ["/app/entrypoint.sh"]
