module InfoCommands where

import Aggregator       (fullExtraLocationMessages, fullMove)
import Cordinations     (Place, Direction (..))
import Doors            (getDoorPlacementsAtLocation, DoorPlacement)
import Items
import Utils
import World

--------------------------------------------------------------------------------
-- Printing items in a list

printItems :: [Item] -> IO [Item]
printItems (x : xs) = do
    putStr (getWordPrefix (show x) ++ " ")
    setDisplayMode ItemHighlight
    putStr (show x)
    setDisplayMode Normal
    if null xs
        then putStr ""
        else
            if length xs == 1
                then putStr " and "
                else putStr ", "
    printItems xs
printItems _ = return []

--------------------------------------------------------------------------------
-- Printing items at current location

printItemsAtLocation :: Place -> [ItemPlacement] -> IO [ItemPlacement]
printItemsAtLocation place itemLocations = do
    let things = getItemsAtLocation place itemLocations
    if null things
        then do
            putStrLn "There are no items here."
            return itemLocations
        else do
            putStr "You see "
            printItems things
            putStrLn "."
            return itemLocations

--------------------------------------------------------------------------------
-- Printing doors at current location

printDoors :: [DoorPlacement] -> IO [DoorPlacement]
printDoors ((door, doorPlace, doorDirection) : xs) = do
    putStr "There is a "
    setDisplayMode DoorHighlight
    putStr (show door)
    setDisplayMode Normal
    putStr " blocking the path "
    setDisplayMode DirectionHighlight
    putStr (show doorDirection)
    setDisplayMode Normal
    putStrLn "."
    printDoors xs
printDoors _ = return []

printDoorsAtLocation :: Place -> [DoorPlacement] -> IO [DoorPlacement]
printDoorsAtLocation place doorLocations = do
    let doorsHere = getDoorPlacementsAtLocation place doorLocations
    if null doorsHere
        then return doorLocations
        else do
            printDoors doorsHere
            return doorLocations

--------------------------------------------------------------------------------
-- Printing walkable directions (move)

filterAvailableDirectionsAtLocation :: Place -> [Direction] -> [Direction]
filterAvailableDirectionsAtLocation place (d : ds) =
    let newPlace = fullMove place d
     in if newPlace == place
           then filterAvailableDirectionsAtLocation place ds
           else d : filterAvailableDirectionsAtLocation place ds
filterAvailableDirectionsAtLocation _ [] = []

getAvailableDirectionsAtLocation :: Place -> [Direction]
getAvailableDirectionsAtLocation place =
    filterAvailableDirectionsAtLocation place [North, East, South, West]

printDirections :: [Direction] -> IO [Direction]
printDirections (d : ds) = do
    setDisplayMode DirectionHighlight
    putStr (show d)
    setDisplayMode Normal
    if null ds
        then putStrLn ""
        else
            if length ds == 1
                then putStr ", and "
                else putStr ", "
    printDirections ds
printDirections _ = return []

printAvailableDirectionsAtLocation :: Place -> IO ()
printAvailableDirectionsAtLocation place = do
    let directions = getAvailableDirectionsAtLocation place
    if null directions
        then putStrLn "You can't walk anywhere from here."
        else do
            if length directions == 1
                then putStr "There is a path going "
                else putStr "There are paths going "
            _ <- printDirections directions
            return ()

--------------------------------------------------------------------------------
-- The 'scan' command

scan :: World -> IO ()
scan (World (planet, location) _ itemLocations doorLocations) = do
    putStr "You are currently on "
    setDisplayMode IslandHighlight
    putStr (show planet)
    setDisplayMode LocationHighlight
    putStrLn (" - " ++ location)
    setDisplayMode Normal

    -- Print items here
    _ <- printItemsAtLocation (planet, location) itemLocations

    -- Print directions
    printAvailableDirectionsAtLocation (planet, location)

    -- Print doors
    _ <- printDoorsAtLocation (planet, location) doorLocations
    return ()
