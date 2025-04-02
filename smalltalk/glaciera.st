Planet subclass: Glaciera [
    init [
        | settlement northernCave centralCave westernCave tmpItemList tmpItem tmpFalcon|

        super init.
        self planetSpaceport: 'settlement'.
        name := 'Glaciera'.

        "Define locations and their connections"
        settlement := Dictionary new.
        settlement at: 'north' put: 'central Cave'.

        northernCave := Dictionary new.
        northernCave at: 'south' put: 'central Cave'.

        centralCave := Dictionary new.
        centralCave at: 'north' put: 'northern Cave'.
        centralCave at: 'west' put: 'western Cave'.

        westernCave := Dictionary new.
        westernCave at: 'east' put: 'central Cave'.

        "Add all locations to the places dictionary"
        places := Dictionary new.
        places at: 'settlement' put: settlement.
        places at: 'northern Cave' put: northernCave.
        places at: 'central Cave' put: centralCave.
        places at: 'western Cave' put: westernCave.

        "Add items to specific locations"
        items := Dictionary new.

        tmpItemList := Dictionary new.
        tmpItem := Item new.
        tmpItem name: 'icy_creature'.
        tmpItem isStatic: true.
        tmpItemList at: 'icy_creature' put: tmpItem.
        items at: 'northern Cave' put: tmpItemList.

        tmpItemList :=Dictionary new.
        tmpFalcon := Item new.
        tmpFalcon name: 'Milenium_falcon'.
        tmpFalcon isStatic: true.
        tmpItemList at: 'Milenium_falcon' put: tmpFalcon.
        items at: self planetSpaceport put: tmpItemList.        

    ]

    describe [
        | descriptions |
        descriptions := Dictionary new.
        descriptions at: 'Glaciera' put: 'You are on Glaciera, a frozen, icy planet. There are small icy creatures all around.'.
        descriptions at: 'settlement' put: 'You are in the settlement, filled with icy creatures.'.
        descriptions at: 'northern Cave' put: 'You are in the northern part of the cave.'.
        descriptions at: 'central Cave' put: 'You are in the central section of the cave.'.
        descriptions at: 'western Cave' put: 'You are in the western part of the cave.'.
        ^descriptions
    ]
]
