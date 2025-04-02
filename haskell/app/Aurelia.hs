module Aurelia where

import Cordinations
import Items
import Doors

places =
    [ (Aurelia, "aurelia_spaceport"),
      (Aurelia, "aurelia_base"),
      (Aurelia, "aurelia_center_outpost"),
      (Aurelia, "aurelia_east_outpost"),
      (Aurelia, "aurelia_west_outpost")
    ]

items =
    [ (BrokenFalcon 0,     (Aurelia, "aurelia_spaceport")),
      (NavigationSystem,   (Aurelia, "aurelia_spaceport")),
      (HyperdriveEngine,   (Aurelia, "aurelia_east_outpost")),
      (Shields,            (Aurelia, "aurelia_west_outpost")),
      (CommunicationArray, (Aurelia, "aurelia_center_outpost")),
      (AccessCodeDecoder 0,(Aurelia, "aurelia_center_outpost"))
    ]

doors =
    [
      (ImperialDatabase, (Aurelia, "aurelia_center_outpost"), North)
    ]

extraLocationMessages =
    [ ((Aurelia, "aurelia_center_outpost"),
        [ "You see a vast Rebel outpost with security modules.",
          "There is a sealed database door up north.",
          ""
        ]
      ),
      ((Aurelia, "aurelia_base"),
        [ "You made it to the main Rebel base.",
          "Inside, you find crucial Imperial data. You may have just won the game!",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (Aurelia, "aurelia_spaceport") North = (Aurelia, "aurelia_center_outpost")
move (Aurelia, "aurelia_center_outpost") North = (Aurelia, "aurelia_base")
move (Aurelia, "aurelia_center_outpost") South = (Aurelia, "aurelia_spaceport")
move (Aurelia, "aurelia_center_outpost") West  = (Aurelia, "aurelia_west_outpost")
move (Aurelia, "aurelia_center_outpost") East  = (Aurelia, "aurelia_east_outpost")
move (Aurelia, "aurelia_east_outpost") West = (Aurelia, "aurelia_center_outpost")
move (Aurelia, "aurelia_west_outpost") East = (Aurelia, "aurelia_center_outpost")
move (planet, location) _ = (planet, location)
