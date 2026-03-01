# Mobile Networking Challenges

## The basic problem

- **DHCP** works for many apps — get new IP at coffee shop, browse, stream
- **Problem**: VoIP call, move to new network → correspondent still sends to old address
- Packets go to **where you were**, not where you are

## Identifier vs locator

- **IP address** does two jobs: identifies endpoint + locates it
- When mobile: want **identifier** (stable) + **locator** (changes)
- Separating these is key to mobility

## Other issues

- **Security**: "My new address is X" — how to prevent spoofing?
- **TCP**: Assumes address stays constant for connection lifetime
- **Workaround**: Apps (HTTP, Netflix) re-establish connections when IP might have changed

## Wireless ≠ mobility

- **Wireless** = data without wire
- **Mobility** = node moves while communicating
- Often together, but different problems

## Network-layer mobility

- Moving **between networks** (e.g. WiFi → cellular)
- Different from: moving between APs in same WiFi (handled by 802.11)
