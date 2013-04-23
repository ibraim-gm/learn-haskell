
module Patterns ( showPatterns ) where

showPatterns = do
  putStrLn $ "factorial 10 = " ++ show (factorial 10)
  putStrLn $ "addPoints (5,15) (10,25) = " ++ show (addPoints (5,10) (10,25))
  putStrLn $ "bhaskara 2 (-6) (-20) = " ++ show (bhaskara 2 (-6) (-20))
  putStrLn $ "testMyWeight 96.6 1.79 = " ++ show (testMyWeight 96.6 1.79)

-- the classic factorial sample
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- deconstructing tuples
addPoints :: (Num a) => (a, a) -> (a, a) -> (a, a)
addPoints (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

-- bhaskara: the 'where' syntax
bhaskara :: (Floating a) => a -> a -> a -> (a, a)
bhaskara a b c = (posDelta, negDelta)
  where
    posDelta = ((-b) + (sqrt delta)) / (2 * a)
    negDelta = ((-b) - (sqrt delta)) / (2 * a)
    delta = (b ^ 2) - (4 * a * c)

-- brazilian IMC (more or less the same as bmi)
testMyWeight :: (Floating a, Ord a) => a -> a -> String
testMyWeight weight height
  | imc < starving = "You're almost dying from starvation."
  | imc <= skinny = "You're skinny. Are you eating enough?"
  | imc <= good = "You're good to go."
  | imc <= fat = "You're fat. Time to do some exercise or a diet."
  | imc <= fatter = "You're VERY fat! You HAVE TO lose weight NOW!"
  | otherwise = "You will probably die soon."
  where
    imc = weight / (height ^ 2)
    (starving, skinny, good, fat, fatter) = (17.0, 18.49, 24.99, 34.99, 39.99)
