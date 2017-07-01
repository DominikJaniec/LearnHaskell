module Notation.ReversePolishSpec (main, spec) where

import Data.Maybe
import Test.Hspec
import Notation
import Notation.ReversePolish


main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  describe "notationKey" $ do
    it "returns correct RPN key for Reverse Polish notation" $ do
      notationKey ReversePolishNotation `shouldBe` "RPN"


  describe "compute" $ do
    context "handles standar cases" $ do
      itComputesAsSpecSample
        [ ("7", 7)
        , ("-4321", -4321)
        , ("-99990000", -99990000)
        , ("6 5 2 +", 13)
        , ("11 11 11 11 *", 14641)
        , ("1 10 100 1000 /", 0.0001)
        , ("17 3 5 7 -", 2)
        , ("3 4 + 12 - 3 * -2 /", 7.5)
        ]


  describe "calculateResult" $ do
    context "ends with error for an empty input" $ do
      itEndsWithErrorAsSpecSamples
        [ ("", (ErrorEmptyInput, 0))
        , ("         ", (ErrorEmptyInput, 9))
        , ("\t\t\t\t\t\t\t", (ErrorEmptyInput, 7))
        , ("\t  \n\t\n   \t    ", (ErrorEmptyInput, 14))
        ]

    context "ends with error for an input with unknown symbol" $ do
      itEndsWithErrorAsSpecSamples
        [ ("x", (ErrorUnknownSymbol, 0))
        , ("1 2 ?", (ErrorUnknownSymbol, 4))
        , ("  .7 seven", (ErrorUnknownSymbol, 5))
        , (" a b c d e f + ", (ErrorUnknownSymbol, 1))
        ]

  describe "calculateResult" $ do
    context "preserves constant (single) value" $ do
      itCalculatesAsSpecSamples
        [ ("7", 7)
        , ("42", 42)
        , ("15", 15)
        , ("-4321", -4321)
        , ("10000", 10000)
        , ("-99999900", -99999900)
        ]

    context "can handle floating point value" $ do
      itCalculatesAsSpecSamples
        [ ("0.5", 0.5)
        , (".1", 0.1)
        , (".123", 0.123)
        , (".99999", 0.99999)
        , ("0000000.32000", 0.32)
        , ("3.14159", 3.14159)
        , ("1234.0000000", 1234.0)
        ]

    context "calculates simplem addition" $ do
      itCalculatesAsSpecSamples
        [ ("2 3 +", 5)
        , ("1 1 1 +", 3)
        , ("1 7 0.3 +", 8.3)
        , (".1 .2 6.3 .4 +", 7)
        ]


itComputesAsSpecSample specs = mapM_ itComputes specs
itComputes (input, result) =
    let computeHeader = "computes with ReversePolishNotation: " ++ show result ++  ", for an input: '" ++ input ++ "'"
        assertCompute = compute ReversePolishNotation input `shouldBe` result
    in it computeHeader assertCompute

itEndsWithErrorAsSpecSamples specs = mapM_ itEndsWithError specs
itEndsWithError (input, (expectedError, expectedAtIndex)) =
    let calculateHeader = "calculates as: '" ++ show expectedError ++ "' at index: " ++ show expectedAtIndex ++ ", for an input: '" ++ input ++ "'"
        assertCalculateResult =
          let errorAtIndex = fromMaybe (-1) . inputIndex
              result = case calculateResult input of
                Left info -> (errorKind info, errorAtIndex info)
                _ -> (ErrorUndefined, -1)
          in result `shouldBe` (expectedError, expectedAtIndex)
    in it calculateHeader $ do assertCalculateResult

itCalculatesAsSpecSamples specs = mapM_ itCalculates specs
itCalculates (input, result) =
    let calculateHeader = "calculates result: " ++ show result ++ ", for an input: '" ++ input ++ "'"
        assertCalculateResult = calculateResult input `shouldBe` Right result
    in it calculateHeader assertCalculateResult
