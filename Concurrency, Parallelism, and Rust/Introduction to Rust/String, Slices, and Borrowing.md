# Concurrency, Parallelism, and Rust: String, Slices, and Borrowing

This note continues [[Concurrency, Parallelism, and Rust/Introduction to Rust/Introduction to Rust|Introduction to Rust]]. It covers how Rust reports failure without exceptions (`Result` and `Option`), how a slice views part of an array without copying, and how `String` and `&str` apply the ownership and borrowing rules to text.

---

## Calling Methods and Macros

- Rust **dereferences for you** when calling methods, so we do not need to write the dereference ourselves.
- **Macros**: a name ending in `!` is a macro (e.g. `println!`).
  - A macro can take any number of arguments and checks them at compile time.

---

## Result<T, E>

- Rust has **no exceptions**.
  - An exception would jump past the code that owns and cleans up values, which breaks the ownership model where the owner frees its memory.
- A function that can fail returns a `Result`.

```rust
// T is the value
// E is the error
enum Result<T, E> {
    Ok(T),  // it worked, returns the value
    Err(E), // it failed: here's why
}

enum Op {
    Add,
    Div,
}

// the return type tells the caller it can fail
fn eval(op: Op, a: i32, b: i32) -> Result<i32, String> {
    // we have to cover every case
    match op {
        Op::Add => Ok(a + b),
        Op::Div if b == 0 => Err(String::from("div by 0")),
        Op::Div => Ok(a / b), // match arms are read sequentially
    }
}
```

- We can handle a `Result` with `match`:

```rust
match eval(Op::Div, 9, 0) {
    Ok(n) => println!("ok: {n}"),
    Err(e) => println!("error: {e}"),
}
```

### The ? Operator

- `?` is shorthand for the `match` on `Ok` and `Err`. It is only good for simple propagation: if an error is returned, we terminate the function and hand the error to the caller, since we cannot make progress anymore.

```rust
fn add_div(a: i32, b: i32) -> Result<i32, String> {
    // these two are equivalent
    let sum = eval(Op::Add, a, b)?;
    let sum = match eval(Op::Add, a, b) {
        Ok(v) => v,
        Err(e) => return Err(e), // `?` does this early return for us
    };
    Ok(sum)
}
```

### unwrap and expect

- `unwrap`: when we get a `Result`, `unwrap` gives us the `Ok` value (e.g. as `n`). If it is an `Err`, the program **panics**.
- `expect`: like `unwrap`, but panics with a message we supply.
- Errors a caller should handle belong in a `match` or `?`, not in `unwrap` or `expect`.

---

## Option<T>

- `Option<T>` means "maybe a value". It is Rust's fix for the null pointer "mistake".
- It tells us a function might or might not return a value, and it tells us when it does not.
- It is either `Some(T)` or `None`.
- It is not like a null reference, because we **have** to handle both cases before using the value.

---

## Slices: A View Into an Array

```rust
let a: [i32; 3] = [0, 1, 2]; // on the stack
let b: &[i32] = &a[1..2];    // a view: no copying, acts like a pointer, and also knows its length
```

- A **slice** `&[T]` borrows part of an array, so no data is copied.
- It carries a pointer and a length, which lets the compiler check bounds.
- Functions can take a slice, so one function works for any array or `Vec` it is given.

---

## Strings

- `String`: an **owned, growable** string, like C++ `std::string`.
  - The text is on the **heap**, encoded in UTF-8.
  - Because the text is on the heap, passing a `String` into a function without a reference **moves** the data (see [[Concurrency, Parallelism, and Rust/Introduction to Rust/Introduction to Rust#Moves|Moves]]).

### String Literals

- `&str` is a **borrowed string slice**.
- `str` is the text itself: some number of bytes.
  - Its size is not known at compile time, so we always use it through a `&str`.
- A literal's bytes live in the program's **read-only data**.
- We can convert a `String` to a `&str` by borrowing it.

---

## Related

- [[Concurrency, Parallelism, and Rust/Introduction to Rust/Introduction to Rust|Introduction to Rust]]: ownership, moves, and borrowing
- [[Systems Programming/Smart Pointers/Shared Pointer|Shared Pointer]]: ownership in C++

## Industry Standard Terms

- **Result<T, E>** → error-as-value / sum-type error handling (like Go's `(value, error)` or C++ `std::expected`)
- **Option<T>** → optional / maybe type (like C++ `std::optional`)
- **Slice (`&[T]`)** → fat pointer / span (like C++ `std::span`)
- **`&str`** → string view (like C++ `std::string_view`)
- **`?` operator** → error propagation
