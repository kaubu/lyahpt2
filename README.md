# lyahpt2

## Notes

### Starting Out
#### 1. First Functions
Declare functions with the syntax `<identifier> <argument(s)> = <expression>`.

```haskell
doubleMe x = x + x

-- doubleUs x y = x*2 + y*2
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                        then x
                        else x*2

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"
```

#### Intro to Lists
Concatenate lists with the `++` operator.

```haskell
-- Concatenate lists (including strings) with the `++` operator

concatIntegerList = [163,25] ++ [2,924]
-- [163,25,2,924]

concatStringList = "Hello" ++ " " ++ "World!"
-- "Hello World!"

concatCharList = ['w', 'o'] ++ ['o', 't']
-- "woot"
```

Concatenating large lists is an expensive operation. Use the cons operator `:`
to prepend to the list instantly.

```haskell
consString = 'A':" Small Cat"
-- "A Small Cat"

consInteger = 5:[1,2,4,5,8]
-- [5,1,2,4,5,8]
```

Get an element from a List using the `!!` operator.

```haskell
listIndexString = "Steve Buscemi" !! 6
-- 'B'

listIndexFloat = [25.0,241.2,5.98,2.4] !! 2
-- 5.98
```

Lists can be compared if they contain items that can be compared.

```sh
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
```

##### Useful functions

```haskell
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
```

### Syntax in Functions
#### 9. Pattern Matching
##### as patterns
Use a variable + `@` in front of a pattern match to store the entire thing in a
variable to reference later.

```haskell
capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]  
```

```haskell
ghci> capital "Dracula"  
"The first letter of Dracula is D"  
```

### Recursion
#### 14. Hello Recursion
We need to have **edge conditions** in recursive functions, otherwise they'd
continue looping with no end in sight.

There are no while loops or for loops in Haskell, and instead we often have to
use recursion to declare what something is.
