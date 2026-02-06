Maca uses a short handshake instead of [[Carrier Sense Multiple Access (CSMA)]]
# Rules
1. a sender node transmits a Request to send, with frame length
	1. transmits RTS packet
2. the receiver replies with Clear-to-send, with frame length
	1. receiver sends CTS packet
3. sender transmits the frame while nodes hearing the CTS stay silent
	1. collisions on RTS/CTS are still possible but less likely, as they are tiny even if they collide it is easy to retransmit

# Exposed Terminal Problem
[[Exposed Terminals]], as A and D are seperated they dont hear the CTS so the sender can transmit the packet without problem. The only issue is if they recieve and send RTS and CTS at the same time as B and C can interfere with each other so they cannot hear the CTS. It does solve the Hidden terminal problem tho.