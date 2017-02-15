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
