module World where

import Items      (Item, ItemPlacement)
import Doors      (DoorPlacement)
import Cordinations (Place)

--------------------------------------------------------------------------------
-- The game state

data World = World
    { place         :: Place            -- Current (Planet, Location)
    , inventory     :: [Item]           -- Items the player holds
    , itemLocations :: [ItemPlacement]  -- Items placed in the world
    , doorLocations :: [DoorPlacement]  -- Doors placed in the world
    }
    deriving (Eq, Show)
