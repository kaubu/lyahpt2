-- Tuples

{-
In some ways, tuples are like lists — they are a way to store several values
into a single value. However, there are a few fundamental differences. A
list of numbers is a list of numbers. That's its type and it doesn't matter
if it has only one number in it or an infinite amount of numbers. Tuples,
however, are used when you know exactly how many values you want to combine
and its type depends on how many components it has and the types of the
components. They are denoted with parentheses and their components are
separated by commas.

Another key difference is that they don't have to be homogenous. Unlike a
list, a tuple can contain a combination of several types.

Think about how we'd represent a two-dimensional vector in Haskell. One way
would be to use a list. That would kind of work. So what if we wanted to put a
couple of vectors in a list to represent points of a shape on a two-dimensional
plane? We could do something like [[1,2],[8,11],[4,5]]. The problem with that
method is that we could also do stuff like [[1,2],[8,11,5],[4,5]], which
Haskell has no problem with since it's a list of lists with numbers, but it
kind of doesn't make sense. But a tuple of size two (also called a pair) is its
own type, which means that a list can't have a couple of pairs in it and then a
triple (a tuple of size three), so let's use that instead. Instead of
surrounding the vectors with square brackets, we use parentheses:
[(1,2),(8,11),(4,5)]. What if we tried to make a shape like
[(1,2),(8,11,5),(4,5)]? Well, we'd get this error:
-}

{-
    • Couldn't match expected type ‘(a, b)’  
                  with actual type ‘(a0, b0, c0)’  
    • In the expression: (8, 11, 5)  
      In the expression: [(1, 2), (8, 11, 5), (4, 5)]  
      In an equation for ‘it’: it = [(1, 2), (8, 11, 5), (4, 5)]  
    • Relevant bindings include  
        it :: [(a, b)] (bound at <interactive>:1:1)  
-}

{-
It's telling us that we tried to use a pair and a triple in the same list,
which is not supposed to happen. You also couldn't make a list like
[(1,2),("One",2)], because the first element of the list is a pair of numbers
and the second element is a pair consisting of a string and a number.

Tuples can also be used to represent a wide variety of data. For instance, if
we wanted to represent someone's name and age in Haskell, we could use a
triple: ("Christopher", "Walken", 55). As seen in this example, tuples can also
contain lists.

Use tuples when you know in advance how many components some piece of data
should have. Tuples are much more rigid because each different size of tuple is
its own type, so you can't write a general function to append an element to a
tuple — you'd have to write a function for appending to a pair, one function
for appending to a triple, one function for appending to a 4-tuple, etc.

While there are singleton lists, there's no such thing as a singleton tuple. It
doesn't really make much sense when you think about it. A singleton tuple would
just be the value it contains and as such would have no benefit to us.

Like lists, tuples can be compared with each other if their components can be
compared. Only you can't compare two tuples of different sizes, whereas you can
compare two lists of different sizes. Two useful functions that operate on
pairs:
-}

-- `fst` takes a pair and returns its first component
-- fst (8,11)
-- 8
-- fst ("Wow", False)
-- "Wow"

-- Note: these functions operate only on pairs. They won't work on triples,
-- 4-tuples, 5-tuples, etc. We'll go over extracting data from tuples in
-- different ways a bit later.

{-
A cool function that produces a list of pairs: `zip`. It takes two lists and
then zips them together into one list by joining the matching elements into
pairs. It's a really simple function but it has loads of uses. It's especially
useful for when you want to combine two lists in a way or traverse two lists
simultaneously.

Here's a demonstration:

    ghci> zip [1,2,3,4,5] [5,5,5,5,5] [(1,5),(2,5),(3,5),(4,5),(5,5)] ghci> zip
    [1..5] ["one","two","three","four","five"]
    [(1,"one"),(2,"two"),(3,"three"),(4,"four"),(5,"five")]

It pairs up the elements and produces a new list. The first element goes with
the first, the second with the second, etc.

Notice that because pairs have different types in them, `zip` can take two
lists that contain different types and zip them up. What happens if the lengths
of the lists don't match?

    ghci> zip [5,3,2,6,2,7,2,5,4,6,6] ["im","a","turtle"]
    [(5,"im"),(3,"a"),(2,"turtle")]

The longer list simply gets cut off to match the length of the shorter one.
Because Haskell is lazy, we can zip finite lists with infinite lists:

    ghci> zip [1..] ["apple","orange","cherry","manga"]
    [(1,"apple"),(2,"orange"),(3,"cherry"),(4,"manga")]

Here's a problem that combines tuples and list comprehensions: which right
triangle that has integers for all sides and all sides equal to or smaller than
10 has a perimeter of 24? First let's try generating all triangles with sides
equal to or smaller than 10:
-}
triangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10] ]

{-
We're just drawing from three lists and our output function is combining them
into a triple. If you evaluate that by typing out "triangles" in GHCI, you'll
get a list of all possible triangles with sides under or equal to 10.

Next, we'll add a condition that they all have to be right triangles. We'll
also modify this function by taking into consideration that side B isn't larger
than the hypotenuse and that side A isn't larger than side B.
-}

rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2 ]
-- [(3,4,5),(6,8,10)]

{-
We're almost done. Now we just need to modify the function by saying that we
want the ones where the perimeter is 24.
-}
rightTriangles' = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24 ]
-- [(6,8,10)]

