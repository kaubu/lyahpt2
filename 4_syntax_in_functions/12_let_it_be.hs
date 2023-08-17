{-
Very similar to where bindings are let bindings.

Where bindings are a syntactic construct that let you bind variables at the end
of a function and the whole function can see them, including the guards.

Let bindings let you bind to variables anywhere and are expressions themselves,
but are very local, so they don't span across guards.

Just like any construct in Haskell that is used to bind values to names, let
bindings can be used for pattern matching.

Let's see them in action! This is how we could define a function that gives us
a cylinder's surface area based on its height and radius:
-}

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea = 2 * pi * r * h
        topArea = pi * r^2
    in sideArea + 2 * topArea
-- ghci> cylinder 5 25
-- 942.4777960769379
-- ghci> cylinder 20 20
-- 5026.548245743669
-- ghci> cylinder 20 2
-- 2764.601535159018

{-
The form is `let <bindings> in <expression>`.

The names that you define in the *let* part are accessible to the expression in
the *in* part.

As you can see, we could have also defined this with a *where* binding. notice
that the names are also aligned in a single column.

So what's the difference between the two? For now it just seems that *let* puts
the bindings first and the expression that uses them later whereas *where* is
the other way around.

The difference is that *let* bindings are expressions themselves. *where*
bindings are just syntactic constructs.

Remember when we did the if statement and it was explained that an if else
statement is an expression and you can cram it almost anywhere?

    ghci> [if 5 > 3 then "Woo" else "Boo", if 'a' > 'b' then "Foo" else "Bar"]
    ["Woo","Bar"]
    ghci> 4 * (if 10 > 5 then 10 else 0) + 2
    42

You can also do that with let bindings.

    ghci> 4 * (let a = 8 in a + 1) + 2
    38

They can also be used to introduce functions in a local scope:

    ghci> [let square x = x * x in (square 5, square 3, square 2)]
    [(25,9,4)]

If we want to bind to several variables inline, we obviously can't align them
at columns. That is why we can separate them with semicolons.

    ghci> (let a = 100; b = 200; c = 300 in a*b*c, let foo = "Hey "; bar = "there!" in foo ++ bar)
    (6000000,"Hey there!")

You don't have to put a semicolon after the last binding but you can if you
want to.

Like we said before, you can pattern match with *let* bindings. They're very
useful for quickly dismantling a tuple into components and binding them to
names and such.

    ghci> (let (a,b,c) = (1,2,3) in a+b+c) * 100
    600

You can also put *let* bindings inside of list comprehensions. Let's rewrite
our previous example of calculating lists of mass-volume pairs to use a let
inside a list comprehension instead of defining an auxiliary function with a
where.
-}

calcDensities :: (RealFloat a) => [(a,a)] -> [a]
calcDensities xs = [density | (m, v) <- xs, let density = m / v]
-- ghci> calcDensities [(5,2), (93,245)]
-- [2.5,0.3795918367346939]

{-
We include a *let* inside a list comprehension must like we would a predicate,
only it doesn't filter the list, it only binds to names.

The names defined in a *let* inside a list comprehension are only visible to
the output function (the part before the |) and all predicates and sections
that come after the binding.

So we could make our function return only the densities that will float in air:
-}

calcDensities' :: (RealFloat a) => [(a,a)] -> [a]
calcDensities' xs = [density | (m, v) <- xs, let density = m / v, density < 1.2]
-- ghci> calcDensities' [(24, 125), (1, 2), (89, 4)]
-- [0.192,0.5]

{-
We can't use the density name in the `(m, v) <- xs` part because it's defined
prior to the let binding.

We omitted the *in* part of the let binding when we used them in list
comprehensions because the visibility of the names is already predefined there.
However, we could use a *let in* binding in a predicate and the names would
only be visible for that predicate.

The *in* part can also be omitted when defining functions and constants
directly in GHCi. If we do that, then the names will be visible throughout the
entire interactive session.

    ghci> let zoot x y z = x * y + z
    ghci> zoot 3 9 2
    29
    ghci> let boot x y z = x * y + z in boot 3 4 2
    14
    ghci> boot

    <interactive>:50:1: error:
        • Variable not in scope: boot
        • Perhaps you meant one of these:
            ‘Ghci3.zoot’ (imported from Ghci3), ‘zoot’ (line 47)

If *let* bindings are cool, why not use them all the time instead of *where*
bindings, you ask? Well, since *let* bindings are expressions and are fairly
local in scope, they can't be used across guards.

Some people prefer where bindings because the names come after the function
they're being used in. That way, the function body is closer to its name and
type declaration, and to some that's more readable.
-}
