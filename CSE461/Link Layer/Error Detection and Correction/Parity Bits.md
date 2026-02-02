take D data bits, add 1 check bit that is the sum of the D bits
- sum is modulo 2 or XOR

# Questions
- how well does parity work
	- what is the distance of the code
		- HD = 2 as if you change one bit then the xor will be different from parity. But if you change 2 bits (assuming they are the same) then the parity will be the same
	- how many errors will it detect/correct
		- it cannot correct as 2 - 1 / 2 = 0 (integer)
		- however it can do all off number of bit flips
- what about larger errors