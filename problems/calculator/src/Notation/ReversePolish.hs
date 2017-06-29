module Notation.ReversePolish
    ( ReversePolishNotation (..)
    , CalcResult
    , ErrorInfo (..)
    , ErrorKind (..)
    , calculateResult
    ) where

import Text.Read
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
calculateResult input =
    case chopTokens input of
        [] -> makeErrorEmptyInput input
        [value] -> handleSingle value
        tokens -> handleTokens tokens


makeErrorEmptyInput :: String -> CalcResult
makeErrorEmptyInput input =
    Left ErrorInfo
    { errorKind = ErrorEmptyInput
    , inputIndex = length input
    }

makeErrorUnknownSymbolAt :: Int -> CalcResult
makeErrorUnknownSymbolAt tokenIndex =
    Left ErrorInfo
    { errorKind = ErrorUnknownSymbol
    , inputIndex = tokenIndex
    }


handleSingle :: Token -> CalcResult
handleSingle token =
    case parseNumber token of
        Nothing -> makeErrorUnknownSymbolAt 0
        Just parsedNumber -> Right parsedNumber

handleTokens :: [Token] -> CalcResult
handleTokens tokens = makeErrorUnknownSymbolAt 0


parseNumber :: Token -> Maybe Double
parseNumber token =
    let correct ('.':xs) = "0." ++ xs
        correct value = value
        tokenValue = correct . content
    in readMaybe $ tokenValue token
