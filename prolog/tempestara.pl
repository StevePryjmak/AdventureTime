/* Places on Tempestara */
on(tempestara, tempestara_stormfront).
on(tempestara, tempestara_central_field).
on(tempestara, tempestara_north_field).
on(tempestara, tempestara_south_field).

entry(tempestara_stormfront).
port(tempestara, tempestara_stormfront).

/* Descriptions of locations on Tempestara */
describe(tempestara) :- write('You are on Tempestara, a stormy planet where thunder roars constantly.'), nl.

describe(tempestara_stormfront) :- write('You are at the stormfront. For now, the skies seem calm, but thunder rumbles in the distance.'), nl.
describe(tempestara_central_field) :- write('You are in the central field.'), nl.
describe(tempestara_south_field) :- write('You are in the southern field.'), nl.
describe(tempestara_north_bridge) :- write('You are on the bridge to the fortress.'), nl.
describe(tempestara_fortress) :- write('You are at the fortress. It looms large and ominous in the stormy landscape.'), nl.

/* Items on Tempestara */
at(data_fragment_tempest, tempestara_fortress).
at(encrypted_door, tempestara_fortress).

/* Navigation on Tempestara */
path(tempestara_stormfront, w, tempestara_central_field).

path(tempestara_central_field, w, tempestara_stormfront).
path(tempestara_central_field, n, tempestara_north_bridge).
path(tempestara_central_field, s, tempestara_south_field).
path(tempestara_central_field, e, tempestara_stormfront).

path(tempestara_north_bridge, s, tempestara_central_field).
path(tempestara_north_bridge, n, tempestara_fortress).

path(tempestara_south_field, n, tempestara_central_field).

path(tempestara_fortress, s, tempestara_north_bridge).
