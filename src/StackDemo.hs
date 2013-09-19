
module StackDemo ( showStackDemo ) where

import Control.Monad.Trans.State

showStackDemo :: IO ()
showStackDemo = putStrLn . show $ evalState manipulateStack []

-- Whe define a stack as a list of ints
type Stack = [Int]

-- Now, we define a StackState, something that will keep the state of our stack
type StatefulStack a = State Stack a

-- pushing values to the stack
push :: Int -> StatefulStack ()
push a = modify (a:)

-- pop values from the state
pop :: StatefulStack Int
pop = state $ \(x:xs) -> (x,xs)

-- peek the last value
peek :: StatefulStack Int
peek = state $ \(x:xs) -> (x,x:xs)

-- manipulate the stack
manipulateStack :: StatefulStack Int
manipulateStack = do
  push 5
  push 7
  a <- pop
  b <- pop
  push (a + b)
  peek
