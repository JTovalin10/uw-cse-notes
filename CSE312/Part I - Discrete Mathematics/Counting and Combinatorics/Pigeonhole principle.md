# CSE 312: Pigeonhole Principle

The **Pigeonhole Principle** states: if $n$ objects are placed into $k$ boxes, then at least one box contains at least $\lceil n/k \rceil$ objects.

$$\text{At least one box has} \geq \left\lceil \frac{n}{k} \right\rceil \text{ objects}$$

- Tells you about any guaranteed collisions or overlaps when distributing objects across a limited number of containers.

## Strong Pigeonhole Principle

If you have $n$ pigeons and $k$ pigeonholes, then there is at least one pigeonhole that has at least $\lceil n/k \rceil$ pigeons.

## Example

If you have to grow 10 crops, and you have 3 seasons to grow them in, then:
- **Pigeons:** The 10 crops
- **Pigeonholes:** The 3 seasons
- **Mapping:** Which crop you grow in which season.

Applying the strong pigeonhole principle, there is at least one season where you will grow at least $\lceil 10/3 \rceil = 4$ crops.

## Practical Tips

When applying the principle, clearly state:
1. What are the pigeons?
2. What are the pigeonholes?
3. How do you map from pigeons to pigeonholes?

Look for a set you're trying to divide into groups, where collisions would help you somehow.

## Related

- [[Product Rule]]
- [[Complementary Counting]]
