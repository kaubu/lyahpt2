{-
Pattern matching consists of specifying patterns to which some data should
conform and then checking to see if it does and then deconstructing the data
according to those patterns.

When defining functions, you can define separate function bodies for different
patterns. This leads to really neat code that's simply and readable. You can
pattern match on any data type — numbers, characters, lists, tuples, etc.

Let's make a really trivial function that checks if the number we supplied to
it is a seven or not.
-}

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"
-- ghci> lucky 7
-- "LUCKY NUMBER SEVEN!"
-- ghci> lucky 2
-- "Sorry, you're out of luck, pal!"

{-
When you call "lucky", the patterns will be checked from top to bottom and when
it conforms to a pattern, the corresponding function body will be used.

The only way a number can conform to the first pattern here is if it is 7. If
it's not, it falls through to the second pattern, which matches anything and
binds it to `x`.

This function could have also been implemented by using an if statement. But
what if we wanted a function that says the numbers from 1 to 5 and says "Not
between 1 and 5" for any other number? Without pattern matching, we'd have to
make a pretty convoluted if then else tree. However, with it:
-}

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5!"
-- ghci> sayMe 1
-- "One!"
-- ghci> sayMe 5
-- "Five!"
-- ghci> sayMe 3
-- "Three!"
-- ghci> sayMe 24
-- "Not between 1 and 5!"

{-
Note that if we moved the last pattern (the catch-all one) to the top, it would
always say "Not between 1 and 5!" because it would catch all the numbers and
they wouldn't have a chance to fall through and be checked for any other
patterns.

Remember the factorial function we implemented previously? We defined the
factorial of a number `n` as `product [1..n]`. We also define a factorial
function recursively, the way it is usually defined in mathematics. We start by
saying that the factorial of 0 is 1. Then we state that the factorial of any
positive integer is that integer multiplied by the factorial of its
predecessor. Here's how that looks like translated in Haskell terms.
-}

factorial :: (Integral a) => a -> a
factorial 0 = 1
-- factorial n = factorial (pred n) -- My guess
factorial n = n * factorial (pred n) -- The book says n - 1
-- ghci> factorial 0
-- 1
-- ghci> factorial 4
-- 24
-- ghci> factorial 17
-- 355687428096000

{-
This is the first time we've defined a function recursively. Recursion is
important in Haskell and we'll take a closer look at it later. But in a
nutshell, this is what happens when we get a factorial of, say, 3. It tries to
compute "3 * factorial 2". The factorial of 2 is "1 * factorial 0", so we have
"3 * (2 * (1 * factorial 0))". Now here comes the trick — we've defined the
factorial of 0 to just be 1 and because it encounters that pattern before the
catch-all one, it just returns 1. So the final result is equivalent to "3 * (2
* (1 * 1))". Had we written the second pattern on top of the first one, it
would catch all numbers, including 0 and our calculation would never terminate.
That's why order is important when specifying patterns and why it's always best
to specify the most specific ones first and then the more general ones later.

Pattern matching can also fail. If we define  a function like this:
-}

charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

{-
and then try to call it with an input that we didn't expect, this is what
happens:

    ghci> charName 'a'
    "Albert"
    ghci> charName 'b'
    "Broseph"
    ghci> charName 'h'
    "*** Exception: 4_syntax_in_functions/9_pattern_matching.hs:(94,1)-(96,22): Non-exhaustive patterns in function charName

It complains that we have non-exhaustive patterns, and rightfully so. When
making patterns, we should always include a catch-all pattern so that our
program doesn't crash if we get some unexpected input.

Pattern matching can also be used on tuples. What if we wanted to make a
function that takes two vectors in a 2d space (that are formed in pairs) and
adds them together? To add together two vectors, we add their x components
separately and then their y components separately. Here's how we would have
done it if we didn't know about pattern matching:
-}

addVectors :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors a b = (fst a + fst b, snd a + snd b)

-- Well, that works, but there's a better way to do it. Let's modify the
-- function so that it uses pattern matching.

addVectors' :: (Num a) => (a,a) -> (a,a) -> (a,a)
addVectors' (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

{-
There we go! Much better. Note that this is already a catch-all pattern. The
type of addVectors (in both cases) is "addVectors :: (Num a) => (a,a) -> (a,a)
-> (a,a)", and so we are guaranteed to get two pairs as parameters.

`fst` and `snd` extract components of pairs. But what about triples? Well,
there are no provided functions that do that but we can make our own.
-}

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- ghci> first ('a','b','c')
-- 'a'
-- ghci> second (2,67,2.2)
-- 67
-- ghci> third ('c','@',7)
-- 7

{-
The "_" means the same thing as it does in list comprehensions. It means that
we really don't care what that part is, so we just write a "_".

Which reminds me, you can also pattern match in list comprehensions. Check this
out:

    ghci> let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
    ghci> [a+b | (a,b) <- xs]
    [4,7,6,8,11,4]

Should a pattern match fail, it will just move on to the next element.

List themselves can also be used in pattern matching. You can match with the
empty list [] or any pattern that involves `:` and an empty list. But since
[1,2,3] is just syntactic sugar for 1:2:3:[], you can also use the former
pattern. A pattern like x:xs will bind the head of the list to x and the rest
of it to xs, even if there's only one element so xs ends up being an empty
list.

Note: The x:xs pattern is used a lot, especially with recursive functions. But
patterns that have : in them only match against lists of length 1 or more.

If you want to bind, say, the first three elements to variables and the rest of
the list to another variable, you can use something like x:y:z:zs. It will only
match against lists that have at least three elements or more.

Now that we know how to pattern match against lists, let's make out own
implementation of the `head` function.
-}

head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x
-- ghci> head' []
-- *** Exception: Can't call head on an empty list, dummy!
-- CallStack (from HasCallStack):
--   error, called at 4_syntax_in_functions/9_pattern_matching.hs:186:12 in main:Main
-- ghci> head' [1]
-- 1
-- ghci> head' [1,2,3,4]
-- 1

{-
Nice! Notice that if you want to bind several variables (even if one of them is
just _ and doesn't actually bind at all), we have to surround them in
parentheses. Also notice the error function that we used. It takes a string and
generates a runtime error, using that string as information about what kind of
error occurred. It causes the program to crash, so it's not good to use it too
much. But call head on an empty list doesn't make sense.

Let's make a trivial function that tells us some of the first elements of the
list in (in)convenient English form.
-}

tell :: (Show a) => [a] -> String
tell [] = "This list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y
-- ghci> tell []
-- "This list is empty"
-- ghci> tell [1]
-- "The list has one element: 1"
-- ghci> tell ['b', 'c']
-- "The list has two elements: 'b' and 'c'"
-- ghci> tell "Guten Tag!"
-- "This list is long. The first two elements are: 'G' and 'u'"

{-
This function is safe because it takes care of the empty list, a singleton
list, a list with two elements, and a list with more than two elements.

Note that (x:[]) and (x:y:[]) could be rewritten as [x] and [x,y] (because it's
syntactic sugar, we don't need the parentheses). We can't rewrite (x:y:_) with
square brackets because it matches any list of length 2 or more.

We've already implemented our own length function using list comprehension. Now
we'll do it by using pattern matching and a little recursion.
-}

length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs
-- ghci> length' [1,2,3]
-- 3
-- ghci> length' [1,2,3,4]
-- 4
-- ghci> length' []
-- 0

{-
This is similar to the factorial function we wrote earlier. First we defined
the result of a known input — the empty list. This is also known as the edge
condition. Then in the second pattern we take the list apart by splitting it
into a head and a tail. We say that the length is equal to 1 plus the length of
the tail. We use _ to match the head because we don't actually care what it is.
Also note that we've taken care of all possible patterns of a list. The first
pattern matches an empty string and the second one matches anything that isn't
an empty list.

Let's see what happens if we call length' on "ham". First it will check if it's
an empty list. Because it isn't, it falls through to the second pattern. It
matches on the second pattern and there it says that the length is 1 + length'
"am", because we broke it into a head and a tail and discarded the head. Okay.
The length' of "am" is, similarly 1 + length' "m". So right now we have 1 + (1
+ length' "m"). length' "m" is 1 + length' "" (could also be written as 1 +
length' []). And we've defined length' [] to be 0. So in the end we have 1 + (1
+ (1 + 0)).

Let's implement sum. We know that the sum of an empty list is 0. We write that
down as a pattern. And we also know that the sum of a list is the head plus the
sum of the rest of the list. So if we write that down we get:
-}

-- My guess without looking at the answers
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs
-- I checked the book, I got a textbook answer
-- ghci> sum' []
-- 0
-- ghci> sum' [1,2]
-- 3
-- ghci> sum' [1,2,5,215,2]
-- 225

{-
There's also a thing called *as patterns*. Those are a handy way of breaking
something up according to a pattern and binding it to names whilst still
keeping a reference to the whole thing. You do that by putting a name and an @
in front of a pattern. For instance, the pattern xs(@x:y:ys). This pattern will
match exactly the same thing as x:y:ys but you can easily get the whole list
via xs instead of repeating yourself by typing out x:y:ys in the function body
again.

Here's a quick and dirty example:
-}

capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
-- ghci> capital "Dracula"
-- "The first letter of Dracula is D"
-- ghci> capital "hello"
-- "The first letter of hello is h"

{-
Normally we use as patterns to avoid repeating ourselves when matching against
a bigger pattern when we have to use the whole thing again in the function
body.

One more thing — you can't use ++ in pattern matches. If you tried to pattern
match against (xs ++ ys), what would be in the first and what would be in the
second list? It doesn't make much sense. It would make sense to match stuff
against (xs ++ [x,y,z]) or just (xs ++ [x]), but because of the nature of
lists, you can't do that.
-}
