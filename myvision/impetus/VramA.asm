include "kh1000.inc"
include "Vram.inc"
include "Chars.inc"

ext WRTVRM, RDVRM, LDIRVM, FILVRM, SetVdpAddressDE, SetVdpAddressHL, InitVdp
ext Chars, SpritePattern
ext VVram_, RowFlags_, Status_

dseg
CurrentPage_: public CurrentPage_
    defw 0
NextPage_: public NextPage_
    defw 0

cseg
ColorSource:
	defb 64, 0f0h
	defb 16, 70h
	defb 4, 0f0h
	defb 8, 0a0h
	defb 84, 70h
    defb 0

cseg
InitVram: public InitVram
    push af | push hl | push de | push bc
        call InitVdp

        ld hl,Chars
        ld de,Vram_PatternGenerator
        ld bc,(Char_Barrier-0)*CharHeight
        call LDIRVM

        ld hl,Vram_PatternGenerator+Char_Barrier*CharHeight
        ld b,8
        do
            ld a,8
            sub b
            if nz
                ld c,a
                do
                    xor a
                    call WRTVRM
                    inc hl
                    dec c
                while nz | wend
            endif
            
            ld a,0ffh
            call WRTVRM
            inc hl
            
            ld a,b
            dec a
            if nz
                ld c,a
                xor a
                do
                    call WRTVRM
                    inc hl
                    dec c
                while nz | wend
            endif
        dwnz

        ld hl,Vram_Color
        ld de,ColorSource
        do
            ld a,(de)
            or a
        while nz
            ld c,a
            inc de
            ld a,(de)
            inc de
            do
                ld b,8
                do
                    push af
                        call WRTVRM
                    pop af
                    inc hl
                dwnz
                dec c
            while nz | wend
        wend

        ld hl,Vram_PatternGenerator+800h
        exx
            ld hl,Vram_PatternGenerator
        exx
        ld c,2
        do
            ld b,2
            do
                ld de,800h
                do
                    exx
                        call RDVRM
                        inc hl
                    exx
                    call WRTVRM
                    inc hl
                    dec de
                    ld a,e
                    or d
                while nz | wend
            dwnz
            ld hl,Vram_Color+800h
            exx
                ld hl,Vram_Color
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret

cseg
WriteR2: ; (a)
    di
        ld b,80h or 2
        ld (VdpAddress+2),a
        ld a,b
        ld (VdpAddress+2),a
    ei
ret

; void ClearScreen();
cseg
ClearScreen_:
    public ClearScreen_
    push af | push de | push bc
        ld hl,Vram_PatternName0
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        ld hl,Vram_PatternName1
        ld bc,VramHeight*VramWidth
        xor a
        call FILVRM

        ld a,06h | call WriteR2
        ld hl,Vram_PatternName0 | ld (CurrentPage_),hl
        ld hl,Vram_PatternName1 | ld (NextPage_),hl
    pop bc | pop de | pop af
ret


; word VramOffset(byte x, byte y);
VramOffset_: public VramOffset_
    push de
        ld l,e
        ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,a
        ld d,0
        add hl,de
    pop de
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
WriteVram_: public WriteVram_
    ex af,af'
        ld a,e
        call WRTVRM
    ex af,af'
    inc hl
ret


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    ex af,af'
        ld a,e
        sub ' '
        call WRTVRM
    ex af,af'
    inc hl
ret


; void StatusToVram();
StatusToVram_: public StatusToVram_
cseg
    push af | push hl | push de | push bc
        ld de,Status_
        ld hl,(NextPage_)
        ld b,VramWidth*2
        do
            ld a,(de) | inc de
            or a
            if nz
                call WRTVRM
            endif
            inc hl
        dwnz
    pop bc | pop de | pop hl | pop af
ret


; void SwitchVram();
SwitchVram_: public SwitchVram_
    push af | push hl | push bc
        ld hl,(NextPage_)
        ld (CurrentPage_),hl
        ld a,h
        cp high Vram_PatternName0
        if z
            ld a,06h | 
            ld hl,Vram_PatternName1
        else
            ld a,07h
            ld hl,Vram_PatternName0
        endif
        ld (NextPage_),hl
        call WriteR2
    pop bc | pop hl | pop af
ret