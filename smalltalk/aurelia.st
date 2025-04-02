

Planet subclass: Aurelia [
    init [
        | spaceport centralOutpost easternOutpost westernOutpost imperialDatabase tmpItemList tmpItem tmpItemBecomes|
        super init.
        self planetSpaceport: 'spaceport'.
        name := 'Aurelia'.

        spaceport := Dictionary new.
        spaceport at: 'north' put: 'central Rebel outpost'.

        centralOutpost := Dictionary new.
        centralOutpost at: 'north' put: 'imperial Database'.  "@TODO put bloker to deth star and chage to deth star"
        centralOutpost at: 'east' put: 'eastern Rebel outpost'.
        centralOutpost at: 'south' put: 'spaceport'.
        centralOutpost at: 'west' put: 'western Rebel outpost'.

        easternOutpost := Dictionary new.
        easternOutpost at: 'west' put: 'central Rebel outpost'.

        westernOutpost := Dictionary new.
        westernOutpost at: 'east' put: 'central Rebel outpost'.

        imperialDatabase := Dictionary new.
        imperialDatabase at: 'south' put: 'central Rebel outpost'.

        places := Dictionary new.
        places at: 'spaceport' put: spaceport.
        places at: 'central Rebel outpost' put: centralOutpost.
        places at: 'eastern Rebel outpost' put: easternOutpost.
        places at: 'western Rebel outpost' put: westernOutpost.
        places at: 'imperial Database' put: imperialDatabase.

        "Add door with a key requirement"
        self addDoorFrom: 'central Rebel outpost' to: 'imperial Database' key: 'Base_access_code'.

        items := Dictionary new.
        
        tmpItemList := Dictionary new.

        tmpItem := Item new.
        tmpItem needsItems: #('navigation_system' 'communication_array' 'shields' 'hyperdrive_engine').

        tmpItemBecomes := Item new.
        tmpItemBecomes name: 'Milenium_falcon'.
        tmpItemBecomes isStatic: true.
        tmpItem becomes: tmpItemBecomes.

        tmpItem name: 'broken_falcon'.
        tmpItem isStatic: true.
        tmpItemList at: 'broken_falcon' put: tmpItem.

        tmpItem := Item new.
        tmpItem name: 'navigation_system'.
        tmpItemList at: 'navigation_system' put: tmpItem.

        "temporary for testing"
"        tmpItem := Item new.
        tmpItem name: 'decoder'.
        tmpItemList at: 'decoder' put: tmpItem."

        items at: 'spaceport' put: tmpItemList.

        tmpItemList := Dictionary new.

        tmpItem := Item new.
        tmpItem name: 'hyperdrive_engine'.

        tmpItemList at: 'hyperdrive_engine' put: tmpItem.

        items at: 'eastern Rebel outpost' put: tmpItemList.

        tmpItemList := Dictionary new.

        tmpItem := Item new.
        tmpItem name: 'communication_array'.
        tmpItemList at: 'communication_array' put: tmpItem.

        tmpItem := Item new.
        tmpItem name: 'access_code_decoder'.
        tmpItem needsItems: #('data_fragment_pyro' 'data_fragment_verdant' 'data_fragment_tempest').
        
        tmpItemBecomes := Item new.
        tmpItemBecomes name: 'Base_access_code'.
        tmpItemBecomes isStatic: false.
        tmpItem becomes: tmpItemBecomes.

        tmpItem isStatic: true.
        tmpItemList at: 'access_code_decoder' put: tmpItem.

        items at: 'central Rebel outpost' put: tmpItemList.

        tmpItemList := Dictionary new.

        tmpItem := Item new.
        tmpItem name: 'shields'.

        tmpItemList at: 'shields' put: tmpItem.

        items at: 'western Rebel outpost' put: tmpItemList.
    ]


    describe [
        | descriptions |
        descriptions := Dictionary new.

        descriptions at: 'Aurelia' put: 'You are on Aurelia, the central Rebel base.'.
        descriptions at: 'spaceport' put: 'You are at the Rebel spaceport.'.
        descriptions at: 'imperial Database' put: self  winningMessage.
        descriptions at: 'central Rebel outpost' put: 'You are in the central Rebel outpost.'.
        descriptions at: 'eastern Rebel outpost' put: 'You are at the eastern Rebel outpost.'.
        descriptions at: 'western Rebel outpost' put: 'You are at the western Rebel outpost.'.

        ^descriptions
    ]

    winningMessage [
        | message |
        message := 'Congratulations! You have infiltrated the Imperial Database, the heart of enemy intelligence.
Your efforts have secured vital information that could turn the tide of the rebellion.
The fate of the galaxy now rests in your hands. Well done, hero of the rebellion!'.
        ^ message.
    ]
]
