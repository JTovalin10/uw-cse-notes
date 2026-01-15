```c
{{ P }} // pre-condition
  S // code
{{ Q }} // post-condition
```
- A hoare triple has two assertions and some code
- Triple is "valid" if the code is correct
	- Given S, $P \rightarrow Q$
	- otherwise false

# Hoare Triples with No Code
```C
{{P}} // pre condition
{{Q}} // Post condition
```
- when is it valid
	- $P \rightarrow Q$
	- just do proof by calculation
# With code
- we can use forward and backwards reasoning
	- move the assertions towards each other untul they meet
# with multiple lines of code
```C
{{ P }}
   S
{{ R }}
   T
{{ Q }}
```
- valid iff there exists an R making both triples valid


# Moving Forward/backwards
- fills in assertions
- Forward
	- fills in postcondition
	-gives strongest post condition making the triple valid
- backwards
	- fills in precondition
	- gives weakest precondition making the triple valid