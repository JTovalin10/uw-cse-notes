- codeword consists of D data plus R check bits
![[Screenshot 2026-01-20 at 4.35.40 PM.png]]
- sender
	- compute R check bits based on the D data bits; send the codeword of D+R bits
- receiver
	- receive D+R bits with unknown errors
	- recompute R check bits based on the D data bits ;error if R doesn't match R'
	![[Screenshot 2026-01-20 at 4.36.28 PM.png]]
## Intuition for error codes
- for D data bits, R check bits
- randomly chosen codeword is unlikely to be correct; overhead is low
- ![[Screenshot 2026-01-20 at 4.37.29 PM.png]]