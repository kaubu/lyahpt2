{-
Whereas patterns are a way of making sure that a value conforms to some form
and deconstructing it, guards are a way of testing whether some property of a
value (or several of them) are true or false. That sounds a lot like an if
statement and it's very similar. The thing is that guards are a lot more
readable when you have several conditions and they play really nice with
patterns.

Instead of explaining their syntax, let's just dive in and make a function
using guards. We're going to make a simple function that responds differently
depending on the density given. Density (or specific mass) is a substance's
mass per unit of volume (here, grams per litre). If a substance has a density
of less than 1.2, it will float in air, as 1.2g/L is the density of air. If it
has more than 1000g/L (the density of water), it will sink in water. Between
are things (like people, usually) that will neither float away nor sink in
water. So here's a function (we won't be calculating density right now, this
function just gets a density and responds).
-}

densityTell :: (RealFloat a) => a -> String
densityTell density
    | density < 1.2     = "Wow! You're going for a ride in the sky!"
    | density <= 1000.0 = "Have fun swimming, but watch out for the sharks!"
    | otherwise         = "If it's sink or swim, you're going to sink."
-- ghci> densityTell 0.8
-- "Wow! You're going for a ride in the sky!"
-- ghci> densityTell 24
-- "Have fun swimming, but watch out for the sharks!"
-- ghci> densityTell 5208
-- "If it's sink or swim, you're going to sink."

{-
Guards are indicated by pipes that follow a functions name and its parameters.
Usually, they're indented a bit to the right and lined up.

A guard is basically a boolean expression. If it evaluates to True, then the
corresponding body is used. If it equates to False, checking drops through to
the next guard, and so on.

If we call this function with 24.3, it will first check if that's smaller or
equal to 1.2. Because it isn't, it falls through to the next guard. The check
is carried out with the second guard, and because 24.3 is less than 1000.0, the
second string is returned.

This is very reminiscent of a big if else tree in imperative languages, only
this is far better and more readable. While big if else trees are usually
frowned upon, sometimes a problem is defined in such a discrete way that you
can't get around them. Guards are a very nice alternative to this.

Many times, the last guard is `otherwise`. otherwise is defined simply as
"otherwise = True" and catches everything. This is very similar to patterns,
only they check if the input satisfies a pattern but guards check for boolean
conditions. If all the guards of a function evaluate to False (and we haven't
provided and otherwise catch-all guard), evaluation falls through to the next
pattern. That's how patterns and guards play nicely together. If no suitable
guards or patterns are found, an error is thrown.

Of course, we can use guards with functions that take as many parameters as we
want. Instead of having the user calculate the density of the substance on
their own before calling the function, let's modify this function so that it
takes a mass (in grams) and volume (in litres).
-}

densityTell' :: (RealFloat a) => a -> a -> String
densityTell' mass volume
    | mass / volume < 1.2       = "Wow! You're going for a ride in the sky!"
    | mass / volume <= 1000.0   = "Have fun swimming, but watch our for the sharks!"
    | otherwise                 = "If it's sink or swim, you're going to sink."

{-
Let's see if cat food will float…

    ghci> densityTell' 400 1
    "Have fun swimming, but watch our for the sharks!"

Looks like it will! At least until it dissolves in the pool… Yuck!

Note that there's no = right after the function name and its parameters before
the first guard. Many newbies get syntax errors because they sometimes put it
there.

Another very simple example: let's implement our own `max` function. If you
remember, it takes two things that can be compared and returns the larger of
them.
-}

max' :: (Ord a) => a -> a -> a
max' a b
    | a > b     = a
    | otherwise = b
-- ghci> max' 4 9
-- 9
-- ghci> max' 75 2
-- 75

{-
Guards can also be written inline, although I'd advise against that because
it's less readable, even for very short functions. But to demonstrate, we could
write max' like this:
-}

max'' :: (Ord a) => a -> a -> a
max'' a b | a > b = a | otherwise = b

-- Ugh! Not very readable at all! Moving on: let's implement our own `compare`
-- using guards.

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b     = GT
    | a == b    = EQ
    | otherwise = LT
-- ghci> 4 `myCompare` 9
-- LT
-- ghci> 42 `myCompare` 42
-- EQ
-- ghci> 12 `myCompare` 1
-- GT

{-
Note: Not only can we call functions as infix with backticks, we can also
define them using backticks. Sometimes its easier to read that way.
-}
