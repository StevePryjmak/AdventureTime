
Object subclass: Planet [
    | name places items doors planetSpaceport|

    Planet class >> new [
        | p |
        p := super new.
        p init.
        ^ p.
    ]

    init [
        name := 'Unnamed Planet'.
        places := Dictionary new.
        doors := Dictionary new.
        items := Dictionary new.
    ]

    name [ ^name]
    planetSpaceport [^planetSpaceport]
    planetSpaceport: place [ planetSpaceport := place]

    from: placeName direction: direction [
        | place newPlace door |
        place := places at: placeName ifAbsent: [ ^ nil ].
        newPlace := place at: direction ifAbsent: [ ^ nil ].

        door := doors at: (placeName -> newPlace) ifAbsent: [ nil ].
        (door notNil and: [ door locked ]) ifTrue: [
            Transcript show: 'The path is blocked by a locked door.'; cr.
            ^ nil
        ].

        ^ newPlace
    ]

    is: itemName at: place [
        | itemsHere|

        itemsHere := self itemsAt: place.
        itemsHere ifNil: [ itemsHere := Array new.].

        itemsHere do: [ :item | 
            (item named = itemName) ifTrue: [ ^ true].
        ].
        
        ^ true
    ]

    getItem: itemName at: place [
        | itemsAt item |
        
        (self is: itemName at: place) ifFalse: [ ^nil].
        
        itemsAt := self itemsAt: place.
        itemsAt do: [ :item | 
            (item named = itemName) ifTrue: [ ^item].
        ].
    ]

    take: itemName at: place [
        | itemsAt item filteredItems |

        item := self getItem: itemName at: place.

        item ifNil: [ ^nil].

        item isStatic ifTrue: [
            Transcript show: 'This item is fixed and cannot be picked up.'; cr; cr.
            ^ nil
        ].

        itemsAt := self itemsAt: place.
        filteredItems := itemsAt select: [ :eachItem | eachItem named ~= itemName ].
        items at: place put: filteredItems.
        ^ item
    ]

    itemsAt: place [
        (items includesKey: place) ifTrue: [
            ^ items at: place
        ].
        ^ nil
    ]

    addDoorFrom: placeName to: destination key: keyName [
        doors at: (placeName -> destination) put: (Door newWithKey: keyName).
    ]

    unlockDoorFrom: placeName to: destination withKey: keyName [
        | door |
        door := doors at: (placeName -> destination) ifAbsent: [ ^ false ].
        ^ door unlockWithKey: keyName
    ]

    useKey: key direction: direction currentPlace: place [
        | targetPlace door |

        targetPlace := (places at: place ifAbsent: [ ^ Transcript show: 'Invalid current place.'; cr. ]) 
            at: direction ifAbsent: [ ^ Transcript show: 'No place in that direction.'; cr. ].

        door := doors at: (place -> targetPlace) ifAbsent: [ ^ Transcript show: 'No door in this direction.'; cr. ].

        (door unlockWithKey: key) ifTrue: [
            doors removeKey: (place -> targetPlace) ifAbsent: [ ^ Transcript show: 'Door already removed.'; cr. ].
            Transcript show: 'The door to ', targetPlace, ' has been unlocked and removed.'; cr.
        ] ifFalse: [
            Transcript show: 'The key does not fit the door.'; cr.
        ].
    ]

    getDescriptionFor: aPlace [
        | descriptions |
        descriptions := self describe.
        ^descriptions at: aPlace ifAbsent: ['Description not available.']
    ]

    describe [
        ^Dictionary new.
    ]


]
