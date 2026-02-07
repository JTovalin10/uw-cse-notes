the current issue we have is how do we connect nodes into a network. We can just do it on a wire or wireless which can cover a small or wide area

We then come with 5 issues that we must solve in order to create communication
1. encoding
	1. we must encode bits so that they can be understood by recieving nodes
		1. think tranmissing int32_t and the reciever thinkgs its uint32_t
2. framing
	1. sending packets into cimplete messages that can be deleivered to the end node
	2. the message delivered to the end hosts are often called frames (or packets)
3. error detection
	1. frames can be corrupted during transmission and we must detect them and take action
4. reliable delivery
5. media access control
	1. we need to mediate access between nodes that are sharing a link (multiple hosts)