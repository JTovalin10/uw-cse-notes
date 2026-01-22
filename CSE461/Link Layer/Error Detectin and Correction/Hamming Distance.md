- hamming distance between two codes ($D_1, D_2$) is the number of bit flips needed to change $D_1$ to $D_2$
- hamming distance of a coding is the minimum error distance between any pair of codewords (bit-strings) that cannot be detected

# Errors
- detection
	- for a coding distance of $d+1$, up to $d$ errors will always be detected
	- [[Parity Bits]]
- correction
	- for a coding of distance $2d+1$, up to $d$ errors can always be corrected by mapping to the closest valid codeword