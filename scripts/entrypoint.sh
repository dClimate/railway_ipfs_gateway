#!/bin/sh

IPFS_GATEWAY_HOST="${IPFS_GATEWAY_HOST:-http://127.0.0.1:8080}"
ALLOW_ORIGINS="${ALLOW_ORIGINS:?ALLOW_ORIGINS is required}"

[ -z "${IPFS_GATEWAY_HOST}" ] && echo "IPFS_GATEWAY_HOST is required" && exit 1
[ -z "${ALLOW_ORIGINS}" ] && echo "ALLOW_ORIGINS is required" && exit 1

echo "Starting IPFS Gateway..."
ipfs init
ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

ipfs daemon &
sleep 5

echo "Connecting to dClimate's IPFS nodes..."
ipfs swarm connect "/ip4/15.235.14.184/udp/4001/quic-v1/p2p/12D3KooWHdZM98wcuyGorE184exFrPEJWv2btXWWSHLQaqwZXuPe"
ipfs swarm connect "/ip4/15.235.86.198/udp/4001/quic-v1/p2p/12D3KooWGX5HDDjbdiJL2QYf2f7Kjp1Bj6QAXR5vFvLQniTKwoBR"
ipfs swarm connect "/ip4/148.113.168.50/udp/4001/quic-v1/p2p/12D3KooWPwXW1tXzHoHgMofDwc9uzi7PLVHZt7QbLNt2v3pxzoEF"

echo "Connected to dClimate's IPFS nodes!"

ipfs config Swarm.ConnMgr.Type "none"
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"${ALLOW_ORIGINS}\"]"
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "[\"HEAD\", \"GET\", \"OPTIONS\"]"

echo "Current IPFS configuration:"
ipfs config show

echo "Starting go server..."
/app/proxy_app

tail -f /dev/null
