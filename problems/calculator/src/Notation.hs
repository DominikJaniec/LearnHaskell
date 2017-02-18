module Notation
    ( Notation (..)
    , calculate
    , compute
    ) where


class Notation a where
    notationKey :: a -> String
    calculator :: (Num r) => a -> (String -> r)

calculate :: (Notation a, Num r) => a -> [String] -> [r]
calculate ntn expressions = map (compute ntn) expressions

compute :: (Notation a, Num r) => a -> String -> r
compute ntn expression = calculator ntn expression
