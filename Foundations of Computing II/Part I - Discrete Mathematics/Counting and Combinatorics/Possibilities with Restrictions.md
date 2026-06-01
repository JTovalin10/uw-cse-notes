# CSE 312: Possibilities with Restrictions

Counting **possibilities with restrictions** is a [[Product Rule|multiplication principle]] problem where some combinations are forbidden. It is not a [[Sum Rule|sum rule]] problem, because every category must still be chosen from (e.g., hat AND shirt AND pants) — we are simply excluding certain combinations.

## General Method

First take the product rule over all options to get the unrestricted total:

$$n_1 \cdot n_2 \cdots n_k = m$$

Then subtract the restrictions. If a forbidden case is itself a product of choices, count it the same way:

$$m_1 \cdot m_2 \cdot 2 = k$$

The valid count is then $m - k$. This subtraction step is **[[Complementary Counting|complementary counting]]** applied to a multiplication-principle problem.

## Worked Example

**Without restrictions**, the count is: 3 hats × 3 shirts × 3 pants = 27 total outfits.

**With restrictions**, we subtract the forbidden combinations:

- Classic overalls + dinosaur pants: 3 hats × 1 × 1 = 3 forbidden outfits
- Night sky + relaxed fit pants: 3 hats × 1 × 1 = 3 forbidden outfits
- Light blue + farmer pants: 3 hats × 1 × 1 = 3 forbidden outfits

**Formula:** Total valid outfits = (Total possible outfits) − (Forbidden outfits) = 27 − 3 − 3 − 3 = **18 outfits**.

## General Formula

If you have $n_1 \times n_2 \times n_3 \times \cdots$ total combinations and you need to subtract specific forbidden combinations, then:

$$\text{Valid combinations} = (n_1 \times n_2 \times n_3 \times \cdots) - \sum(\text{forbidden combinations})$$

When the forbidden cases themselves overlap, the subtraction must follow the [[Principle of Inclusion-Exclusion]] so that no combination is removed more than once.

## Related

- [[Product Rule]]
- [[Principle of Inclusion-Exclusion]]
- [[Complementary Counting]]

## Industry Standard Terms

- **Possibilities with Restrictions** → "constrained counting" / "counting with forbidden configurations" / "counting with exclusions."
