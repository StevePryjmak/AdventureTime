module Glaciera where

import Cordinations
import Items
import Doors

places :: [(Planet, String)]
places =
    [ (Glaciera, "glaciera_settlement"),
      (Glaciera, "glaciera_central_cave"),
      (Glaciera, "glaciera_northern_cave"),
      (Glaciera, "glaciera_western_cave")
    ]

items :: [ItemPlacement]
items =
    [ (IcyCreature, (Glaciera, "glaciera_northern_cave"))
    ]

doors :: [DoorPlacement]
doors = []

extraLocationMessages :: [(Place, [String])]
extraLocationMessages =
    [ ( (Glaciera, "glaciera_settlement"),
        [ "You’ve landed on a frosty settlement in Glaciera.",
          "Icy wind gusts across the snow, and you see cave openings nearby.",
          ""
        ]
      ),
      ( (Glaciera, "glaciera_northern_cave"),
        [ "This part of the cave houses clusters of small icy creatures.",
          "They scurry around, seemingly guarding something.",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (Glaciera, "glaciera_settlement") North = (Glaciera, "glaciera_central_cave")
move (Glaciera, "glaciera_central_cave") South = (Glaciera, "glaciera_settlement")
move (Glaciera, "glaciera_central_cave") North = (Glaciera, "glaciera_northern_cave")
move (Glaciera, "glaciera_central_cave") West  = (Glaciera, "glaciera_western_cave")
move (Glaciera, "glaciera_western_cave") East  = (Glaciera, "glaciera_central_cave")
move (Glaciera, "glaciera_northern_cave") South = (Glaciera, "glaciera_central_cave")
move (planet, location) _ = (planet, location)
