module ArgsParser
    ( dumpArgs
    ) where

data Args = Args
    { notation :: String
    , expressions :: [String]
    } deriving (Show)

parseArgs :: [String] -> Args
parseArgs xs = Args { notation = "RPN", expressions = xs }

dumpArgs :: [String] -> String
dumpArgs args = let
    line n str = "  " ++ (show n) ++ ". " ++ str
    enhance _ [] = []
    enhance n (x:xs) = (line n x) : (enhance (n+1) xs)
    in unlines $ "Arguments are:" : enhance 1 args