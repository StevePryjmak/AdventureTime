module DoorCommands where

import Cordinations
import Doors
import Items
import System.IO (hFlush, stdout)
import Utils
import World
import Data.Maybe (isNothing, fromJust, listToMaybe)
import Text.Read (readMaybe)

-- Helper to print a list of doors blocking directions
printDoorOptions :: Integer -> [DoorPlacement] -> IO ()
printDoorOptions _ [] = return ()
printDoorOptions i ((door, _, direction) : xs) = do
    putStr (show i ++ ": ")
    setDisplayMode DoorHighlight
    putStr (show door)
    setDisplayMode Normal
    putStr " blocking "
    setDisplayMode DirectionHighlight
    print direction
    setDisplayMode Normal
    printDoorOptions (i + 1) xs

-- If multiple door placements exist at the same location, ask which one to open
decideDoorToOpen :: [DoorPlacement] -> IO DoorPlacement
decideDoorToOpen doorPlacements =
    case doorPlacements of
        [] -> error "decideDoorToOpen called with an empty list"
        [singleDoor] -> return singleDoor
        multipleDoors -> do
            putStrLn "Which door do you want to open?"
            printDoorOptions 1 multipleDoors
            putStr "> "
            hFlush stdout
            input <- getLine
            let i = readMaybe input :: Maybe Int
            case i of
                Just n | n > 0 && n <= length multipleDoors ->
                    return (multipleDoors !! (n - 1))
                _ -> do
                    putStrLn "Invalid input."
                    decideDoorToOpen multipleDoors

-- Try to find all instances of a given door type at the current location
findDoor :: Door -> Place -> [DoorPlacement] -> IO (Maybe DoorPlacement)
findDoor door place doorLocations = do
    let doorPlacements = findDoorPlacements door place doorLocations
    if null doorPlacements
        then return Nothing
        else do
            doorPlacement <- decideDoorToOpen doorPlacements
            return (Just doorPlacement)

-- Attempt to open a door with a particular key item
openDoorWithKey :: World -> Door -> Item -> IO World
openDoorWithKey (World place inv itemLoc doorLoc) door key = do
    if checkIfItemInInventory inv key
        then do
            mDoorPlacement <- findDoor door place doorLoc
            case mDoorPlacement of
                Just doorPlacementToDelete -> do
                    let newDoorLocations = removeItem doorLoc doorPlacementToDelete
                    let newInventory    = removeItem inv key

                    putStr "You open the "
                    setDisplayMode DoorHighlight
                    putStr (show door)
                    setDisplayMode Normal
                    putStrLn "."

                    return (World place newInventory itemLoc newDoorLocations)
                Nothing -> do
                    putStrLn "There is no door to open here."
                    return (World place inv itemLoc doorLoc)
        else do
            putStrLn "You don't have the required key/code to open this door."
            return (World place inv itemLoc doorLoc)


tryOpenDoorByArgs :: World -> [String] -> IO World
tryOpenDoorByArgs world args =
    case args of
        ["encrypted", "door", "with", "old", "access", "key"] ->
            openDoorWithKey world EncryptedDoor OldAccessKey

        ["imperial", "database", "with", "decoded", "access", "code"] ->
            openDoorWithKey world ImperialDatabase DecodedAccessCode

        _ -> do
            putStrLn "Not a valid open command."
            return world
