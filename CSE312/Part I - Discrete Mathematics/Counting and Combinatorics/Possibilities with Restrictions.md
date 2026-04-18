# CSE 312: Counting with Restrictions

First take the **product rule** of all options:

$$n_1 \cdot n_2 \cdots n_k = m$$

Then subtract the restrictions. For example, if there are forbidden combinations:

$$m_1 \cdot m_2 \cdot 2 = k$$

$m - k$ would be the result.

---

This is a **multiplication principle** problem with **restrictions**, not a sum rule problem.

**Without restrictions**, it would be: 3 hats × 3 shirts × 3 pants = 27 total outfits

**With restrictions**, we need to subtract the forbidden combinations:

- Classic overalls + dinosaur pants: 3 hats × 1 × 1 = 3 forbidden outfits
- Night sky + relaxed fit pants: 3 hats × 1 × 1 = 3 forbidden outfits
- Light blue + farmer pants: 3 hats × 1 × 1 = 3 forbidden outfits

**Formula:** Total valid outfits = (Total possible outfits) − (Forbidden outfits) = 27 − 3 − 3 − 3 = **18 outfits**

**General formula for this type of problem:** If you have $n_1 \times n_2 \times n_3 \times \cdots$ total combinations, and you need to subtract specific forbidden combinations, then:

Valid combinations = $(n_1 \times n_2 \times n_3 \times \cdots) - \sum(\text{forbidden combinations})$

This uses the **inclusion-exclusion principle** rather than the sum rule, since we're dealing with multiple categories that must all be chosen from (hat AND shirt AND pants), with certain combinations excluded.

## Related

- [[Product Rule]]
- [[Principle of Inclusion-Exclusion]]
- [[Complementary Counting]]
