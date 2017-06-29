module Notation.ReversePolishSpec (main, spec) where

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


  describe "calculateResult" $ do
    context "ends with error for an empty input" $ do
      let errorFor input = makeError ErrorEmptyInput (length input)
      let makeErrorSample input = (input, errorFor input)
      itCalculateResultAsSpecSamples
        [ makeErrorSample ""
        , makeErrorSample "         "
        , makeErrorSample "\t\t\t\t\t\t\t"
        , makeErrorSample "\t  \n\t\n   \t    "
        ]

    context "ends with error for an input with unknown symbol" $ do
      let errorAt = makeError ErrorUnknownSymbol
      itCalculateResultAsSpecSamples
        [ ("x", errorAt 0)
        , ("1 2 ?", errorAt 4)
        , ("  .7 seven", errorAt 9)
        , (" a b c d e f + ", errorAt 1)
        ]

  describe "compute" $ do
    context "preserves constant (single) value" $ do
      itComputesAsSpecSamples
        [ ("7", 7)
        , ("42", 42)
        , ("15", 15)
        , ("-4321", -4321)
        , ("10000", 10000)
        , ("-99999900", -99999900)
        ]

    context "can handle floating point value" $ do
      itComputesAsSpecSamples
        [ ("0.5", 0.5)
        , (".1", 0.1)
        , (".123", 0.123)
        , (".99999", 0.99999)
        , ("0000000.32000", 0.32)
        , ("3.14159", 3.14159)
        , ("1234.0000000", 1234.0)
        ]

    context "calculates simplem addition" $ do
      itComputesAsSpecSamples
        [ ("2 3 +", 5)
        , ("1 1 1 +", 3)
        , ("1 7 0.3 +", 8.3)
        , (".1 .2 6.3 .4 +", 7)
        ]

itComputesAsSpecSamples specs = mapM_ itComputes specs
itComputes (input, result) =
    let computeHeader i r = "computes: " ++ show r ++ ", for an input: '" ++ i ++ "'"
        assertCompute i r = compute ReversePolishNotation i `shouldBe` r
    in it (computeHeader input result) $ do assertCompute input result

itCalculateResultAsSpecSamples specs = mapM_ itCalculateResult specs
itCalculateResult (input, result) =
    let calculateHeader i r = "calculates result: " ++ show r ++ ", for an input: '" ++ i ++ "'"
        assertCalculateResult i r = calculateResult i `shouldBe` r
    in it (calculateHeader input result) $ do assertCalculateResult input result

makeError kind index = Left ErrorInfo { errorKind = kind, inputIndex = index }
