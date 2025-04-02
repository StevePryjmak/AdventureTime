module Ignisia where

import Cordinations
import Items
import Doors

places :: [(Planet, String)]
places =
    [ (Ignisia, "ignisia_old_mine"),
      (Ignisia, "ignisia_northern_volcano"),
      (Ignisia, "ignisia_western_volcano"),
      (Ignisia, "ignisia_eastern_volcano"),
      (Ignisia, "ignisia_mine_control_room")
    ]

items :: [ItemPlacement]
items =
    [ (DataFragmentPyro, (Ignisia, "ignisia_mine_control_room"))
    ]

doors :: [DoorPlacement]
doors =
    [ (EncryptedDoor, (Ignisia, "ignisia_eastern_volcano"), South)
    ]

extraLocationMessages :: [(Place, [String])]
extraLocationMessages =
    [ ( (Ignisia, "ignisia_old_mine"),
        [ "The ground radiates intense heat. This old mine is the only stable spot.",
          ""
        ]
      ),
      ( (Ignisia, "ignisia_eastern_volcano"),
        [ "A path along the volcano’s edge leads to a hidden control room inside.",
          ""
        ]
      ),
      ( (Ignisia, "ignisia_mine_control_room"),
        [ "The heat is overwhelming, and a glowing data fragment rests in the center.",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (Ignisia, "ignisia_old_mine") North = (Ignisia, "ignisia_northern_volcano")
move (Ignisia, "ignisia_old_mine") West  = (Ignisia, "ignisia_western_volcano")
move (Ignisia, "ignisia_old_mine") East  = (Ignisia, "ignisia_eastern_volcano")
move (Ignisia, "ignisia_northern_volcano") South = (Ignisia, "ignisia_old_mine")
move (Ignisia, "ignisia_western_volcano") East   = (Ignisia, "ignisia_old_mine")
move (Ignisia, "ignisia_eastern_volcano") West   = (Ignisia, "ignisia_old_mine")
move (Ignisia, "ignisia_eastern_volcano") South  = (Ignisia, "ignisia_mine_control_room")
move (Ignisia, "ignisia_mine_control_room") North = (Ignisia, "ignisia_eastern_volcano")
move (planet, location) _ = (planet, location)
