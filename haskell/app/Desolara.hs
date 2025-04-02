module Desolara where

import Cordinations
import Items

places = [(Desolara, "desolara_landing_zone")]

items = [(OldAccessKey, (Desolara, "desolara_landing_zone"))]

doors = []

extraLocationMessages =
    [ ( (Desolara, "desolara_landing_zone"),
        [ "This planet is a barren, desolate place.",
          "There is an old Rebel droid holding a key.",
          ""
        ]
      )
    ]

move :: Place -> Direction -> Place
move (planet, location) _ = (planet, location)
