module NotationSpec (main, spec) where

import Test.Hspec
import Notation


main :: IO ()
main = hspec spec


data TestNtn = TestNtn
instance Notation TestNtn where
    notationKey ntn = "TestNotation"
    calculator ntn = fromIntegral . length

spec :: Spec
spec = do
  describe "calculate" $ do
    it "uses given Notation's calculator to compute result from given expressions set" $ do
      calculate TestNtn ["1", "22", "..5..", "will be 10", "this notation just counts characters, so it will be 54"]
      `shouldBe`
      [1, 2, 5, 10, 54]
