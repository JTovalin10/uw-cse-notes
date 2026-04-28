# Stars and Bars

**[[CSE312/Definitions/Stars and Bars|Stars and Bars]]**: To pick $n$ objects from $k$ groups (where order doesn't matter and every element of each group is indistinguishable), use the formula:

$$\binom{n+k-1}{k-1}$$

This counting technique gets its name from representing the indistinguishable items as "stars" and using $k-1$ "bars" to divide them into $k$ distinct groups.

## Example

Suppose you want to buy 12 seeds from Pierre's General Store, and there are 5 types of seeds (parsnip, cauliflower, potato, kale, garlic). 
- We are picking $n = 12$ objects from $k = 5$ groups.
- The number of possible orders is $\binom{12+5-1}{5-1} = \binom{16}{4}$.
