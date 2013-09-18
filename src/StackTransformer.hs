-- This is the same thing as 'StackDemo', but using a MonadTransformer (StateT) to glue
-- State and IO monads together

module StackTransformer ( showStackTransformer ) where

import Control.Monad.Trans.State
import Control.Monad.IO.Class (liftIO)
import Control.Applicative

-- Just to remember:
-- print :: Show a => a -> IO ()
-- (=<<) :: Monad m => (a -> m b) -> m a -> m b (it 'lifts' the function, like fmap)
showStackTransformer :: IO ()
showStackTransformer = print =<< (evalStateT manipulateStack [])

-- Again, the stack is just a list of ints
type Stack = [Int]

-- This time, our state is a bit more involved
type StatefulStack a = StateT Stack IO a

-- pushing values
-- liftIO :: (Monad m) => IO a -> m a (it 'transforms' an IO value in the current monad)
-- This trick let us 'call' IO functions inside our Monad. Take a look at the MonadIO class
push :: Int -> StatefulStack ()
push a = do
  liftIO . putStrLn $ ">> Pushing the value " ++ (show a)
  state $ \xs -> ((),a:xs)

-- popping
pop :: StatefulStack Int
pop = do
  (x:xs) <- get
  liftIO . putStrLn $ ">> Popping the value " ++ (show x)
  state $ \_ -> (x,xs)

-- peeking
peek :: StatefulStack Int
peek = do
  (x:xs) <- get
  liftIO . putStrLn $ ">> Peeking the value " ++ (show x)
  state $ \_ -> (x,x:xs)

-- manipulate the stack
manipulateStack :: StatefulStack Int
manipulateStack = do
  push 5
  push 7
  a <- pop
  b <- pop
  push (a + b)
  peek
