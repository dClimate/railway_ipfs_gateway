# IPFS Kubo Docker Image

This repository provides a Docker setup to run [IPFS Kubo](https://github.com/ipfs/kubo) with custom configurations. The image is built on Ubuntu and includes pre-configured IPFS settings.

---

## Building and Running the Docker Image

```bash
docker build -t dclimate/ipfs-gateway .
docker run -d -p 8080:8080 dclimate/ipfs-gateway
```

### Environment Variables

-   `ALLOW_ORIGINS` (required): Specifies CORS origins as a JSON array. Example: "\*" or "[\"http://example.com\"]".

## License

This project is licensed under the MIT License.
