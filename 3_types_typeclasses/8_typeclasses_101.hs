{-
A typeclass is a sort of interface that defines some behaviour.

If a type is a part of a typeclass, that means that it supports and implements
the behaviour the typeclass describes.

A lot of people coming from OOP get confused by typeclasses because they think
they are like classes in object oriented languages. Well, they're not. You can
think of them kind of as Java interfaces, only better.

What's the type signature of the == function?

    ghci> :t (==)
    (==) :: Eq a => a -> a -> Bool

Note: the equality operator, "==", is a function. So are +, *, -, /, and pretty
much all operators. If a function is comprised only of special characters, it's
considered an infix function by default. If we want to examine its type, pass
it to another function, or call it as a prefix function, we have to surround it
in parentheses.

Interesting. We see a new thing here, the => symbol. Everything before the =>
symbol is called a class constraint. We can read the previous type declaration
like this: "the equality function takes any two values that are of the same
type and returns a Bool. The type of those two values must be a member of the
Eq class (this was the class constraint)".

The Eq typeclass provides an interface for testing an equality. Any type where
it makes sense to test for equality between two values of that type should be a
member of the Eq class. All standard Haskell types except for IO (the type for
dealing with input and output) and functions are part of the Eq typeclass.

The `elem` function has a type of "(Eq a) => a -> [a] -> Bool" because it uses
"==" over a list to check whether some value we're looking for is in it.
-}

{-
Some basic typeclasses:

Eq is used for types that support equality testing. The functions its members
implement are == and /=. So if there's an Eq class constraint for a type
variable in a function, it uses == or /= somewhere inside its definition. All
the types we mentioned previously except for functions are part of Eq, so they
can be testing for equality.

    ghci> 5 == 5
    True
    ghci> 5 /= 5
    False
    ghci> 'a' == 'a'
    True
    ghci> "Ho Ho" == "Ho Ho"
    True
    ghci> 3.432 == 3.432
    True

Ord is for types that have an ordering.

    ghci> :t (>)
    (>) :: Ord a => a -> a -> Bool

All the types that we've covered so far except for function are a part of Ord.
Ord covers all the standard comparing functions such as >, <, >=, and <=. The
compare function takes two Ord members of the same type and returns an
ordering.

Ordering is a type that can be GT, LT, or EQ, meaning greater than, less than,
and equal, respectively.

To be a member of Ord, a type must first have membership in the prestigious and
exclusive Eq club.

    ghci> "Abrakadabra" < "Zebra"
    True
    ghci> "Abrakadabra" `compare` "Zebra"
    LT
    ghci> 5 >= 2
    True
    ghci> 5 `compare` 3
    GT

Members of Show can be presented as strings. All types covered so far except
for functions are a part of Show. The most used function that deals with the
Show typeclass is `show`. It takes a value whose type is a member of Show and
presents it to us as a string.

    ghci> show 3
    "3"
    ghci> show 5.334
    "5.334"
    ghci> show True
    "True"

Read is sort of the opposite typeclass of Show. The `read` function takes a
string and returns a type which is a member of Read.

    ghci> read "True" || False
    True
    ghci> read "8.2" + 3.8
    12.0
    ghci> read "5" - 2
    3
    ghci> read "[1,2,3,4]" ++ [3]
    [1,2,3,4,3]

So far so good. Again, all types covered so far are in this typeclass. But what
happens if we try to do just read "4"?

My ghci: ghci> read "4" *** Exception: Prelude.read: no parse Book's ghci:
    ghci> read "4"  
    <interactive>:1:0:  
        Ambiguous type variable `a' in the constraint:  
          `Read a' arising from a use of `read' at <interactive>:1:0-7  
        Probable fix: add a type signature that fixes these type variable(s)  

What GHCI is telling us here is that it doesn't know what we want in return.
Notice that in the previous uses of read we did something with the result
afterward. That way, GHCI could infer what kind of result we wanted out of our
read. If we used it as a boolean, it knew it had to return a Bool. But now, it
knows we want some type that is part of the Read class, it just doesn't know
which one.

Let's take a look at the type signature of read.

    ghci> :t read
    read :: Read a => String -> a

See? It returns a type that is part of Read, but if we don't try to use it in
some way later, it has no way of knowing which type. That's why we can use
explicit type annotations.

Type annotations are a way of explicitly saying what the type of an expression
should be. We do that by adding :: at the end of the expression and then
specifying a type.

Observe:

    ghci> read "5" :: Int
    5
    ghci> read "5" :: Float
    5.0
    ghci> (read "5" :: Float) * 4
    20.0
    ghci> read "[1,2,3,4]" :: [Int]
    [1,2,3,4]
    ghci> read "(3,'a')" :: (Int, Char)
    (3,'a')

Most expressions are such that the compiler can infer what their type is by
itself. But sometimes, the compiler doesn't know whether to return a value of
type Int or Float for an expression like `read "5"`.

To see what the type is, Haskell would have to actually evaluate `read "5"`,
but since Haskell is a statically typed language, it has to know all the types
before the code is compiled (or in the case of GHCI, evaluated). So we have to
tell Haskell: "Hey, this expression should have this type, in case you didn't
know!".

Enum members are sequentially ordered types — they can be enumerated. The main
advantage of the Enum typeclass is that we can use its types in list rangers.
They also have defined successors and predecessors, which you can get with the
succ and pred functions.

Types in this class: (), Bool, Char, Ordering, Int, Integer, Float, and Double.

    ghci> ['a'..'e']
    "abcde"
    ghci> [LT .. GT]
    [LT,EQ,GT]
    ghci> [3..5]
    [3,4,5]
    ghci> succ 'B'
    'C'

Note: You can't type "[LT..GT]", that becomes an error.

Bounded members have an upper and lower bound.

    ghci> minBound :: Int
    -9223372036854775808
    ghci> maxBound :: Char
    '\1114111'
    ghci> maxBound :: Bool
    True
    ghci> minBound :: Bool
    False

minBound and maxBound are interesting because they have the type of `(Bounded
a) => a`. In a sense they are polymorphic constants.

All tuples are also part of Bounded if the components are also in it.

    ghci> maxBound :: (Bool, Int, Char)
    (True,9223372036854775807,'\1114111')

Num is a numeric typeclass. Its members have the property of being able to act
like numbers. Let's examine the type of a number.

    ghci> :t 20
    20 :: Num a => a

It appears that whole numbers are also polymorphic constants. They can act like
any type that's a member of the Num typeclass.

    ghci> 20 :: Int
    20
    ghci> 20 :: Integer
    20
    ghci> 20 :: Float
    20.0
    ghci> 20 :: Double
    20.0

Those are the types that are in the Num typeclass. If we examine the type of
`*`, we'll see that it accepts all numbers.

    ghci> :t (*)
    (*) :: Num a => a -> a -> a

It takes two numbers of the same type and returns a number of that type. That's
why (5 :: Int) * (6 :: Integer) will result in a type error whereas (5 * (6 ::
Integer)) will work just fine and produce an Integer, because 5 can act like an
Integer or an Int.

To join Num, a type must already be friends with Show and Eq.

Integral is also a numeric typeclass. Num includes all numbers, including real
numbers and integral numbers, whereas Integral includes only integral (whole)
numbers. In this typeclass are Int and Integer.

Floating includes only floating point numbers, so Float and Double.

A very useful function for dealing with numbers if `fromIntegral`.

It has a type declaration of "fromIntegral :: (Num b, Integral a) => a -> b".

From its type signature we see that it takes an integral number and turns it
into a more general number. That's useful when you want integral and floating
point types to work together nicely. For instance, the `length` function has a
type declaration of "length :: [a] -> Int" instead of having a more general
type of "(Num b) => length :: [a] -> b". I think that's there for historical
reasons or something, although in my opinion, it's pretty stupid.

Anyway, if we try to get a length of a list and then add it to 3.2, we'll get
an error because we tried to add together an Int and a floating point number.
So to get around this, we do "fromIntegral (length [1,2,3,4]) + 3.2" and it all
works out.

Notice that fromIntegral has several class constraints in its type signature.
That's completely valid and as you can see, the class constraints are separated
by commas inside parentheses.
-}

