module Main where

import System.Environment
import ArgsParser

main :: IO ()
main = do
    appName <- getProgName
    rawArgs <- getArgs
    putStrLn $ dump appName rawArgs
