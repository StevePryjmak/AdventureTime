/* Places on Dunestria */
on(dunestria, dunestria_landing_zone).
on(dunestria, dunestria_western_dunefield).
on(dunestria, dunestria_central_dunefield).
on(dunestria, dunestria_eastern_dunefield).

entry(dunestria_landing_zone).
port(dunestria, dunestria_landing_zone).

/* Descriptions of locations on Dunestria */
describe(dunestria) :- write('You are on Dunestria, a harsh desert planet with sharp, rocky formations that hurt your feet as you walk.'), nl.

describe(dunestria_landing_zone) :- write('You are in the landing zone. The sand here softens the spiky terrain slightly.'), nl.
describe(dunestria_central_dunefield) :- write('You are in the central dune field, surrounded by rocky spikes.'), nl.
describe(dunestria_western_dunefield) :- write('You are in the western dune field. It seems to be a dead end.'), nl.
describe(dunestria_eastern_dunefield) :- write('You are in the eastern dune field.'), nl.
describe(dunestria_far_east_dunefield) :- write('You are in the far eastern dune field.'), nl.

/* Items on Dunestria */
at(old_access_key, dunestria_far_east_dunefield).

/* Navigation on Dunestria */
path(dunestria_landing_zone, n, dunestria_central_dunefield).

path(dunestria_central_dunefield, w, dunestria_western_dunefield).
path(dunestria_central_dunefield, e, dunestria_eastern_dunefield).
path(dunestria_central_dunefield, s, dunestria_landing_zone).
path(dunestria_central_dunefield, n, dunestria_landing_zone).

path(dunestria_eastern_dunefield, w, dunestria_central_dunefield).
path(dunestria_eastern_dunefield, e, dunestria_far_east_dunefield).
path(dunestria_eastern_dunefield, s, dunestria_landing_zone).
path(dunestria_eastern_dunefield, n, dunestria_landing_zone).

path(dunestria_western_dunefield, w, dunestria_landing_zone).
path(dunestria_western_dunefield, e, dunestria_central_dunefield).
path(dunestria_western_dunefield, s, dunestria_landing_zone).
path(dunestria_western_dunefield, n, dunestria_landing_zone).

path(dunestria_far_east_dunefield, w, dunestria_eastern_dunefield).
path(dunestria_far_east_dunefield, e, dunestria_landing_zone).
path(dunestria_far_east_dunefield, s, dunestria_landing_zone).
path(dunestria_far_east_dunefield, n, dunestria_landing_zone).
