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

  describe "compute" $ do
    context "preserves constant (single) value" $ do
      itAssertComputeSpecSamples
        [ ("7", 7)
        , ("42", 42)
        , ("15", 15)
        , ("-4321", -4321)
        , ("10000", 10000)
        , ("-99999900", -99999900)
        ]

    context "can handle floating point value" $ do
      itAssertComputeSpecSamples
        [ ("0.5", 0.5)
        , (".1", 0.1)
        , ("0000000.32000", 0.32)
        , ("3.14159", 3.14159)
        , ("1234.0000000", 1234.0)
        ]

    context "calculates simplem addition" $ do
      itAssertComputeSpecSamples
        [ ("2 3 +", 5)
        , ("1 1 1 +", 3)
        , ("1 7 0.3 +", 8.3)
        , (".1 .2 6.3 .4 +", 7)
        ]

itAssertComputeSpecSamples specs = mapM_ itAssertCompute specs

itAssertCompute (input, result) = let
    computeHeader i r = "computes: " ++ (show r) ++ ", for an input: '" ++ i ++ "'"
    assertCompute i r = compute ReversePolishNotation i `shouldBe` r
  in it (computeHeader input result) $ do assertCompute input result
