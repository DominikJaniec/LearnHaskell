module Main where

import System.Environment
import ArgsParser

main :: IO ()
main = do
    rawArgs <- getArgs
    putStrLn $ dumpArgs rawArgs
