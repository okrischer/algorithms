{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
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
'bumSort' is a basic implementation of the __/Bottom-up MergeSort/__ algorithm on lists.
Running time: O(n lg n)

>>> bumSort [5,4,8,1,9,3,2,7,6]
[1,2,3,4,5,6,7,8,9]
-}
bumSort :: Ord a => [a] -> [a]
bumSort [] = []
bumSort xs = unwrap (until single (pairWith merge) (map wrap xs))

wrap :: a -> [a]
wrap x = [x]

unwrap :: [a] -> a
unwrap [x] = x

single :: [a] -> Bool
single [x]  = True
single _    = False

-- | 'parWith' is the worker method for __/Bottom-up MergeSort/__

-- | >>> pairWith merge (map wrap [5,4,8,1,9,3,0,2,7,6])
-- [[4,5],[1,8],[3,9],[0,2],[6,7]]
pairWith f [] = []
pairWith f [x] = [x]
pairWith f (x:y:xs) = f x y:pairWith f xs


{- |
'smoothMS' is a basic implementation of the __/Smooth MergeSort/__ algorithm on lists.

>>> smoothMS [5,4,8,1,9,3,2,7,6]
[1,2,3,4,5,6,7,8,9]
-}
smoothMS :: Ord a => [a] -> [a]
smoothMS [] = []
smoothMS xs = unwrap (until single (pairWith merge) (runs xs))

-- | 'runs' is the worker method for __/Smooth MergeSort/__

-- | >>>  runs [5,4,8,1,9,3,2,7,6]
-- [[5],[4,8],[1,9],[3],[2,7],[6]]
runs :: Ord a => [a] -> [[a]]
runs = foldr op []
    where op x [] = [[x]]
          op x ((y:xs):xss) | x <= y = (x:y:xs):xss
                            | otherwise = [x]:(y:xs):xss


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

-- |Definition of a __/Heap/__ as a binary tree with Nodes on top of subtrees
data Tree a = Null | Node a (Tree a) (Tree a)
    deriving Show

-- |'mkheap' creates a size-balanced binary tree in form of a __/Heap/__
-- in linearithmic time: O(n lg n)
-- >>> mkheap [5,4,8,1,9,3,2,7,6]
-- Node 1 (Node 2 (Node 3 (Node 7 Null Null) Null) (Node 4 Null Null)) (Node 5 (Node 8 (Node 9 Null Null) Null) (Node 6 Null Null))
mkheap :: Ord a => [a] -> Tree a
mkheap [] = Null
mkheap (x:xs) = Node y (mkheap ys) (mkheap zs)
    where (y, ys, zs) = split(x:xs)

-- |'split' is a helper function for 'mkheap', which splits a list into a Node label
-- (which is the smallest element in the input) and two sublists
-- >>> split [5,4,8,1,9,3,2,7,6]
-- (1,[4,2,3,7],[8,9,5,6])
split :: Ord a => [a] -> (a, [a], [a])
split (x:xs) = foldr op (x, [], []) xs
    where op x (y, ys, zs) | x <= y    = (x, y:zs, ys)
                           | otherwise = (y, x:zs, ys)

-- | flattens a __/Heap/__ or heap-like
flatten :: Ord a => Tree a -> [a]
flatten Null = []
flatten (Node x u v) = x:merge (flatten u) (flatten v)

-- |'hSort' is a basic implementation for sorting with O(n^2)
-- >>> hSort [5,4,8,1,9,3,2,7,6]
-- [1,2,3,4,5,6,7,8,9]
hSort :: Ord a => [a] -> [a]
hSort = flatten . mkheap
