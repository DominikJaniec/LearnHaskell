module Notation.ReversePolish
    ( ReversePolishNotation (..)
    ) where

import Notation


data ReversePolishNotation = ReversePolishNotation
instance Notation ReversePolishNotation where
    notationKey ntn = "RPN"
    calculator ntn = parse

parse :: String -> Double
parse ('.':xs) = parse $ "0." ++ xs
parse x = read x
