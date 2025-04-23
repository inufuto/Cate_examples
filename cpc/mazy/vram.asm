include "cpc.inc"
include "mazy.inc"
include "char.inc"

ext AsciiPattern, ManPattern, MonPattern, GoalPattern, KnPattern, WallPattern, TitlePattern

WindowSize equ WindowWidth*WindowHeight
PatternRam equ 0a000h

    dseg
VVram defs WindowSize
public VVram
backup defs WindowSize
BaseX	defb	0
BaseY	defb	0
public BaseX, BaseY

ext map, map.step


cseg
PatternAddress:
    push de
        ld l,a
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        ld de,PatternRam
        add hl,de
    pop de
ret


; void MakePatternMono(byte c:a, ptr<byte> pSource:de, byte count:c, byte color:b);
dseg
    color: defb 0
cseg
MakePatternMono:
    ex af,af'
        ld a,b
        ld (color),a
    ex af,af'
    di
        push af | push hl | push de | push bc
            exx
                call PatternAddress
            exx
            ld a,(color) ; color
            exx
                ld d,a
                rlca | rlca | rlca | rlca
                ld b,a
                ld a,d
                rrca
                or b
                and 11h
                ld d,a
            exx
            do
                ld l,CharHeight
                do
                    ld a,(de) | inc de
                    exx
                        ld c,a
                    exx
                    ld h,2
                    do
                        exx
                            ld e,0
                        exx
                        ld b,4
                        do
                            exx
                                sla e
                                sla c
                                if c
                                    ld a,e
                                    or d
                                    ld e,a
                                endif
                            exx
                        dwnz
                        exx
                            ld (hl),e
                            inc hl
                        exx
                        dec h
                    while nz | wend
                    dec l
                while nz | wend
                dec c
            while nz | wend
        pop bc | pop de | pop hl | pop af
    ei
ret


; void MakePatternColor(byte c:a, ptr<byte> pSource:de, byte count:c);
MakePatternColor:
    di
        push af | push hl | push de | push bc
            call PatternAddress
            ex de,hl
            push hl
                ld l,c
                ld h,0
                add hl,hl ;*2
                add hl,hl ;*4
                add hl,hl ;*8
                add hl,hl ;*16
                ld c,l
                ld b,h
            pop hl
            ldir
        pop bc | pop de | pop hl | pop af
    ei
ret


cseg
ColorTable:
    defb Char.Ascii
    defw AsciiPattern
    defb 64, 3

    defb Char.Man.Stop.Left
    defw ManPattern
    defb 88, 3

    defb Char.Goal
    defw GoalPattern
    defb 4*2, 3

    defb Char.Kn.Left
    defw KnPattern
    defb 4, 3

    defb Char.Wall
    defw WallPattern
    defb 1+4*4, 2

    defb 0ffh

InitVram: public InitVram
    ld hl,ColorTable
    do
        ld a,(hl) | inc hl
        cp 0ffh
    while nz
        ld e,(hl) | inc hl
        ld d,(hl) | inc hl
        ld c,(hl) | inc hl
        ld b,(hl) | inc hl
        call MakePatternMono
    wend

    ld a,Char.Chaser
    ld de,MonPattern
    ld c,4*2
    call MakePatternColor
ret


cseg
MapToVVram: public MapToVVram
    ld a,(BaseY)
    ld l,a
    ld h,0
    add hl,hl   ;*2
    add hl,hl   ;*4
    add hl,hl   ;*8 : map.step
    ld de,map
    add hl,de
    ld a,(BaseX)
    ld b,a
    srl a
    srl a
    srl a
    ld e,a
    ld d,0
    add hl,de
    ex de,hl
    ld c,1
    ld a,b
    and 07h
    do | while nz
        sla c
        dec a
    wend
    ld hl, VVram
    ld b, WindowHeight
    do
        push bc
            push de
                ld b, WindowWidth
                do
                    ld a,(de)
                    and c
                    if nz
                        ld (hl), Char.Wall
                    else
                        ld (hl), Char.Space
                    endif
                    inc hl
                    rlc c
                    if c
                        inc de
                    endif
                dwnz
            pop de
            ex de,hl
            ld bc, map.step
            add hl,bc
            ex de,hl
        pop bc
    dwnz
ret


Put2x2:
    public Put2x2
; in
;   a: index
;   h: y
;   l: x
; use: except ix, iy
    ex af,af'
        ld bc,202h
        ld de, (BaseX)
        ld a,l
        sub e
        if c
            inc a
            ret nz
            dec c
            ex af,af'
            inc a
            ex af,af'
        endif
        cp WindowWidth
        ret nc
        cp WindowWidth-1
        if z
            dec c
        endif
        ld l,a

        ld a,h
        sub d
        if c
            inc a
            ret nz
            dec b
            ex af,af'
            add a,2
            ex af,af'
        endif
        cp WindowHeight
        ret nc
        cp WindowHeight-1
        if z
            dec b
        endif
        ld h,a

        push bc
            ld c,l
            ld b,0
            ld l,h
            ld h,0
            add hl,hl   ;*2
            add hl,hl   ;*4
            add hl,hl   ;*8
            ld e,l
            ld d,h
            add hl,hl   ;*16
            add hl,de   ;*24
            ld de, VVram
            add hl, de
            add hl, bc
        pop bc
    ex af,af'
    ld de, WindowWidth
    do
        push bc
        push hl
        push af
            ld b,c
            pc4.5:
                ld (hl),a
                inc hl
                inc a
            djnz pc4.5
        pop af
        pop hl
        pop bc
        add hl,de
        add a,2
    dwnz
ret


Put1x1:
    public Put1x1
; in
;   a: index
;   h: y
;   l: x
; use: except ix, iy
    ex af,af'
        ld bc,202h
        ld de, (BaseX)

        ld a,l
        sub e
        ret c
        cp WindowWidth
        ret nc
        ld l,a

        ld a,h
        sub d
        ret c
        cp WindowHeight
        ret nc
        ld h,a

        ld c,l
        ld b,0
        ld l,h
        ld h,0
        add hl,hl   ;*2
        add hl,hl   ;*4
        add hl,hl   ;*8
        ld e,l
        ld d,h
        add hl,hl   ;*16
        add hl,de   ;*24
        ld de, VVram
        add hl, de
        add hl, bc
    ex af,af'
    ld (hl),a
ret


ClearVram:  public ClearVram
    ld hl,0c000h
    ld de,0c001h
    ld bc,4000h-1
    ld (hl),0
    ldir

    ld hl,backup
    ld bc,WindowWidth*WindowHeight
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret


Print1:
; in
;   a: char
;   de: vram address
; uses hl,de,bc,af,af'
    push de
        call PatternAddress
        ex de,hl
            ld b,8
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
                ld a,(de) | inc de
                ld (hl),a
                push bc
                    ld bc,800h-1
                    add hl,bc
                pop bc
            dwnz
        ex de,hl
    pop de
ret

Print1x1:   public Print1x1
    call Print1
ret


VVramToVram:    public VVramToVram
    ld de,VVram
    ld hl,backup
    exx
        ld de,Vram+XOffset
    exx
    ld c, WindowHeight ; vertical count    
    do
        ld b,WindowWidth
        do 
            push bc
                ld a,(de)
                inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Print1
                    exx
                endif
                exx
                    inc de
                    inc de
                exx
                inc hl
            pop bc
        dwnz
        exx
            ex de,hl
                ld bc,VramRowSize-WindowWidth*2
                add hl,bc
            ex de,hl
        exx
        dec c
    while nz | wend
ret 

Print2x2:   public Print2x2
; in
;   a: char
;   de: address
; use af
    push hl
    push bc
    push de
        ld c,2
        do
            ld b,2
            do
                push bc
                    push af
                        call Print1
                    pop af
                    inc de | inc de
                    inc a
                pop bc
            dwnz
            ex de,hl
                ld de, VramWidth-2*2
                add hl,de
            ex de,hl
            dec c
        while nz | wend
    pop de
    pop bc
    pop hl
    inc de | inc de | inc de | inc de
ret


PrintC: public PrintC
; in
;   de: address
;   a: char
; out
;   de: next address
; use af
    push hl | push bc
    add a,Char.Ascii-' '
    call Print1x1
    pop bc | pop hl
    inc de | inc de
ret 


PrintS: public PrintS
; in
;   hl: string
;   de: address
; out
;   de: next address
; use hl af
    do
        ld a,(hl) | inc hl
        or a
    while nz
        call PrintC
    wend
ret 
