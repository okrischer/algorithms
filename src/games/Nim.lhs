\section{The Game of Nim}

\subsection{The Goal of Nim}

In the game of \textbf{nim} you are given a number of rows or heaps, each of them containing a number of items larger than zero. 
It is your task to remove one or more items from one row at every move, where two players make their moves in turns.
There are two versions of the game: the first, in which the player wins, whoever takes the last item from the board, and the other in which the same player looses.
The gameplay is identical for both variants, so we will stick to the first variant in the course of this example.

\subsection{Creating the Game Play}

We are going to build the logic for the game \emph{bottom up}, meaning that we build all the needed singular-purpose functions first and then compose the main game logic with these functions.

\begin{impl}[Switch players]
\end{impl}
\begin{haskellcode}

> {-# OPTIONS_GHC -Wno-incomplete-patterns #-}
> import Data.Char ( digitToInt, isDigit )
> import Data.Bits ( Bits(xor) )
> 
> next :: Int -> Int 
> next 1 = 2
> next 2 = 1

\end{haskellcode}

\begin{impl}[Create the board and check game status]
\end{impl}
\begin{haskellcode}

> type Board = [Int]
> initial :: Board
> initial = [5,4,3,2,1]
> finished :: Board -> Bool
> finished = all (== 0)

\end{haskellcode}

\begin{impl}[Make valid move]
A move is specified by a row number and the number of items to be removed, and it's valid if the row contains at least this many items.
\end{impl}
\begin{haskellcode}

> valid :: Board -> (Int, Int) -> Bool
> valid board (row, num) = board !! (row-1) >= num
> 
> move :: Board -> (Int, Int) -> Board
> move board (row, num) = [update r n | (r,n) <- zip [1..] board]
>      where update r n = if r == row then n - num else n

\end{haskellcode}

\begin{impl}[IO functions for gameplay]
\end{impl}
\begin{haskellcode}

> putRow :: Int -> Int -> IO ()
> putRow row num = do putStr (show row)
>                     putStr ": "
>                     putStrLn (concat (replicate num "* "))
> 
> putBoard :: Board -> IO ()
> putBoard [a,b,c,d,e] = do putRow 1 a
>                           putRow 2 b
>                           putRow 3 c
>                           putRow 4 d
>                           putRow 5 e
> 
> getDigit :: String -> IO Int
> getDigit prompt = do putStr prompt
>                      d <- getChar
>                      newline
>                      if isDigit d then
>                         return (digitToInt d)
>                      else 
>                         do putStrLn "error: no digit provided!"
>                            getDigit prompt
> 
> newline :: IO ()
> newline = putChar '\n'

\end{haskellcode}

\begin{impl}[Create the main game loop]
\end{impl}
\begin{haskellcode}

> nimH2H :: Board -> Int -> IO ()
> nimH2H board player = do
>     newline
>     putBoard board
>     if finished board then do 
>         newline
>         putStr "player "
>         putStr (show (next player))
>         putStrLn " wins!!"
>     else do
>         newline
>         putStr "player "
>         print player
>         row <- getDigit "enter a row number: "
>         num <- getDigit "stars to remove: "
>         if valid board (row, num) then
>             nimH2H (move board (row, num)) (next player)
>         else do
>             newline
>             putStrLn "error: invalid move!"
>             nimH2H board player

\end{haskellcode}

With that, we have a first running version of \emph{nim}, which can be played in GHCI with two human players \emph{head to head}, e.g. \texttt{<nimH2H initial 1>}, starting with player 1.
Of course, this is only fun if you have a friend to play with, as the game is missing any logic by now. We will take care of this in the next section.

\subsection{Creating the Game Logic}

If you try to win the game we have so far, you will soon recognize that it is not as trivial as it seems at first, as you have to think a few moves in advance and calculate the possible moves of your opponent.

A general winning strategy for a game is to calculate all the remaining possible moves at each turn and to store them in an appropriate data structure, often called the \emph{game tree}.
We will lateron see an example for this in the section of \emph{tic-tac-toe}.
However, in the case of \emph{nim} this is not a promising strategy, as nim is a non-deterministic game, for which you cannot compute all remaining moves, at least not in a reasonable time.

Thankfully, there is another way of tackling this problem, which is, however, anything but obvious. To make a long story short, here is an algorithm for a winning strategy for this kind of games:

\begin{enumerate}
\item Compute the \textbf{Nim-Sum} of the given board. The Nim-Sum is the \emph{bitwise-exclusive-or} of the number of elements in each row: $s_{nim} = n_{r1} \oplus n_{r2} \oplus \cdots \oplus n_{rn}$
\item If the Nim-Sum is zero make a stalling move, otherwise continue with step 3
\item Compute the \emph{bitwise-xor} of the Nim-Sum with the number of elements for every row: $bxor_1 = s_{nim} \oplus n_{r1}, bxor_2 = s_{nim} \oplus n_{r2}, \cdots , bxor_n = s_{nim} \oplus n_{rn}$
\item Find a row, whose result of step 3 is less than its number of elements
\item Reduce the number of elements in the row of step 4, such that it equals its result from step 3.  
\end{enumerate}

The key point of this algorithm is the insight that you cannot win the game if the Nim-Sum is zero and it's your turn to move.
This is why we make a stalling move in step 2 of the algorithm, hoping for a mistake of the human player.
To give the human player at least a chance to win, we will let him make the first move with the initial board, whose Nim-Sum is not zero, which you are welcome to check.

\begin{impl}[Step 1: compute the Nim-Sum]
\end{impl}
\begin{haskellcode}

> nimSum :: Board -> Int
> nimSum = foldr xor 0

\end{haskellcode}

\begin{impl}[Step 2: make stalling move]
\end{impl}
\begin{haskellcode}

> stall :: Board -> Int -> (Int, Int)
> stall (x:xs) row
>     | x > 0 = (row, 1)
>     | otherwise = stall xs (row+1)

\end{haskellcode}

\begin{impl}[Steps 3 - 5]
Reduce the elements of a row to its \texttt{bitwise-xor} with Nim-Sum:
\end{impl}
\begin{haskellcode}

> reduce :: Board -> Int -> (Int, Int)
> reduce board row
>     | x > bxor = (row, x - bxor)
>     | otherwise = reduce board (row+1)
>     where x = board !! (row-1)
>           bxor = xor (nimSum board) x

\end{haskellcode}

\begin{impl}[Adjust the main game loop to allow the computer (player 2) to make its own choice]
\end{impl}
\begin{haskellcode}

> nim :: Board -> Int -> IO ()
> nim board player = do
>     newline
>     putBoard board
>     if finished board then do 
>         newline
>         if player == 1 then print "computer wins!!"
>         else print "you win!!"
>     else do
>         newline
>         if player == 1 then do -- human player
>             row <- getDigit "enter a row number: "
>             num <- getDigit "stars to remove: "
>             if valid board (row, num) then
>                 nim (move board (row, num)) 2
>             else do
>                 newline
>                 putStrLn "error: invalid move!"
>                 nim board player
>         else do -- computer player
>             if nimSum board == 0 then nim (move board (stall board 1)) 1
>             else nim (move board (reduce board 1)) 1

\end{haskellcode}

The game can now be startet in GHCI with \texttt{<nim initial 1>}.