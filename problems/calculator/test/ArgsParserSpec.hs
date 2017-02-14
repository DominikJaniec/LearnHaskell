module ArgsParserSpec (main, spec) where

import Data.List
import Test.Hspec
import ArgsParser

main :: IO ()
main = hspec spec

spec :: Spec
spec = do

  describe "help" $ do
    it "contains correct execution command line" $ do
      help `shouldSatisfy` ("calculator -n:SAMPLE expr1 [expr2..n]" `isInfixOf`)


  describe "parseArgs" $ do
    it "returns HELP page, when no arguments are passed" $ do
      parseArgs [] `shouldBe` Left help

    it "returns HELP page, when not enought arguments are passed" $ do
      parseArgs ["-n:just_this"] `shouldBe` Left help

    it "returns Args with given Notation and expression" $ do
      parseArgs ["-n:X", ""]
      `shouldBe`
      Right Args { notation = "X", expressions = [""] }

    it "returns Args with given Notation and all expressions in given order" $ do
      parseArgs ["-n:MAGIC", "C", "A", "B"]
      `shouldBe`
      Right Args { notation = "MAGIC", expressions = ["C", "A", "B"] }


  describe "dump" $ do
    it "produces some message" $ do
      dump "program name" ["some", "arguments"] `shouldSatisfy` not . null

    it "contains program name in first line" $ do
      dump "AppName.exe" [] `shouldSatisfy` (\x -> "AppName.exe" `isInfixOf` ((head . lines) x))
