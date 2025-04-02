module Items where

import Cordinations
import Utils

data Item
    = OldAccessKey
    | HyperdriveEngine
    | NavigationSystem
    | CommunicationArray
    | Shields
    | DataFragmentPyro
    | DataFragmentVerdant
    | DataFragmentTempest
    | BrokenFalcon Int
    | MillenniumFalcon
    | AccessCodeDecoder Int
    | DecodedAccessCode
    | IcyCreature
    deriving (Eq)

instance Show Item where
    show OldAccessKey         = "old access key"
    show HyperdriveEngine     = "hyperdrive engine"
    show NavigationSystem     = "navigation system"
    show CommunicationArray   = "communication array"
    show Shields              = "shields"
    show DataFragmentPyro     = "data fragment (pyro)"
    show DataFragmentVerdant  = "data fragment (verdant)"
    show DataFragmentTempest  = "data fragment (tempest)"
    show (BrokenFalcon n)     = "broken Millennium Falcon (" ++ show n ++ "/4 parts)"
    show MillenniumFalcon     = "Millennium Falcon"
    show (AccessCodeDecoder n)= "access code decoder (" ++ show n ++ "/3 data)"
    show DecodedAccessCode    = "decoded access code"
    show IcyCreature          = "icy creature"


use :: Item -> Item -> (Item, Bool)

-------------------------------------------------------------------------------
-- Combining data fragments with an access code decoder

use DataFragmentPyro (AccessCodeDecoder n) =
    if n == 2
        then (DecodedAccessCode, True)
        else (AccessCodeDecoder (n + 1), True)

use DataFragmentVerdant (AccessCodeDecoder n) =
    if n == 2
        then (DecodedAccessCode, True)
        else (AccessCodeDecoder (n + 1), True)

use DataFragmentTempest (AccessCodeDecoder n) =
    if n == 2
        then (DecodedAccessCode, True)
        else (AccessCodeDecoder (n + 1), True)

-------------------------------------------------------------------------------
-- Repairing the Falcon

use Shields (BrokenFalcon parts) =
    if parts == 3
        then (MillenniumFalcon, True)
        else (BrokenFalcon (parts + 1), True)

use NavigationSystem (BrokenFalcon parts) =
    if parts == 3
        then (MillenniumFalcon, True)
        else (BrokenFalcon (parts + 1), True)

use CommunicationArray (BrokenFalcon parts) =
    if parts == 3
        then (MillenniumFalcon, True)
        else (BrokenFalcon (parts + 1), True)

use HyperdriveEngine (BrokenFalcon parts) =
    if parts == 3
        then (MillenniumFalcon, True)
        else (BrokenFalcon (parts + 1), True)

-------------------------------------------------------------------------------
-- Default: no valid combination

use item1 _ = (item1, False)

--------------------------------------------------------------------------------
-- On-pickup messages

onPickupMessages :: [(Item, [String])]
onPickupMessages =
    [ ( AccessCodeDecoder 0,
        [ "This portable decoder can process data fragments from different planets.",
          "You'll need multiple fragments to compile a final access code.",
          ""
        ]
      ),
      ( OldAccessKey,
        [ "A battered key rumored to open just one locked door.",
          "Hopefully it's the right one.",
          ""
        ]
      ),
      ( IcyCreature,
        [ "You carefully scoop up this tiny, shivering being.",
          "It looks around curiously before settling into your pack.",
          ""
        ]
      ),
      ( DataFragmentPyro,
        [ "A fragment blazing with red-hot energy.",
          "Better keep it in a heatproof container.",
          ""
        ]
      ),
      ( DataFragmentVerdant,
        [ "A fragment radiating green life force.",
          "Vines seem to grow around your fingertips as you touch it.",
          ""
        ]
      ),
      ( DataFragmentTempest,
        [ "A fragment crackling with electricity.",
          "Tiny sparks dance across its surface.",
          ""
        ]
      )
    ]

printPickupMessage :: Item -> [(Item, [String])] -> IO ()
printPickupMessage _ [] = return ()
printPickupMessage item ((i, linesOfText) : xs) =
    if item == i
        then do
            printLines linesOfText
            printPickupMessage item xs
        else printPickupMessage item xs

--------------------------------------------------------------------------------
-- ItemPlacement: which item is at which place

type ItemPlacement = (Item, Place)

checkIfAtItemLocation :: Place -> [ItemPlacement] -> Item -> Bool
checkIfAtItemLocation (planet, loc) ((i, (p, l)) : xs) item =
    (p == planet && l == loc && i == item) || checkIfAtItemLocation (planet, loc) xs item
checkIfAtItemLocation _ [] _ = False

checkIfItemInInventory :: [Item] -> Item -> Bool
checkIfItemInInventory inv item = item `elem` inv

getItemPlacementsAtLocation :: Place -> [ItemPlacement] -> [ItemPlacement]
getItemPlacementsAtLocation place (x : xs) =
    if snd x == place
        then x : getItemPlacementsAtLocation place xs
        else getItemPlacementsAtLocation place xs
getItemPlacementsAtLocation _ [] = []

getItemsAtLocation :: Place -> [ItemPlacement] -> [Item]
getItemsAtLocation place locs =
    map fst (getItemPlacementsAtLocation place locs)
