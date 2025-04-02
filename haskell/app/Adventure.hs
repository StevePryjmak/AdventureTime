module Main where

import Cordinations
  ( Direction (East, North, South, West),
    Planet (Aurelia, Desolara, Dunestria, Glaciera, Ignisia, Tempestara, Verdantis),
    Place,
    warp
  )
import Information
import Desolara
import Verdantis
import Aurelia
import Glaciera
import Dunestria
import Tempestara
import Ignisia

import Aggregator
import Data.Maybe (isJust, fromJust)
import DoorCommands
import Doors
import InfoCommands
import ItemCommands
import Items
import MoveCommands
import System.IO (stdout, hFlush)
import Utils
import World

printIntroduction :: IO ()
printIntroduction = printLines introductionText

printInstructions :: IO ()
printInstructions = printLines instructionsText

readCommand :: IO String
readCommand = do
    putStr "> "
    hFlush stdout
    getLine

gameLoop :: World -> IO World
gameLoop world = do
    cmd <- readCommand
    let splitCmd = words cmd
    if null splitCmd
       then do
           putStrLn "Type 'instructions' for a list of commands."
           gameLoop world
       else do
           case splitCmd of
               (cmdName : cmdArgs) -> case cmdName of
                   "startgame" -> do
                       printIntroduction
                       scan world
                       putStrLn ""
                       gameLoop (World (Aurelia, "aurelia_spaceport") [] fullItems fullDoors) -- start at Aurelia's spaceport with an empty inventory

                   "instructions" -> do
                       printInstructions
                       putStrLn ""
                       gameLoop world

                   "inventory" -> do
                       putStrLn "You are holding: "
                       setDisplayMode ItemHighlight
                       printItems (inventory world)
                       setDisplayMode Normal
                       putStrLn ""
                       gameLoop world

                   "scan" -> do
                       scan world
                       putStrLn ""
                       gameLoop world

                   "take" -> do
                       newWorld <- tryTakeItemByArgs world cmdArgs
                       putStrLn ""
                       gameLoop newWorld

                   "use" -> do
                       newWorld <- tryUseItemByArgs world cmdArgs
                       putStrLn ""
                       gameLoop newWorld

                   "open" -> do
                       newWorld <- tryOpenDoorByArgs world cmdArgs
                       putStrLn ""
                       gameLoop newWorld

                   "move" -> do
                       newWorld <- tryMoveByArgs world cmdArgs
                       scan newWorld
                       putStrLn ""
                       gameLoop newWorld

                   "warp" -> do
                       newWorld <- tryWarpByArgs world cmdArgs
                       scan newWorld
                       putStrLn ""
                       gameLoop newWorld
                       
                   "quit" -> return world
                   ":q"   -> return world
                   "exit" -> return world
                   _ -> do
                       printLines ["Unknown command.", ""]
                       gameLoop world
               [] -> do
                   putStrLn "Type 'instructions' for a list of commands."
                   gameLoop world

main :: IO ()
main = do
    printIntroduction
    printInstructions
    _ <- gameLoop (World (Aurelia, "aurelia_spaceport") [] fullItems fullDoors)
    return ()
