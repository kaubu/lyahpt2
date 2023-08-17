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

