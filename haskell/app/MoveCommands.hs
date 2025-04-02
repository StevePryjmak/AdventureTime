module MoveCommands where

import Aggregator
import Cordinations
import Data.Maybe
import Doors
import Items
import Utils
import World

--------------------------------------------------------------------------------
-- Moving on the current planet

getExtraLocationMessage :: [(Place, [String])] -> Place -> Maybe [String]
getExtraLocationMessage messages place = lookup place messages

tryMoveByArgs :: World -> [String] -> IO World
tryMoveByArgs (World curPlace inv itemLoc doorLoc) args =
    case getDirectionFromArgs args of
        Nothing -> do
            putStrLn "Not a valid direction."
            return (World curPlace inv itemLoc doorLoc)
        Just direction -> do
            -- Check if a door is blocking movement
            let maybeDoor = doorBlocks curPlace doorLoc direction
            case maybeDoor of
                Just door -> do
                    putStr "The "
                    setDisplayMode DoorHighlight
                    putStr (show door)
                    setDisplayMode Normal
                    putStrLn " blocks your way."
                    return (World curPlace inv itemLoc doorLoc)
                Nothing -> do
                    -- Actually move
                    let newPlace = fullMove curPlace direction
                    -- Show any extra flavor text
                    let msg = getExtraLocationMessage fullExtraLocationMessages newPlace
                    case msg of
                        Just linesOfText -> printLines linesOfText
                        Nothing          -> return ()
                    return (World newPlace inv itemLoc doorLoc)

--------------------------------------------------------------------------------
-- Warping between planets

tryWarpByArgs :: World -> [String] -> IO World
tryWarpByArgs (World curPlace inv itemLoc doorLoc) args =
    if checkIfAtItemLocation curPlace itemLoc MillenniumFalcon
        then
            case getDirectionFromArgs args of
                Nothing -> do
                    putStrLn "Not a valid direction."
                    return (World curPlace inv itemLoc doorLoc)
                Just dir -> do
                    newPlace <- warp curPlace dir
                    putStr "You warp to "
                    setDisplayMode IslandHighlight
                    putStr (show (fst newPlace))
                    setDisplayMode Normal
                    putStrLn "."

                    -- Move the Falcon with you
                    let newItemLoc =
                            removeItem itemLoc (MillenniumFalcon, curPlace)
                            ++ [(MillenniumFalcon, newPlace)]

                    -- Print any flavor text
                    let msg = getExtraLocationMessage fullExtraLocationMessages newPlace
                    case msg of
                        Just linesOfText -> printLines linesOfText
                        Nothing          -> return ()

                    return (World newPlace inv newItemLoc doorLoc)
        else do
            putStrLn "You can't warp without the Millennium Falcon at your location."
            return (World curPlace inv itemLoc doorLoc)
