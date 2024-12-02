# IPFS Kubo Docker Image

This repository provides a Docker setup to run [IPFS Kubo](https://github.com/ipfs/kubo) with custom configurations. The image is built on Ubuntu and includes pre-configured IPFS settings and a custom Go server (`proxy_app`).

## Features

-   **IPFS Configuration**:
    -   API address: `/ip4/0.0.0.0/tcp/5001`
    -   Gateway address: `/ip4/0.0.0.0/tcp/8080`
    -   Pre-configured CORS headers.
    -   Swarm connections to dClimate's IPFS nodes.
    -   Disabled connection manager for performance optimization.
-   **Custom Application**: Includes `proxy_app`, a Go server running alongside IPFS.
-   Lightweight and easy-to-extend Docker image.

---

## Getting Started

### Building and Running the Docker Image

Clone the repository and build the image:

```bash
docker build -t dclimate/ipfs-gateway .
```

```bash
docker run -d \
    -e ALLOW_ORIGINS="*" \
    -p 8080:8080 \
    dclimate/ipfs-gateway
```

### Environment Variables

-   `ALLOW_ORIGINS` (required): Specifies CORS origins as a JSON array. Example: "\*" or "[\"http://example.com\"]".

## License

This project is licensed under the MIT License.
