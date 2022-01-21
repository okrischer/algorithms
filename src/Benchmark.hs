import Criterion.Main ( defaultMain, bench, bgroup, whnf )
import qualified DivConq as DC
import qualified Random as R
import Data.List (sort)

main :: IO ()
main = do
  let small = R.randInt 1000 42 (0, 1000)
  let large = R.randInt 1000000 42 (0, 1000000)

  defaultMain [
    bgroup "small"  [ bench "List.sort" $ whnf sort        small
                    , bench "iSort"     $ whnf DC.iSort    small
                    , bench "qSort"     $ whnf DC.qSort    small
                    , bench "smoothMS"  $ whnf DC.smoothMS small
                    ],
    bgroup "large"  [ bench "List.sort" $ whnf sort        large
                    , bench "iSort"     $ whnf DC.iSort    large
                    , bench "qSort"     $ whnf DC.qSort    large
                    , bench "smoothMS"  $ whnf DC.smoothMS large
                    ]
    ]