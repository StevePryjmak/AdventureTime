Object subclass: Item [
    | name neededItems become isStatic|

    Item class >> new [
        | g |
        g := super new.
        g init.
        ^ g.
    ]

    init [
        name := 'Undefined name'.
        isStatic := false.
        neededItems := #().
        become = nil.
    ]

    isStatic [ ^isStatic.]
    isStatic: aStatic [ isStatic := aStatic]
    name: aString [ name := aString ]
    needsItems: aList [ neededItems := aList ]
    becomes: anItem [ become := anItem ]

    named [ ^ name ]
    neededItems [ ^ neededItems ]
    become [ ^ become ]

    stillNeeds [
        neededItems isEmpty ifTrue: [
            Transcript show: 'Nothing is needed.'; cr.
        ] ifFalse: [
            Transcript show: 'Still needs: '; cr.
            neededItems do: [ :item |
                Transcript show: '    ', item;cr.
            ].
            Transcript cr.
            
        ].
    ]


    tryUseItem: itemName [
        | item used |
        neededItems isEmpty ifTrue: [
            Transcript show: 'Object is in final state no items neded'; cr.
            ^false.
        ].
        used := false.

        (neededItems includes: itemName) ifTrue: [
            used := true.
            Transcript show: itemName, ' was used on ', name; cr.
            neededItems := (neededItems select: [ :each | (each = itemName) not ]) asArray.
        ].


        neededItems isEmpty ifTrue: [
            Transcript show: 'neededItems is empty, proceeding with becoming an item.'; cr.

            item := become.
            
            item ifNil: [
                Transcript show: 'Failed to become an item.'; cr.
                ^used. 
            ].

            Transcript show: name, ' became ', (item named); cr.
            name := item named.
            neededItems := item neededItems.
            isStatic := item isStatic.
            become := item become.
        ].

        used ifFalse: [
            Transcript show: itemName, ' is not needed for ', name; cr.
        ].
        self stillNeeds.
        ^used.
    ]



]
