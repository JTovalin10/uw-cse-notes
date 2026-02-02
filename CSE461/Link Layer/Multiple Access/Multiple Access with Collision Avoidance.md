# Rules
1. a sender node transmits a Request to send, with frame length
2. the receiver replies with Clear-to-send, with frame length
3. sender transmits the frame while nodes hearing the CTS stay silent
	1. collisions on RTS/CTS are still possible but less likely