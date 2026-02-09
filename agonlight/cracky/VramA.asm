include "Vram.inc"
include "Chars.inc"

ext MonoPattern, ColorPattern, SpritePattern
ext PollTimer_

TopY equ (240-CharHeight*VramHeight)/2

dseg
Vram_: public Vram_
    defs VramWidth*VramHeight
Backup0:
    defs VramWidth*VramHeight
Backup1:
    defs VramWidth*VramHeight
pBackup:
    defw 0
CmdBuffer:
    defs 410h
ColorBytes:
    defs 4*2
AplhaValue:
    defb 0

cseg
PaletteTable:
defb	00h, 00h, 00h, 5fh, 3fh, 0dfh, 0ffh, 00h
defb	00h, 0dfh, 9fh, 0dfh, 00h, 0ffh, 00h, 00h
defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 0ffh, 0ffh, 0ffh
defb	00h, 00h, 00h, 7fh, 7fh, 7fh, 0dfh, 9fh
defb	00h, 0bfh, 5fh, 5fh, 00h, 7fh, 00h, 00h
defb	5fh, 9fh, 0ffh, 0dfh, 3fh, 0bfh, 0bfh, 0bfh
ColorTable: public ColorBytes
defb 64, 7 ; Ascii
defb 16, 10 ; Logo
defb 1, 15 ; HardFloor
defb 2, 10 ; Ladder
defb 8, 15 ; CrackedFloor
defb 4, 14 ; Item
defb 0

CrateBitmapCmd:
defb 23,27,0,0
defb 23,27,1 | defw 8,8
CrateBitmapCmdLength equ 11

InitVram: public InitVram
    ld hl,CrateBitmapCmd
    ld de,CmdBuffer
    ld bc,CrateBitmapCmdLength
    ldir
    ld a,0ffh | ld (AplhaValue),a
    ld a,CharWidth | ld (CmdBuffer+7),a
    ld a,CharHeight | ld (CmdBuffer+9),a
    xor a | ld (CmdBuffer+3),a
    ; Mono BG
    ld hl,MonoPattern
    ld de,ColorTable
    do
        ld a,(de)
        or a
    while nz
        inc de
        ld b,a
        ld a,(de) | inc de
        push hl | push de
            push af
                ld hl,ColorBytes | call FillColorBytes
            pop af
            rrca | rrca | rrca | rrca
            ld hl,ColorBytes+4 | call FillColorBytes
        pop de | pop hl
        ld c,a
        do
            push de | push bc
                ld de,CmdBuffer+CrateBitmapCmdLength
                ld c,CharHeight
                do
                    ld a,(hl) | inc hl
                    push hl
                        ld b,CharWidth
                        do
                            rlca
                            if c
                                ld hl,ColorBytes
                            else
                                ld hl,ColorBytes+4
                            endif
                            push bc
                                ld bc,4
                                ldir
                            pop bc
                        dwnz
                    pop hl
                    dec c
                while nz | wend
                push hl
                    ld hl,CmdBuffer
                    ld bc,CrateBitmapCmdLength+256
                    defb 49h | rst 18h
                pop hl
            pop bc | pop de
            ld a,(CmdBuffer+3)
            inc a
            ld (CmdBuffer+3),a
        dwnz
    wend

    ; Color BG
    ld hl,ColorPattern
    ld c,Char_End-Char_Color
    do
        ld de,CmdBuffer+CrateBitmapCmdLength
        ld b,CharHeight
        do
            push bc
                ld c,CharWidth/2
                call BitmapRow
            pop bc
        dwnz
        push hl | push bc
            ld hl,CmdBuffer
            ld bc,CrateBitmapCmdLength+CharWidth*CharHeight*4
            defb 49h | rst 18h
        pop bc | pop hl
        ld a,(CmdBuffer+3)
        inc a
        ld (CmdBuffer+3),a
        dec c
    while nz | wend

    ; Sprite
    xor a | ld (AplhaValue),a
    ld a,SpriteWidth | ld (CmdBuffer+7),a
    ld a,SpriteHeight | ld (CmdBuffer+9),a

    ld hl,SpritePattern
    ld c,Pattern_End-Char_End
    do
        ld de,CmdBuffer+CrateBitmapCmdLength
        ld b,SpriteHeight
        do
            push bc
                ld c,SpriteWidth/2
                call BitmapRow
            pop bc
        dwnz
        push hl | push bc
            ld hl,CmdBuffer
            ld bc,CrateBitmapCmdLength+SpriteWidth*SpriteHeight*4
            defb 49h | rst 18h
        pop bc | pop hl
        ld a,(CmdBuffer+3)
        inc a
        ld (CmdBuffer+3),a
        dec c
    while nz | wend
ret
FillColorBytes:
    push de
        push af
            ld a,(AplhaValue) | ld e,a
        pop af
        and 0fh
        if nz
            ld e,0ffh
        endif
        push de
            ld e,a
            add a,a
            add a,e
            add a,low PaletteTable | ld e,a
            ld a,high PaletteTable | adc a,0 | ld d,a
            push bc
                ld b,3
                do
                    ld a,(de) | inc de
                    ld (hl),a | inc hl
                dwnz
            pop bc
        pop de
        ld (hl),e | inc hl
    pop de
ret
BitmapRow:
    do
        ld a,(hl) | inc hl
        push hl
            ld b,2
            do
                rrca | rrca | rrca | rrca
                push af
                    ld hl,ColorBytes | call FillColorBytes
                    push bc
                        ld hl,ColorBytes
                        push bc
                            ld bc,4
                            ldir
                        pop bc
                    pop bc
                pop af
            dwnz
        pop hl
        dec c
    while nz | wend
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
ClearScreen:
    ld a,12
    defb 49h | rst 10h
    ld a,16
    defb 49h | rst 10h
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        call ClearScreen
        call SwapScreen
        call ClearScreen
        call SwapScreen

        ld hl,Vram_
        ld bc,VramWidth*VramHeight
        call Clear

        ld hl,Backup0
        ld bc,VramWidth*VramHeight*2
        call Clear

        ld hl,Backup0 | ld (pBackup),hl
    pop bc | pop hl | pop af
ret


DrawCharCmd:
    defb 23,27,0,1
    defb 23,27,3 | defw 0,0
DrawCharCmdLength equ 11

; void PresentVram();
cseg
PresentVram_: public PresentVram_
    push af | push hl | push de | push bc
        ld hl,TopY | ld (DrawCharCmd+9),hl ; yPos
        ld de,Vram_
        ld hl,(pBackup)
        ld c,VramHeight
        do
            call PollTimer_

            xor a | ld (DrawCharCmd+7),a | ld (DrawCharCmd+8),a ; xPos
            ld b,VramWidth
            do
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    ld (DrawCharCmd+3),a
                    push hl | push de | push bc
                        ld hl,DrawCharCmd
                        ld bc,DrawCharCmdLength
                        ; di
                            defb 49h | rst 18h
                        ; ei
                    pop bc | pop de | pop hl
                endif
                inc hl
                push hl | push bc
                    ld hl,(DrawCharCmd+7)
                    ld bc,CharWidth | add hl,bc
                    ld (DrawCharCmd+7),hl
                pop bc | pop hl
            dwnz
            push hl | push bc
                ld hl,(DrawCharCmd+9)
                ld bc,CharHeight | add hl,bc
                ld (DrawCharCmd+9),hl
            pop bc | pop hl
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; void SwapScreen();
cseg
SwapScreenCmd:
    defb 23,0,0c3h
SwapScreenCmdLength equ 3

SwapScreen:
    ld hl,SwapScreenCmd
    ld bc,SwapScreenCmdLength
    defb 49h | rst 18h
ret
SwapScreen_: public SwapScreen_
    push af | push hl | push de | push bc
        call SwapScreen

        ld a,(pBackup+1)
        cp high Backup0
        if z
            ld hl,Backup1
        else
            ld hl,Backup0
        endif
        ld (pBackup),hl
    pop bc | pop de | pop hl | pop af
    call PollTimer_
ret


cseg
Mul40:
    ld c,a
    ld a,e
    add a,a ;*2
    add a,a ;*4
    add a,e ;*5
    ld l,a | ld h,0
    add hl,hl ;*10
    add hl,hl ;*20
    add hl,hl ;*40
    ld b,0
    add hl,bc
ret

; ptr<byte> VramPtr(byte x, byte y);
cseg
VramPtr_: public VramPtr_
    push af | push bc
        call Mul40
        ld bc,Vram_ | add hl,bc
    pop bc | pop af
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    ld (hl),e | inc hl
ret

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
PrintC_: public PrintC_
    push af
        ld a,e
        sub 20h
        ld (hl),a | inc hl
    pop af
ret


; void DrawSprite(byte x, byte y, byte pattern);
cseg
DrawSprite_: public DrawSprite_
    push af | push hl | push de | push bc
        ld l,a | ld h,0 ; xPos
        ld (DrawCharCmd+7),hl
        ld a,e ;yPos
        add a,TopY
        ld l,a | ld h,0
        ld (DrawCharCmd+9),hl
        ld a,c ; pattern
        ld (DrawCharCmd+3),a

        ld hl,DrawCharCmd
        ld bc,DrawCharCmdLength
        ; di
            defb 49h | rst 18h
        ; ei
    pop bc | pop de | pop hl | pop af
    call PollTimer_
ret


; void EraseBackup(byte x, byte y);
EraseBackup_: public EraseBackup_
    push af | push bc
        ld bc,0202h
        ld d,a
        and 7
        if nz
            inc b
        endif
        ld a,e
        and 7
        if nz
            inc c
        endif
        ld a,d
        srl a | srl a | srl a
        srl e | srl e | srl e
        push bc
            call Mul40
            ld de,(pBackup) | add hl,de
        pop bc
        do
            push hl
                ld a,b
                do
                    ld (hl),0ffh | inc hl
                dwnz
                ld b,a
            pop hl
            push bc
                ld bc,VramWidth | add hl,bc
            pop bc
            dec c
        while nz | wend
    pop bc | pop af
    call PollTimer_
ret
