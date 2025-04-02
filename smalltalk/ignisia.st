Planet subclass: Ignisia [
    init [
        | oldMine northernVolcano westernVolcano easternVolcano controlRoom tmpItemList tmpItem tmpFalcon |

        super init.
        self planetSpaceport: 'old Mine'.
        name := 'Ignisia'.

        "Define locations and their connections"
        oldMine := Dictionary new.
        oldMine at: 'north' put: 'northern Volcano'.
        oldMine at: 'west' put: 'western Volcano'.
        oldMine at: 'east' put: 'eastern Volcano'.

        northernVolcano := Dictionary new.
        northernVolcano at: 'south' put: 'old Mine'.

        westernVolcano := Dictionary new.
        westernVolcano at: 'east' put: 'old Mine'.

        easternVolcano := Dictionary new.
        easternVolcano at: 'west' put: 'old Mine'.
        easternVolcano at: 'south' put: 'mine Control Room'.

        controlRoom := Dictionary new.
        controlRoom at: 'north' put: 'eastern Volcano'.

        "Add all locations to the places dictionary"
        places := Dictionary new.
        places at: 'old Mine' put: oldMine.
        places at: 'northern Volcano' put: northernVolcano.
        places at: 'western Volcano' put: westernVolcano.
        places at: 'eastern Volcano' put: easternVolcano.
        places at: 'mine Control Room' put: controlRoom.


        self addDoorFrom: 'eastern Volcano' to: 'mine Control Room' key: 'old_access_key'.

        "Add items to specific locations"
        items := Dictionary new.

        "Items in old Mine"
        tmpItemList := Dictionary new.
        tmpFalcon := Item new.
        tmpFalcon name: 'Milenium_falcon'.
        tmpFalcon isStatic: true.
        tmpItemList at: 'Milenium_falcon' put: tmpFalcon.
        items at: 'old Mine' put: tmpItemList.

        "Items in mine Control Room"
        tmpItemList := Dictionary new.
        tmpItem := Item new.
        tmpItem name: 'data_fragment_pyro'.
        tmpItemList at: 'data_fragment_pyro' put: tmpItem.
        items at: 'mine Control Room' put: tmpItemList.
    ]

    describe [
        | descriptions |
        descriptions := Dictionary new.
        descriptions at: 'Ignisia' put: 'You are on Ignisia, a volcanic planet. It''s incredibly hot here.'.
        descriptions at: 'old Mine' put: 'You are at the old mine. It''s the only stable ground around.'.
        descriptions at: 'northern Volcano' put: 'You are at the northern volcano.'.
        descriptions at: 'western Volcano' put: 'You are at the western volcano.'.
        descriptions at: 'eastern Volcano' put: 'You are at the eastern volcano.'.
        descriptions at: 'mine Control Room' put: 'You are inside the mine control room. The intense heat makes you sweat.'.
        ^descriptions
    ]
]
