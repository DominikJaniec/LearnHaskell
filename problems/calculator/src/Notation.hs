module Notation
    ( Notation (..)
    , calculate
    , compute
    ) where


class Notation a where
    notationKey :: a -> String
    calculator :: a -> (String -> Double)

calculate :: (Notation a) => a -> [String] -> [Double]
calculate ntn = map (compute ntn)

compute :: (Notation a) => a -> String -> Double
compute = calculator
