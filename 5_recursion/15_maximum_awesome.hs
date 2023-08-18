{-
The `maximum` function takes a list of things that can be ordered (e.g.
instances of the Ord typeclass) and returns the biggest of them. Think about
how you'd implement that in an imperative fashion. You'd probably set up a
variable to hold the maximum value so far and then you'd loop through the
elements of a list and if an element is bigger than the current maximum value,
you'd replace it with that element. The maximum value that remains at the end
is the result.

Whew! That's quite a lot of words to describe such a simple algorithm.

---

Now let's see how we'd define it recursively. We could first set up an edge
condition and say that the maximum of a singleton list is equal to the only
element in it. Then we can say that the maximum of a longer list is the head if
the head is bigger than the maximum of the tail. If the maximum of the tail is
bigger, well, then it's the maximum of the tail.

That's it! Now let's implement that in Haskell.
-}

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of an empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs
-- ghci> maximum' [1]
-- 1
-- ghci> maximum' [1,2,3]
-- 3
-- ghci> maximum' [1,2,3,72,25,0]
-- 72

{-
As you can see, pattern matching goes great with recursion! Most imperative
languages don't have pattern matching so you have to make a lot of if-else
statements to test for edge conditions. Here, we simply put them out as
patterns.

So the first edge condition says that if the list is empty, crash! Makes sense
because what's the maximum of an empty list? I don't know.

The second pattern also lays out an edge condition. It says that if it's the
singleton list, just give back the only element.

Now the third pattern is where the action happens. We use pattern matching to
split a list into a head and a tail. This is a very common idiom when doing
recursion with lists, so get used to it. We use a *where* binding to define
maxTail as the maximum of the rest of the list. Then we check if the head is
greater than the maximum of the rest of the list. If it is, we return the head.
Otherwise, we return the maximum of the rest of the list.

---

Let's take an example list of numbers and check out how this would work on
them: [2,5,1]. If we call maximum' on that, the first two patterns won't match.
The third one will, and the list is split into 2 and [5,1]. The *where* clause
wants to know the maximum of [5,1], so we follow that route. It matches the
third pattern again, and [5,1] is split into 5 and [1]. Again, the where clause
wants to know the maximum of [1] (which is 1), we obviously get back 5 (in the
guard clause). So now we know that the maximum of [5,1] is 5. We go up one step
again where we had 2 and [5,1]. Comparing 2 with the maximum of [5,1], which is
5, we choose 5.

An even clearer way to write this function is to use max. If you remember, max
is a function that takes two numbers and returns the bigger of them. Here's how
we could rewrite maximum' using max:
-}

maximum'':: (Ord a) => [a] -> a
maximum'' [] = error "maximum of an empty list"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

{-
How's that for elegant! In essence, the maximum of a list is the max of the
first element and the maximum of the tail.
-}
