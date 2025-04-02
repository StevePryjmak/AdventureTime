Object subclass: Player [
    | currentPlace currentPlanet inventory |

    Player class >> new [
        | g |
        g := super new.
        g init.
        ^ g.
    ]

    init [
        currentPlace := 'spaceport'.
        currentPlanet := nil.
        inventory := Array new.
    ]

    changePlace: place [ currentPlace := place.]
    changePlanet: newPlanet  [ currentPlanet := newPlanet.]
    currentPlanet [ ^currentPlanet]
    currentPlace [ ^currentPlace]

    walk: direction [
        | newPosition |
        (#('north' 'east' 'south' 'west') includes: direction) ifTrue: [
            newPosition := currentPlanet from: currentPlace direction: direction.
            newPosition ifNotNil: [
                self changePlace: newPosition.
            ] ifNil: [
                Transcript show: 'You cannot go that way.'; cr.
            ].

        ].
    ]

    addItem: newItem [
        inventory := inventory copyWith: newItem.
    ]

    removeItem: item [
        inventory remove: item.
    ]

    hasItem: item [
        ^ inventory includes: item.
    ]

    showPosition [
        Transcript 
            show: 'You are on ', (currentPlanet getDescriptionFor: (currentPlanet name)); cr;
            show: (currentPlanet getDescriptionFor: currentPlace); cr.

        Transcript cr.
    ]

    showInventory [
        Transcript show: 'Inventory: ';cr.
        inventory do: [:item |
            Transcript show:'   ', item named;cr.
        ].
        Transcript cr.
    ]

    use: itemName on: targetName [
        | item target result|

        item := inventory detect: [:each | each named = itemName] ifNone: [
            Transcript show: 'You do not have ', itemName, '.'; cr.
            ^ self. 
        ].

        target := currentPlanet getItem: targetName at: currentPlace.
        target ifNil: [
            Transcript show: targetName, ' is not here at ', currentPlace asString; cr.
            ^ self. 
        ].

        result := target tryUseItem: itemName.
        result ifTrue: [
            inventory := (inventory select: [ :each | (each = item) not ]) asArray.
            Transcript show: itemName, ' was removed from inventory.'; cr.
        ].
    ]

    useKey: keyName direction: direction [
        | keyFound |

        keyFound := inventory detect: [:item | item named = keyName] ifNone: [
            Transcript show: 'You do not have the key named ', keyName, '.'; cr.
            ^ self.
        ].

        currentPlanet useKey: keyName direction: direction currentPlace: currentPlace.
    ]


]

