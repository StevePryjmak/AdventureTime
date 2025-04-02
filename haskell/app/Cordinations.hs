module Cordinations where

import Text.Read (readMaybe)

data Planet
    = Aurelia
    | Tempestara
    | Desolara
    | Dunestria
    | Verdantis
    | Glaciera
    | Ignisia
    deriving (Eq)

instance Show Planet where
    show Aurelia    = "Aurelia"
    show Tempestara = "Tempestara"
    show Desolara   = "Desolara"
    show Dunestria  = "Dunestria"
    show Verdantis  = "Verdantis"
    show Glaciera   = "Glaciera"
    show Ignisia    = "Ignisia"

data Direction = North | South | West | East
    deriving (Eq)

instance Show Direction where
    show North = "north"
    show South = "south"
    show West  = "west"
    show East  = "east"

instance Read Direction where
    readsPrec _ "north" = [(North, "")]
    readsPrec _ "n"     = [(North, "")]
    readsPrec _ "south" = [(South, "")]
    readsPrec _ "s"     = [(South, "")]
    readsPrec _ "west"  = [(West,  "")]
    readsPrec _ "w"     = [(West,  "")]
    readsPrec _ "east"  = [(East,  "")]
    readsPrec _ "e"     = [(East,  "")]
    readsPrec _ _       = []

getDirectionFromArgs :: [String] -> Maybe Direction
getDirectionFromArgs (a : _) = readMaybe a
getDirectionFromArgs _       = Nothing

type Place = (Planet, String)

warp :: Place -> Direction -> IO Place
warp (Aurelia,    "aurelia_spaceport") North = return (Dunestria,  "dunestria_landing_zone")
warp (Aurelia,    "aurelia_spaceport") South = return (Glaciera,   "glaciera_settlement")
warp (Aurelia,    "aurelia_spaceport") West  = return (Desolara,   "desolara_landing_zone")
warp (Aurelia,    "aurelia_spaceport") East  = return (Verdantis,  "verdantis_grove")

warp (Dunestria,  "dunestria_landing_zone") West  = return (Tempestara, "tempestara_stormfront")
warp (Dunestria,  "dunestria_landing_zone") South = return (Aurelia,    "aurelia_spaceport")

warp (Desolara,   "desolara_landing_zone") East  = return (Aurelia,    "aurelia_spaceport")
warp (Desolara,   "desolara_landing_zone") North = return (Tempestara, "tempestara_stormfront")

warp (Tempestara, "tempestara_stormfront") South = return (Desolara,   "desolara_landing_zone")
warp (Tempestara, "tempestara_stormfront") East  = return (Dunestria,  "dunestria_landing_zone")

warp (Verdantis,  "verdantis_grove") West  = return (Aurelia,    "aurelia_spaceport")
warp (Verdantis,  "verdantis_grove") South = return (Ignisia,    "ignisia_old_mine")

warp (Ignisia,    "ignisia_old_mine") North = return (Verdantis, "verdantis_grove")
warp (Ignisia,    "ignisia_old_mine") West  = return (Glaciera,  "glaciera_settlement")

warp (Glaciera,   "glaciera_settlement") East = return (Ignisia, "ignisia_old_mine")
warp (Glaciera,   "glaciera_settlement") North= return (Aurelia, "aurelia_spaceport")

-- Fallback if you can't warp
warp place _ = do
    putStrLn "You can't warp there."
    return place
