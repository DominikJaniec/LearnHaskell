module Generators.PrimeGenSpec (main, spec) where

import qualified Data.List as List
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "make" $ do
    context "generates infinity stepping list" $ do
      it "with gap of single number" $ do
        assumeInf (makeStepping 1) `shouldSatisfy` allIncBy 1

assumeInf = List.take 21

allIncBy :: Integer -> [Integer] -> Bool
allIncBy n =
  extract . List.foldl check (True, n - 1)
  where
    check (True, prev) x = (x - 1 == prev, x)
    check (False, _) x = (False, x)
    extract (result, _) = result

makeStepping start = [start..]
