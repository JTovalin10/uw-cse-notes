# Correctness of Loops
- assignment and condition reasoning is mechanical
- loop reasoning cannot be made mechanical
	- no way around this 
- one extra bit of information fixes this
	- need to provide a loop invariant
	- with the invariant, reasoning is again mechanical
# Loop Invariants
- loop invariant is true every time at hte top of the loop
	- must be true when we get to the top the first time
	- must remain true each time execute S and loop back up
- Use "Inv": to indicate a loop invariant

```C
{{ P }}
{{ Inv: I }}
while (cond) {
{{ I and cond }}
S
{{ I }}
}
{{ I and not cond }}
{{ Q }}
```
- the steps here are the following
	- I holds initally
	- S preserves I
	- Q holds when loop exists