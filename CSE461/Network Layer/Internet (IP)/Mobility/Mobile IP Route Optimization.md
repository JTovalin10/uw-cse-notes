# Mobile IP Route Optimization

## Triangle routing problem

- Path: Correspondent → [[Home Agent (Mobile IP)|Home agent]] → [[Foreign Agent (Mobile IP)|Foreign agent]] → Mobile
- **Wasteful** when correspondent and mobile are on same network (or nearby)
- Two sides of triangle instead of direct path

## Solution: binding cache

- **[[Home Agent (Mobile IP)|Home agent]]** sends **binding update** (message carrying home address → care-of address mapping) to correspondent: "mobile is at [[Care-of Address (Mobile IP)|care-of]] X"
- **Correspondent** caches ([[Home Address (Mobile IP)|home address]] → [[Care-of Address (Mobile IP)|care-of address]])
- Next packets: correspondent **tunnels directly** to care-of (skips [[Home Agent (Mobile IP)|home agent]])

## When cache is wrong

- Mobile moved again; cache has old care-of
- **[[Foreign Agent (Mobile IP)|Foreign agent]]** receives packet for mobile no longer there → sends **binding warning** to correspondent
- Cache entries expire (lifetime in binding update)

## Security

- Authentication required — prevent attacker from claiming "I'm the new care-of for victim"
