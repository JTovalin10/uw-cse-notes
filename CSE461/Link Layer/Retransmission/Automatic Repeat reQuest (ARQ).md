- often used when errors are common or must be corrected
	- wifi and tcp
- rules at sender and receiver
	- receiver automatically acknowledges correct frames with an [[Acknowledgment (ACK)|ACK]]
	- sender automatically resends after a timeout, until an ACK is received
# Normal Operations
no loss
![[Screenshot 2026-01-22 at 2.54.43 PM.png]]
# Loss and retransmission
![[Screenshot 2026-01-22 at 2.55.14 PM.png]]
# Duplicates
## Lost
- what happens if an ACK is lost?
![[Screenshot 2026-01-22 at 2.57.00 PM.png]]
## Timeout early
![[Screenshot 2026-01-22 at 2.57.25 PM.png]]




# Whats tricky about ARQ
1. how long to set the timeout
2. how to avoid accepting duplicate frames as new frames
## Timeouts
Timeouts should be:
- not too big (link goes idle)
- not too small (spurious resend)
- fairly easy on a [[Local Area Network (LAN)|LAN]]
	- clear worst case, little variation
- fairly difficult over the internet
	- much variation, no obvious bound