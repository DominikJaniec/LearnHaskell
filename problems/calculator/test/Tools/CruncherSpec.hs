module Tools.CruncherSpec (main, spec) where

import Data.Maybe
import Test.Hspec
import Tools.BlankChopper
import Tools.Cruncher


main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "cruncherFor" $
    context "resolves correct cruncher's info for a given token" $
      itResolvesCrunchersInfoAsSpecSamples
        [ ("+", CruncherInfo { symbol = "+", fullName = "addition", argsLimit = Nothing })
        , ("-", CruncherInfo { symbol = "-", fullName = "subtraction", argsLimit = Nothing })
        ]


resolveCruncherFor x = cruncherFor Token { content = x, index = 0 }
resolvecruncherInfoFor x = fst $ fromMaybe unknownCruncher (resolveCruncherFor x)

itResolvesCrunchersInfoAsSpecSamples = mapM_ itResolvesCrunchersInfo
itResolvesCrunchersInfo (input, result) = let
    chopHeader i r = "resolves as: " ++ show r ++ ", for a token: '" ++ i ++ "'"
    assertChop i r = resolvecruncherInfoFor i `shouldBe` r
  in it (chopHeader input result) $ assertChop input result
