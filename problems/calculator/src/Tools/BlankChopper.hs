module Tools.BlankChopper
    ( Token(..)
    , chop
    , chopTokens
    ) where


data Token = Token
    { content :: String
    , index :: Int
    } deriving (Show)

chop :: String -> [String]
chop str = map content $ chopTokens str

chopTokens :: String -> [Token]
chopTokens str =
    let input = ' ' : str
        infos = map makeInfo $ zip input [-1..]
        initial = Stats { lastChar = BlankChar, tokens = [], buffer = "" }
    in tokens $ foldr chopper initial infos


data ChopAction = BlankStill | BlankOccur | TokenStill | TokenOccur
data CharKind = BlankChar | TokenChar

data Stats = Stats
    { lastChar :: CharKind
    , tokens :: [Token]
    , buffer :: String
    }

data Info = Info
    { charItem :: Char
    , charKind :: CharKind
    , charIndex :: Int
    }


kind :: Char -> CharKind
kind ' ' = BlankChar
kind '\t' = BlankChar
kind '\n' = BlankChar
kind _ = TokenChar

makeInfo :: (Char, Int) -> Info
makeInfo (c, i) = Info
    { charItem = c
    , charKind = kind c
    , charIndex = i
    }

whatAction :: Info -> Stats -> ChopAction
whatAction Info { charKind = BlankChar } Stats { lastChar = BlankChar } = BlankStill
whatAction Info { charKind = BlankChar } _ = BlankOccur
whatAction Info { charKind = TokenChar } Stats { lastChar = TokenChar } = TokenStill
whatAction Info { charKind = TokenChar } _ = TokenOccur

chopper :: Info -> Stats -> Stats
chopper info stats =
    case whatAction info stats of
        BlankStill ->
            stats

        BlankOccur ->
            let tokenContent = buffer stats
                tokenIndex = charIndex info + 1
                token = Token { content = tokenContent, index = tokenIndex }
                allTokens = token : tokens stats
            in stats { lastChar = BlankChar, tokens = allTokens, buffer = "" }

        TokenStill ->
            let newBuffer = charItem info : buffer stats
            in stats { buffer = newBuffer }

        TokenOccur ->
            let firstBuffer = [charItem info]
            in stats { lastChar = TokenChar, buffer = firstBuffer }
