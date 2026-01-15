# Unsigned Integer
$$
-2^{n-1} \leq x \leq 2^{n-1}-1
$$
# Signed Integer
$$
0 \leq x \leq 2^{n} - 1
$$
# Calculating n as a bit
To calculate n we take the product of $2^n$ (s). 
Example:
$$
99 \quad = 64 + 32 + 2+1 = 2^6 + 2^5 + 2^1 + 2^0 \Rightarrow 0x 01100011 \quad \text{We include leading 0 to state its signed}
$$
To calculate a negative number first calculate its positive counter part
Example:
$$
18 = 16 + 2 = 2^4 + 2^1 \Rightarrow 0x 10010
$$
Then we flip the 0x and add one to the end
$$
0x10010 \Rightarrow 0x01101 + 1 \Rightarrow 0x01110
$$
