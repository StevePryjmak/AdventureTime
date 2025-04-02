module Utils where

import System.Console.ANSI
import Cordinations (Place)

--------------------------------------------------------------------------------
-- Removing an element from a list

removeItem :: Eq a => [a] -> a -> [a]
removeItem (x : xs) item
    | x == item = xs
    | otherwise = x : removeItem xs item
removeItem [] _ = []

--------------------------------------------------------------------------------
-- Printing multiple lines

printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

--------------------------------------------------------------------------------
-- “a” vs. “an” logic

anStarts :: String
anStarts = "aeiouAEIOU"

getWordPrefix :: String -> String
getWordPrefix (c : _) = if c `elem` anStarts then "an" else "a"
getWordPrefix _       = "a"

--------------------------------------------------------------------------------
-- Display modes for colored text (items, doors, directions, etc.)

data DisplayMode
    = Normal
    | ItemHighlight
    | IslandHighlight
    | LocationHighlight
    | DoorHighlight
    | DirectionHighlight

setDisplayMode :: DisplayMode -> IO ()
setDisplayMode Normal = setSGR [Reset]

setDisplayMode ItemHighlight =
    setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Blue]

setDisplayMode IslandHighlight =
    setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Green]

setDisplayMode LocationHighlight =
    setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Cyan]

setDisplayMode DoorHighlight =
    setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Red]

setDisplayMode DirectionHighlight =
    setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Yellow]
