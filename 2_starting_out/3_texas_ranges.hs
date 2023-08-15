-- Haskell ranges are inclusive

-- Writing [1..20] generates a list of 1 through 20, like so:
integerRange = [1..20]
-- [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

lowerRange = ['a'..'z']
-- "abcdefghijklmnopqrstuvwxyz"

upperRange = ['A'..'Z']
-- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

-- Ranges are cool because you can also specify a step
-- What if we want all even numbers between 1 and 20?
-- Or every third number between 1 and 20?
evenNumbers = [2,4..20]
-- [2,4,6,8,10,12,14,16,18,20]

thirdNumber = [3,6..20]
-- [3,6,9,12,15,18]

-- As you can see, you have to input two elements and the step is guessed from
-- that.
-- You can only specify one step.

-- To make a list of all numbers from 20 to 1, you can't just do [20..1], you
-- have to do:
downRange = [20,19..1]
-- [20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]

-- Floating point numbers aren't completely precise, so using them in ranges
-- can be pretty funky!
floatingRange = [0.1, 0.3..1]
-- [0.1,0.3,0.5,0.7,0.8999999999999999,1.0999999999999999

-- You should probably not use floating point numbers in list ranges

-- You can also use ranges to make infinite lists by just not specifying an
-- upper limit.

{-
Let's examine how you would get the first 24 multiples of 13.

Sure, you could do [13,26..24*13], but there's a better way:
-}
multiples = take 24 [13,26..]
-- [13,26,39,52,65,78,91,104,117,130,143,156,169,182,195,208,221,234,247,260,
-- 273,286,299,312]

{-
Because Haskell is lazy, it won't try to evaluate the infinite list immediately
because it would never finish. It'll wait to see what you want to get out of
that infinite list. And here it sees you just want the first 24 elements and it
gladly obliges.

A handful of functions that produce infinite lists:
-}

-- `cycle` takes a list and cycles it into an infinite list. If you just try to
-- display the result, it will go on forever, so you have to slice it off
-- somewhere.
cycleRes = take 10 (cycle [1,2,3])
-- [1,2,3,1,2,3,1,2,3,1]
cycleRes' = take 12 (cycle "LOL ")
-- "LOL LOL LOL "

-- `repeat` takes an element and produces an infinite list of just that
-- element. It's list cycling a list with only one element.
repeatRes = take 10 (repeat 5)
-- [5,5,5,5,5,5,5,5,5,5]

-- Although it's simpler to just use the `replicate` function if you want some
-- number of the same element in a list.
replicateRes = replicate 3 10
replicateRes' = 3 `replicate` 10
-- [10,10,10]

