how information is sent
moden

# Non return to zero
with electricity, we can represent 0 with -V and 1 with +V
to have a reset go to 0V (return to zero)

## Clock recovery (4B/5B)
- Map every 4 data buts into 5 code bits without long run of zeros
	- 0000 -> 11110, 0001 -> 01001, 1110 -> 11100, 1111 -> 11101
- Has at most 3 zeros in a row
- also invert signal level on 