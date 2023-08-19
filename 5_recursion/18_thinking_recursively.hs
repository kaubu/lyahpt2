{-
We did quite a bit of recursion so far, and as you've probably noticed, there's
a pattern here. Usually you define an edge case and then you define a function
that does something between some element and a function applied to the rest.

It doesn't matter if it's a list, tree, or any other data structure.
    
A sum is the first element of a list plus the sum of the rest of the list.

A product of a list is the first element of the list times the product of the
rest of the list.

The length of a list is one plus the length of the tail of the list.

Et cetera, et cetera…

---

Of course, these also have edge cases. Usually the edge case is some scenario
where a recursive application doesn't make sense. When dealing with lists, the
edge case is most often the empty list. If you're dealing with trees, the edge
case is usually a node that doesn't have any children.

It's similar when you're dealing with numbers recursively. Usually it has to do
with some number and the function applied to that number modified. We did the
factorial function earlier and it's the product of a number and the factorial
of that number minus one. Such a recursive application doesn't make sense with
zero, because factorials are defined only for positive integers.

Often the edge case value turns out to be its identity. The identity for
multiplicate is 1 because if you multiply something by 1, you get that
something back. Also when doing sums on lists, we define the sum of an empty
list as 0 and 0 the identity of addition.

In quicksort, the edge case is the empty and the identity is also the empty
list, because if you add an empty list to a list, you just get the original
list back.

---

So when trying to think of a recursive way to solve a problem, try to think of
when a recursive solution doesn't apply and see if you can use that as an edge
case, think about identities, and think about whether you'll break apart the
parameters of the function (for instance, lists are usually broke into a head
and a tail via pattern matching) and on which part you'll use the recursive
call.
-}
