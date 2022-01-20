{- |
Module      : DivConq
Description : Basic Algorithms, implementing the __/Divide & Conquer/__ pattern
Stability   : experimental
-}
module DivConq where

{- |
'mSort' is a basic implementation of the __/MergeSort/__ algorithm on lists.
Running time: O(n lg n)

>>> mSort [5,4,8,1,9,3,2,7,6]
[1,2,3,4,5,6,7,8,9]
-}
mSort :: Ord a => [a] -> [a]
mSort [] = []
mSort [x] = [x]
mSort xs = merge (mSort left) (mSort right)
           where (left, right) = halve xs

{- |
'halve' is a helper function of 'msort' for dividing a list into two sublists.
It avoids traversing the input list several times.
>>> halve [1..9]
([2,4,6,8],[1,3,5,7,9])
-}
halve :: [a] -> ([a], [a])
halve = foldr op ([], []) where op x (ys, zs) = (zs, x:ys)

-- |The 'merge' subroutine for 'mSort'.
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge left@(x:xs) right@(y:ys)
    | x <= y    = x : merge xs right
    | otherwise = y : merge left ys


{- |
'qSort' is a basic implementation of the __/QuickSort/__ algorithm on lists.
Average running time: O(n lg n)

>>> qSort [5,4,8,1,9,3,2,7,6]
[1,2,3,4,5,6,7,8,9]
-}
qSort :: Ord a => [a] -> [a]
qSort [] = []
qSort (x:xs) = qSort ys ++ [x] ++ qSort zs
    where (ys, zs) = partition (<x) xs

{- |
'partition is the worker method for 'qSort' and divides an input list into two sublists,
one with elements matching the predicate, the other with all elements that don't.
>>> partition (<5) [5,4,8,1,9,3,2,7,6]
([4,1,3,2],[5,8,9,7,6])
-}
partition :: (a -> Bool) -> [a] -> ([a], [a])
partition p = foldr op ([], [])
    where op x (ys, zs) = if p x then (x:ys, zs) else (ys, x:zs)

{- |
'iSort' is a basic implementation of the __/InsertionSort/__ algorithm on lists.
Running time: O(n^2)

>>> iSort [5,4,8,1,9,3,2,7,6]
[1,2,3,4,5,6,7,8,9]
-}
iSort :: Ord a => [a] -> [a]
iSort = foldr insert []

-- |The 'insert' subroutine for 'iSort'
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y = x:y:ys
                | otherwise = y : insert x ys
