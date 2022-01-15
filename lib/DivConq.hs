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
    where
    (left, right) = splitAt (length xs `div` 2) xs

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
qSort (x:xs) = pSort xs [] []
    where
    pSort [] us vs = qSort us ++ [x] ++ qSort vs
    pSort (y:xs) us vs = if y < x
                         then pSort xs (y:us) vs
                         else pSort xs us (y:vs)

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
