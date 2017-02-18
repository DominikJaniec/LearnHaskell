module Notation
    ( Notation (..)
    , calculate
    , compute
    ) where


class Notation a where
    notationKey :: a -> String
    calculator :: a -> (String -> Double)

calculate :: (Notation a) => a -> [String] -> [Double]
calculate ntn expressions = map (compute ntn) expressions

compute :: (Notation a) => a -> String -> Double
compute ntn expression = calculator ntn expression
