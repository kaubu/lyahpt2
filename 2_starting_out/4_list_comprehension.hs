-- To get the first 10 even natural numbers We could do something like: take 10
-- [2,4..] But what if we didn't want doubles of the first 10 natural numbers
-- but some kind of more complex function applied onto them? We could use a
-- list comprehension for that.

-- The list comprehension we could use is:
evenList = [x*2 | x <- [1..10]]
-- [2,4,6,8,10,12,14,16,18,20]

-- Let's add a condition (or predicate) to that comprehension. Predicates go
-- after the binding parts and are separated from them by a comma. Let's say we
-- want only the elements which, doubled, are greater than or equal to 12:
bigEvenList = [x*2 | x <- [1..10], x*2 >= 12]
-- [12,14,16,18,20]

-- Cool, it works. How about if we wanted all numbers from 50 to 100 whose
-- remainder when divided with the number 7 is 3? Easy.
remainderList = [ x | x <- [50..100], x `mod` 7 == 3 ]
-- [52,59,66,73,80,87,94]

-- Note that weeding out lists by predicates is also called **filtering**. We
-- took a list of numbers and we filtered them by the predicate.

-- Now for another example. Let's say we want a comprehension that replaces
-- each odd number greater than 10 with "BANG!" and each odd number that's less
-- than 10 with "BOOM!". If a number isn't odd, we throw it out of our list.
-- For convenience, we'll put that comprehension behind a function so that we
-- can easily reuse it. The function `odd` returns True on an odd number and
-- False on an even number.
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x ]
-- ghci> boomBangs [7..13]
-- ["BOOM!","BOOM!","BANG!","BANG!"]

-- We can include several predicates. If we wanted all numbers from 10 to 20
-- that are not 13, 15, or 19, we'd do:
severalPredicates = [ x | x <- [10..20], x /= 13, x /= 15, x /= 19 ]
-- [10,11,12,14,16,17,18,20]

-- Not only can we have multiple predicates in list comprehensions (an element
-- must satisfy all the predicates to be included in the resulting list), we
-- can also draw from several lists. When drawing from several lists,
-- comprehensions produce all combinations of the given lists and then join
-- them by the output function we supply. A list produced by a comprehension
-- that draws from two lists of length 4 will have a length of 16, provided we
-- don't filter them.

-- If we have two lists, [2,5,10] and [8,10,11] and we want to get the products
-- of all possible combinations between numbers in those lists, here's what
-- we'd do.
twoLists = [ x*y | x <- [2,5,10], y <- [8,10,11] ]
-- [16,20,22,40,50,55,80,100,110]

-- As expected, the length of the new list is 9. What if we wanted all possible
-- products that are more than 50?

moreThan50 = [ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50 ]
-- [55,80,100,110]

-- How about a list comprehension that combines a list of adjectives and a list
-- of nouns… for epic hilarity.
nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]
wordCombinations = [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]
-- ["lazy hobo","lazy frog","lazy pope","grouchy hobo","grouchy frog","grouchy pope","scheming hobo","scheming frog","scheming pope"]

-- As you can see, it creates all possible combinations between the two lists.

-- I know! Let's write our own version of `length`! We'll call it `length'`.
length' xs = sum [1 | _ <- xs]
-- ghci> length' [1,2,3]
-- 3

-- "_" means that we don't care what we'll draw from the list, so instead of
-- writing a variable name that we'll never use, we just write "_" instead.
-- This function replaces every element of a list with "1" and then sums that
-- up. This means that the resulting sum will be the length of our list.

-- Just a friendly reminder: because strings are lists, we can use list
-- comprehensions to process and produce strings. Here's a function that takes
-- a string and removes everything except uppercase letters from it.
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z'] ]
-- ghci> removeNonUppercase "Hahaha! Ahahahaha!"
-- "HA"
-- ghci> removeNonUppercase "IdontLIKEFROGS!"
-- "ILIKEFROGS"

