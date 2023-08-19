{-
Every function in Haskell officially takes one parameter. So how is it possible
that we defined and used several functions that take more than one parameter so
far? Well, it's a clever trick! All the functions that accepted *several
parameters* so far have been **curried functions**.

What does that mean? You'll understand it best on an example. Let's take our
good friend, the `max` function. It looks like it takes two parameters and
returns the one that's bigger.

Doing "max 4 5" first creates a function that takes a parameters and returns
either 4 or that parameter, depending on which is bigger. Then, `5` is applied
to that function and that function produces our desired result.

That sounds like a mouthful but it's actually a really cool concept.

The following two calls are equivalent:

    ghci> max 4 5
    5
    ghci> (max 4) 5
    5

Putting a space between two things is simply **function application**. The
space is sort of like an operator and it has the higher precedence.

Let's examine the type of `max`. It's "max :: (Ord a) => a -> a -> a". That can
also be written as "max :: (Ord a) => a -> (a -> a)". That could be read as:
`max` takes an `a` and returns (that's the ->) a function that takes an `a` and
returns an `a`. That's why the return type and the parameters of functions are
simply separated with arrows.

So how is that beneficial to us? Simply speaking, if we call a function with
too few parameters, we get back a **partially applied** function, meaning a
function that takes as many parameters as we left out.

Using partial application (calling functions with too few parameters, if you
will) is a neat way to create functions on the fly so we can pass them to
another function or seed them with some data.

Take a look at this offensively simply function:
-}

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z

{-
What really happens when we do "multThree 3 5 9" or "((multThree 3) 5) 9"?

First, 3 is applied to multThree, because they're separated by a space. This
creates a function that takes one parameter and returns a function. So then 5
is applied to that, which creates a function that will take a parameter and
multiply it by 15. 9 is applied to that function so that function and the
result is 135 or something.

Remember that this functions type could also be written as "multThree :: (Num
a) => a -> (a -> (a -> a))". The thing before the -> is the parameter that a
function takes and the thing after is what it returns. So our function takes an
a and returns a function of type (Num a) => a -> (a -> a). Similarly, this
function takes an a and returns a function of type (Num a) => a -> a. And this
function, finally, just takes an a and returns an a.

Take a look at this:

    ghci> let multTwoWithNine = multThree 9
    ghci> multTwoWithNine 2 3
    54
    ghci> let multWithEighteen = multTwoWithNine 2
    ghci> multWithEighteen 10
    180

By calling functions with too few parameters, so to speak, we're creating new
functions on the fly.

What if we wanted to create a function that takes a number and compares it to
100? We could do something like this:
-}

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred = compare 100

{-
The type declaration stays the same, because "compare 100" returns a function.
Compare has a type of "(Ord a) => a -> (a -> Ordering)" and calling it with 100
returns a "(Num a, Ord a) => a -> Ordering".

The additional class constraint sneaks up there because 100 is also part of the
Num typeclass.

=== Yo! Make sure that you really understand how curried functions and partial
application work because they're really important!
===

---

Infix functions can also be partially applied by using sections.

To section an infix function, simply surround it with parentheses and only
supply a parameter on one side. That creates a function that takes one
parameter and then applies to the side that's missing an operand.

An insultingly trivial function:
-}

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)
-- ghci> divideByTen 200
-- 20.0
-- ghci> divideByTen 57
-- 5.7
-- ghci> divideByTen 1
-- 0.1
-- ghci> divideByTen 10
-- 1.0

{-
Calling, say, divideByTen 200 is equivalent to doing 200 / 10, as is doing
(/10) 200.

---

A function that checks if a character supplied to it is an uppercase letter:
-}

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])
-- ghci> isUpperAlphanum 'b'
-- False
-- ghci> isUpperAlphanum 'G'
-- True

{-
The only special thing about sections is using `-`. From the definition of
sections, (-4) would result in a function that takes a number and subtracts 4
from it. However, for convenience, (-4) means minus four.

So if you want to make a function that subtracts 4 from the number it gets as a
parameter, partially apply the `subtract` function like so: "(subtract 4)".

What happens if we try to just do "multThree 3 4" in GHCi instead of binding it
to a name with a let or passing it to another function?

    ghci> multThree 3 4

    <interactive>:25:1: error:
        • No instance for (Show (Integer -> Integer))
            arising from a use of ‘print’
            (maybe you haven't applied a function to enough arguments?)
        • In a stmt of an interactive GHCi command: print it

GHCi is telling us that the expression produced a function of type `a -> a`
(Integer -> Integer in my error), but it doesn't know how to print it to the
screen.

Functions aren't instances of the Show typeclass, so we can't get a neat string
representation of a function.

When we do, say, "1 + 1" at the GHCi prompt, it first calculates that to "2"
and then calls `show` on `2` to get a textual representation of that number.
And the textual representation of `2` is just the string "2", which then gets
printed to our screen.
-}
