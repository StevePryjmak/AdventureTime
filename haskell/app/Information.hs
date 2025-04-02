module Information where

introductionText :: [String]
introductionText =
  [ "A long time ago, in a galaxy oppressed by the Empire...",
    "Your only hope is to assemble the legendary Millennium Falcon",
    "and gather scattered data fragments to decode the Empire's greatest secret.",
    "Starting on planet Aurelia, you must fix your broken ship, warp across",
    "dangerous worlds, and unlock the Imperial Database that holds the key",
    "to toppling the Empire once and for all.",
    ""
  ]

instructionsText :: [String]
instructionsText =
  [ "Available commands are:",
    "startgame                  -> Start the game from Aurelia.",
    "move (direction)           -> Move to another location on the current planet.",
    "warp (direction)           -> Warp to another planet (requires Millennium Falcon at your location).",
    "scan                       -> Scan your current location (see items, doors, directions).",
    "inventory                  -> Check the items you are holding.",
    "take (item)                -> Pick up an item at your location.",
    "use (item) on (item)       -> Use an item in your possession on another item.",
    "open (door) with (key)     -> Open a door with an item (like an old access key).",
    "instructions               -> Show these instructions again.",
    "quit / :q / exit           -> End the game.",
    ""
  ]
