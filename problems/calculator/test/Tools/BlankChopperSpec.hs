module Tools.BlankChopperSpec (main, spec) where

import Test.Hspec
import Tools.BlankChopper


main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "chop" $ do
    context "breaks on spaces" $ do
      itChopsAsSpecSamples
        [ ("x y", ["x", "y"])
        , ("a    b", ["a", "b"])
        , ("  m n   ", ["m", "n"])
        , ("more then one", ["more", "then", "one"])
        , ("        blanked    front", ["blanked", "front"])
        , ("tails should be empty         ", ["tails", "should", "be", "empty"])
        , ("       shrouded    with void      ", ["shrouded", "with", "void"])
        ]

    context "breaks on tabs" $ do
      itChopsAsSpecSamples
        [ ("t\tt", ["t", "t"])
        , ("q\t\t\ty", ["q", "y"])
        , ("\ttabs\tevery\twhere\t", ["tabs", "every", "where"])
        , ("\t\t\t\t\t\tmuch\ttabs\tat\tstart", ["much", "tabs", "at", "start"])
        , ("only\tend\tis\ttabed\t\t\t\t", ["only", "end", "is", "tabed"])
        , ("\t\t\t\tlike\tfog\twithin\ttabs\t\t\t\t", ["like", "fog", "within", "tabs"])
        ]

    context "breaks on new lines" $ do
      itChopsAsSpecSamples
        [ ("1\n2", ["1", "2"])
        , ("\n4\n3\n2\n1\n", ["4", "3", "2", "1"])
        , ("\n\n\n\nmagic\n\n\nnumber\n\n\n\nseven\n\n", ["magic", "number", "seven"])
        ]

itChopsAsSpecSamples specs = mapM_ itChops specs
itChops (input, result) = let
    chopHeader i r = "choped as: " ++ show r ++ ", for an input: '" ++ i ++ "'"
    assertChop i r = chop i `shouldBe` r
  in it (chopHeader input result) $ do assertChop input result
