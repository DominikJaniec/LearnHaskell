module Notation.ReversePolish
    ( ReversePolishNotation (..)
    , CalcResult
    , ErrorInfo (..)
    , ErrorKind (..)
    , calculateResult
    ) where

import Notation
import Tools.BlankChopper


data ReversePolishNotation = ReversePolishNotation
instance Notation ReversePolishNotation where
    notationKey ntn = "RPN"
    calculator ntn input =
        case calculateResult input of
            Right value -> value
            Left _ -> 0/0

type CalcResult = Either ErrorInfo Double

data ErrorInfo = ErrorInfo
    { errorKind :: ErrorKind
    , inputIndex :: Int
    } deriving (Eq, Show)

data ErrorKind = ErrorUndefined
    | ErrorEmptyInput
    | ErrorUnknownSymbol
    deriving (Eq, Show)

calculateResult :: String -> CalcResult
calculateResult input = Left ErrorInfo { errorKind = ErrorEmptyInput, inputIndex = 0 }
