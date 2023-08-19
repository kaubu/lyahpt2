hw = "Hello World!"
integerList = [24,15,1,25,236,2]
countdown = [5,4,3,2,1]

-- Concatenate lists (including strings) with the `++` operator

concatIntegerList = [163,25] ++ [2,924]
-- [163,25,2,924]

concatStringList = "Hello" ++ " " ++ "World!"
-- "Hello World!"

concatCharList = ['w', 'o'] ++ ['o', 't']
-- "woot"

-- Concatenating large lists is an expensive operation
-- Use the cons operator `:` to prepend to the list instantly

consString = 'A':" Small Cat"
-- "A Small Cat"

consInteger = 5:[1,2,4,5,8]
-- [5,1,2,4,5,8]

-- Get an element using an index with the `!!` operator

listIndexString = "Steve Buscemi" !! 6
-- 'B'

listIndexFloat = [25.0,241.2,5.98,2.4] !! 2
-- 5.98

-- Lists can be compared if the stuff they contain can be compared

{-
    ghci> [3,2,1] > [2,1,0]  
    True
    ghci> [3,2,1] > [2,10,100]  
    True
    ghci> [3,4,2] > [3,4]  
    True
    ghci> [3,4,2] > [2,4]  
    True
    ghci> [3,4,2] == [3,4,2]  
    True
-}

-- Some useful functions

-- `head` takes a list and returns its head (the first element)
fHead = head [5,4,3,2,1]
-- 5

-- `tail` takes a list and returns its tail (all elements but the first)
fTail = tail [5,4,3,2,1]
-- [4,3,2,1]

-- `last` takes a list and returns its last element
fLast = last [5,4,3,2,1]
-- 1

-- `init` takes a list and returns everything except its last element
fInit = init [5,4,3,2,1]
-- [5,4,3,2]

-- `length` takes a list and returns its length
fLength = length [5,4,3,2,1]
-- 5

-- `null` checks if a list is empty
fNull = null [1,2,3]
-- False
fNull' = null []
-- True

-- `reverse` reverses a list
fReverse = reverse [5,4,3,2,1]
-- [1,2,3,4,5]

-- `take` takes a number and a list
-- it extracts that many elements from the beginning of the list
{-
    ghci> take 3 [5,4,3,2,1]  
    [5,4,3]  
    ghci> take 1 [3,9,3]  
    [3]  
    ghci> take 5 [1,2]  
    [1,2]  
    ghci> take 0 [6,6,6]  
    []  
-}
-- See how if we try to take more elements than there are in the list, it just
-- returns the list. If we try to take 0 elements, we get an empty list.

-- `maximum` takes a list of stuff that can be ordered and returns the biggest
-- element
fMaximum = maximum [5,4,3,2,1]
-- 5

-- `minimum` returns the smallest
fMinimum = minimum [5,4,3,2,1]
-- 1

-- `sum` takes a list of numbers and returns their sum (adds them all)
fSum = sum [5,4,3,2,1]
-- 15

-- `product` takes a list and returns their product (multiplies them all)
fProduct = product [5,4,3,2,1]
-- 120

-- `elem` takes an item and a list and tells us if that item is an element of
-- the list. It's usually called as an infix function because it's easier to
-- read that way.
fElem = elem 4 [1,2,3,4]
fElem' = 4 `elem` [1,2,3,4]
-- True
fElem'' = 10 `elem` [3,4,5,6]
-- False

