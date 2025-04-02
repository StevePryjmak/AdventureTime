/* Places on Verdantis */
on(verdantis, verdantis_grove).
on(verdantis, verdantis_southern_hills).
on(verdantis, verdantis_central_hills).
on(verdantis, verdantis_eastern_hills).

entry(verdantis_grove).
port(verdantis, verdantis_grove).

/* Descriptions of locations on Verdantis */
describe(verdantis) :- write('You are on Verdantis, a forested planet with lush greenery. The air smells like fresh mint.'), nl.

describe(verdantis_grove) :- write('You are in the grove. The ground is muddy and damp.'), nl.
describe(verdantis_central_hills) :- write('You are on the central hills.'), nl.
describe(verdantis_southern_hills) :- write('You are on the southern hills.'), nl.
describe(verdantis_eastern_hills) :- write('You are on the eastern hills.'), nl.

/* Items on Verdantis */
at(data_fragment_verdant, verdantis_eastern_hills).

/* Navigation on Verdantis */
path(verdantis_grove, s, verdantis_central_hills).

path(verdantis_central_hills, n, verdantis_grove).
path(verdantis_central_hills, s, verdantis_southern_hills).
path(verdantis_central_hills, e, verdantis_eastern_hills).

path(verdantis_eastern_hills, w, verdantis_central_hills).

path(verdantis_southern_hills, n, verdantis_central_hills).
