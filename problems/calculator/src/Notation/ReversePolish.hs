module Notation.ReversePolish
    ( ReversePolishNotation (..)
    ) where

import Notation

data ReversePolishNotation = ReversePolishNotation
instance Notation ReversePolishNotation where
    notationKey ntn = "RPN"
    calculator ntn = (\expr -> 42)
