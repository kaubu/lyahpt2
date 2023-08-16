{-
We can use the `:t` command which, followed by any valid expression, tells us
its type.

    ghci> :t 'a'  
    'a' :: Char  
    ghci> :t True  
    True :: Bool  
    ghci> :t "HELLO!"  
    "HELLO!" :: [Char]  
    ghci> :t (True, 'a')  
    (True, 'a') :: (Bool, Char)  
    ghci> :t 4 == 5  
    4 == 5 :: Bool  

Here we see that doing `:t` on an expression prints out the expression followed
by `::` and its type.

`::` is read as "has type of".

Explicit types are always denoted with the first letter in capital case.

'a' it would seem, has a type of Char. It's not hard to conclude that this
stands for character.

True is of a Bool type. That makes sense.

But what's this? Examining the type of "HELLO!" yields a [Char] (it actually
yields String in the latest Haskell version). The square brackets denote a
list. So we read that as it being a list of characters.

Unlike lists, each tuple length has its own type. So the expression of "(True,
'a')" has a type of (Bool, Char), whereas an expression such as ('a','b','c')
would have the type of (Char, Char, Char).

4 == 5 will always return False, so its type is Bool.
-}

{-
Functions also have types. When writing our own functions, we can choose to
give them an explicit type declaration.

This is generally considered to be good practice except when writing very short
functions.

From here on, we'll give all the functions that we make type declarations.

Remember the list comprehension that we made previously that filters a string
so that only caps remain? Here's how it looks with a type declaration.
-}

-- removeNonUppercase :: [Char] -> [Char]
removeNonUppercase :: String -> String
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z'] ]

{-
removeNonUppercase has a type of [Char] -> [Char], meaning that it maps from a
string to a string. That's because it takes one string as a parameter and
returns another result.

The [Char] type is synonymous with String so it's clearer if we write
"removeNonUppercase :: String -> String".

We didn't have to give this function a type declaration because the compiler
can infer by itself that it's a function from a string to a string but we did
anyway.

But how do we write out the type of a function that takes several parameters?
Here's a simple function that takes three integers and adds them together:
-}

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

{-
The parameters are separated with `->` and there's no special distinction
between the parameters and the return type.

The return type is the last item in the declaration and the parameters are the
first three.

Later on we'll see why they're all just separated with `->` instead of having
some more explicit distinction between the return types and the parameters like
"Int, Int, Int -> Int" or something.
-}

{-
If you want to give your function a type declaration but are unsure as to what
it should be, you can always just write the function without it and then check
with `:t`. Functions are expressions too, so `:t` works on them without a
problem.
-}

{-
Here's an overview of some common types:

Int stands for integer. It's used for whole numbers. 7 can be an Int but 7.2
cannot. Int is bounded, which means that it has a minimum and a maximum value.
Usually on 32-bit machines the maximum possible Int is 2147483647 and the
minimum is -2147483648.

Integer stands for, er… also integer. The main difference is that it's not
bounded so it can be used to represent really really big numbers. I mean like
really big. Int, however, is more efficient.

    factorial :: Integer -> Integer  
    factorial n = product [1..n]

    ghci> factorial 50  
    30414093201713378043612608166064768844377641568960512000000000000  

Float is a real floating point with single precision.

    circumference :: Float -> Float  
    circumference r = 2 * pi * r  

    ghci> circumference 4.0  
    25.132742

Double is a real floating point with double the precision!

    circumference' :: Double -> Double  
    circumference' r = 2 * pi * r  

    ghci> circumference' 4.0  
    25.132741228718345

Bool is a boolean type. It can only have two values: True and False.

Char represents a character. It's denoted by single quotes. A list of
characters is a string.

Tuples are types but they are dependent on their length as well as the types of
their components, so there si theoretically an infinite amount of tuple types,
which is too many to cover in this tutorial. Note that the empty tuple () is
also a type which can only have a single value: ().
-}

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r

