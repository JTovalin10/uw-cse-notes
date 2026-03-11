import os, re

# A map of (file_path, old_string) -> new_string
# This will safely replace the exact wrong placeholders/images with the right ones.

fixes = [
    # Transport Layer
    ("CSE461/Transport/Network-Side Congestion Control.md", "[Image: Feedback signals loop between sender, router queue, and receiver]", "![[Screenshots/Feedback signals.png]]"),
    ("CSE461/Transport/Network-Side Congestion Control.md", "[Image: Packet marking and signaling flow in an ECN-enabled network]", "![[Screenshots/ECN.png]]"),
    ("CSE461/Transport/Network-Side Congestion Control.md", "[Image: Graph comparing queue occupancy and drop probability for Tail Drop vs. RED]", "![[Screenshots/Congestion Performance.png]]"),
    
    ("CSE461/Transport/Transport Layer - TCP Congestion Control.md", "[Image: The AIMD \"Sawtooth\" diagram showing cwnd vs. time]", "![[Screenshots/ToothSaw AIMD.png]]"),
    
    ("CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP).md", "[Image: Relationship between TCP send/receive buffers and the sliding window pointers]", "![[Screenshots/TCP Connection Release.png]]"),
    
    ("CSE461/Transport/Timeout Misfortune.md", "[Image: Graph showing Sample RTT vs. the adaptive timeout envelope (EstimatedRTT + 4*DevRTT)]", "![[Screenshots/Example of Adaptive Timeout.png]]"),
    ("CSE461/Transport/Timeout Misfortune.md", "[Image: Sequence diagram comparing a recovery via Fast Retransmit (ACK clock preserved) vs. Recovery via Timeout (ACK clock lost).]", "![[Screenshots/Fast Retransmit.png]]"),

    # Network Layer
    ("CSE461/Network Layer/Network Layer - IPv4 Addressing and Subnetting.md", "[Image: Bit-level diagram of the IPv4 header fields]", "![[Screenshots/IPv4 Packet Header.png]]"),
    ("CSE461/Network Layer/Network Layer - IPv6.md", "[Image: Comparison of IPv4 and IPv6 header structures]", "![[Screenshots/Ipv6 Fragmentaton extension header.png]]"),
    ("CSE461/Network Layer/Network Layer - Forwarding and Routing Mechanics.md", "[Image: Diagram of IP-in-IP encapsulation showing Inner and Outer headers]", "![[Screenshots/IP tunneling.png]]"),

    # Link Layer
    ("CSE461/Link Layer/Link Layer - Switching and Bridges.md", "[Image: Diagram showing a physical mesh topology converted to a logical tree by blocking redundant links]", "![[Screenshots/a switch provides a star topology.png]]"),
    ("CSE461/Link Layer/Framing/FrameComponents/Bit Stuffing.md", "![[Screenshot 2026-01-20 at 4.28.47 PM.png]]", "![[Screenshots/Binary Padding 4,5.png]]"),
    ("CSE461/Link Layer/Framing/FrameComponents/Byte Stuffing.md", "![[Screenshot 2026-01-20 at 4.26.09 PM.png]]", "![[Screenshots/FLAG ESC padding.png]]"),

    # Application Layer
    ("CSE461/Application/Persistent Connections.md", "![[Persistent Connections.png]]", "![[Screenshots/Persistent Connections.png]]"),
    ("CSE461/Application/Routing Overlays.md", "![[Route Aggregation with CIDR.png]]", "![[Screenshots/Effects of indendent parties(2).png]]"),
    ("CSE461/Application/Routing Overlays.md", "![[IP addressess (classes).png]]", "![[Screenshots/Route Aggregation with CIDR.png]]"), # wait, routing overlays: Triangle inequality
    ("CSE461/Application/Peer-to-Peer Networks.md", "![[an example of virtual private networks.png]]", "![[Screenshots/Network topology.png]]"),
    ("CSE461/Application/Peer-to-Peer Networks.md", "![[A tunnel through an internetwork.png]]", "![[Screenshots/Casting.png]]"),
    ("CSE461/Application/Peer-to-Peer Networks.md", "![[Switch Buffer.png]]", "![[Screenshots/Bottleneck.png]]"),
    
    # Remove wrongfully placed Network/Link images from Application
    ("CSE461/Application/Domain Name System (DNS).md", "![[a switch provides a star topology.png]]\n", ""),
    ("CSE461/Application/Domain Name System (DNS).md", "![[example of a virtual circuit network.png]]\n", ""),
    ("CSE461/Application/Overlay Networks - Fundamental Mechanics.md", "![[Source routing in a switched network.png]]\n", ""),
    ("CSE461/Application/Overlay Networks - Fundamental Mechanics.md", "![[three ways to handle headers for source routing.png]]\n", ""),
    ("CSE461/Application/Network Management - SNMP and gNMI.md", "![[ATM Cell format at the UNI.png]]\n", ""),
    ("CSE461/Application/Page Load Time (PLT).md", "![[IPv4 Packet Header.png]]\n", ""),
    ("CSE461/Application/Page Load Time (PLT).md", "![[IP Datagram traversing the sequence of physical networks graphed.png]]\n", ""),
    ("CSE461/Application/Content Distribution Networks (CDN).md", "![[Router FIFO Queue.png]]\n", ""),
    ("CSE461/Application/Peer-to-Peer Networks.md", "![[General purpose processor used as a software switch.png]]\n", ""),
    ("CSE461/Application/Peer-to-Peer Networks.md", "![[Bare-metal switch using a network processing unit.png]]\n", ""),
    ("CSE461/Application/Routing Overlays.md", "![[Header Fields used in IP fragmentation.png]]\n", ""),
]

for filepath, old_str, new_str in fixes:
    if os.path.exists(filepath):
        with open(filepath, "r") as f:
            content = f.read()
        if old_str in content:
            content = content.replace(old_str, new_str)
            with open(filepath, "w") as f:
                f.write(content)
            print(f"Fixed {filepath}")
        else:
            print(f"Skipped {filepath} (old string not found)")
    else:
        print(f"Not found: {filepath}")

# Global catch-all for remaining wrong filenames in Application:
app_dir = "CSE461/Application"
wrong_names = [
    "a switch provides a star topology.png", "example of a virtual circuit network.png",
    "an example of virtual private networks.png", "A tunnel through an internetwork.png",
    "General purpose processor used as a software switch.png", "Bare-metal switch using a network processing unit.png",
    "Switch Buffer.png", "Router FIFO Queue.png", "Header Fields used in IP fragmentation.png",
    "IP addressess (classes).png", "Route Aggregation with CIDR.png", "Source routing in a switched network.png",
    "three ways to handle headers for source routing.png", "ATM Cell format at the UNI.png",
    "IPv4 Packet Header.png", "IP Datagram traversing the sequence of physical networks graphed.png"
]
for file in os.listdir(app_dir):
    if file.endswith(".md"):
        filepath = os.path.join(app_dir, file)
        with open(filepath, "r") as f:
            content = f.read()
        modified = False
        for w in wrong_names:
            if f"![[{w}]]" in content:
                content = content.replace(f"![[{w}]]", "")
                modified = True
        if modified:
            with open(filepath, "w") as f:
                f.write(content)
            print(f"Cleaned up {filepath}")

