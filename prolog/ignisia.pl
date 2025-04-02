/* Places on Ignisia */
on(ignisia, ignisia_old_mine).
on(ignisia, ignisia_northern_volcano).
on(ignisia, ignisia_western_volcano).
on(ignisia, ignisia_eastern_volcano).

entry(ignisia_old_mine).
port(ignisia, ignisia_old_mine).

/* Descriptions of locations on Ignisia */
describe(ignisia) :- write('You are on Ignisia, a volcanic planet. It''s incredibly hot here.'), nl.

describe(ignisia_old_mine) :- write('You are at the old mine. It''s the only stable ground around.'), nl.
describe(ignisia_northern_volcano) :- write('You are at the northern volcano.'), nl.
describe(ignisia_western_volcano) :- write('You are at the western volcano.'), nl.
describe(ignisia_eastern_volcano) :- write('You are at the eastern volcano.'), nl.
describe(ignisia_mine_control_room) :- write('You are inside the mine control room. The intense heat makes you sweat.'), nl.

/* Items on Ignisia */
at(data_fragment_pyro, ignisia_mine_control_room).
at(encrypted_door, ignisia_mine_control_room).

/* Navigation on Ignisia */
path(ignisia_old_mine, n, ignisia_northern_volcano).
path(ignisia_old_mine, w, ignisia_western_volcano).
path(ignisia_old_mine, e, ignisia_eastern_volcano).

path(ignisia_northern_volcano, s, ignisia_old_mine).
path(ignisia_western_volcano, e, ignisia_old_mine).
path(ignisia_eastern_volcano, w, ignisia_old_mine).

path(ignisia_eastern_volcano, s, ignisia_mine_control_room).

path(ignisia_mine_control_room, n, ignisia_eastern_volcano).
