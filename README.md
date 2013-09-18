## learn-haskell

Just a small cabal project to track my progress learning haskell.
There's nothing extremelly original here, but some things may be useful for
you if you're trying to learn too (especially the State and monad transformers
sample).

The samples are:

*    `BabySteps`: The most basic function definitions you can imagine. Largely based
      on the first chapters of [Learn You a Haskell for Greater Good!](http://learnyouahaskell.com/).
*    `Patterns`: Varios pattern-matching samples
*    `Rational`: A naive implementation of rational numbers. This is a interesting exercise to learn
      Haskell, but keep in mind that this is for **learning purposes only**, since Haskell already have
      support for rational numbers. Still, very fun to do.
*    `Tree`: Sample showing a datatype to represent a tree and how to make a functor for it. Very easy
      and somewhat boring, but a mandatory exercise to see if you *really* understand functors.
*    `RPN`: A reverse polish notation parser. Again, this was based on an example of [LYAHGG](http://learnyouahaskell.com/).
*    `StackDemo`: A tiny sample on how to use the State monad.
*    `StackTransformer`: The same sample from `StackDemo`, but re-implemented to use a monad transformer
      to glue both `State` and `IO` monads. Very interesting and simple to follow, but make sure you understand
      `Functor`, `Applicative` and `Monad` typeclasses before trying to understando this one.

If you have any doubt about the samples, encoutered a bug ou simply have a suggestion for a better sample,
send me a message or fork the project and send a pull request.

## License

BSD-3. See `LICENSE` and have fun.
