
fizzBuzz = map zzer [1..]
    where zzer x
            | fizzer x && buzzer x = "fizz-buzz"
            | fizzer x = "fizz"
            | buzzer x = "buzz"
            | otherwise = show x
            where
                divided by x = x `mod` by == 0
                fizzer = divided 3
                buzzer = divided 5

fizzBuzz' = let
    zzer x
        | fizzer x && buzzer x = "fizz-buzz"
        | fizzer x = "fizz"
        | buzzer x = "buzz"
        | otherwise = show x
        where
            divided by x = x `mod` by == 0
            fizzer = divided 3
            buzzer = divided 5
    in map zzer [1..]

fizzBuzz'' =
    let divided by x = x `mod` by == 0
        fizzer = divided 3
        buzzer = divided 5
        zzer x
            | fizzer x && buzzer x = "fizz-buzz"
            | fizzer x = "fizz"
            | buzzer x = "buzz"
            | otherwise = show x
    in map zzer [1..]
