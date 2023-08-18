{-
We mention recursion briefly in the previous chapter. In this chapter, we'll
take a closer look at recursion, why it's important to Haskell, and how we can
work out very concise and elegant solutions to problems by thinking
recursively.

---

If you still don't know what recursion is, read this sentence. Haha! Just
kidding! Recursion is action a way of defining functions in which the function
is applied inside its own definition. Definitions in mathematics are often
given recursively.

For instance, the Fibonacci sequence is defined recursively. First, we define
the first two Fibonacci numbers non-recursively. We say that F(0) = 0 and F(1)
= 1, meaning that the 0th and 1st Fibonacci numbers are 0 and 1, respectively.

Then, we say that for any other natural number, that Fibonacci number is the
sum of the previous two Fibonacci numbers. So F(n) = F(n-1) + F(n-2). That way,
F(3) is F(2) + F(1), which is (F(1) + F(0)) + F(1).

Because we've now come down to only non-recursively defined Fibonacci numbers,
we can safely say that F(3) is 2. Having an element or two in a recursion
definition defined non recursively (like F(0) and F(1) here) is also called
**edge condition** and is important if you want your recursive function to
terminate. If we hadn't defined F(0) and F(1) non recursively, you'd never get
a solution to any number because you'd reach 0 and then you'd go into negative
numbers. All of a sudden you'd be saying that F(-2000) is F(-2001) + F(-2002)
and there still wouldn't be an end in sight!

---

Recursion is important to Haskell because unlike imperative languages, you do
computations in Haskell by declaring what something *is* instead of *how* you
get it. That's why there are no while loops or for loops in Haskell, and
instead we many times have to use recursion to declare what something is.
-}
