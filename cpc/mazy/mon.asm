include "char.inc"

count equ 8

;offsets
x equ 0
y equ 1
type equ 2
status equ 3
clock equ 4
unitSize equ 5

status.none equ 0
status.live equ 1
status.die equ 2
type.horizontal equ 0
type.vertical equ 1
type.chase equ 2

dseg
monsters defs unitSize * count
public monsters

extrn ToMapSize, Tst2x2
extrn man.x, man.y, man.status.die
extrn Put2x2

cseg

Mon.Init: public Mon.Init
    ld iy, monsters
    ld c,count
    ld de,unitSize
    do
        push bc
            ld a,(hl) | inc hl
            call ToMapSize
            ld (iy+x),a
            ld a,(hl) | inc hl
            push af
                and 3fh
                call ToMapSize
                ld (iy+y),a
            pop af
            rlca
            rlca
            and 3
            ld (iy+type),a
            ld (iy+status),status.live
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
ret 

Mon.Move:   public Mon.Move
    ld iy,monsters
    ld b,count
    do
        push bc
            inc (iy+clock)
            ld a,(iy+status)
            dec a
            if z
                ; status.live
                ld l,(iy+x)
                ld h,(iy+y)
                call TestHit.Man

                ld a,(iy+type)
                or a
                if z
                    ; type.horizontal
                    ld a, (man.x)
                    ld c,a
                    ld a,(iy+x)
                    cp c
                    jr z, Next
                    if c
                        inc a
                    else
                        dec a
                    endif
                    ld l,a
                    ld h,(Iy+y)
                    jr TryToMove
                endif
                dec a
                if z
                    ; type.vertical
                    ld a, (man.y)
                    ld b,a
                    ld a,(iy+y)
                    cp b
                    jr z, Next
                    if c
                        inc a
                    else
                        dec a
                    endif
                    ld h,a
                    ld l,(iy+x)
                    TryToMove:
                    call TestMove
                    jr nz,Next
                    CanMove:
                    ld (iy+x),l
                    ld (iy+y),h
                    call TestHit.Man
                    jr Next
                endif
                dec a
                if z
                    ; chaser
                    bit 0,(iy+clock)
                    jr z,Next

                    ld l,(iy+x)
                    ld h,(iy+y)
                    ld a,(man.x)
                    cp l
                    if nz
                        if c
                            dec l
                        else
                            inc l
                        endif
                        call TestMove
                        jr z,CanMove
                        ld l,(iy+x)
                    endif
                    ld a,(man.y)
                    cp h
                    jr z,Next
                    if c
                        dec h
                    else
                        inc h
                    endif
                    call TestMove
                    jr z,CanMove
                    jr Next
                endif
            endif
            dec a
            if z
                ; status.die
                ld a,(iy+clock)
                cp 4
                if z
                    ld (iy+status),status.none
                endif
            endif
            Next:
            ld de, unitSize
            add iy,de
        pop bc
    dwnz
ret 

TestMove:
    call Tst2x2
    ret nz

    push de | push bc
        ld ix,monsters
        ld b,count
        do
            db 0DDH | ld a,l
            db 0FDH | ld c,l
            cp c
            if nz
                ld a,(ix+status)
                dec a
                if z
                    ; status.live
                    ld a,l
                    sub (ix+x)
                    inc a
                    cp 3
                    if c
                        ld a,h
                        ld c,(ix+y)
                        sub c
                        inc a
                        ld c,a
                        cp 3
                        if c
                            inc a;  z := 0
                            jr exit
                        endif
                    endif
                endif
            endif
            ld de,unitSize
            add ix,de
        dwnz
        xor a   ; z := 1
        exit:
    pop bc | pop de
ret

TestHit.Man:
    ld a,(man.x)
    sub l
    inc a
    cp 3
    if c
        ld a,(man.y)
        sub h
        inc a
        cp 3
        if c
            ld a,1
            ld (Man.Status.Die),a
        endif
    endif
ret

Mon.Draw:   public Mon.Draw
    ld iy,monsters
    ld b,count
    do
        push bc
            ld a,(iy+status)
            dec a
            if z
                ; status.live
                ld a,(iy+type)
                cp type.chase
                if z
                    ld a,Char.Chaser
                    jr put
                endif
                ld a,Char.Disturber
                jr put
            endif
            dec a
            if z
                ; status.die
                ld a,Char.Bang
                put:
                ld l,(iy+x) | ld h,(iy+y)
                call Put2x2
            endif
            ld de,unitSize
            add iy,de
        pop bc
    dwnz
ret

extrn AddScore
Mon.TestHit.Kn: public Mon.TestHit.Kn
; in
;   hl: (x,y) of knife
    push bc
    push de
        ld ix,monsters
        ld b,count
        ld c,0
        do
            ld a,(ix+status)
            dec a
            if z
                ; status.live
                ld a,l
                sub (ix+x)
                jr z,hit_x
                dec a
                if z
                    hit_x:
                    ld a,h
                    sub (ix+y)
                    jr z,hit_y
                    dec a
                    if z
                        hit_y:
                        ld (ix+status),status.die
                        ld (ix+clock),0
                        inc c
                        ld a,(ix+type)
                        cp type.chase
                        if z
                            ld e,30 ; 300 Pts.
                        else
                            ld e,10
                        endif
                        ld d,0
                        call AddScore
                    endif
                endif
            endif
            ld de,unitSize
            add ix,de
        dwnz
    ld a,c
    or a
    pop de
    pop bc
ret        

