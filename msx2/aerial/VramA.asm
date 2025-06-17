include "BIOS.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext MonoPattern, ColorPattern, SpritePattern

CharSourceY equ 192
CharVram equ CharSourceY*128

dseg
Backup: public Backup
Backup0:
	defs VVramWidth*VVramHeight
Backup1:
	defs VVramWidth*VVramHeight
pBackup:
	defw 0
Page:
	defw 0


cseg
PaletteValues:
defb	00h, 00h, 07h, 00h, 70h, 00h, 77h, 03h
defb	00h, 07h, 06h, 06h, 70h, 07h, 77h, 07h
defb	00h, 00h, 63h, 05h, 61h, 00h, 52h, 03h
defb	55h, 06h, 03h, 03h, 72h, 04h, 44h, 04h
ColorTable:
defb 64, 07h ; Ascii
defb 16, 0bh ; Logo
defb 0
cseg
InitVram: public InitVram
    xor a | ld (BDRCLR),a
    call CHGCLR

    ld a,5 | call CHGMOD
    ld bc,0a08h | call WRTVDP
    ld bc,0009h | call WRTVDP

    ld hl,PaletteValues
    ld d,0
    ld b,16
    do
        ld a,(hl) | inc hl
        ld e,(hl) | inc hl
        push hl | push de | push bc
            ld ix,SETPLT | call EXTROM
        pop bc | pop de | pop hl
        inc d
    dwnz

    ld bc,010eh | call WRTVDP
    xor a
    ld de,MonoPattern
    ld hl,ColorTable
    do  
        ld b,(hl)
        inc b | dec b
    while nz
        inc hl
        ld c,(hl)
        inc hl
        do
            call MakePatternMono
            inc a
        dwnz
        add a,b
    wend

    ld de,ColorPattern
    do
        call MakePatternColor
        inc a
        cp Char_End
    while c | wend

    xor a
    ld de,SpritePattern
    do
        call MakeSpritePattern
        inc a
        cp Pattern_End
    while c | wend
ret

ToCharPatternAddress: ; a->hl
    push de
        ld l,a
        and 1fh
        add a,a ;*2    
        add a,a ;*4
        ld e,a | ld d,0
        ld a,l
        and 0e0h
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,de
        ld de,CharVram | add hl,de
    pop de
ret

MakePatternMono:
    push af | push hl | push bc
        call ToCharPatternAddress
        ld a,c
        exx
            ld d,a
            and 0fh
            ld e,a
            srl d | srl d | srl d | srl d
        exx
        ld c,CharHeight
        do
            ld a,(de) | inc de
            push de
                ld e,a
                ld b,VramStep
                do
                    ld d,2
                    do
                        exx
                            sla c | sla c | sla c | sla c
                        exx
                        sla e
                        if c
                            exx
                                ld a,c
                                or e
                                ld c,a
                            exx
                        else
                            exx
                                ld a,c
                                or d
                                ld c,a
                            exx
                        endif
                        dec d
                    while nz | wend
                    exx
                        ld a,c
                    exx
                    call NWRVRM | inc hl
                dwnz
                ld de,VramWidth-VramStep
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret

MakePatternColor:
    push af | push hl | push bc
        call ToCharPatternAddress
        ld c,CharHeight
        do
            ld b,VramStep
            do
                ld a,(de) | inc de
                call NWRVRM | inc hl
            dwnz
            push de
                ld de,VramWidth-VramStep
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret

ToSpritePatternAddress: ; a->hl
    push de
        ld l,a
        and 0fh
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        ld e,a | ld d,0
        ld a,l
        and 0f0h
        ld l,a | ld h,0
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        add hl,hl ;*64
        add hl,hl ;*128
        add hl,de
        ld de,SpriteVram | add hl,de
    pop de
ret

MakeSpritePattern:
    push af | push hl | push bc
        call ToSpritePatternAddress
        ld c,CharHeight*2
        do
            ld b,VramStep*2
            do
                ld a,(de) | inc de
                call NWRVRM | inc hl
            dwnz
            push de
                ld de,VramWidth-VramStep*2
                add hl,de
            pop de
            dec c
        while nz | wend
    pop bc | pop hl | pop af
ret



; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,0000h
        ld bc,VramRowSize*VramHeight
        xor a
        call FILVRM

        ld hl,8000h
        ld bc,VramRowSize*VramHeight
        xor a
        call FILVRM

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight*2
        call Clear

        ld hl,Backup1 | ld (pBackup),hl
        ld a,1 | ld (Page),a
        ld bc,1f02h | call WRTVDP
    pop bc | pop hl | pop af
ret


; VdpStatus: ;s#b
;     push bc
;         ld bc,(VdpOutPort)
;         inc c
;         out (c),a
;         ld a,15 or 80h
;         out (c),a
;         ld a,(VdpInPort) | ld c,a
;         inc c
;         in a,(c)
;     pop bc
; ret

WaitVdp:
    push bc
        di
            ld a,(VdpOutPort) | ld c,a | inc c
            ld a,2 | out (c),a
            ld a,15 or 80h | out (c),a
            ld a,(VdpInPort) | ld c,a | inc c
            do
                in a,(c)
                and 1
            while nz | wend
            ld a,(VdpOutPort) | ld c,a | inc c
            xor a | out (c),a
            ld a,15 or 80h | out (c),a
        ei
    pop bc
ret

Put: ; (i=page, h=dy, l=dx, a=code)
    push bc
        call WaitVdp
        ld a,(VdpOutPort) | ld c,a
        inc c
        di
            ld a,32 | out (c),a
            ld a,17 or 80h | out (c),a
            inc c | inc c
            xor a
            out (c),e | out (c),a ; sx
            out (c),d | out (c),a ; sy
            out (c),l | out (c),a ; dx
            ld a,i
            out (c),h | out (c),a ; dy
            xor a
            ld b,8
            out (c),b | out (c),a ; nx
            out (c),b | out (c),a ; ny
            out (c),a | out (c),a ; arg
            ld a,0d0h | out (c),a ; command
        ei
    pop bc
ret

SourceCharYX: ; (a=>de)
    ld e,a
    rrca | rrca
    and 038h
    add a,CharSourceY
    ld d,a
    ld a,e
    rlca | rlca | rlca
    and 0f8h
    ld e,a
ret

; word Put(word yx, byte c);
cseg
Put_: public Put_
    push af
        push de
            ld a,e
            call SourceCharYX
            xor a | ld i,a
            do
                call Put
                ld a,i | inc a | ld i,a
                cp 2
            while c | wend
        pop de
        ld a,l | add a,8 | ld l,a
        ld a,h | adc a,0 | ld h,a
    pop af
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld a,(Page) | ld i,a
        ld de,VVram_
        ld hl,(pBackup)
        exx
            ld hl,1000h
        exx
        ld c, VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call SourceCharYX
                        call Put
                    exx
                endif
                inc hl
                exx
                    ld a,l | add a,8 | ld l,a
                exx
            dwnz
            exx
                ld a,h | add a,8 | ld h,a
                ld l,0
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SwitchVram();
cseg
SwitchVram_: public SwitchVram_
    push af | push hl | push bc
        ld a,(Page)
        or a
        if nz
            xor a
            ld hl,Backup0
            ld bc,3f02h
        else
            inc a
            ld hl,Backup1
            ld bc,1f02h
        endif
        ld (Page),a
        ld (pBackup),hl
        call WRTVDP
    pop bc | pop hl | pop af
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    push af | push hl | push de | push bc
        ld bc,0202h
        
        ld d,a
        and 1
        if nz
            inc b
        endif
        ld a,d
        rrca | and 1fh | ld d,a

        ld a,e
        and 1
        if nz
            inc c
        endif
        ld a,e
        and 0feh
        ld l,a | ld h,0
        add hl,hl ;*4
        add hl,hl ;*8
        add hl,hl ;*16
        add hl,hl ;*32
        ld e,d | ld d,0
        add hl,de
        ld de,(pBackup) | add hl,de

        ex af,af' | ld a,b | ex af,af'
        ld de,VVramWidth
        do
            push hl
                ex af,af' | ld b,a | ex af,af'
                ld a,0ffh
                do
                    ld (hl),a | inc hl
                dwnz
            pop hl
            add hl,de
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        add a,a
        add a,a
        ld l,a

        ld a,e
        add a,a
        add a,a
        add a,16
        ld h,a

        ld b,16
        ld a,c
        cp Pattern_MyBullet
        if nc
            srl b
        endif
        ; rrca
        and 0f0h
        add a,192
        ld d,a
        ld a,c
        rlca | rlca | rlca | rlca
        and 0f0h
        ld e,a

        ld a,(Page) | ld i,a
        call WaitVdp
        ld a,(VdpOutPort) | ld c,a
        inc c
        di
            ld a,32 | out (c),a
            ld a,17 or 80h | out (c),a
            inc c | inc c
            xor a
            out (c),e | out (c),a ; sx
            inc a
            out (c),d | out (c),a ; sy
            xor a
            out (c),l | out (c),a ; dx
            ld a,i
            out (c),h | out (c),a ; dy
            xor a
            out (c),b | out (c),a ; nx
            out (c),b | out (c),a ; ny
            out (c),a | out (c),a ; arg
            ; ld a,0d0h | out (c),a ; command
            ld a,98h | out (c),a ; command
        ei
    pop bc | pop de | pop hl | pop af
ret
