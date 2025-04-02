module Tempestara where

import Cordinations
import Items
import Doors

places :: [(Planet, String)]
places =
    [ (Tempestara, "tempestara_stormfront"),
      (Tempestara, "tempestara_central_field"),
      (Tempestara, "tempestara_south_field"),
      (Tempestara, "tempestara_north_bridge"),
      (Tempestara, "tempestara_fortress")
    ]

items :: [ItemPlacement]
items =
    [ (DataFragmentTempest, (Tempestara, "tempestara_fortress"))
    ]

doors :: [DoorPlacement]
doors =
    [ (EncryptedDoor, (Tempestara, "tempestara_north_bridge"), North)
    ]

extraLocationMessages :: [(Place, [String])]
extraLocationMessages =
    [ ( (Tempestara, "tempestara_stormfront"),
        [ "You land in the midst of swirling clouds on Tempestara.",
          "Thunder echoes across the horizon.",
          ""
        ]
      ),
      ( (Tempestara, "tempestara_north_bridge"),
        [ "A heavy storm crackles overhead.",
          "You can see a looming fortress to the north.",
          ""
        ]
      ),
      ( (Tempestara, "tempestara_fortress"),
        [ "Lightning flashes repeatedly, striking something in the courtyard.",
          "A small object seems to be at the center of all this thunderous energy.",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (Tempestara, "tempestara_stormfront") West = (Tempestara, "tempestara_central_field")
move (Tempestara, "tempestara_central_field") West  = (Tempestara, "tempestara_stormfront")
move (Tempestara, "tempestara_central_field") North = (Tempestara, "tempestara_north_bridge")
move (Tempestara, "tempestara_central_field") South = (Tempestara, "tempestara_south_field")
move (Tempestara, "tempestara_central_field") East  = (Tempestara, "tempestara_stormfront")
move (Tempestara, "tempestara_north_bridge") South  = (Tempestara, "tempestara_central_field")
move (Tempestara, "tempestara_north_bridge") North  = (Tempestara, "tempestara_fortress")
move (Tempestara, "tempestara_south_field") North   = (Tempestara, "tempestara_central_field")
move (Tempestara, "tempestara_fortress") South      = (Tempestara, "tempestara_north_bridge")
move (planet, location) _ = (planet, location)
