# CSE484: Spectre

**Spectre** is a class of hardware vulnerability that exploits **speculative execution** — a CPU optimization where the processor executes instructions ahead of time before it knows if they are needed — to leak information across security boundaries via a **cache timing side channel**.

![[Screenshot 2025-12-02 at 4.31.43 PM.png]]

## Spectre Threat Model

An attacker can read memory from another process or even the kernel without being authorized to do so, purely by observing timing behavior of the CPU's cache.

![[Screenshot 2025-12-02 at 4.32.33 PM.png]]

## Spectre Attack Sketch

1. **Train the branch predictor** to follow one branch of a conditional — the CPU learns to "predict" that a certain path will be taken.
2. **After training**, set up a condition where the predicted branch would **access information the code should not be allowed to access**: `secret = array1[x]` for a large out-of-bounds index `x`.
3. During speculative execution, the CPU fetches the secret, and this **affects which part of `array2` is loaded into the cache** (the secret value is used as an index into `array2`).
4. **After the hardware determines the branch was incorrectly predicted**, the speculative execution is rolled back — but the **cache state is not restored**. `array2[secret * stride]` remains in cache.
5. **Time reads** to each row of `array2`. The row that hits (fast) reveals the value of `secret`.

## Related

- [[Side Channel Attacks]] — general overview of side channel attack methods, including cache timing
- [[CSE484/Security Fundamentals/Other types of attacks|Other Types of Attacks]] — timing attacks at the software level