core idea: stop being a distributed system
- centralize the operation of the network
	- create a "controller" that operates the network
- push new code, state, and configuration from "controller" to switches
	- Run link state with a global view of the network rather than in a distributed fashion. 
	- Allows for “global” policies to be enforced. 
	- Can resolve failures in more robust, faster manne
## Problem
creates a chicken-egg problem as do we talk if there is no network

## [[SDN - Control and Data Plane]]
