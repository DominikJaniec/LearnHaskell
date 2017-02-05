doubleMe x = x + x

-- doubleUs x y = x*2 + y*2
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                        then x
                        else doubleMe x

doubleSmallNumber' x = (if x > 100 then x else doubleMe x) + 1

length' xs = sum [1 | _ <- xs]

removeNonUpperCase str = [c | c <- str, c `elem` ['A'..'Z']]

rightTriangls maxSide permiter = [(a,b,c) | c <- [1..maxSide], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == permiter]

fun x y = (x, y)

tenDividedBy :: (Floating a) => a -> a
tenDividedBy = (10/)