{-
In the previous section, we defined a density calculator function and responder
like this:

    densityTell :: (RealFloat a) => a -> a -> String  
    densityTell mass volume  
        | mass / volume < 1.2 = "Wow! You're going for a ride in the sky!"  
        | mass / volume <= 1000.0 = "Have fun swimming, but watch out for sharks!"  
        | otherwise   = "If it's sink or swim, you're going to sink."  

Notice that we repeat ourselves here two times. We repeat ourselves two times.
Repeating yourself (two times) while programming is about as desirable as
getting kicked in the head. Since we repeat the same expression twice, it would
be ideal if we could calculate it once, bind it to a name, and then use that
name instead of an expression.

Well, we can modify our function like this:
-}

densityTell :: (RealFloat a) => a -> a -> String
densityTell mass volume
    | density < 1.2 = "Wow! You're going for a ride in the sky!"
    | density <= 1000.0 = "Have fun swimming, but watch out for sharks!"
    | otherwise = "If it's sink or swim, you're going to sink."
    where density = mass / volume
-- ghci> densityTell 400 2
-- "Have fun swimming, but watch out for sharks!"

{-
We put the keyword `where` after the guards (usually it's best to indent it as
much as the pipes are indented) and then we define several names or functions.
These names are visible across the guards and give us the advantage of not
having to repeat ourselves.

If we decide that we want to calculate density a little differently, we only
have to change it once. It also improves readability by giving names to things
and can make our programs run faster since stuff like our density variable here
is calculated only once.

We could go a bit overboard and present our function like this:
-}

densityTell' :: (RealFloat a) => a -> a -> String
densityTell' mass volume
    | density < air     = "Wow! You're going for a ride in the sky!"
    | density <= water  = "Have fun swimming, but watch out for sharks!"
    | otherwise         = "If it's sink or swim, you're going to sink."
    where   density = mass / volume
            air     = 1.2
            water   = 1000.0

{-
The names we defined in the where section of a function are only visible to
that function, so we don't have to worry about them polluting the namespace of
other functions. Notice that all the names are aligned at a single column. If
we don't align them nice and proper, Haskell gets confused because then it
doesn't know that they're all part of the same block.

*where* bindings aren't shared across function bodies of different patterns. If
you want several patterns of one function to access some shared name, you have
to define it globally.

You can also use where buttons to **pattern match**! We could have rewritten
the where section of our previous function as:

    where   density         = mass / volume
            (air, water)    = (1.2, 1000.0)

Let's make another fairly trivial function where we get a first and last name
and give back somebody their initials.
-}

initials :: String -> String -> String
initials firstName lastName = [f] ++ ". " ++ [l] ++ "."
    where   (f:_) = firstName
            (l:_) = lastName
-- ghci> initials "John" "Kennedy"
-- "J. K."
-- ghci> initials "Marceline" "Winters"
-- "M. W."

{-
We could have done this pattern matching directly in the function's parameters
(it would have been shorter and clearer actually) but this just goes to show
that it's possible to do it in where bindings as well.

Just like we've defined constants in where blocks, you can also define
functions. Staying true to our solids programming theme, let's make a function
that takes a list of mass-volume pairs and returns a list of densities.
-}

calcDensities :: (RealFloat a) => [(a, a)] -> [a]
calcDensities xs = [density m v | (m, v) <- xs]
    where density mass volume = mass / volume
-- ghci> calcDensities [(52,32), (9,128), (425,22)]
-- [1.625,7.03125e-2,19.318181818181817]

{-
And that's all there is to it! The reason we had to introduce density as a
function in this example is because we can't just calculate one density from
the function parameters. We have to examine the list passed to the function and
there's a different density for every pair in there.

where bindings can also be nested. It's a common idiom to make a function and
define some helper function in its where clause and then to give those
functions helper functions as well, each with its own where clause.
-}
