# Hosted IPFS Gateway & HTTP Proxy

## Uses

- [**Kubo**](https://github.com/ipfs/kubo) - IPFS implementation in Go
- [**Deno**](https://deno.land/) JavaScript runtime

## Purpose

Overcome public IPFS gateway limitations, such as [429 Too Many Requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429), by hosting your own IPFS Gateway and HTTP Proxy.

![429 Example](https://github-production-user-asset-6210df.s3.amazonaws.com/23618431/261382276-f08af99b-fad0-4076-afbf-91d41b428147.png)

## Usage

```sh
git clone https://github.com/o-az/eyepfs.git
```

#### Install **`Deno`**

```sh
curl -fsSL https://deno.land/x/install/install.sh | sh
```

<sup> _**note**: if you're using `vscode`, replace `"deno.path"` in `.vscode/settings.json` with the path to your `deno` installation_</sup>

Other install options: <https://deno.land/manual/getting_started/installation#download-and-install>

#### Build **`Dockerfile`**

```sh
docker buildx build . \
  --progress 'plain' \
  --file 'Dockerfile' \
  --tag 'ipfs_gateway_proxy' \
  --platform 'linux/amd64'

# or `deno task docker:build`
```

#### Run the image you just built

```sh
docker run --rm \
  -it \
  --detach \
  --name 'ipfs_gateway_proxy' \
  --env IPFS_GATEWAY_HOST='http://127.0.0.1:8080' \
  --publish '3031:3031' \
  'ipfs_gateway_proxy' \
  --platform 'linux/amd64'

# or `deno task docker:run`
```

#### Run a quick test

<sup> _note: btw it may need a few seconds if it's your first time, no more than 6. So if request fail, just retry_</sup>

Open this in browser: <http://127.0.0.1:3031/bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi>

or run this:

```sh
curl --location --request GET \
  --url 'http://127.0.0.1:3031/bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi' \
  --output '/tmp/ipfs_proxy_image.jpeg' && \
  stat '/tmp/ipfs_proxy_image.jpeg'
```

## Deployment

anywhere that can run a **`Dockerfile`** 🐳

[**`Railway.app`**](https://railway.app/) happens to be one of the best option

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/PhPjgz?referralCode=eD4laT)

## Upcoming Features

- [ ] 🔨 (`CORS`) configuration,
- [ ] 🔨 Setup rate limiter,
- [ ] (`Kubo`) disable all methods but `GET` and `HEAD`,
- [ ] 🔨 (`Kubo`) set `Swarm#ConnMgr#Type` to `"none"` (disable all swarm connections),
- [ ] (`CI`) workflow publish image to Docker Hub & GitHub Container Registry,
- [ ] (`CI`) Generate a simple performance report on push,
- [ ] Got any ideas? [Let's chat](https://github.com/o-az/eyepfs/issues/new)

If an item has 🔨 it means it's configurable through env variables
