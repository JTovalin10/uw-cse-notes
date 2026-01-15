![[Screenshot 2025-12-02 at 4.31.43 PM.png]]

## Spectre Threat Model
![[Screenshot 2025-12-02 at 4.32.33 PM.png]]

# Spectre Attack Sketch
1. train branch predictor to follow one branch of conditional
2. after training, make the followed branch **access information that the code should not be allowed to access(secret=array1[x] for large x)**
3. The secret information will affet **which part** of array2 is loaded into the cache
4. After the hardware determines that the branch was incorrectly executed, the logic of the program will be rolled back but the cache will still be impacted
5. time reads to cache to see which row of array2 was accessed