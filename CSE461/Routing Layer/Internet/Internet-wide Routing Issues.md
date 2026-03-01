1. scaling to very large networks
	1. techniques of IP prefixes, hierarchy, prefix aggregation
2. Incorporating policy decisions
	1. letting different parties choose their routes to suit their own needs
## Effects of Independent Parties
- each party selects routes to suit its own interest
	- shortest path in [[Internet Service Provider (ISP)]]
![[effects of indepdent parties.png]]
- selected paths are longer than overall shortest path
	- and symmetric too
	- blue is the path they chose and pink is the optimal path where we want to chose a path for A2->B1 and B1->A2
- this is a consequence of independent goals and decisions
- ![[Effects of indendent parties(2).png]]
we can fix this with [[Routing Policies]]