"The germ of a text adventure game
Marcin Szlenk 2024"

"Game class

Responsibilities:
* print/read outputs/inputs
* handle game loop
* handle 'instructions' and 'halt' commands

Collaborators:
* ..."

Object subclass: Game [
    |map|

    introductionText := {
        ''.
        'In a galaxy oppressed by the iron grip of the Empire, the Rebel Alliance has won a glimmer of hope.'.
        'On the planet Aurelia, deep in the Imperial archives, lies the blueprint to the Death Star-the ultimate weapon of destruction.'.
        'Your mission as a brave Rebel operative is to assemble the Millennium Falcon and journey across star systems to collect data fragments that unlock this crucial blueprint.'.
        'May the Force guide you.'.
        ''.
    }.

    instructionsText := {
        'Available commands are:'. 
        ''.
        'instructions                -- to see these instructions.'. 
        'inventory                   -- to see your inventory.'. 
        'move (direction)            -- to go in a direction.'.
        'warp (direction)            -- to travel on another planet Milenium_falcon required'. 
        'take (item)                 -- to take an item.'. 
        'look                        -- to look around.'. 
        'use (itemUse) (itemOn)      -- to use item1 from inventory on item2'.
        'use_key (key) (direction)   -- to use key on a door in that direction'.
        'quit                        -- to end the game and quit.'. 
        ''.
    }.

    Game class >> new [
        | g |
        g := super new.
        g init.
        ^g
    ]

    init [
        map := (GameMap new).
    ]

    printLines: anArray [
        anArray do: [ :string | Transcript show: string; cr ]
    ]

    printIntroduction [
       self printLines: introductionText.
    ]

    printInstructions [
        self printLines: instructionsText.
    ]


    readCommand [
        Transcript show: '> '.
        ^ FileStream stdin nextLine
    ]


    run [
        |cmd realItem|
        self printIntroduction.
        self printInstructions.

        self completeGame.

        [map isGameOver] whileFalse: [
            cmd := self readCommand.
            self doCommand: cmd.
        ]
    ]

    "implementation of continue for loop"
    doCommand: cmd [
        | isUnknown splitCmd cmdName argCount direction |

        splitCmd := cmd substrings.
        argCount := splitCmd size.
        argCount = 0 ifTrue: [
            Transcript show: 'Please input valid command'; cr; cr.
            ^nil.
        ].
        cmdName := splitCmd at: 1.

        cmdName = 'instructions' ifTrue: [
            self printInstructions.
            ^nil.
        ].

        cmdName = 'quit' ifTrue: [
            map isGameOver: true.
            ^nil.
        ].
            
        cmdName = 'move' ifTrue: [
            argCount = 2 ifFalse: [
                self printLines: #('Move command requires 1 argument:' '    #direction: north, south, west, east' '').
                ^nil.
            ].
            direction := (splitCmd at: 2).
            map move: direction.
            map displayLocation.
            ^nil.
        ].

        cmdName = 'take' ifTrue: [
            | item realItem |
            argCount = 2 ifFalse: [
                self printLines: #('Take command requires 1 argument:' '    #item: item name which is in current place' '').
                ^nil.
            ].
            item := (splitCmd at: 2).
            
            realItem := (map player currentPlanet) take: item at: (map player currentPlace).
            Transcript show: realItem named;cr.
            realItem ifNotNil: [
                map player addItem: realItem.
                Transcript show: 'You took: ', realItem named; cr.
            ].

            map displayLocation.
            ^nil.
        ].

        cmdName = 'inventory' ifTrue: [
            map player showInventory.
            ^nil.
        ].

        cmdName = 'look' ifTrue: [
            map displayLocation.
            ^nil.
        ].

        cmdName = 'use' ifTrue: [
            | itemName targetName |
            argCount = 3 ifFalse: [
                self printLines: #('Use command requires 2 argument:' '    #item1: item from inventory to use' '    #item2: item to use on' '').
                ^nil.
            ].

            itemName := splitCmd at: 2.
            targetName := splitCmd at: 3.
            
            map player use: itemName on: targetName.
            map displayLocation.
            ^nil.
        ].

        cmdName = 'use_key' ifTrue: [
            | keyName direction|
            argCount = 3 ifFalse: [
                self printLines: #('Use_key command requires 2 argument:' '    #key: key to use' '    #direction: direction to door' '').
                ^nil.
            ].


            keyName := splitCmd at: 2.
            direction := splitCmd at: 3.
            

            map player useKey: keyName direction: direction.
            map displayLocation.
            ^nil.
        ].

        cmdName = 'warp' ifTrue: [

            argCount = 2 ifFalse: [
                self printLines: #('Warp command requires 1 argument:' '    #direction: direction of planet to wrap' '').
                ^nil.
            ].
            map warp: (splitCmd at: 2).
            map displayLocation.
            ^nil.
        ].

        self printLines: #('Unknown command.' '')
        
    ]

    "auto game complete function useful for testing"
    completeGame [
        | commands |
        commands := {
            "Repear falcon"
            'take navigation_system'.
            'move north'.
            'take communication_array'.
            'move east'.
            'take hyperdrive_engine'.
            'move west'.
            'move west'.
            'take shields'.
            'move east'.
            'move south'.
            'use navigation_system broken_falcon'.
            'use communication_array broken_falcon'.
            'use hyperdrive_engine broken_falcon'.
            'use shields broken_falcon'.

            'warp east'.
            'move south'.
            'move east'.
            'take data_fragment_verdant'.
            'move west'.
            'move north'.

            'warp west'.
            'warp west'.
            'take old_tempestara_fortress_key'.
            'warp north'.
            'move west'.
            'move north'.
            'use_key old_tempestara_fortress_key north'.
            'move north'.
            'take data_fragment_tempest'.
            'move south'.
            'move south'.
            'move east'.

            'warp east'.
            'move north'.
            'move east'.
            'move east'.
            'take old_access_key'.
            'move west'.
            'move west'.
            'move south'.
            'warp south'.
            'warp south'.
            'warp east'.
            'move east'.
            'use_key old_access_key south'.
            'move south'.
            'take data_fragment_pyro'.
            'move north'.
            'move west'.
            'warp north'.
            'warp west'.
            'move north'.
            'use data_fragment_pyro access_code_decoder'.
            'use data_fragment_verdant access_code_decoder'.
            'use data_fragment_tempest access_code_decoder'.
            'take Base_access_code'.
            'use_key Base_access_code north'.
            'move north'.
        }.
        Transcript show: '------------------------------------------------------------'; cr.
        commands do: [:command | 
            Transcript show: 'Command inputed: ', command; cr;cr.
            self doCommand: command.
            Transcript show: '------------------------------------------------------------'; cr.
        ].
    ]
]

Game new run.
