:- dynamic i_am_at/1, 
    i_am_on/1,
    at/2,
    holding/1,
    needs/2,
    describe/1, 
    entry/1,
    port/2, 
    on/2.


needs(broken_falcon, hyperdrive_engine).
needs(broken_falcon, navigation_system).
needs(broken_falcon, shields).
needs(broken_falcon, communication_array).

needs(access_code_decoder, data_fragment_pyro).
needs(access_code_decoder, data_fragment_verdant).
needs(access_code_decoder, data_fragment_tempest).

becomes(broken_falcon, millennium_falcon).
becomes(access_code_decoder, decoded_access_code).

cannot_be_taken(broken_falcon).
cannot_be_taken(millennium_falcon).
cannot_be_taken(encrypted_door).
cannot_be_taken(access_code_decoder).

blocks_space(encrypted_door).
blocks_space(imperial_database).

opens(encrypted_door, old_access_key).
opens(imperial_database, decoded_access_code).
