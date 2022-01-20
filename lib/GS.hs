module GS where
import Data.Char (ord, chr)

type Bit = Char

bin2dec' :: [Bit] -> Int
bin2dec' bits =
    sum [w*b | (w,b) <- zip weights (reverse $ char2dgt bits)]
        where weights = iterate (*2) 1

char2dgt :: [Bit] -> [Int]
char2dgt [] = []
char2dgt (c:cs)
    | c <= '9'  = ord c - 48 : char2dgt cs
    | c <  'A'  = error "not a digit"
    | c <= 'F'  = ord c - 55 : char2dgt cs
    | otherwise = error "not a digit"

bin2dec'' :: Int -> [Bit] -> Int
bin2dec'' b bits = 
    foldr (\z x -> z + b * x) 0 (reverse $ char2dgt bits)

bin2dec = bin2dec'' 2
oct2dec = bin2dec'' 8
hex2dec = bin2dec'' 16

dec2bin' :: Int -> Int -> [Int]
dec2bin' _ 0 = []
dec2bin' b n = n `mod` b : dec2bin' b (n `div` b)

dec2bin n = reverse $ map dgt2char (dec2bin' 2 n)
dec2oct n = reverse $ map dgt2char (dec2bin' 8 n)
dec2hex n = reverse $ map dgt2char (dec2bin' 16 n)

dgt2char :: Int -> Bit
dgt2char d
    | d <= 9  = chr (d + 48)
    | d <= 15 = chr (d + 55)
    | otherwise = error "not a digit"
