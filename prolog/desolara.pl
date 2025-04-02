:- dynamic i_am_at/1, 
    i_am_on/1,
    at/2,
    holding/1,
    needs/2,
    describe/1, 
    landing_zone/1,
    port/2, 
    on/2.

/* Places on Desolara */
on(desolara, desolara_landing_zone).

entry(desolara_landing_zone).
port(desolara, desolara_landing_zone).

/* Descriptions of locations on Desolara */
describe(desolara) :- write('You are on Desolara, a small, desolate planet with remnants of Imperial technology.'), nl.
describe(desolara_landing_zone) :- at(old_access_key, desolara_landing_zone), write('You are in the landing zone. There''s an old Rebel droid here, holding a key in its mechanical arm.'), nl.
describe(desolara_landing_zone) :- write('You are in the landing zone. There''s an old Rebel droid here.'), nl.

/* Items on Desolara */
at(old_access_key, desolara_landing_zone).