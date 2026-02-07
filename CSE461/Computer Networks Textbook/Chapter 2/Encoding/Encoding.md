## Intro
We must first understand how to turn nodes and links into usable building blocks and connect them so we can transmit bits from one node to the other.

Our task is to encode binary data into the signal so the source node is able to send the signal that links are able to carry and then decode the signal back to the corresponding binary data at the receiving node.

The way we do this is with [[Network Adaptors]]

# Problem
The issue when encoding bits into signal is when we have long strings of 1s or 0s--non-return to zero.
- baseline wander
	- sequence of several consecutive 1s means that the signal stays high on the link for an extended period of time
		- the receiver keeps an average of the signal it has seen so far and then uses this average to distinguish between low and high signals.
		- when the average is significantly lower than this average, the receiver thinks that it has just seen a 0
		- so the issue is that too many 1s or 0s messes up this average and makes it harder to detect the change
- clock recovery
	- the issue is that both the encoding and decoding processes are driven by a clock and the sender and receiver's clock have to be precisely in sync in order for the receiver to recover the same bits the sender transmits
		- slightly different and you cannot decode the signal
		- a solution is to derive the clock from the signal called clock recovery process
			- if the signal changes then the receiver knows it is at a clock cycle boundary and can resync itself, however a long period without a transition leads to clock drift so this means it depends on having lots of transitions in the signal
# Solutions
*non-return to zero inverted*: the sender makes a transition from the current signal to encode a 1 and stays at the current signal to encode a 0
- this solves the problem of consecutive 1s but does nothing for consecutive 0s
*Manchester Encoding*: merges the clock with a signal by transmitting the XOR of the NRZ-encoded data and the clock
- however an issue with this is that it doubles the rate at which signal transitions are made on the link which means the receiver has half the time to detect each pulse of the signal. ([[baud rate]])
![[Pasted image 20260206235719.png]]
