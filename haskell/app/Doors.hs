module Doors where

import Cordinations

data Door
    = EncryptedDoor
    | ImperialDatabase
    deriving (Eq)

instance Show Door where
    show EncryptedDoor    = "encrypted door"
    show ImperialDatabase = "imperial database"

type DoorPlacement = (Door, Place, Direction)

getDoorPlacementsAtLocation :: Place -> [DoorPlacement] -> [DoorPlacement]
getDoorPlacementsAtLocation place ((door, doorPlace, doorDirection) : xs)
    | doorPlace == place = (door, doorPlace, doorDirection) : getDoorPlacementsAtLocation place xs
    | otherwise          = getDoorPlacementsAtLocation place xs
getDoorPlacementsAtLocation _ [] = []

findDoorPlacements :: Door -> Place -> [DoorPlacement] -> [DoorPlacement]
findDoorPlacements door place ((d, p, dir) : xs)
    | p == place && d == door = (d, p, dir) : findDoorPlacements door place xs
    | otherwise               = findDoorPlacements door place xs
findDoorPlacements _ _ [] = []

-- Checks if any door at `place` blocks traveling `direction`
doorBlocks :: Place -> [DoorPlacement] -> Direction -> Maybe Door
doorBlocks place ((door, doorPlace, doorDir) : xs) direction
    | doorPlace == place && doorDir == direction = Just door
    | otherwise = doorBlocks place xs direction
doorBlocks _ [] _ = Nothing
