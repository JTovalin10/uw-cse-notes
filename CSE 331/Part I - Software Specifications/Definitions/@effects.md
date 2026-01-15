results of mutation listed
- promises about the state when the call returns
- no @effects means any change is possible
- [[@modifies]]
```C
@modifies A
@effects all entries of A set to zero
void clear(int[] A)
```