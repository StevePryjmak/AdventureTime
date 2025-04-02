module Dunestria where

import Cordinations
import Items
import Doors

places :: [(Planet, String)]
places =
    [ (Dunestria, "dunestria_landing_zone"),
      (Dunestria, "dunestria_central_dunefield"),
      (Dunestria, "dunestria_western_dunefield"),
      (Dunestria, "dunestria_eastern_dunefield"),
      (Dunestria, "dunestria_far_east_dunefield")
    ]

items :: [ItemPlacement]
items =
    [ (OldAccessKey, (Dunestria, "dunestria_far_east_dunefield"))
    ]

doors :: [DoorPlacement]
doors = []

extraLocationMessages :: [(Place, [String])]
extraLocationMessages =
    [ ( (Dunestria, "dunestria_landing_zone"),
        [ "This desert planet is covered in sharp rocky formations.",
          "The scorching sun beats down relentlessly.",
          ""
        ]
      ),
      ( (Dunestria, "dunestria_far_east_dunefield"),
        [ "The sand here is so hot it nearly melts your boots.",
          "You’d rather not stay any longer than necessary.",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (Dunestria, "dunestria_landing_zone") North = (Dunestria, "dunestria_central_dunefield")
move (Dunestria, "dunestria_central_dunefield") West  = (Dunestria, "dunestria_western_dunefield")
move (Dunestria, "dunestria_central_dunefield") East  = (Dunestria, "dunestria_eastern_dunefield")
move (Dunestria, "dunestria_central_dunefield") South = (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_central_dunefield") North = (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_eastern_dunefield") West = (Dunestria, "dunestria_central_dunefield")
move (Dunestria, "dunestria_eastern_dunefield") East = (Dunestria, "dunestria_far_east_dunefield")
move (Dunestria, "dunestria_eastern_dunefield") South= (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_eastern_dunefield") North= (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_western_dunefield") West = (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_western_dunefield") East = (Dunestria, "dunestria_central_dunefield")
move (Dunestria, "dunestria_western_dunefield") South= (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_western_dunefield") North= (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_far_east_dunefield") West = (Dunestria, "dunestria_eastern_dunefield")
move (Dunestria, "dunestria_far_east_dunefield") East = (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_far_east_dunefield") South= (Dunestria, "dunestria_landing_zone")
move (Dunestria, "dunestria_far_east_dunefield") North= (Dunestria, "dunestria_landing_zone")
move (planet, location) _ = (planet, location)
