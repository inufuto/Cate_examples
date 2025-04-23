include "char.inc"

count equ 4

; offsets
x equ 0
y equ 1
status equ 2
unitSize equ 3

; statuses
status.none equ 0
status.floor equ 1
status.held equ 2
status.flying equ 3

    dseg
knives defs unitSize * count
Kn.Invnt defb 0
blink defb 0
    public  knives, Kn.Invnt

    extrn ToMapSize, Tst1x1
    extrn Put1x1, Print.Kn.Invent
    extrn man.x
    extrn goal.x
    extrn Sound_Get, Sound_Hit

    cseg
directions:
    defb -1,0,1,0,0,-1,0,1

Kn.Init:
    public Kn.Init
	ld iy, knives
    ld c, count
    ld de,unitSize
	do
        push bc
            ld a,(hl)
            inc hl
            call ToMapSize
            ld (iy+x),a
            ld a,(hl)
            inc hl
            call ToMapSize
            ld (iy+y),a
            call DirectionToGoal
            or status.floor
            ld (iy+status),a
            add iy,de
        pop bc
        dec c
	dwnz
    ld a,c
    or a
    if nz
        do
            ld (iy+status),status.none
            add iy,de
            dec a
        while nz|wend
    endif
    xor a
    ld (Kn.Invnt),a
ret

Kn.Start: public Kn.Start
; in
;   l: x
;   h: y
;   a: direction
    ld c,a

    ld iy,knives
    ld b,count
    ld de,unitSize
    do
        ld a,(iy+status)
        and 3
        cp status.held
        if z
            ld (iy+x),l
            ld (iy+y),h
            ld a,c
            rlca
            rlca
            or status.flying
            ld (iy+status),a
            ld a,(Kn.Invnt)
            dec a
            ld (Kn.Invnt),a
            call Sound_Get
            call Print.Kn.Invent
            ret
        endif
        add iy,de
    dwnz
ret

Kn.Move:
    public Kn.Move
    ld iy,knives
    ld b,count
    do
        push bc
            ld a,(iy+status)
            and 3
            jp z, Move.Next    ; status.none
            dec a
            if z
                ; status.floor
                ld hl,(man.x)
                ld a,(iy+x)
                sub l
                if nz
                    dec a
                    jp nz, Move.Next
                endif
                ld a,(iy+y)
                sub h
                if nz
                    dec a
                    jp nz, Move.Next
                endif
                ld a,(iy+status)
                and 0fch
                or status.held
                ld (iy+status),a
                ld a,(Kn.Invnt)
                inc a
                ld (Kn.Invnt),a
                call Sound_Get
                call Print.Kn.Invent
                jp Move.Next
            endif
            dec a
            jp z, Move.Next ; status.held
            dec a
            if z
                ; status.flying
                ld a,(iy+status)
                rrca
                and 6
                ld e,a
                ld d,0
                ld hl, directions
                add hl,de
                ld a,(iy+x)
                add a,(hl)
                ld e,a
                inc hl
                ld a,(iy+y)
                add a,(hl)
                ld h,a
                ld l,e
                call Tst1x1
                if z
                    ld (iy+x),l
                    ld (iy+y),h
                    call TestHit
                    jp Move.Next
                endif
                call DirectionToGoal
                or status.floor
                ld (iy+status),a
            endif
            Move.Next:
            ld de,unitSize
            add iy,de
        pop bc
    dwnz
ret 

Kn.Draw:    public Kn.Draw
    ld a,(blink) | inc a | ld (blink), a
    ld iy,knives
    ld b,count
    do
        push bc
            ld a, (iy+status)
            and 3
            jp z, Draw.Next;   none
            dec a
            if z
                ; floor
                ld a,(blink)
                and 1
                jp z, kd1
                jp Draw.Next
            endif
            dec a
            jp z, Draw.Next;   held
            kd1:
                ld l,(iy+x)
                ld h,(iy+y)
                ld a,(iy+status)
                rrca
                rrca
                and 3
                add a,Char.Kn.Left
                call Put1x1
            Draw.Next:
            ld de,unitSize
            add iy,de
        pop bc
    dwnz
ret

DirectionToGoal:
    push bc
    push hl
        ld hl,(goal.x)
        ld a,l | sub (iy+x) | ld l,a
        call Abs| ld c,a
        ld a,h | sub (iy+y) | ld h,a
        call Abs| ld b,a
        sub c
        if c
            bit 7,l
            if z
                ld a, 1
            else
                xor a
            endif
        else
            bit 7,h
            if z
                ld a,3
            else
                ld a,2
            endif
        endif
        rlca
        rlca
    pop hl
    pop bc
ret

Abs: public Abs
    bit 7,a
    ret z
    neg
ret    

extrn  Mon.TestHit.Kn, Snd.Address

TestHit:
    call Mon.TestHit.Kn
    if nz
        push hl
            ld hl,Sound_Hit
            ld (Snd.Address),hl
            ld a,(iy+status)
            call DirectionToGoal
            or status.floor
            ld (iy+status),a
        pop hl
    endif
ret
