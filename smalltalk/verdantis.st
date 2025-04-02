Planet subclass: Verdantis [
    init [
        | grove centralHills southernHills easternHills tmpItemList tmpItem tmpFalcon|

        super init.
        self planetSpaceport: 'grove'.
        name := 'Verdantis'.


        "Define locations and their connections"
        grove := Dictionary new.
        grove at: 'south' put: 'central Hills'.

        centralHills := Dictionary new.
        centralHills at: 'north' put: 'grove'.
        centralHills at: 'south' put: 'southern Hills'.
        centralHills at: 'east' put: 'eastern Hills'.

        southernHills := Dictionary new.
        southernHills at: 'north' put: 'central Hills'.

        easternHills := Dictionary new.
        easternHills at: 'west' put: 'central Hills'.

        "Add all locations to the places dictionary"
        places := Dictionary new.
        places at: 'grove' put: grove.
        places at: 'central Hills' put: centralHills.
        places at: 'southern Hills' put: southernHills.
        places at: 'eastern Hills' put: easternHills.

        "Add items to specific locations"
        items := Dictionary new.

        "Items at eastern Hills"
        tmpItemList := Dictionary new.
        tmpItem := Item new.
        tmpItem name: 'data_fragment_verdant'.
        tmpItemList at: 'data_fragment_verdant' put: tmpItem.
        items at: 'eastern Hills' put: tmpItemList.

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
        descriptions at: 'Verdantis' put: 'You are on Verdantis, a forested planet with lush greenery. The air smells like fresh mint.'.
        descriptions at: 'grove' put: 'You are in the grove. The ground is muddy and damp.'.
        descriptions at: 'central Hills' put: 'You are on the central hills.'.
        descriptions at: 'southern Hills' put: 'You are on the southern hills.'.
        descriptions at: 'eastern Hills' put: 'You are on the eastern hills.'.
        ^descriptions
    ]
]
