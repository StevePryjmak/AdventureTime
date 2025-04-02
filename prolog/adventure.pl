:- discontiguous i_am_at/1, 
    i_am_on/1,
    at/2,
    holding/1,
    needs/2,
    describe/1, 
    entry/1,
    port/2, 
    on/2,
    path/3.

% :- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

/* Planet definitions */
:- include('aurelia').
:- include('desolara').
:- include('dunestria').
:- include('glaciera').
:- include('ignisia').
:- include('tempestara').
:- include('verdantis').

/* Space navigation paths */
:- include('space_navigation').

/* Item definitions */
:- include('items').

:- dynamic i_am_at/1, 
    i_am_on/1,
    at/2,
    holding/1,
    needs/2,
    describe/1, 
    entry/1,
    port/2, 
    on/2.

i_am_at(aurelia_spaceport).
i_am_on(aurelia).

/* Rules for picking up an object */
take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        cannot_be_taken(X) -> 
            write('You cannot take that!'),
            nl,
        !;
            i_am_at(Place),
            at(X, Place),
            retract(at(X, Place)),
            assert(holding(X)),
            write('OK.'),
            !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* Rules for putting down an object */
drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.

use_key(Key, Direction) :-
        i_am_at(Place),
        holding(Key),
        path(Place, Direction, Destination),
        at(Blocker, Destination),
        opens(Blocker, Key),
        retract(at(Blocker, Destination)),
        retract(holding(Key)),
        write('You opened '),
        write(Blocker),
        write('.'),
        !, nl.

use(X, Y) :-
        i_am_at(Place),
        at(X, Place),
        holding(Y),
        needs(X, Y),
        retract(holding(Y)),
        retract(needs(X, Y)),
        still_needs(X),
        write('OK.'),
        nl,
        maybe_change(X),
        !.

still_needs(X) :-
        needs(X, Y),
        write(X), write(' still needs '), write(Y), nl, fail.

still_needs(_).

maybe_change(X) :-
        forall(needs(X, _), false),
        becomes(X, Z),
        at(X, Place),
        retract(at(X, Place)),
        assert(at(Z, Place)),
        write(X), write(' became '), write(Z), nl, !.

maybe_change(_).

/* Direction letters as calls to go/1 */

n :- go(n).
s :- go(s).
e :- go(e).
w :- go(w).

/* Movement rule */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        forall(at(Thing, There), not(blocks_space(Thing))) -> 
            i_am_at(Here),
            path(Here, Direction, There),
            retract(i_am_at(Here)),
            assert(i_am_at(There)),
            maybe_win(There),
            nl, scan, !
            ;
            i_am_at(Here),
            path(Here, Direction, There),
            at(Anything, There),
            blocks_space(Anything),
            write('You can''t go there, there is a '), write(Anything), write(' in your path.'),
            nl, !.

go(_) :-
        write('You can''t go that way.').

maybe_win(There) :-
    winning_location(There),
    finish, !.

maybe_win(_).

warp(Direction) :-
        i_am_on(Here),
        i_am_at(HereEntry),
        entry(HereEntry),
        at(millennium_falcon, HereEntry),
        space_navigation(Here, Direction, There),
        port(There, ThereEntry),
        retract(i_am_on(Here)),
        retract(i_am_at(HereEntry)),
        retract(at(millennium_falcon, HereEntry)),
        assert(i_am_on(There)),
        assert(i_am_at(ThereEntry)),
        assert(at(millennium_falcon, ThereEntry)),
        !, scan.

warp(_) :-
        write('You can''t warp there.').


/* Look around */

scan :-
        i_am_on(Planet),
        i_am_at(Location),
        describe(Planet),
        describe(Location),
        nl,
        notice_objects_at(Location),
        !, nl.

/* Mention objects in vicinity */

notice_objects_at(Location) :-
        at(X, Location),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).

check_holding :-
        holding(X),
        write('You are holding a '), write(X), write('.'), nl,
        fail, !, nl.

check_holding.

/* Check items in hand */
inventory :-
        (holding(_) ->
            write('You are holding:'), nl, check_holding;
            write('Your hands are empty.'), nl).

/* Game start story */
start_story :-
        write('In a galaxy oppressed by the iron grip of the Empire, the Rebel Alliance has won a glimmer of hope.'), nl,
        write('On the planet Aurelia, deep in the Imperial archives, lies the blueprint to the Death Star—the ultimate weapon of destruction.'), nl,
        write('Your mission as a brave Rebel operative is to assemble the Millennium Falcon and journey across star systems to collect data fragments that unlock this crucial blueprint.'), nl,
        write('May the Force guide you.'), nl, nl.

/* Game end story */
end_story :-
        write('You finally have it. The complete Death Star blueprint.'), nl,
        write('With this, the Alliance can strike a crippling blow to the Empire, giving new hope to the galaxy.'), nl,
        write('The battle is far from over, but today, you have made a difference. Today, you have given the galaxy a chance.'), nl,
        nl.

/* Game over */

die :-
        finish.

/* End game instruction */

finish :-
        nl,
        end_story,
        write('The game is over. Please enter the "halt." command.'),
        nl.

/* Game instructions */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.                   -- to start the game.'), nl,
        write('n.  s.  e.  w.           -- to go in that direction.'), nl,
        write('warp(Direction).         -- to warp in that direction from the entry with the Millennium Falcon.'), nl,
        write('take(Object).            -- to pick up an object.'), nl,
        write('use(Object, Another).    -- to use something you are holding on another object.'), nl,
        write('use_key(Key, Direction). -- to use a key on a door in a direction.'), nl,
        write('drop(Object).            -- to put down an object.'), nl,
        write('scan.                    -- to scan around you again.'), nl,
        write('inventory.               -- to check the list of items you are holding.'), nl,
        write('instructions.            -- to see this message again.'), nl,
        write('halt.                    -- to end the game and quit.'), nl,
        nl.

/* Start game */

start :-
        start_story,
        instructions,
        scan.