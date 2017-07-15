module Tools.Cruncher
    ( CrunchMethod
    , CruncherInfo(..)
    , CrunchErrorKind
    , cruncherFor
    , unknownCruncher
    ) where

import Tools.BlankChopper


type CrunchMethod = [Double] -> Either CrunchErrorKind Double

data CruncherInfo = CruncherInfo
    { symbol :: String
    , fullName :: String
    , argsLimit :: Maybe Int
    } deriving (Eq, Show)

data CrunchErrorKind = ErrorUndefined
    | ErrorTooMuchArgs
    | ErrorTooFewArgs
    | ErrorArgOutOfRange
    deriving (Eq, Show)

unknownCruncher :: (CruncherInfo, CrunchMethod)
unknownCruncher = let
    cruncher _ = Left ErrorUndefined
    info = CruncherInfo
        { symbol = ""
        , fullName = "UNKNOWN"
        , argsLimit = Just (-1)
        }
    in (info, cruncher)

cruncherFor :: Token -> Maybe (CruncherInfo, CrunchMethod)
cruncherFor token = Nothing
