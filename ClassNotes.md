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
  * **Semantics**: What do the various language features mean? For example, how are expressions evaluated?
  * **Idioms**: What are the common approaches to using the language features to express computations?

---

## Class two

* **Compound Types**

  * **Each-of** :A compound type t describes values that contain each of values of type t1, t2, ..., and
    tn.
  * **“One-of”**: A compound type t describes values that contain a value of one of the types t1, t2, ..., or
    tn.
  * **“Self-reference”**: A compound type t may refer to itself in its definition in order to describe recursive
    data structures like lists and trees.

* **By** name by Position, ==Syntactic Sugar==

  * Records are **By name**(==Order does not matters==; Tuples are **By Position**(==Order matters==)
  * Java's hybrid approach: *The method body uses variable names to refer to the different arguments, but the caller passes arguments by position.* 
  * Syntactic Sugar
    * It is syntactic because we can describe everything about tuples
      ==in terms of equivalent== record syntax. It is sugar because it makes the language sweeter
    * Syntactic sugar is a great way to keep the key ideas in a programming-language
      ==small== (making it easier to implement) while giving programmers convenient ways to write things.

* **Datatype Bindings**

  * *Constructors*: ,<u>First, it is either a function for creating values of the new type (if
    the variant has of t for some type t) or it is actually a value of the new type</u>
    * **The result** of these *Constructor* function calls are values that “know
      **which variant** they are” (they store a “tag”) and have the **underlying data** passed to the constructor
  * **Pattern matching and Case expressions. Type synonyms**
    * ==Case expression== : it evaluates two of its subexpressions: first the expression between the case and of keywords and second the expression in the first branch that matches.
    * ==P => e==  Patterns are used to match against the result of evaluating the case's first expression,  **Thus**, evaluating a case expression is called ==Pattern matching==
    * *The  type checker knows what types these variables have because they were specified  in the datatype binding that created the constructor used in the pattern*
    * **Pattern matching is good because**:
      1. warning for repeated branches
      2. warning for non-exhausted variants
      3. never mess up and try to get something out of a **Wrong** variant
  * A type synonym simply creates another name for an existing type that is
    entirely interchangeable with the existing type.
  * ==Polymorphic Datatypes==
    * datatype 'a option = NONE | SOME  of 'a
  * **Every function in ML takes exactly one argument**! Every time we write a multi-argument function,we are really writing a one-argument function that takes a tuple as an argument and ==uses pattern-matching== to extract the pieces.

* Type Inference

  * ==One more good thing== for pattern matching is that it provides the information for your language implementation to do type inference so that ==you do not need to write down the type==

* Polymorphic type

  *  If you can take a type containing ’a, ’b, ’c, etc. and replace each of these type variables
    **consistently** to get the type you “want,” then you have a more general type than the one you want.

* Nested Pattern

  * anywhere we have been putting a variable in our patterns, we can instead put another pattern. 

* **Tail recursion**

  * How function call are implemented::

    * ```Conceptually, there is a call stack, which is a stack (the
      Conceptually, there is a call stack, which is a stack (the data structure with push and pop operations) with one element for each function call that has been started
      but has not yet completed. Each element stores things like the value of local variables and what part of the function has not been evaluated yet. When the evaluation of one function body calls another function, a new element is pushed on the call stack and it is popped o↵ when the called function completes.
      ```

  * tail call:  *there is nothing more for the caller to do after the callee returns except return the callee’s result.*

    * optimization: When a call is a tail call, the caller’s stack-frame is popped **before the call** — the callee’s stack-frame just replaces the caller’s. 
    * Tail calls do not need to be to the same function (f can call g), so they are **more flexible than while-loops** that always have to “call” the same loop.
    * Converting need ==associativity==...
    * tail position:	
      * the position that has no more things for caller after callee returns