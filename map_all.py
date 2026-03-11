import os, re

screenshots = [
    "a switch provides a star topology.png", "A tunnel through an internetwork.png", "ACK Clocking.png", "AIMD.png",
    "an example of virtual private networks.png", "ATM Cell format at the UNI.png", "Bare-metal switch using a network processing unit.png",
    "Binary Padding 4,5.png", "Bottleneck.png", "Casting.png", "Congestion Performance.png", "Datagram Forwarding.png",
    "Datagrams vs Virtual Circuits.png", "Datagrams.png", "discrete to continous noisy channels.png", "ECN.png",
    "Effects of indendent parties(2).png", "effects of indepdent parties.png", "example of a virtual circuit network.png",
    "Example of Adaptive Timeout.png", "Example of RTT for retransmissions.png", "Fast Retransmit.png", "Feedback signals.png",
    "FLAG ESC padding.png", "General purpose processor used as a software switch.png", "Header Fields used in IP fragmentation.png",
    "Header.png", "internel, external translation table.png", "IP addressess (classes).png", "IP Datagram traversing the sequence of physical networks graphed.png",
    "IP Header, ICMP Hedaer, ICMP data.png", "IP packet.png", "IP tunneling.png", "IPv4 Packet Header.png",
    "Ipv6 Fragmentaton extension header.png", "IPv6 provider-based unicast address.png", "Middleboxes.png", "NAT (5).png",
    "NAT.png", "Network Running GBP.png", "Network topology.png", "Packet Loss.png", "Persistent Connections.png",
    "Route Aggregation with CIDR.png", "Router and Switches internal buffering.png", "Router FIFO Queue.png", "Router Queue.png",
    "Slow Start + AIMD.png", "Source routing in a switched network.png", "Switch Buffer.png", "TCP Connection Release.png",
    "TCP Slow-Start.png", "three ways to handle headers for source routing.png", "Three-Way Handshake.png", "ToothSaw AIMD.png",
    "UDP header.png"
]

# Manual overrides for accuracy
mapping = {
    "ACK Clocking.png": "CSE461/Definitions/Acknowledgment (ACK).md",
    "AIMD.png": "CSE461/Transport/Transport Layer - TCP Congestion Control.md",
    "ATM Cell format at the UNI.png": "CSE461/Definitions/Asynchronous Transfer Mode (ATM).md",
    "Bare-metal switch using a network processing unit.png": "CSE461/Definitions/Network Processor Unit (NPU).md",
    "Binary Padding 4,5.png": "CSE461/Physical Layer/Physical Layer - Encoding and Modulation.md",
    "Bottleneck.png": "CSE461/Link Layer/Link Layer - Switching and Bridges.md",
    "Casting.png": "CSE461/Routing Layer/Routing Layer - Delivery Models.md",
    "Congestion Performance.png": "CSE461/Transport/Transport Layer - TCP Congestion Control.md",
    "Datagram Forwarding.png": "CSE461/Definitions/Forwarding.md",
    "Datagrams vs Virtual Circuits.png": "CSE461/Definitions/Virtual Circuit (VC).md",
    "Datagrams.png": "CSE461/Definitions/Datagram.md",
    "discrete to continous noisy channels.png": "CSE461/Physical Layer/Physical Layer - Signals and Channel Capacity.md",
    "ECN.png": "CSE461/Transport/Network-Side Congestion Control.md",
    "Effects of indendent parties(2).png": "CSE461/Routing Layer/Routing Layer - Interdomain Concepts.md",
    "effects of indepdent parties.png": "CSE461/Routing Layer/Routing Layer - Interdomain Concepts.md",
    "example of a virtual circuit network.png": "CSE461/Definitions/Virtual Circuit (VC).md",
    "Example of Adaptive Timeout.png": "CSE461/Transport/Timeout Misfortune.md",
    "Example of RTT for retransmissions.png": "CSE461/Transport/Timeout Misfortune.md",
    "Fast Retransmit.png": "CSE461/Transport/Timeout Misfortune.md",
    "Feedback signals.png": "CSE461/Transport/Network-Side Congestion Control.md",
    "FLAG ESC padding.png": "CSE461/Link Layer/Link Layer - Framing.md",
    "General purpose processor used as a software switch.png": "CSE461/Definitions/Software Defined Networking (SDN).md",
    "Header Fields used in IP fragmentation.png": "CSE461/Network Layer/Network Layer - Internetworking and IP.md",
    "Header.png": "CSE461/Definitions/Encapsulation.md",
    "internel, external translation table.png": "CSE461/Network Layer/Network Layer - IPv4 Addressing and Subnetting.md",
    "IP addressess (classes).png": "CSE461/Definitions/IP Address Classes (Classful Addressing).md",
    "IP Datagram traversing the sequence of physical networks graphed.png": "CSE461/Network Layer/Network Layer - Internetworking and IP.md",
    "IP Header, ICMP Hedaer, ICMP data.png": "CSE461/Definitions/Internet Control Message Protocol (ICMP).md",
    "IP packet.png": "CSE461/Definitions/Internet Protocol (IP).md",
    "IP tunneling.png": "CSE461/Network Layer/Network Layer - Forwarding and Routing Mechanics.md",
    "IPv4 Packet Header.png": "CSE461/Network Layer/Network Layer - IPv4 Addressing and Subnetting.md",
    "Ipv6 Fragmentaton extension header.png": "CSE461/Network Layer/Network Layer - IPv6.md",
    "IPv6 provider-based unicast address.png": "CSE461/Network Layer/Network Layer - IPv6.md",
    "Middleboxes.png": "CSE461/Network Layer/Network Layer - Internetworking and IP.md",
    "NAT (5).png": "CSE461/Network Layer/Network Layer - IPv4 Addressing and Subnetting.md",
    "NAT.png": "CSE461/Network Layer/Network Layer - IPv4 Addressing and Subnetting.md",
    "Network Running GBP.png": "CSE461/Routing Layer/Routing Layer - Border Gateway Protocol (BGP).md",
    "Network topology.png": "CSE461/Application/Peer-to-Peer Networks.md",
    "Packet Loss.png": "CSE461/Definitions/Requirements.md",
    "Persistent Connections.png": "CSE461/Application/Persistent Connections.md",
    "Route Aggregation with CIDR.png": "CSE461/Definitions/Classless Interdomain Routing (CIDR).md",
    "Router and Switches internal buffering.png": "CSE461/Definitions/Router.md",
    "Router FIFO Queue.png": "CSE461/Definitions/Router.md",
    "Router Queue.png": "CSE461/Definitions/Router.md",
    "Slow Start + AIMD.png": "CSE461/Transport/Transport Layer - TCP Congestion Control.md",
    "Source routing in a switched network.png": "CSE461/Definitions/Source Routing.md",
    "Switch Buffer.png": "CSE461/Definitions/Switch.md",
    "TCP Connection Release.png": "CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP).md",
    "TCP Slow-Start.png": "CSE461/Transport/Transport Layer - TCP Congestion Control.md",
    "three ways to handle headers for source routing.png": "CSE461/Definitions/Source Routing.md",
    "Three-Way Handshake.png": "CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP).md",
    "ToothSaw AIMD.png": "CSE461/Transport/Transport Layer - TCP Congestion Control.md",
    "UDP header.png": "CSE461/Transport/Transport Layer - UDP and Port Demultiplexing.md",
    "a switch provides a star topology.png": "CSE461/Link Layer/Link Layer - Switching and Bridges.md",
    "A tunnel through an internetwork.png": "CSE461/Definitions/Virtual Private Network (VPN).md",
    "an example of virtual private networks.png": "CSE461/Definitions/Virtual Private Network (VPN).md"
}

# 1. Clean up remaining Pasted image or placeholders in all files, but ONLY if we have mapped an image to that file.
for s, file_path in mapping.items():
    if not os.path.exists(file_path): continue
    
    with open(file_path, "r") as f:
        content = f.read()
    
    img_link = f"![[Screenshots/{s}]]"
    
    # If the image is already in the file, skip
    if img_link in content or f"![[{s}]]" in content:
        continue
        
    # Attempt to replace first [Image: ...]
    if "[Image:" in content:
        content = re.sub(r"\[Image: .*?\]", img_link, content, count=1)
    # Else attempt to replace first Pasted image ...
    elif "![[Pasted image" in content:
        content = re.sub(r"!\[\[Pasted image .*?\.png\]\]", img_link, content, count=1)
    elif "![[Screenshot " in content:
        content = re.sub(r"!\[\[Screenshot .*?\.png\]\]", img_link, content, count=1)
    else:
        # Just append it
        content += f"\n\n{img_link}\n"
        
    with open(file_path, "w") as f:
        f.write(content)

# Now, clear out any remaining Pasted image or Screenshot references everywhere else so there are no broken links left.
for root, dirs, files in os.walk("CSE461"):
    for file in files:
        if file.endswith(".md"):
            path = os.path.join(root, file)
            with open(path, "r") as f:
                content = f.read()
            original = content
            content = re.sub(r"!\[\[Pasted image .*?\.png\]\]\n?", "", content)
            content = re.sub(r"!\[\[Screenshot .*?\.png\]\]\n?", "", content)
            # Also clean up unreplaced placeholders if desired, but user mainly cared about wrong screenshots.
            if original != content:
                with open(path, "w") as f:
                    f.write(content)

