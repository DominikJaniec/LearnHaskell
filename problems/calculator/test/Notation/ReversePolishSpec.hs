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
      itAssertComputeSpecSamples [("7", 7), ("42", 42), ("15", 15), ("-4321", -4321)]


itAssertComputeSpecSamples specs = mapM_ itAssertCompute specs

itAssertCompute (input, result) = let
    computeHeader i r = "computes: " ++ (show r) ++ ", for a input: '" ++ i ++ "'"
    assertCompute i r = compute ReversePolishNotation i `shouldBe` r
  in it (computeHeader input result) $ do assertCompute input result
