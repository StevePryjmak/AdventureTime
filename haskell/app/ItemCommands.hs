module ItemCommands where

import Cordinations
import Items
import Utils
import World
import Data.Maybe (listToMaybe, fromMaybe)

--------------------------------------------------------------------------------
-- Taking an item

takeItem :: World -> Item -> IO World
takeItem (World place inventory itemLocations doorLocations) item =
    if checkIfAtItemLocation place itemLocations item
        then do
            printPickupMessage item onPickupMessages
            putStr "You picked up the "
            setDisplayMode ItemHighlight
            putStr (show item)
            setDisplayMode Normal
            putStrLn "."

            let newInventory = inventory ++ [item]
            let newItemLocations = removeItem itemLocations (item, place)
            return (World place newInventory newItemLocations doorLocations)
        else do
            putStrLn "You can't see that item here."
            return (World place inventory itemLocations doorLocations)

--------------------------------------------------------------------------------
-- Parsing arguments to take an item

tryTakeItemByArgs :: World -> [String] -> IO World
tryTakeItemByArgs world args =
    case args of
        ["old", "access", "key"]   -> takeItem world OldAccessKey
        ["hyperdrive", "engine"]   -> takeItem world HyperdriveEngine
        ["navigation", "system"]   -> takeItem world NavigationSystem
        ["communication", "array"] -> takeItem world CommunicationArray
        ["shields"]                -> takeItem world Shields
        ["data", "fragment", "(pyro)"]     -> takeItem world DataFragmentPyro
        ["data", "fragment", "(verdant)"]  -> takeItem world DataFragmentVerdant
        ["data", "fragment", "(tempest)"]  -> takeItem world DataFragmentTempest
        ["broken", "millennium", "falcon"] -> do
            putStrLn "It's too large and broken to simply pick up."
            return world
        ["millennium", "falcon"] -> do
            putStrLn "You can't just pick up the entire Millennium Falcon!"
            return world
        ["access", "code", "decoder"] -> takeItem world (AccessCodeDecoder 0)
        ["icy", "creature"]           -> takeItem world IcyCreature
        ["decoded", "access", "code"] -> do
            putStrLn "You can't find that item lying around. It's formed by combining data fragments!"
            return world
        _ -> do
            putStrLn "That's not a recognized item to take."
            return world

--------------------------------------------------------------------------------
-- Using an item on another item

printItemUsedMessage :: Item -> Item -> IO ()
printItemUsedMessage i1 i2 = do
    putStr "You used the "
    setDisplayMode ItemHighlight
    putStr (show i1)
    setDisplayMode Normal
    putStr " on the "
    setDisplayMode ItemHighlight
    putStr (show i2)
    setDisplayMode Normal
    putStrLn "."

printItemUseFailMessage :: Item -> Item -> IO ()
printItemUseFailMessage i1 i2 = do
    putStr "You cannot use the "
    setDisplayMode ItemHighlight
    putStr (show i1)
    setDisplayMode Normal
    putStr " on the "
    setDisplayMode ItemHighlight
    putStr (show i2)
    setDisplayMode Normal
    putStrLn "."

useItem :: World -> Item -> Item -> IO World
useItem (World place inventory itemLocations doorLocations) itemA itemB = do
    let oldWorld = World place inventory itemLocations doorLocations
    -- Check if itemA is in inventory
    if not (checkIfItemInInventory inventory itemA)
        then do
            putStrLn "You don't have that item to use."
            return oldWorld
        else do
            -- Check if itemB is either in inventory or on the ground here
            let itemBHere = checkIfAtItemLocation place itemLocations itemB
            let itemBInInv = checkIfItemInInventory inventory itemB

            if (not itemBHere) && (not itemBInInv)
                then do
                    putStrLn "You don't see the target item anywhere."
                    return oldWorld
                else do
                    let (newItem, success) = use itemA itemB
                    if success
                        then do
                            printItemUsedMessage itemA itemB
                            if itemBHere
                                then do
                                    let newItemsAtLoc =
                                            removeItem itemLocations (itemB, place)
                                            ++ [(newItem, place)]
                                    let newInv = removeItem inventory itemA
                                    return (World place newInv newItemsAtLoc doorLocations)
                                else do
                                    -- itemB is in inventory
                                    let newInv =
                                            removeItem (removeItem inventory itemA) itemB
                                            ++ [newItem]
                                    return (World place newInv itemLocations doorLocations)
                        else do
                            printItemUseFailMessage itemA itemB
                            return oldWorld

--------------------------------------------------------------------------------
-- Parsing arguments to use an item on another item

tryUseItemByArgs :: World -> [String] -> IO World
tryUseItemByArgs world args =
    case args of
        -- Using ship parts on a broken falcon
        ["hyperdrive", "engine", "on", "broken", "millennium", "falcon"] ->
            findBrokenFalcon world HyperdriveEngine
        ["navigation", "system", "on", "broken", "millennium", "falcon"] ->
            findBrokenFalcon world NavigationSystem
        ["communication", "array", "on", "broken", "millennium", "falcon"] ->
            findBrokenFalcon world CommunicationArray
        ["shields", "on", "broken", "millennium", "falcon"] ->
            findBrokenFalcon world Shields

        -- Using data fragments on access code decoder
        ["data", "fragment", "(pyro)", "on", "access", "code", "decoder"] ->
            findDecoder world DataFragmentPyro
        ["data", "fragment", "(verdant)", "on", "access", "code", "decoder"] ->
            findDecoder world DataFragmentVerdant
        ["data", "fragment", "(tempest)", "on", "access", "code", "decoder"] ->
            findDecoder world DataFragmentTempest

        _ -> do
            putStrLn "That use command doesn't seem valid."
            return world

--------------------------------------------------------------------------------
-- Helpers for use commands

findDecoder :: World -> Item -> IO World
findDecoder w itemToUse =
    case findAccessCodeDecoder w of
        Just decoder -> useItem w itemToUse decoder
        Nothing -> do
            putStrLn "No access code decoder is found in your possession."
            return w

findAccessCodeDecoder :: World -> Maybe Item
findAccessCodeDecoder (World _ inv _ _) =
    let maybeDecoder = filter (\x -> case x of
                                        AccessCodeDecoder _ -> True
                                        _ -> False) inv
     in listToMaybe maybeDecoder

findBrokenFalcon :: World -> Item -> IO World
findBrokenFalcon w part =
    case locateBrokenFalcon w of
        Just bf -> useItem w part bf
        Nothing -> do
            putStrLn "No broken Millennium Falcon is accessible here."
            return w

locateBrokenFalcon :: World -> Maybe Item
locateBrokenFalcon (World place inv allItems doorLocs) =
    let invMatches  = filter (\x -> case x of
                                        BrokenFalcon _ -> True
                                        _              -> False) inv
        locMatches  = filter (\(i, p) -> case i of
                                            BrokenFalcon _ -> True
                                            _ -> False) allItems
    in if not (null invMatches)
            then listToMaybe invMatches
            else fmap fst (listToMaybe locMatches)
