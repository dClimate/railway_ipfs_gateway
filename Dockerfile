# Base image with Node.js
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    gnupg \
    iproute2 \
    jq \
    tar \
    nodejs \
    npm && \
    apt-get clean

# Install the necessary npm dependencies
COPY package.json /app/package.json
WORKDIR /app
RUN npm install

# Expose IPFS API and Gateway ports
EXPOSE 8080

# Copy the minimal script to run Helia
COPY start-helia.mjs /app/start-helia.mjs

# Run the Helia script
CMD ["node", "/app/start-helia.mjs"]
