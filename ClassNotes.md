[TOC]

## Recursion

* Get to all the element of the list
* What should be the answer for empty list or non-empty list

  * Typically in terms of the answer for the tail of the list
* Functions that produce list of any size is recursive:

  * Create a list out of smaller lists
* **Avoid repeated recursion** 

  * save **Recursive results**  in local bindings is essential 


# Class Summary

_This notes will mainly about sematic and interesting programming language feature **not** about particular programming language itself

## Class one

* ML programs is a sequence of bindings.

  * Each binding gets *type-checked* and then (assuming it type-checks)
    evaluated. What type (if any) a binding has depends on a **static environment**,1 which is roughly the types
    of the preceding bindings in the file. How a binding is evaluated depends on a **dynamic environment**, which
    is roughly the values of the preceding bindings in the file.

* A **Value** is an expression that, "has no more computation to do"

  *  All values are expressions. Not all expressions
    are values.

* Whenever you **learn a new construct** in a programming language, you should ask these three
  questions:

  * **What is the syntax? What are the type-checking rules? What are the evaluation

  rules?**

* The **evaluation rule for a function binding** is trivial: A function is a value — we simply add x0 to the environment as a function that can be called later.

* **To write a recursive function**, the thought process involves thinking about the base case — for example, what should the answer be for an empty list — and the recursive case — how can the answer be expressed in terms of the answer for the rest of the list.

* use local variable to avoid repeated computation

* e1 andalso e2 == if e1 then e2 else false;  e1 orelse e2 == if e1 then true else e2

* **About inmutable**

  * Because if there is no such feature, then when you are writing your code you can rely on **no**
    **other code** doing something that would make your code wrong, incomplete, or difficult to use.
  * **Saving space** is a nice advantage of immutable data, but so is simply not having to worry
    about whether things are aliased or not when writing down elegant algorithms.

* the essential pieces for any PL:

  * **Syntax**: How do you write the various parts of the language?
  *  **Semantics**: What do the various language features mean? For example, how are expressions evaluated?
  * **Idioms**: What are the common approaches to using the language features to express computations?