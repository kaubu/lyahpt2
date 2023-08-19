{-
Now that we know how to generally think recursively, let's implement a few
functions using recursion. First off, we'll implement `replicate`.

replicate takes an Int and some element and returns a list that has several
repetitions of the same element.

For instance, "replicate 3 5" returns [5,5,5].

Let's think about the edge condition. My guess is that the edge condition is 0
or less. If we try to replicate something zero times, it should return an empty
list. Also for negative numbers, because it doesn't really make sense.
-}

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0    = []
    | otherwise = x:replicate' (n-1) x -- wtf does the x: syntax mean??

{-
We used guards here instead of patterns because we're testing for a boolean
condition. If n is less than or equal to 0, return an empty list. Otherwise,
return a list that has x as the first element and then x replicated n-1 times
as the tail. Eventually, the (n-1) part will cause our function to reach the
edge condition.

###

Ahhhh, so because the (n-1) will eventually reach 0 which produces 0, this
produces something like 5:5:5:5:5:[], which becomes a list.

###

Note: Num is not a subclass of Ord. This is because not every number type has
an ordering, e.g. complex numbers aren't ordered. So that's why we have to
specify both the Num and Ord class constraints when doing addition or
subtraction and also comparison.

---

Next up, we'll implement `take`. it takes a certain number of elements from a
list. For instance, "take 3 [5,4,3,2,1]" will returns [5,4,3].

If we try to take 0 or less elements from a list, we get an empty list. Also if
we try to take another from an empty list. Notice that those are two edge
conditions right there.

So let's write that out:
-}

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0    = []
take' _ []      = []
take' n (x:xs)  = x : take' (n-1) xs
-- ghci> take' 2 [5,2,4]
-- [5,2]
-- ghci> take' 2 [5,2]
-- [5,2]
-- ghci> take' 2 [5]
-- [5]

{-
The first pattern specifies that if we try to take 0 or a negative number of
elements, we get an empty list. Notice that we're using _ to match the list
because we don't really care what it is in this case. Also notice that we use a
guard, but without an otherwise part. That means that if n turns out to be more
than 0, the matching will fall through to the next pattern.

The second pattern indicates that if we try to take anything from an empty
list, we get an empty list.

The third pattern breaks the list into a head and a tail. And then we state
that taking n elements from a list equals a list that has x as the head and
then a list that takes n-1 elements from the tail as a tail.

Try using a piece of paper to write down how the evaluation would look like if
we try to take, say, 3 from [4,3,2,1]. 

###

Not a piece of paper but close enough.

First, we do "take 3 [4,3,2,1]".

It matches the third pattern, where n=3, x=4, and xs=[3,2,1]. We then declare a
new list with 4 at the head, and then take 2 from [3,2,1].

"take 2 [3,2,1]" matches the third pattern, which assigns n=2, x=3, and
xs=[2,1]. Returns a new list with 3 at the head (now 4:3 atm), then calls take
again.

"take 1 [2,1]" matches the third pattern. n=1, x=2, xs=[1]. it appends 2 to the
head of a new list (4:3:2 atm), and then calls take.

"take 0 [1]" matches the first pattern, wherein n == 0 which satisfies the n <=
0 check. Because of that, it returns an empty list in the tail.

This results in the following list:

4:3:2:[], which evaluates to [4,3,2].

Ergo, "take 3 [4,3,2,1]" returns [4,3,2].

###

---

`reverse` simply reverses a list. Think about the edge condition. What is it?
Come on… it's the empty list! An empty list reversed equals the empty list
itself. O-kay. What about the rest of it? Well, you could say that if we split
a list to a head and a tail, the reversed list is equal to the reversed tail
and the head at the end.
-}

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]
-- ghci> reverse' [5,4,3,2,1]
-- [1,2,3,4,5]
-- ghci> reverse' [6]
-- [6]
-- ghci> reverse' []
-- []

{-
There we go!

Because Haskell supports infinite lists, our recursion doesn't really have to
have an edge condition. But if it doesn't have it, it will either keep churning
at something infinitely or produce an infinite data structure, list an infinite
list. The good thing about infinite lists though, is that we can cut them where
we want.

`repeat` takes an element and returns an infinite list that has just that
element. A recursive implementation of that is really easy, watch.
-}

repeat' :: a -> [a]
repeat' x = x:repeat' x

{-
Calling "repeat 3" will give us a list that starts with 3 and then has an
infinite amount of 3's as a tail. So calling "repeat 3" would evaluate like
3:repeat 3, which is 3:(3:repeat 3), which is 3:(3:(3:repeat 3)), etc.

repeat 3 will never finish evaluating, whereas "take 5 (repeat 3)" will give us
a list of five 's. So essentially it's like doing "replicate 5 3".

---

`zip` takes two lists and zips them together. "zip [1,2,3] [2,3]" returns
[(1,2), (2,3)] because it truncates the longer list to match the length of the
shorter one. How about if we zip an empty list? Well, we get an empty list back
then. So there's our edge condition. However, zip takes two lists as
parameters, so there are actually two edge conditions.
-}

zip' :: [a] -> [b] -> [(a,b)]
zip' _ []           = []
zip' [] _           = []
zip' (x:xs) (y:ys)  = (x,y):zip' xs ys
-- ghci> zip' [5,4,3,2,1] [1,2,3,4,5]
-- [(5,1),(4,2),(3,3),(2,4),(1,5)]
-- ghci> zip' [7,8,9,0] [5,4,3]
-- [(7,5),(8,4),(9,3)]

{-
First two patterns say that if the first or second list is empty, we get an
empty list. The third one says that two lists zipped are equal to pairing up
their heads and then tacking on the zipped tails.

Zipping [1,2,3] and ['a','b'] will eventually try to zip [3] with []. The edge
condition patterns kick in and so the result is (1,'a'):(2,'b'):[], which is
exactly the same as [(1,'a'),(2,'b')].

---

Let's implement one more standard library function — `elem`. It takes an
element and a list and sees if that element is in the list. The edge condition,
as is most of the times with lists, is the empty list. We know that an empty
list contains no elements, so it certainly doesn't have the droids we're
looking for.
-}

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x    = True
    | otherwise = a `elem'` xs
-- ghci> 6 `elem'` [4,5,7]
-- False
-- ghci> 6 `elem'` [4,5,6]
-- True

{-
Pretty simple and expected. If the head isn't the element then we check the
tail. If we reach an empty list, the result is False.
-}
