Planet subclass: Tempestara [
    init [
        | stormfront centralField northBridge southField fortress tmpItemList tmpItem tmpFalcon |

        super init.
        self planetSpaceport: 'stormfront'.
        name := 'Tempestara'.

        "Define locations and their connections"
        stormfront := Dictionary new.
        stormfront at: 'west' put: 'central Field'.

        centralField := Dictionary new.
        centralField at: 'east' put: 'stormfront'.
        centralField at: 'north' put: 'north Bridge'.
        centralField at: 'south' put: 'south Field'.

        northBridge := Dictionary new.
        northBridge at: 'south' put: 'central Field'.
        northBridge at: 'north' put: 'fortress'.

        fortress := Dictionary new.
        fortress at: 'south' put: 'north Bridge'.

        southField := Dictionary new.
        southField at: 'north' put: 'central Field'.

        "Add all locations to the places dictionary"
        places := Dictionary new.
        places at: 'stormfront' put: stormfront.
        places at: 'central Field' put: centralField.
        places at: 'north Bridge' put: northBridge.
        places at: 'south Field' put: southField.
        places at: 'fortress' put: fortress.

        self addDoorFrom: 'north Bridge' to: 'fortress' key: 'old_tempestara_fortress_key'.

        items := Dictionary new.
        
        tmpItemList := Dictionary new.
        tmpItem := Item new.
        tmpItem name: 'data_fragment_tempest'.
        tmpItemList at: 'data_fragment_tempest' put: tmpItem.
        items at: 'fortress' put: tmpItemList.
        
        tmpItemList := Dictionary new.
        tmpFalcon := Item new.
        tmpFalcon name: 'Milenium_falcon'.
        tmpFalcon isStatic: true.
        tmpItemList at: 'Milenium_falcon' put: tmpFalcon.
        items at: 'stormfront' put: tmpItemList.

    ]

    describe [
        | descriptions |
        descriptions := Dictionary new.
        descriptions at: 'Tempestara' put: 'You are on Tempestara, a stormy planet where thunder roars constantly.'.
        descriptions at: 'stormfront' put: 'You are at the stormfront. The skies seem calm, but thunder rumbles in the distance.'.
        descriptions at: 'central Field' put: 'You are in the central field.'.
        descriptions at: 'south Field' put: 'You are in the southern field.'.
        descriptions at: 'north Bridge' put: 'You are on the bridge to the fortress.'.
        descriptions at: 'fortress' put: 'You are at the fortress. It looms large and ominous.'.
        ^descriptions
    ]
]
