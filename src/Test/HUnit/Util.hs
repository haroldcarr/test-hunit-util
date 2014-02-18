{-
Created       : 2013 Sep 28 (Sat) 09:01:51 by carr.
Last Modified : 2014 Feb 17 (Mon) 21:35:53 by Harold Carr.
-}

module Test.HUnit.Util
    (
     t
    ,teq
    ,ter
    ,tt
    ) where

import Control.Exception (ErrorCall(ErrorCall), evaluate, try, Exception)
import Test.HUnit
import Test.HUnit.Base   ((~?=), Test(TestCase, TestList))
import Test.HUnit.Text   (runTestTT)

------------------------------------------------------------------------------
-- import Test.HUnit.Tools  (assertRaises) -- cabal install testpack
-- NOTE: I manually "inlined" this to workaround cabal problems.
{- | Asserts that a specific exception is raised by a given action. -}
assertRaises :: (Show a, Control.Exception.Exception e, Show e, Eq e) =>
                String -> e -> IO a -> IO ()
assertRaises msg selector action =
    let thetest e = if e == selector then return ()
                    else assertFailure $ msg ++ "\nReceived unexpected exception: "
                             ++ (show e) ++ "\ninstead of exception: " ++ (show selector)
        in do
           r <- Control.Exception.try action
           case r of
                  Left e -> thetest e
                  Right _ -> assertFailure $ msg ++ "\nReceived no exception, but was expecting exception: " ++ (show selector)

------------------------------------------------------------------------------
-- http://stackoverflow.com/questions/13350164/how-do-i-test-for-an-error-in-haskell
instance Eq ErrorCall where
    x == y = show x == show y

assertError msg ex f =
    assertRaises msg (ErrorCall ex) $ evaluate f

------------------------------------------------------------------------------

-- Given an expression, check that it evaluated to expected results.
teq :: (Eq a, Show a) => String -> a -> a      -> Test
teq testName actual expected = TestCase $ assertEqual testName expected actual

-- Given an expression, check that it raises the expected error.
ter ::        Show a  => String -> a -> String -> Test
ter testName actual expected = TestCase $ assertError testName expected actual

-- Given an expression, check that it evaluates to expected result.
t :: (Eq a) => (Show a) => String -> a -> a -> [Test]
t testName actual = tt testName [actual]

-- Given a list of expressions, check they all evaluate to the same thing.
tt :: (Eq a) => (Show a) => String -> [a] -> a -> [Test]
tt testName actuals expected = map (\actual -> teq testName actual expected) actuals

-- Given an expression, check that it raises the expected error.
e :: (Eq a) => (Show a) => String -> a -> String -> [Test]
e testName actual = ee testName [actual]

ee :: (Eq a) => (Show a) => String -> [a] -> String -> [Test]
ee testName actuals expected = map (\actual -> ter testName actual expected) actuals

-- End of file.
