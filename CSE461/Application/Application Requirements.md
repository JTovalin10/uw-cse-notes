![[Application Requirements.png]]
## Network Delay
- consdier one direction
	- constant rate of media is geenrated at source, later consumerd at reciever
	- network must have enough bandwidth, and adds a delay
- network delay is variable
	- message latency + queuing delay
	- variability in delay is called jitter
## Playout
- ideally want fixed, and small network delay for interactivity
	- emulate the telepphone network
	- media arrives  at reciever after variable network delay
	- media arrival curve determines the timout in playout biuffer and deadline
	- ![[playout.png]]![[Playout with variable media arrival.png]]
## Playout Buffer
- put media in playout buffer at receiver until consumpution time
	- smooth out variable network delay
	- media arrival curve determines time inplayout buffer and deadline
	- pick largest acceptable network delay to set the playout point
	- tradeoffs
		- larger acceptable entwrok delay
			- larger buffer/delay, less loss
		- smaller acceptable network delay
			- smaller buffer/delay, more loss
	- ![[Playout Buffer.png]]
## Streamed vs Interactive Media
- streamed is less demanding
	- unidirectional
	- low delay not essential; affects startup but not interactivity
	- still needs to handle bandwidth, jitter
### handle jitters
- plauout buffer
- use high and low watermark to control source over/underfill
	- start pulling media at low level
	- stop pulling media at high level
	- ![[High and Low water mark.png]]
## Handling Bandwidth
- send file in ne of multiple encodings
	- higher quality encoding require more bandwidth
	- select best encoding given avalauble bandwidth
	- contain multiple compressed files and send best pick to uncompress and send to user
### Streaming UDP or TCP
- UDP minimizes message delay for interactive, real-time sessions
	- for real time or late is as good as dropped applications
- TCP is typically used for streaming
	- low delay is not essential; startup
	- loss recovery simplifies presentation
	- HTTP/TCP passes through firewalls
	- use playout buffer to store the next video or x time ahead of video as we dont need it right now