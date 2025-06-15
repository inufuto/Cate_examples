include "BIOS.inc"
include "Vram.inc"
include "Chars.inc"

ext MonoPattern
ext BlockPattern, UfoPattern
ext UfoRowCenterXd_
ext Ground_

dseg
Reg2Value:
    defb 0
Reg4Value:
    defb 0

cseg
ColorSource:
defb 8, 0f0h ; Ascii
defb 2, 70h ; Logo
defb 1, 0e0h ; Remain
defb 3, 70h ; BlockA
defb 3, 90h ; BlockB
defb 3, 0b0h ; BlockC
defb 0

cseg
InitVram: public InitVram
    call INIT32
    xor a
    ld (BDRCLR),a
    call CHGCLR

    ld hl,MonoPattern
    ld de,Vram_PatternGenerator
    ld bc,CharHeight*Char_BlockA
    call LDIRVM

    ld de,Vram_PatternGenerator+CharHeight*Char_BlockA
    ld hl,BlockPattern
    ld b,3
    do
        push bc
            push hl | push de
                ld bc,CharHeight*4*2
                call LDIRVM
            pop de | pop hl
            ld bc,CharHeight*4
            add hl,bc
            ex de,hl
                ld bc,CharHeight*24
                add hl,bc
            ex de,hl
        pop bc
    dwnz

    ld hl,Vram_PatternGenerator2
    exx
        ld hl,Vram_PatternGenerator
    exx
    ld bc,CharHeight*Char_End
    do
        exx
            call RDVRM
            inc hl
        exx
        call WRTVRM
        inc hl
        dec bc
        ld a,c | or b
    while nz | wend

    ld hl,Vram_Color
    ld de,ColorSource
    do
        ld a,(de)
        or a
    while nz
        ld b,a
        inc de
        ld a,(de)
        inc de
        do
            push af
                call WRTVRM
            pop af
            inc hl
        dwnz
    wend
ret


; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram_PatternName
        ld bc,300h
        xor a
        call FILVRM

        ld hl,Vram_PatternName2
        ld bc,300h
        xor a
        call FILVRM

        ld a,07h | ld (Reg2Value),a
        ld bc,0602h | call WRTVDP
        ld a,01h | ld (Reg4Value),a
        ld bc,0004h | call WRTVDP
    pop bc | pop hl | pop af
ret


; ; word VramAddress(byte x, byte y);
; VramAddress_: public VramAddress_
;     push de
;         ld l,e
;         ld h,0
;         add hl,hl ;*2
;         add hl,hl ;*4
;         add hl,hl ;*8
;         add hl,hl ;*16
;         add hl,hl ;*32
;         ld e,a
;         ld d,0
;         add hl,de
;         ld de,Vram
;         add hl,de
;     pop de
; ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    ex af,af'
        ld a,e
        call WRTVRM
        inc h | inc h | inc h | inc h
        call WRTVRM
        dec h | dec h | dec h | dec h
        inc hl
    ex af,af'
ret



; void UpdateChars();
cseg
UpdateChars_: public UpdateChars_
    push af | push hl | push de | push bc
        ld a,(VdpOutPort) | ld c,a
        exx
            ld c,a | inc c
            ld a,(Reg4Value)
            or a
            if z
                ld hl,4000h+Vram_PatternGenerator+(Char_BlockA+4)*CharHeight
            else
                ld hl,4000h+Vram_PatternGenerator2+(Char_BlockA+4)*CharHeight
            endif
        exx
        ld a,(UfoRowCenterXd_)
        neg
        add a,8
        ld b,a

        ld hl,UfoPattern
        ld d,3
        do
                di
                    exx
                        out (c),l
                        out (c),h
                    exx
                    ld e,14*CharHeight
                    do
                        push de | push bc
                            ld d,(hl) | inc hl
                            ld e,(hl) | inc hl
                            ld a,b
                            or a
                            if nz
                                do
                                    sla e
                                    rl d
                                dwnz
                            endif
                            out (c),d
                        pop bc | pop de
                        dec e
                    while nz | wend
                ei
                exx
                    ld de,CharHeight*24
                    add hl,de
                exx
            dec d
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SwitchChars();
cseg
SwitchChars_: public SwitchChars_
    push af | push bc
        ld a,(Reg4Value)
        ld b,a
        xor 1
        ld (Reg4Value),a
        ld c,4 | call WRTVDP
    pop bc | pop af
ret


; word CurrentPage();
cseg
CurrentPage_: public CurrentPage_
    push af
        ld a,(Reg2Value)
        cp 6
        if z
            ld hl,Vram_PatternName
        else
            ld hl,Vram_PatternName2
        endif
    pop af
ret


; void SwitchPage();
cseg
SwitchPage_: public SwitchPage_
    push af | push bc
        ld a,(Reg2Value)
        ld b,a
        xor 1
        ld (Reg2Value),a
        ld c,2 | call WRTVDP
    pop bc | pop af
ret


; void WriteVram(word vram, byte c);
cseg
WriteVram_: public WriteVram_
    push af
        ld a,e
        call WRTVRM
    pop af
ret


; void CopyToVram(word vram, ptr<byte> pBytes, byte count);
cseg
CopyToVram_: public CopyToVram_
    push af | push hl | push de | push bc
        ld b,0
        ex de,hl
        call LDIRVM
    pop bc | pop de | pop hl | pop af
ret


Ground_BlockMask equ 03h
Ground_BombMask equ 0ch

; void DrawBackground();
dseg
RowBuff:
    defs VramWidth*2
cseg
DrawBackground_: public DrawBackground_
    push af | push hl | push de | push bc | push ix
        ld hl,Ground_
        ld ix,RowBuff
        ld b,VramWidth
        do
            ld c,(hl) | inc hl
            ld a,c | and Ground_BombMask
            if nz
                rrca | rrca
                dec a
                add a,Char_BlockC
                jr DrawBackground_write
            endif
            ld a,c | and Ground_BlockMask
            if nz
                dec a
                add a,Char_BlockA
                DrawBackground_write:
                ld (ix),a
                inc a | inc a
                ld (ix+VramWidth),a
            else
                xor a
                ld (ix),a
                ld (ix+VramWidth),a
            endif
            inc ix
        dwnz

        call CurrentPage_
        ld bc,VramWidth*2
        add hl,bc
        ld e,6
        do
            xor a
            ld bc,VramWidth*2+1
            call FILVRM
            ld bc,VramWidth*3
            add hl,bc
            dec e
        while nz | wend

        ld bc,VramWidth*2
        add hl,bc
        ld de,RowBuff
        ex de,hl
        ld bc,VramWidth*2
        call LDIRVM
    pop ix | pop bc | pop de | pop hl | pop af
ret
