module Tools.Cruncher
    ( CrunchMethod
    , CruncherInfo(..)
    , CrunchErrorKind
    , cruncherFor
    ) where

import Tools.BlankChopper


type CrunchMethod = [Double] -> Either String Double

data CruncherInfo = CruncherInfo
    { symbol :: String
    , fullName :: String
    , argsLimit :: Maybe Int
    } deriving Show

data CrunchErrorKind = ErrorUndefined
    | ErrorTooMuchArgs
    | ErrorTooFewArgs
    | ErrorArgOutOfRange
    deriving (Eq, Show)

cruncherFor :: Token -> Maybe (CruncherInfo, CrunchMethod)
cruncherFor token = Nothing
