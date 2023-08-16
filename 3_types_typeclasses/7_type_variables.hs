{-
What do you think is the type of the `head` function? Because head takes a list
of any type and returns the first element, so what could it be? Let's check!

    ghci> :t head
    head :: [a] -> a

Hmmm! What is this a? Is it a type? Remember that we previously stated that
types are written in capital case, so it can't exactly be a type. Because it's
not in capital case it's actually a **type variable**. That means that "a" can
be of any type.

This is much like generics in other languages, only in Haskell it's much more
powerful because it allows us to easily write very general functions if they
don't use any specific behaviour of the types in them. Functions that have type
variables are called **polymorphic functions**. The type declaration of head
states that it takes a list of any type and returns one element of that type.

Although type variables can have names longer than one character, we usually
give them names of a, b, c, d…

Remember fst? It returns the first component of a pair. Let's examine its type.

    ghci> :t fst
    fst :: (a, b) -> a

We see that fst takes a tuple which contains two types and returns an element
which is of the same type as the pair's first component. That's why we use fst
on a pair that contains any two types. Note that just because a and b are
different type variables, they don't have to be different types. It just states
that the first component's type and the return value's type are the same.
-}

