module ArgsParser
    ( Args(..)
    , parseArgs
    , help
    , dump
    ) where

import Data.List


data Args = Args
    { notation :: String
    , expressions :: [String]
    } deriving (Eq, Show)

help :: String
help = unlines
    [ "Incorrect execution parameters:"
    , "  $ calculator -n:SAMPLE expr1 [expr2..n]"
    , ""
    , "    -n:SAMPLE        - where {SAMPLE} is Mathematical Notation key"
    , "    expr1 [expr2..n] - list of expressions in given Notation to calculate"
    ]

parseArgs :: [String] -> Either String Args
parseArgs [] = Left help
parseArgs [_] = Left help
parseArgs xs = case getNotation xs of
    Nothing -> Left help
    Just ntn -> Right $ buildArgs ntn xs
    where
        getNotation args = stripPrefix "-n:" $ head args
        buildArgs ntn xs = Args { notation = ntn, expressions = tail xs }

dump :: String -> [String] -> String
dump name args = let
    header = "The '" ++ name ++ "' executed with " ++ show (length args) ++ " arguments:"
    line n str = "  " ++ show n ++ ". " ++ str
    enhance _ [] = []
    enhance n (x:xs) = line n x : enhance (n + 1) xs
    in unlines $ header : enhance 1 args
