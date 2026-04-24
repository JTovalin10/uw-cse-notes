import os
import re

vault_root = "/home/justin/Desktop/uw-cse-notes"
def_dir = os.path.join(vault_root, "CSE461/Definitions")

# Files identified previously
files_to_check = [
    "CSE461/Definitions/HTTP (CSE 333).md",
    "CSE461/Definitions/Synchronous Time-Division Multiplexing.md",
    "CSE461/Definitions/Layering.md",
    "CSE461/Definitions/Protocols and Layers.md",
    "CSE461/Definitions/Encapsulation (stack).md",
    "CSE461/Definitions/OSI Layers.md",
    "CSE461/Definitions/Application.md",
    "CSE461/Definitions/Store and forward packet switching.md",
    "CSE461/Definitions/World Wide Web - Architecture, Identifiers, and Caching.md",
    "CSE461/Definitions/CSMA-CD (Collision Detection).md",
    "CSE461/Definitions/Link Layer.md",
    "CSE461/Definitions/Network Layer.md",
    "CSE461/Definitions/Physical Layer.md",
    "CSE461/Definitions/IP Packet Format.md",
    "CSE461/Definitions/IP Fragmentation and Reassembly.md",
    "CSE461/Definitions/Software Switch.md",
    "CSE461/Definitions/Software Defined Networks.md",
    "CSE461/Definitions/Neighbor Discovery Protocol (NDP).md",
    "CSE461/Definitions/Routing Areas (OSPF).md",
    "CSE461/Definitions/Border Gateway Protocol (BGP).md",
    "CSE461/Definitions/AS Relationships and Policies.md",
    "CSE461/Definitions/Integrating iBGP and eBGP.md",
    "CSE461/Definitions/Mobile IP.md",
    "CSE461/Definitions/IP Address.md",
    "CSE461/Definitions/Longest matching prefix.md",
    "CSE461/Definitions/Subnetting.md",
    "CSE461/Definitions/Slow Start.md",
    "CSE461/Definitions/Maximum Segment Size (MSS).md",
    "CSE461/Definitions/Congestion Avoidance.md",
    "CSE461/Definitions/Multiplicative Decrease.md",
    "CSE461/Definitions/IPv4.md",
    "CSE461/Definitions/IPv6.md",
    "CSE461/Definitions/cwnd.md",
    "CSE461/Definitions/IP Tunneling.md",
    "CSE461/Definitions/Virtual Private Networks (VPN).md",
    "CSE461/Definitions/MPLS.md",
    "CSE461/Definitions/CDN.md",
    "CSE461/Definitions/Head-of-Line (HOL) Blocking.md",
    "CSE461/Definitions/gRPC.md",
    "CSE461/Definitions/RTP.md",
    "CSE461/Definitions/Playout Buffer.md",
    "CSE461/Definitions/Flow Control.md",
    "CSE461/Definitions/Round Trip Time (RTT).md",
    "CSE461/Definitions/ACK Clocking.md",
    "CSE461/Definitions/Slow Start (TCP Additive Increase).md",
    "CSE461/Definitions/QUIC.md",
    "CSE461/Definitions/RSVP.md",
    "CSE461/Definitions/Bandwidth.md",
    "CSE461/Definitions/Head-of-Line (HOL) Blocking\\.md",
    "CSE461/Definitions/XML.md",
    "CSE461/Definitions/Protobufs.md",
    "CSE461/Definitions/Proxy.md",
    "CSE461/Definitions/DiffServ.md",
    "CSE461/Definitions/Multimedia Applications.md",
]

all_md_files = []
for root, dirs, files in os.walk(vault_root):
    for file in files:
        if file.endswith(".md"):
            all_md_files.append(os.path.join(root, file))

results = []

for rel_path in files_to_check:
    full_path = os.path.join(vault_root, rel_path)
    if not os.path.exists(full_path):
        continue
    
    term = os.path.basename(rel_path).replace(".md", "")
    # Remove escaping if any
    term_unescaped = term.replace("\\", "")
    
    refs = []
    # Search patterns: [[Term]], [[Term|...]], [[path/to/Term]], [[path/to/Term|...]]
    # We also need to handle cases where the term itself might have regex special characters
    term_pattern = re.escape(term_unescaped)
    pattern = re.compile(r'\[\[([^\]|]*' + term_pattern + r'(\.md)?)(|[^\]]*)?\]\]')

    for md_file in all_md_files:
        if md_file == full_path:
            continue
        
        with open(md_file, 'r', errors='ignore') as f:
            content = f.read()
            if pattern.search(content):
                refs.append(os.path.relpath(md_file, vault_root))
    
    results.append({
        "path": rel_path,
        "term": term_unescaped,
        "ref_count": len(refs),
        "refs": refs
    })

for res in results:
    print(f"FILE: {res['path']}")
    print(f"TERM: {res['term']}")
    print(f"COUNT: {res['ref_count']}")
    print(f"REFS: {', '.join(res['refs'])}")
    print("-" * 20)
