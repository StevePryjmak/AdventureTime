Planet subclass: Desolara [
    init [
        | landingZone tmpItemList tmpItem descriptions tmpFalcon|
        super init.
        self planetSpaceport: 'desolara_landing_zone'.
        name := 'Desolara'.

        "Define items"
        items := Dictionary new.
        tmpItemList := Dictionary new.

        tmpItem := Item new.
        tmpItem name: 'old_tempestara_fortress_key'.
        tmpItemList at: 'old_tempestara_fortress_key' put: tmpItem.

        tmpFalcon := Item new.
        tmpFalcon name: 'Milenium_falcon'.
        tmpFalcon isStatic: true.
        tmpItemList at: 'Milenium_falcon' put: tmpFalcon.
        items at: 'desolara_landing_zone' put: tmpItemList.
    ]

    describe [
        | descriptions |
        descriptions := Dictionary new.

        descriptions at: 'Desolara' put: 'You are on Desolara, a small, desolate planet with remnants of Imperial technology.'.
        descriptions at: 'desolara_landing_zone' put: 'You are in the landing zone. There''s an old Rebel droid here, holding a key in its mechanical arm.'.

        ^descriptions
    ]
]
