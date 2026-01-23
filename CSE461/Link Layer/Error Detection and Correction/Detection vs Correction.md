The overhead of each depends on the error
![[Screenshot 2026-01-22 at 2.41.33 PM.png]]![[Screenshot 2026-01-22 at 2.41.39 PM.png]]
![[Screenshot 2026-01-22 at 2.42.50 PM.png]]
# Error Correction in practice
1. heavily used in physical layer
	1. LDPC is the future, used for demanding links
	2. convolutional codes widely used in practice
2. error detection (w/ retransmission) is used in the link layer and above for residual errors
3. correction also used in the application layer
	1. called forward error correction
	2. normally with an erasure error mode
	3. reed-solomon