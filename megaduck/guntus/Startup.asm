include "MegaDuck.inc"
include "Vram.inc"

ext InitVram
ext InitSound, SoundHandler
ext InitSprites
ext Main_
ext ModeValue

dseg
TimerCount: public TimerCount
    defb 0

cseg
jp Startup
    defs 40h-3
INT40: public INT40
    jp VBlankHandler
    defs 8-3
INT48: public INT48
    ; jp StatHandler
    defs 8
INT50: public INT50
    jp TimerHandler
    defs 0b0h-3
Startup: public Startup
    di
    ld sp,0dff0h
    xor a,a | ldh (IE),a | ldh (LCDC),a

    ld hl,DMAProcBegin
    ld de,HRAM
    ld b,DMAProcEnd-DMAProcBegin
    do
        ld a,(hl+)
        ld (de),a | inc de
        dec b
    while nz|wend

    ld a,77h | ldh (rAUDVOL),a
    ld a,0ffh | ldh (rAUDTERM),a
    ld a,8fh | ldh (rAUDENA),a
   
    call InitVram
    call InitSound
    call InitSprites

    ld a,-68 | ldh (TMA),a
    ld a,04h | ldh (TAC),a
    ld a,40h | ldh (STAT),a
    ld a,16-1 | ldh (LYC),a
    ld a,05h | ldh (IE),a
    xor a,a | ldh (SCX),a
    xor a,a | ldh (SCY),a
    ei
jp Main_

DMAProcBegin:
    ld a,high ObjSource | ldh (DMA),a
    ld a,40
    do
        dec a
    while nz|wend
ret
DMAProcEnd:

VBlankHandler:
    push af
        ld a,(ModeValue) | ldh (LCDC),a
        call HRAM
    pop af
    ei
reti

; StatHandler:
;     push af
;         do
;             ldh a,(STAT)
;             bit 1,a
;         while nz|wend
;     pop af
;     ei
; reti

TimerHandler:
    push af
        ld a,(TimerCount)
        or a,a
        if nz
            dec a
            ld (TimerCount),a
        endif
        call SoundHandler
    pop af
    ei
reti


WaitTimer_: public WaitTimer_
    push af
        ld (TimerCount),a
        do
            ld a,(TimerCount)
            or a,a
        while nz | wend
    pop af
ret
