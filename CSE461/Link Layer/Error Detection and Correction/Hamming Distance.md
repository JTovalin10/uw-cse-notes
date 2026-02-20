- hamming distance between two codes ($D_1, D_2$) is the number of bit flips needed to change $D_1$ to $D_2$
- hamming distance of a coding is the **minimum** error distance between any pair of codewords (bit-strings) that cannot be detected
- with an Hamming Distance of $n$, up to $n - 1$ buts can be detected and $\text{floor(}\frac{n-1}{2})$ can be corrected
# Errors
- detection
	- for a coding distance of $d$, up to $d - 1$ errors will always be detected
	- [[Parity Bits]]
- correction
	- for a coding of distance $d$, up to $\lfloor \frac{d-1}{2} \rfloor$ errors can always be corrected by mapping to the closest valid codeword

# Example
![[Screenshot 2026-01-26 at 12.51.48 PM.png]]
