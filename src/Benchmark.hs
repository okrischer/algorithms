import Criterion.Main ( defaultMain, bench, bgroup, whnf )
import qualified Sorting as S
import qualified Random as R
import Data.List (sort)

main :: IO ()
main = do
  let small = R.randInt 1000 42 (0, 1000)
  let large = R.randInt 1000000 42 (0, 1000000)

  defaultMain [
    bgroup "small"  [ bench "List.sort" $ whnf sort       small
                    , bench "quick"     $ whnf S.qSort    small
                    , bench "smoothMS"  $ whnf S.smoothMS small
                    ],
    bgroup "large"  [ bench "List.sort" $ whnf sort       large
                    , bench "quick"     $ whnf S.qSort    large
                    , bench "smoothMS"  $ whnf S.smoothMS large
                    ]
    ]