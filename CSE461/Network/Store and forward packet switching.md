 both service models use this
- routers receive a complete packet and store it temporarily if necessary before forwarding it onwards
- we use statistical multiplexing to share link bandwidth over time
- switching element has internal buffering for contention ![[Screenshot 2026-02-09 at 12.43.23 PM.png]]
- Simplified view with per port output buffering
	- buffer is typically FIFO queue
	- if full, packets are discarded ![[Screenshot 2026-02-09 at 12.43.58 PM.png]]