{-
We have a list of items that can be sorted. Their type is an instance of the
Ord typeclass. And now, we want to sort them! There's a very cool algorithm for
sorting called quicksort. It's a very clever way of sorting items. While it
takes upwards of 10 lines to implement quicksort in imperative languages, the
implementation is much shorter and elegant in Haskell.

Quicksort has become a sort of poster child for Haskell. Therefore, let's
implement it here, even though implementing quicksort in Haskell is considered
really cheesy because everyone does it to showcase how elegant Haskell is.

---

So, the type signature is going to be "quicksort :: (Ord a) -> [a] -> [a]". No
surprises there. The edge condition? Empty list, as is expected. A sorted empty
list is an empty list.

Now here comes the main algorithm:

    A sorted list is a list that has all values smaller than (or equal to) the
    head of the list in front (and those values sorted), then comes the head of
    the list in the middle, and then comes all the values that are bigger than
    the head (they're also sorted).

Notice that was *sorted* two times in this definition, so we'll probably have
to make the recursive call twice!

Also notice that we defined it using the verb *is* to define the algorithm
instead of saying *do this*, *do that*, *then do that*… That's the beauty of
functional programming! How are we going to filter the list so that we only get
the elements smaller than the head of our list and only elements that are
bigger? List comprehensions.

So, let's dive in and define this function.
-}

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted   = quicksort [a | a <- xs, a <= x]
        biggerSorted    = quicksort [a | a <- xs, a > x]
    in  smallerSorted ++ [x] ++ biggerSorted

{-
Let's give it a small test run to see if it appears to behave correctly.

    ghci> quicksort [52,2,6,6,1,2,6,7,8,23,6,2,7,8,2,13,1,5,3]
    [1,1,2,2,2,2,3,5,6,6,6,6,7,7,8,8,13,23,52]
    ghci> quicksort "the quick brown fox jumps over the lazy dog"
    "        abcdeeefghhijklmnoooopqrrsttuuvwxyz"

Booyah! That's what I'm talking about! So if we have, say [5,1,9,4,6,7,3] and
we want to sort it, this algorithm will first take the head, which is 5, and
then put it in the middle of two lists that are smaller and bigger than it. So
at one point, you'll have [1,4,3] ++ [5] ++ [9,6,7]. We know that once a list
is sorted completely, the number 5 will stay in the fourth place since there
are 3 numbers lower than it and 3 numbers higher than it.

Now if we sort [1,4,3] and [9,6,7], we have a sorted list! We sort the two
lists using the same function. Eventually, we'll break it up so much that we
reach empty lists and an empty list already sorted in a way, by virtue of being
empty.

Although we chose to compare all the elements to heads, we could have used any
element to compare against. In quicksort, an element that you compare against
is called a pivot. We chose the head because it's easy to get by pattern
matching.
-}
