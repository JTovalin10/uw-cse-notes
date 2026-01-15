# The Stack in Memory Management

The stack is a part of memory that holds local variables and function call information.

```c
int main() {
	int a = 2;
	int b = 4;
	temp();
}
int temp() {
	int c = 10;
	int d;
}
```

## Stack Visualization

### Case 1: During Function Execution

|main|temp|
|---|---|
|a=2|c=10|
|b=4|d|

### Case 2: Before temp() is Called

```c
int main() {
	int a = 2;
	int b = 4;
	// stack until here //
	temp();
}
```

|Stack|Value|
|---|---|
|a|2|
|b|4|

### Case 3: After temp() Returns

```c
int main() {
	int a = 2;
	int b = 4;
	temp(); // after this returns
	int e = 5; // new variable
}
```

|Stack|Value|
|---|---|
|a|2|
|b|4|
|e|5|

## Example with Conditions

```c
int main() {
    int x = 10;
    
    if (x > 5) {
        int y = 20; // only created if condition is true
        printf("%d %d\n", x, y);
    }
    else {
        int z = 30; // only created if condition is false
        printf("%d %d\n", x, z);
    }
    
    int final = 100;
}
```

### Stack When x > 5 (True Branch)

|Variable|Value|
|---|---|
|x|10|
|y|20|
|final|100|

### Stack When x ≤ 5 (False Branch)

|Variable|Value|
|---|---|
|x|10|
|z|30|
|final|100|

## Example with Loops

```c
int main() {
    int count = 0;
    
    for (int i = 0; i < 3; i++) {
        int temp = i * 10;
        count += temp;
    }
    
    int result = count;
}
```

### Stack During 1st Iteration (i = 0)

|Variable|Value|
|---|---|
|count|0|
|i|0|
|temp|0|

### Stack During 2nd Iteration (i = 1)

|Variable|Value|
|---|---|
|count|0|
|i|1|
|temp|10|

### Stack During 3rd Iteration (i = 2)

|Variable|Value|
|---|---|
|count|20|
|i|2|
|temp|20|

### Stack After Loop

|Variable|Value|
|---|---|
|count|40|
|result|40|
