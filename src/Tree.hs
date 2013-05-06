
module Tree (showTree) where

showTree = do
  putStrLn $ "values = " ++ (show values)
  putStrLn $ "tree = " ++ (show tree)
  putStrLn $ "doubleTree = " ++ (show doubleTree)
  where
    values = [5, 4, 3, 7, 8, 6, 2, 9, 0]
    tree = foldl insertTree EmptyNode values
    doubleTree = fmap (*2) tree

data Node a = EmptyNode | Node a (Node a) (Node a) deriving (Show)

instance Functor Node where
  fmap _ EmptyNode = EmptyNode
  fmap f (Node a b c) = Node (f a) (fmap f b) (fmap f c)

insertTree :: (Ord a) => Node a -> a -> Node a
insertTree EmptyNode a = Node a EmptyNode EmptyNode
insertTree (Node a left right) value
  | value == a = Node a left right
  | value < a = Node a (insertTree left value) right
  | value > a = Node a left (insertTree right value)
