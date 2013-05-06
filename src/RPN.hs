
module RPN (showRPN) where

showRPN = do
  putStrLn $ "5 5 + => " ++ (show $ solveRPN "5 5 +")
  putStrLn $ "5 7 1 + - => " ++ (show $ solveRPN "5 7 1 + -")
  putStrLn $ "5 5 5 + => " ++ (show $ solveRPN "5 5 5 +")
  putStrLn $ "5  => " ++ (show $ solveRPN "5")

solveRPN :: (Num a, Read a) => String -> Maybe a
solveRPN  = safeHead . foldl process [] . words
  where process (x:y:xs) "+" = (x + y):xs
        process (x:y:xs) "-" = (y - x):xs
        process (x:y:xs) "*" = (x * y):xs
        process xs str = (read str):xs
        safeHead [] = Nothing
        safeHead (x:xs:[]) = Nothing
        safeHead xs = Just $ head xs
