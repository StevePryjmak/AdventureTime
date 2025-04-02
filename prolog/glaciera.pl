/* Places on Glaciera */
on(glaciera, glaciera_settlement).
on(glaciera, glaciera_northern_cave).
on(glaciera, glaciera_central_cave).
on(glaciera, glaciera_western_cave).

entry(glaciera_settlement).
port(glaciera, glaciera_settlement).

/* Descriptions of locations on Glaciera */
describe(glaciera) :- write('You are on Glaciera, a frozen, icy planet. There are small icy creatures all around.'), nl.

describe(glaciera_settlement) :- write('You are in the settlement. It''s filled with small icy creatures coming out of the cave.'), nl.
describe(glaciera_northern_cave) :- at(icy_creature, glaciera_northern_cave), write('You are in the northern part of the cave. There are only icy creatures here, it seems.'), nl.
describe(glaciera_northern_cave) :- write('You are in the northern part of the cave. The icy creatures seem to want their friend back.'), nl.
describe(glaciera_central_cave) :- write('You are in the central section of the cave. You can hear faint, eerie sounds echoing.'), nl.
describe(glaciera_western_cave) :- write('You are in the western section of the cave. It is eerily quiet.'), nl.

/* Items on Glaciera */
at(icy_creature, glaciera_northern_cave).

/* Navigation on Glaciera */
path(glaciera_settlement, n, glaciera_central_cave).

path(glaciera_central_cave, s, glaciera_settlement).
path(glaciera_central_cave, n, glaciera_northern_cave).
path(glaciera_central_cave, w, glaciera_western_cave).

path(glaciera_western_cave, e, glaciera_central_cave).

path(glaciera_northern_cave, s, glaciera_central_cave).
