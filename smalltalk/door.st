Object subclass: Door [
    | locked keyName |

    Door class >> newWithKey: aKey [
        | door |
        door := super new.
        door locked: true.
        door keyName: aKey.
        ^ door
    ]

    locked [
        ^ locked
    ]

    locked: aBoolean [
        locked := aBoolean.
    ]

    keyName [
        ^ keyName
    ]

    keyName: aKeyName [
        keyName := aKeyName.
    ]

    unlockWithKey: aKey [
        Transcript show: 'Key neded: ',keyName; cr.
        (keyName = aKey) ifTrue: [
            self locked: false.
            ^ true.
        ].
        ^ false.
    ]
]
