#!/bin/sh

IPFS_GATEWAY_HOST="${IPFS_GATEWAY_HOST:-http://127.0.0.1:8080}"
ALLOW_ORIGINS="${ALLOW_ORIGINS:?ALLOW_ORIGINS is required}"

[ -z "${IPFS_GATEWAY_HOST}" ] && echo "IPFS_GATEWAY_HOST is required" && exit 1
[ -z "${ALLOW_ORIGINS}" ] && echo "ALLOW_ORIGINS is required" && exit 1

echo "Starting IPFS Gateway..."
ipfs init
ipfs daemon &
sleep 5

echo "Connecting to dClimate's IPFS nodes..."
ipfs swarm connect "/ip4/15.235.14.184/tcp/4001/p2p/12D3KooWT32PiwLWNhC5nRmhqiJTTJycopo3bxYpCSLr6TCHSn1Q"
ipfs swarm connect "/ip4/15.235.86.198/tcp/4001/p2p/12D3KooWCKaGcTgY23i2frcH4ZiNF5tcAZ33u4ZNruhkrtpPhd6L"
ipfs swarm connect "/ip4/148.113.168.50/tcp/4001/p2p/12D3KooWGi5NzUFEsg6gwLwzX2Kvg9QZ88ug1J8sJr6nVhqBC64b"

echo "Connected to dClimate's IPFS nodes!"

ipfs config Swarm.ConnMgr.Type "none"
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"${ALLOW_ORIGINS}\"]"
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "[\"HEAD\", \"GET\", \"OPTIONS\"]"

echo "Current IPFS configuration:"
ipfs config show

echo "Starting go server..."
/app/proxy_app

tail -f /dev/null
