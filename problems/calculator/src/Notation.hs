module Notation
    ( Notation (..)
    , calculate
    ) where


class Notation a where
    notationKey :: a -> String
    calculator :: (Num r) => a -> (String -> r)

calculate :: (Notation a, Num r) => a -> [String] -> [r]
calculate ntn expressions = map (calculator ntn) expressions
