1. why do we state trasnfer
	1. to bring new baclup (formely idle server) up to date
2. when do we do a state transfer
	1. if prmary ercieves new view with a new backup
3. why do we do a state transfer
4. during state transfer, primary can just stop sending out pings
5. out primary can continue pinging the view server with old views
6. backup can recieve duplciated/late state transfer messages
	1. we need to gurarantee that state on backup is only overwritten once per view change
7. what happens if the state transfer ack gets dropped
	1. resend staet trasnfer message, but bacup should not overwrite their state if they have already the state transfer
	2. execute a state transfer once per view. The backup should still always respond to a state transfer request acknowledging the reqiest