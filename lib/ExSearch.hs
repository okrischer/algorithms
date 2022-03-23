module ExSearch where

import Data.List (permutations)

safe :: [Int] -> Bool
safe qs = check (zip [1..] qs)

check :: (Eq a, Num a) => [(a, a)] -> Bool
check [] = True
check ((r,q):rqs) =
    and [abs (q' - q) /= r' - r | (r', q') <- rqs] && check rqs

{-|
A first sulution to the n-queens problem.

>>> queens 4
[[2,4,1,3],[3,1,4,2]]
-}
queens :: Int -> [[Int]]
queens n = filter safe perms
    where perms = permutations [1..n]
