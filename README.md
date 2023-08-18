# lyahpt2

## Notes

### 9. Pattern Matching
#### as patterns
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

### 14. Hello Recursion
We need to have **edge conditions** in recursive functions, otherwise they'd
continue looping with no end in sight.

There are no while loops or for loops in Haskell, and instead we often have to
use recursion to declare what something is.
