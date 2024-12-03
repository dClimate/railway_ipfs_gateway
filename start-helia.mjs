import { createHelia } from "helia";
import { multiaddr } from "multiaddr";

const peers = [
    "/ip4/15.235.14.184/udp/4001/p2p/12D3KooWHdZM98wcuyGorE184exFrPEJWv2btXWSSHLQaqwZXuPe",
    "/ip4/15.235.86.198/udp/4001/p2p/12D3KooWGX5HDDjbdiJL2QYf2f7Kjp1Bj6QAXR5vFvLQniTKwoBR",
    "/ip4/148.113.168.50/udp/4001/p2p/12D3KooWPwXW1tXzHoHgMofDwc9uzi7PLVHZt7QbLNt2v3pxzoEF",
];

async function startHelia() {
    const helia = await createHelia();

    console.log("Helia Node started!");
    console.log("Peer ID:", helia.libp2p.peerId.toString());

    // Connect to specified peers
    for (const peerAddr of peers) {
        try {
            const ma = multiaddr(peerAddr);

            console.log(`Attempting to connect to ${peerAddr}`);

            // Extract PeerId from multiaddr
            const peerId = ma.getPeerId();

            // Attempt to dial the peer
            await helia.libp2p.dial(ma);

            console.log(`Connected to ${peerAddr}`);
        } catch (err) {
            console.error(`Failed to connect to ${peerAddr}:`, err);
        }
    }

    // Periodically log connected peers
    const peerInterval = setInterval(() => {
        const connectedPeers = helia.libp2p.getPeers();
        console.log(`Currently connected peers: ${connectedPeers.length}`);
        connectedPeers.forEach((peer) => {
            console.log(`- ${peer.toString()}`);
        });
    }, 5000);

    // Keep the process running
    process.on("SIGINT", async () => {
        console.log("Shutting down...");
        clearInterval(peerInterval);
        await helia.stop();
        process.exit(0);
    });

    return helia;
}

startHelia().catch((err) => {
    console.error("Error starting Helia:", err);
    process.exit(1);
});
