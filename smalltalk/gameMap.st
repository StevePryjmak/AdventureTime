
Object subclass: GameMap [
    | isGameOver player aurelia tempestara verdantis ignisia dunestria desolara glaciera connections wonPlace|

    GameMap class >> new [
        | g |
        g := super new.
        g init.
        ^ g
    ]

    init [
        isGameOver := false.
        aurelia := (Aurelia new).
        tempestara := (Tempestara new).
        verdantis := (Verdantis new).
        ignisia := (Ignisia new).
        dunestria := (Dunestria new).
        desolara := (Desolara new).
        glaciera := (Glaciera new).

        player := (Player new).
        player changePlanet: aurelia.
        player changePlace: 'spaceport'.
        wonPlace := 'imperial Database'.

        "Define connections between planets"
        self init_connections.
    ]

    init_connections [
        connections := Dictionary new.

        connections at: aurelia put: (Dictionary new
            at: 'north' put: dunestria;
            at: 'east' put: verdantis;
            at: 'south' put: glaciera;
            at: 'west' put: desolara;
            yourself).

        connections at: tempestara put: (Dictionary new
            at: 'south' put: desolara;
            at: 'east' put: dunestria;
            yourself).

        connections at: verdantis put: (Dictionary new
            at: 'west' put: aurelia;
            at: 'south' put: ignisia;
            yourself).

        connections at: dunestria put: (Dictionary new
            at: 'west' put: tempestara;
            at: 'south' put: aurelia;
            yourself).

        connections at: ignisia put: (Dictionary new
            at: 'north' put: verdantis;
            at: 'west' put: glaciera;
            yourself).

        connections at: desolara put: (Dictionary new
            at: 'north' put: tempestara;
            at: 'east' put: aurelia;
            yourself).

        connections at: glaciera put: (Dictionary new
            at: 'east' put: ignisia;
            at: 'north' put: aurelia;
            yourself).
    ]

    isGameOver [^isGameOver]
    player [^player]
    isGameOver: val [isGameOver:=val.]

    move: direction [
        player walk: direction.
        (player currentPlace = wonPlace) ifTrue: [
            isGameOver :=true.
        ]
    ]

    warp: direction [
        | currentPlanet newPlanet directionMap itemsHere isFalconHere |
        currentPlanet := player currentPlanet.
        itemsHere := player currentPlanet itemsAt: (player currentPlace).

        itemsHere ifNil: [
            itemsHere := Array new.
        ].

        isFalconHere := false.
        itemsHere do: [ :item | 
            (item named = 'Milenium_falcon') ifTrue: [ isFalconHere := true ].
        ].

        isFalconHere ifFalse: [
            Transcript show: 'You need to be at the spaceport with the fixed Falcon'; cr.
            ^nil
        ].

        directionMap := connections at: currentPlanet ifAbsent: [
            Transcript show: 'Nothing in that directoin try another direction.';cr;cr.
            ^nil 
        ].
        newPlanet := directionMap at: direction ifAbsent: [ 
            Transcript show: 'Planet not fount in that direction.';cr;cr.            
            ^nil 
        ].
        player changePlanet: newPlanet.
        player changePlace: newPlanet planetSpaceport.
        Transcript show: 'Warping to ', newPlanet name; cr.
    ]




    displayLocation [
        | itemsHere |
        player showPosition.
        itemsHere := player currentPlanet itemsAt: (player currentPlace).
        itemsHere ifNotNil: [
            itemsHere isEmpty
                ifTrue: [Transcript show: 'I do not see anything here.'; cr.]
                ifFalse: [
                    itemsHere do: [:item | 
                        Transcript show: 'There is a ', item named, ' here. ';cr.
                    ].
                ].
            Transcript cr.
        ]
    ]
]