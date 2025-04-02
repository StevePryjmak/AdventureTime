/* Places on Aurelia */
on(aurelia, aurelia_spaceport).
on(aurelia, aurelia_base).
on(aurelia, aurelia_east_outpost).
on(aurelia, aurelia_center_outpost).
on(aurelia, aurelia_west_outpost).

entry(aurelia_spaceport).
port(aurelia, aurelia_spaceport).

/* Descriptions of locations on Aurelia */
describe(aurelia) :- write('You are on Aurelia, the central Rebel base.'), nl.

describe(aurelia_spaceport) :- write('You are at the Rebel spaceport.'), nl.
describe(aurelia_base) :- write('You are at the Rebel base.'), nl.
describe(aurelia_center_outpost) :- write('You are in the central Rebel outpost.'), nl.
describe(aurelia_east_outpost) :- write('You are at the eastern Rebel outpost.'), nl.
describe(aurelia_west_outpost) :- write('You are at the western Rebel outpost.'), nl.

winning_location(aurelia_base).

/* Items on Aurelia */
at(broken_falcon, aurelia_spaceport).
at(navigation_system, aurelia_spaceport).
at(hyperdrive_engine, aurelia_east_outpost).
at(shields, aurelia_west_outpost).
at(communication_array, aurelia_center_outpost).
at(access_code_decoder, aurelia_center_outpost).
at(imperial_database, aurelia_base).

/* Navigation on Aurelia */
path(aurelia_spaceport, n, aurelia_center_outpost).
path(aurelia_spaceport, e, aurelia_spaceport).
path(aurelia_spaceport, w, aurelia_spaceport).

path(aurelia_center_outpost, n, aurelia_base).
path(aurelia_center_outpost, e, aurelia_east_outpost).
path(aurelia_center_outpost, w, aurelia_west_outpost).
path(aurelia_center_outpost, s, aurelia_spaceport).

path(aurelia_east_outpost, n, aurelia_base).
path(aurelia_east_outpost, e, aurelia_spaceport).
path(aurelia_east_outpost, w, aurelia_center_outpost).
path(aurelia_east_outpost, s, aurelia_spaceport).

path(aurelia_west_outpost, n, aurelia_base).
path(aurelia_west_outpost, e, aurelia_center_outpost).
path(aurelia_west_outpost, w, aurelia_spaceport).
path(aurelia_west_outpost, s, aurelia_spaceport).

path(aurelia_base, n, aurelia_spaceport).
path(aurelia_base, e, aurelia_east_outpost).
path(aurelia_base, w, aurelia_west_outpost).
path(aurelia_base, s, aurelia_center_outpost).
