**[[CSE341/Definitions/Part1/Option|Option]]**: A type constructor used to represent a value that may or may not exist (a "partial" value).
### Formal Definition
A type $t \text{ option}$ is a **[[CSE341/Definitions/Part1/Variant|Variant]]** with two constructors: `None` (representing no data) and `Some v` (where $v$ has type $t$).
### Simplified Explanation
A box that is either empty or contains exactly one item.
