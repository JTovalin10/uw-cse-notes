- attacks based on **information that can be learned from the implementation of a system**, rather than breaking its theoretical properties
	- initially most commonly discussed in context of cryptosystems
	- but also prevalent in many contexts
# Methods
- Traffic Analysis
![[Screenshot 2025-12-02 at 4.21.47 PM.png]]
- keybpard eavesdropping
- accelerometer/gyroscope eavesdropping
- audio from video
- power analysis
	- **simple power analysis**: Directly red off bits power line
	- **Differential power analysis**: look for statistical differences in power traces and base on guesses for a key bit
	-![[Screenshot 2025-12-02 at 4.24.13 PM.png]]
- Key extraction via electrical potential
		-![[Screenshot 2025-12-02 at 4.24.38 PM.png]]
- Cache timing attacks
	- Manipulate cache to a known state, wait for victim activity, then examine what has changed
