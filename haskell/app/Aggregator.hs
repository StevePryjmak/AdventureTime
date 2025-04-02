module Aggregator where

import Cordinations
import Desolara
import Doors
import Verdantis
import Items
import Aurelia
import Glaciera
import Dunestria
import Tempestara
import Ignisia

fullExtraLocationMessages :: [(Place, [String])]
fullExtraLocationMessages =
    Aurelia.extraLocationMessages
    ++ Desolara.extraLocationMessages
    ++ Verdantis.extraLocationMessages
    ++ Glaciera.extraLocationMessages
    ++ Dunestria.extraLocationMessages
    ++ Tempestara.extraLocationMessages
    ++ Ignisia.extraLocationMessages

fullMove :: Place -> Direction -> Place
fullMove (Aurelia,   p) d   = Aurelia.move   (Aurelia,   p) d
fullMove (Desolara,  p) d   = Desolara.move  (Desolara,  p) d
fullMove (Verdantis, p) d   = Verdantis.move (Verdantis, p) d
fullMove (Glaciera,  p) d   = Glaciera.move  (Glaciera,  p) d
fullMove (Dunestria, p) d   = Dunestria.move (Dunestria, p) d
fullMove (Tempestara,p) d   = Tempestara.move(Tempestara,p) d
fullMove (Ignisia,   p) d   = Ignisia.move   (Ignisia,   p) d

fullItems :: [ItemPlacement]
fullItems =
    Aurelia.items
    ++ Desolara.items
    ++ Verdantis.items
    ++ Glaciera.items
    ++ Dunestria.items
    ++ Tempestara.items
    ++ Ignisia.items

fullDoors :: [DoorPlacement]
fullDoors =
    Aurelia.doors
    ++ Desolara.doors
    ++ Verdantis.doors
    ++ Glaciera.doors
    ++ Dunestria.doors
    ++ Tempestara.doors
    ++ Ignisia.doors
