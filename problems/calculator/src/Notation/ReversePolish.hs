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
import Tools.Cruncher


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
    , errorDetails :: Maybe String
    , inputIndex :: Maybe Int
    } deriving (Eq, Show)

data ErrorKind = ErrorUndefined
    | ErrorEmptyInput
    | ErrorUncomputable
    | ErrorUnknownSymbol
    deriving (Eq, Show)

calculateResult :: String -> CalcResult
calculateResult input =
    case chopTokens input of
        [] -> Left $ makeErrorEmptyInputFrom input
        [value] -> handleSingleToken value
        tokens -> handleTokens tokens


makeErrorEmptyInputFrom :: String -> ErrorInfo
makeErrorEmptyInputFrom input = ErrorInfo
    { errorKind = ErrorEmptyInput
    , errorDetails = Nothing
    , inputIndex = Just $ length input
    }

makeErrorUncomputableWith :: Maybe String -> ErrorInfo
makeErrorUncomputableWith moreDetails = ErrorInfo
    { errorKind = ErrorUncomputable
    , errorDetails = moreDetails
    , inputIndex = Nothing
    }

makeErrorUnknownSymbol :: Token -> String -> ErrorInfo
makeErrorUnknownSymbol token details = ErrorInfo
    { errorKind = ErrorUnknownSymbol
    , errorDetails = Just details
    , inputIndex = Just $ index token
    }


handleSingleToken :: Token -> CalcResult
handleSingleToken token =
    case parseNumber token of
        Just parsedNumber -> Right parsedNumber
        Nothing -> Left $ makeErrorUnknownSymbol token message
            where message = "Could not parse '" ++ show (content token) ++ "' as Number."

handleTokens :: [Token] -> CalcResult
handleTokens tokens =
    let initialState = Right []
        crunchTokens state token = case state of
            Right values -> crunchToken values token
            Left _ -> state
        toResult state = case state of
            Right [value] -> Right value
            Left errorInfo -> Left errorInfo
            Right values -> Left $ makeErrorUncomputableWith $ Just message
                where message = "Solution do not have a single result. Left with: " ++ show values
    in toResult $ foldl crunchTokens initialState tokens


type ValueStack = [Double]
type CrunchingState = Either ErrorInfo ValueStack

parseNumber :: Token -> Maybe Double
parseNumber token =
    let correct ('.':xs) = "0." ++ xs
        correct value = value
        tokenValue = correct . content
    in readMaybe $ tokenValue token

crunchToken :: ValueStack -> Token -> CrunchingState
crunchToken values token =
    case parseNumber token of
        Just parsedNumber -> Right $ parsedNumber:values
        Nothing -> crunchSymbolFrom token values

crunchSymbolFrom :: Token -> ValueStack -> CrunchingState
crunchSymbolFrom token values =
    let crunchWith (info, method) = Right values
    in case cruncherFor token of
        Just cruncher -> crunchWith cruncher
        Nothing -> Left $ makeErrorUnknownSymbol token message
            where message = "Could not find known implementation for a symbol: '" ++ content token ++ "'."
