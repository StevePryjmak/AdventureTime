Planet subclass: Dunestria [
    init [
        | landingZone westernDuneField centralDuneField easternDuneField farEasternDuneField tmpItemList tmpItem tmpFalcon|

        super init.
        self planetSpaceport: 'landing Zone'.
        name := 'Dunestria'.

        "Define locations and their connections"
        landingZone := Dictionary new.
        landingZone at: 'north' put: 'central Dunefield'.

        westernDuneField := Dictionary new.
        westernDuneField at: 'east' put: 'central Dunefield'.

        centralDuneField := Dictionary new.
        centralDuneField at: 'south' put: 'landing Zone'.
        centralDuneField at: 'west' put: 'western Dunefield'.
        centralDuneField at: 'east' put: 'eastern Dunefield'.

        easternDuneField := Dictionary new.
        easternDuneField at: 'west' put: 'central Dunefield'.
        easternDuneField at: 'east' put: 'far eastern Dunefield'.

        farEasternDuneField := Dictionary new.
        farEasternDuneField at: 'west' put: 'eastern Dunefield'.

        "Add all locations to the places dictionary"
        places := Dictionary new.
        places at: 'landing Zone' put: landingZone.
        places at: 'western Dunefield' put: westernDuneField.
        places at: 'central Dunefield' put: centralDuneField.
        places at: 'eastern Dunefield' put: easternDuneField.
        places at: 'far eastern Dunefield' put: farEasternDuneField.

        "Add items to specific locations"
        items := Dictionary new.

        tmpItemList := Dictionary new.
        tmpItem := Item new.
        tmpItem name: 'old_access_key'.
        tmpItemList at: 'old_access_key' put: tmpItem.
        items at: 'far eastern Dunefield' put: tmpItemList.

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
        descriptions at: 'Dunestria' put: 'You are on Dunestria, a harsh desert planet with sharp, rocky formations that hurt your feet as you walk.'.
        descriptions at: 'landing Zone' put: 'You are in the landing zone. The sand here softens the spiky terrain slightly.'.
        descriptions at: 'western Dunefield' put: 'You are in the western dune field. It seems to be a dead end.'.
        descriptions at: 'central Dunefield' put: 'You are in the central dune field, surrounded by rocky spikes.'.
        descriptions at: 'eastern Dunefield' put: 'You are in the eastern dune field.'.
        descriptions at: 'far eastern Dunefield' put: 'You are in the far eastern dune field. You see sometiong in the sand'.
        ^descriptions
    ]
]
