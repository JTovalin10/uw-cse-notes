import os, re
from collections import Counter
import math

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

def get_tokens(s):
    return re.findall(r'\w+', s.lower())

def similarity(s1, s2):
    t1 = get_tokens(s1)
    t2 = get_tokens(s2)
    c1 = Counter(t1)
    c2 = Counter(t2)
    intersection = sum((c1 & c2).values())
    union = sum((c1 | c2).values())
    return intersection / union if union else 0

def find_best_match(context):
    best = None
    best_score = -1
    for s in screenshots:
        # Also include keywords
        name_no_ext = s.replace(".png", "")
        score = similarity(context, name_no_ext)
        if score > best_score:
            best_score = score
            best = s
    return best, best_score

for root, dirs, files in os.walk("CSE461"):
    for file in files:
        if file.endswith(".md"):
            filepath = os.path.join(root, file)
            with open(filepath, "r") as f:
                content = f.read()
            
            # Find [Image: ...]
            placeholders = re.findall(r"\[Image: (.*?)\]", content)
            
            # Find ![[...]] with captions
            lines = content.split('\n')
            for i, line in enumerate(lines):
                if "![[" in line and ".png]]" in line:
                    match = re.search(r"!\[\[(.*?.png)\]\]", line)
                    if match:
                        img = match.group(1)
                        # Find caption
                        caption = ""
                        for j in range(i+1, min(i+4, len(lines))):
                            if "Figure:" in lines[j]:
                                caption = lines[j]
                                break
                        if not caption and i > 0:
                            caption = lines[i-1]
                        
                        best_s, score = find_best_match(caption + " " + file)
                        print(f"FILE: {filepath}\nIMG: {img}\nCAPTION: {caption}\nBEST MATCH: {best_s} ({score:.2f})\n")
                        
            for p in placeholders:
                best_s, score = find_best_match(p + " " + file)
                print(f"FILE: {filepath}\nPLACEHOLDER: {p}\nBEST MATCH: {best_s} ({score:.2f})\n")

