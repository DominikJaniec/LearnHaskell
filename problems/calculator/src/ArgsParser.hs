module ArgsParser
    ( dump
    ) where

data Args = Args
    { notation :: String
    , expressions :: [String]
    } deriving (Show)

parseArgs :: [String] -> Args
parseArgs xs = Args { notation = "RPN", expressions = xs }

dump :: String -> [String] -> String
dump name args = let
    header name args = "The '" ++ name ++ "' executed with " ++ (show $ length args) ++ " arguments:"
    line n str = "  " ++ (show n) ++ ". " ++ str
    enhance _ [] = []
    enhance n (x:xs) = (line n x) : (enhance (n+1) xs)
    in unlines $ (header name args) : (enhance 1 args)
