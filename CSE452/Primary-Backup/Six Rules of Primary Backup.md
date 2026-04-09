## General Flow
- What messages do they send/recieve
	- Client
		- sends request to primary
		- sends getview
	- Primary sends a forward request to backup
		- Sends forward request to backup
		- pings view server
	- backup
		- sends forward ack to primary
		- pings view server
	- view server
		- sends client viewrpeply
		- sends primary VR
		- sends backup VR
		- sends request to idle pool
## Rules
1. primary must wait for backup to execute the command before executing it and replying t client
	1. what if we did not forward requests before executing them?
		1. primary changes or different views
			1. stale reads occur. if primary changes then it wont have the cache
			2. if view changes then view may not contain the same info
	2. Forwarding
		1. only execute a command on the primary after receiving an ack from the backup during forwarding
		2. the backup is at most one command ahead of the primary at all times
2. backup must accept forward requests only if  view is correct
	1. how do we know which view is sending the message?
3. Primary in view i + 1 mst have been backup or primary in view i
	1. what if the new primary was not in the previous view
		1. primary or backup in the prev view will have the most up to date application state
		2. an idle server can have an empty application state
		3. the new primary MUST have been in the previous view when changing the primary of a view
4. Non primary must reject client requests
	1. the issue with this is that the primary would never get this request so it will never execute it
	2. client is not guraneeed that they will be talking to the primary
	3. any node could be on an outdated view
	4. servers should onyl process/repsond to client if they beleive they are primary
5. viewserver cannot move onto i + 1 until ack from primary in view i is recieved
	1. [[State Machine Replication (State Transfer)]]
	2. if the primary ack's this mean it has completed state transfer so they have the correct application state
	3. probllem
		1. preqre of an ack includes the complete state transfer to bring anew backup up to speed
6. Every operation must be before or after state transfer (problem with processing request during a state transfer)
	1. wht if we process requests during state transfers
		1. this is to avoid overwritting values