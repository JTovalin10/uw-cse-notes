# CSE341: Variant

A data type that represents a "one-of" choice between several different constructors, each potentially carrying different data.

### Formal Definition

Also known as a Sum Type or Tagged Union. Defined as `type t = C1 [of t1] | ... | Cn [of tn]`.

### Simplified Explanation

A type that says "this value can be one of these specific things," like a Shape being either a Circle, Square, or Triangle.

See: [[CSE341/Pattern Matching/Records and Variants|Records and Variants]]
