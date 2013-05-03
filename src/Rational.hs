
module Rational ( showRational ) where

showRational = do
  putStrLn $ "87//116 = " ++ show (87//116)
  putStrLn $ "(1//3) /+/ (2//5) /+/ (3//13) = " ++ show ((1//3) /+/ (2//5) /+/ (3//13))
  putStrLn $ "(8//9) /-/ (1//3) /-/ (2//7) = " ++ show ((8//9) /-/ (1//3) /-/ (2//7))
  putStrLn $ "(1//3) /*/ (2//5) /*/ (4//7) = " ++ show ((1//3) /*/ (2//5) /*/ (4//7))
  putStrLn $ "(1//11) /:/ (2//5) /:/ (7//13) = " ++ show ((1//11) /:/ (2//5) /:/ (7//13))

-- data type for rational numbers
data Ratio = Ratio Int Int

instance Show Ratio where
  show (Ratio a b) = (show a) ++ "//" ++ (show b)

-- compute the next multiple of a number and the next multiple
-- to a maximun (desired) value
nextMultiple :: (Num a) => a -> a -> a
nextMultiple = (+)

nextMultipleTo :: (Num a, Ord a) => a -> a -> a -> a
nextMultipleTo n acc max
   | acc < max = nextMultipleTo n next max
   | otherwise =  acc
   where
     next = (nextMultiple n acc)

-- compute the mmc between 2 numbers.
-- the pairs are in the format (original, accumulator) because we need
-- to slowly increment the numbers until we get the minimun multiple
-- value between a and b
mmc' :: (Num a, Ord a) => (a, a) -> (a, a) -> a
mmc' (va, ta) (vb, tb)
  | ta == tb = ta
  | ta < tb  = mmc' (va, nextA) (vb, tb)
  | ta > tb = mmc' (va, ta) (vb, nextB)
  where
    nextA = nextMultipleTo va ta tb
    nextB = nextMultipleTo vb tb ta

-- just a nicer interface to the mmc calculation
mmc :: (Num a, Ord a) => a -> a -> a
mmc a b = mmc' (a, a) (b, b)

-- Apply a denominator value to a Ratio
applyDenominator :: Ratio -> Int -> Ratio
applyDenominator (Ratio a b) d
  | isDivisible = Ratio (d' * a) d
  | otherwise = error "incompatible denominator value."
  where
    d' = (d `div` b)
    isDivisible = (d' * b) == d

-- normalize two ratios (make them use the same denominator)
normalizeRatios :: Ratio -> Ratio -> (Ratio, Ratio)
normalizeRatios r1@(Ratio _ d1) r2@(Ratio _ d2) = (a, b)
  where
    d = mmc d1 d2
    a = applyDenominator r1 d
    b = applyDenominator r2 d

-- compute the mdc between 2 numbers
mdc a b
  | rest == 0 = smaller
  | rest == smaller = 1
  | otherwise = mdc rest smaller
  where
    smaller = min a b
    bigger = max a b
    rest  = bigger `mod` smaller

-- simplify a ratio
simplifyRatio :: Ratio -> Ratio
simplifyRatio (Ratio n d) = (Ratio n' d')
  where
    m = mdc n d
    n' = n `div` m
    d' = d `div` m

-- operator to create a new ratio
(//) :: Int -> Int -> Ratio
a // b = simplifyRatio $ Ratio a b

-- conversion between numbers and ratio
toRatio :: Int -> Ratio
toRatio a = a // 1

toFractional :: (Fractional a) => Ratio -> a
toFractional (Ratio a b) = (fromIntegral a) / (fromIntegral b)

-- basic operations on ratios
(/+/) :: Ratio -> Ratio -> Ratio
r1 /+/ r2 = (n1 + n2) // d
  where
    ((Ratio n1 d), (Ratio n2 _)) = normalizeRatios r1 r2

(/-/) :: Ratio -> Ratio -> Ratio
r1 /-/ r2 = (n1 - n2) // d
  where
    ((Ratio n1 d), (Ratio n2 _)) = normalizeRatios r1 r2

(/*/) :: Ratio -> Ratio -> Ratio
r1 /*/ r2 = (n1 * n2) // (d1 * d2)
  where
    (Ratio n1 d1) = r1
    (Ratio n2 d2) = r2

(/:/) :: Ratio -> Ratio -> Ratio
r1 /:/ (Ratio n2 d2) = r1 /*/ (Ratio d2 n2)
