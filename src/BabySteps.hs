
module BabySteps ( showBabySteps ) where

showBabySteps = do
  putStrLn $ "doubleMe 5 = " ++ show (doubleMe 5)
  putStrLn $ "doubleUs 5 7 = " ++ show (doubleUs 5 7)
  putStrLn $ "doubleSmallNumberAndAddOne 50 = " ++ show (doubleSmallNumberAndAddOne 50)
  putStrLn $ "doubleSmallNumberAndAddOne 500 = " ++ show (doubleSmallNumberAndAddOne 500)
  putStrLn $ "productOneToTen = " ++ show (productOneToTen)
  putStrLn $ "multiplesOfThirteen = " ++ show (multiplesOfThirteen)
  putStrLn $ "boomBang [7..13] = " ++ show (boomBang [7..13])
  putStrLn $ "triangles = " ++ show (triangles)


-- a simple function
doubleMe x = x + x

-- another easy one. Take a look of the function application precedence!
doubleUs x y = doubleMe x + doubleMe y

-- Our first statement! Yay!
doubleSmallNumberAndAddOne  x = (if x > 100
                                 then x
                                 else doubleMe x) + 1

-- ranges!
productOneToTen = product [1..10]

-- multiples of thirteen
multiplesOfThirteen = take 5 [13,26..]

-- BOOM or BANG?
boomBang xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

-- which right triangle that has integers for all sides and
-- all sides equal to or smaller than 10 has a perimeter of 24?
triangles = [(a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a + b + c == 24]
