module Verdantis where

import Cordinations
import Items
import Doors

places :: [(Planet, String)]
places =
    [ (Verdantis, "verdantis_grove"),
      (Verdantis, "verdantis_central_hills"),
      (Verdantis, "verdantis_southern_hills"),
      (Verdantis, "verdantis_eastern_hills")
    ]

items :: [ItemPlacement]
items =
    [ (DataFragmentVerdant, (Verdantis, "verdantis_eastern_hills"))
    ]

doors :: [DoorPlacement]
doors = []

extraLocationMessages :: [(Place, [String])]
extraLocationMessages =
    [ ( (Verdantis, "verdantis_grove"),
        [ "You find yourself in a lush forest grove on Verdantis.",
          "The ground is muddy and damp, teeming with strange plants.",
          ""
        ]
      ),
      ( (Verdantis, "verdantis_eastern_hills"),
        [ "Tall grasses wave in the breeze, revealing a faint green glow.",
          "There seems to be something hidden among the vines...",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (Verdantis, "verdantis_grove") South       = (Verdantis, "verdantis_central_hills")
move (Verdantis, "verdantis_central_hills") North = (Verdantis, "verdantis_grove")
move (Verdantis, "verdantis_central_hills") South = (Verdantis, "verdantis_southern_hills")
move (Verdantis, "verdantis_central_hills") East  = (Verdantis, "verdantis_eastern_hills")
move (Verdantis, "verdantis_eastern_hills") West  = (Verdantis, "verdantis_central_hills")
move (Verdantis, "verdantis_southern_hills") North = (Verdantis, "verdantis_central_hills")
move (planet, location) _ = (planet, location)
