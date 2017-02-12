module ArgsParserSpec (main, spec) where

import Test.Hspec
import ArgsParser

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "dump" $ do
    it "produces some message" $ do
      dump "program name" ["some", "arguments"] `shouldSatisfy` not . null
