include "Share.inc"
include "Sub.inc"
include "Chars.inc"

ext CmdLoop

dseg
PatternRam: public PatternRam
    defs PatternSize*(Char_End-Char_Sprite)
PatternRamEnd: public PatternRamEnd

cseg
WaitG:
    push af
        do
            in a,(GGdcStatusPort)
            and 2
        while nz | wend
    pop af
ret
SendGCmd:
    call WaitG
    out (GGdcCmdPort),a
ret
SendGParam:
    call WaitG
    out (GGdcParamPort),a
ret

SetAddress: ;(hl)
    ld a,CursCmd | call SendGCmd
    ld a,l | out (GGdcParamPort),a
    ld a,h | out (GGdcParamPort),a
    ; xor a | out (GGdcParamPort),a
ret


ClearVram: public ClearVram
    ld hl,0 | call SetAddress

    ld a,MaskCmd | call SendGCmd
    ld a,0ffh | call SendGParam | call SendGParam
    
    ld a,FigsCmd | call SendGCmd
    ld a,2 | call SendGParam
        
    ld a,WDatCmd | call SendGCmd

    ld de,4000h*PlaneCount*2/4
    do
        call WaitG
        xor a
        ld b,4
        do
            out (GGdcParamPort),a
        dwnz
        dec de
        ld a,e | or d
    while nz | wend
jp CmdLoop

DefChar: public DefChar
    ld a,(SubShareRam+Share_Char)
    call PatternPtrDe
    ld hl,SubShareRam+Share_Pattern
    ld bc,PatternSize
    ldir
jp CmdLoop
PatternPtrDe: ; a=char code
    ld l,a | ld h,0
    ld e,l | ld d,h
    add hl,hl ;*2
    add hl,de ;*3
    add hl,hl ;*6
    add hl,hl ;*12
    add hl,hl ;*24
    add hl,hl ;*48
    ld de,PatternRam-(PatternSize*Char_Sprite) | add hl,de
    ex de,hl
ret

DrawChar1: public DrawChar1
    ld de,SubShareRam+Share_Pattern
    jr DrawChar
DrawChar2: public DrawChar2
    ld a,(SubShareRam+Share_Char)
    call PatternPtrDe
DrawChar:    
    ld hl,(SubShareRam+Share_Address)
    ld c,PlaneCount
    do
        push hl
            ld a,FigsCmd | call SendGCmd
            xor a | out (GGdcParamPort),a

            call SetAddress

            ld a,MaskCmd | call SendGCmd
            ld a,0ffh | out (GGdcParamPort),a | out (GGdcParamPort),a
            ld a,WDatCmd | call SendGCmd
            xor a
            ld b,CharHeight*2
            do
                call WaitG
                out (GGdcParamPort),a
                out (GGdcParamPort),a
            dwnz

            call SetAddress

            ld b,CharHeight
            do
                ld a,MaskCmd | call SendGCmd
                ld a,(de) | inc de
                out (GGdcParamPort),a
                ld a,(de) | inc de
                out (GGdcParamPort),a

                ld a,WDatCmd | call SendGCmd
                ld a,0ffh
                out (GGdcParamPort),a
                out (GGdcParamPort),a
                out (GGdcParamPort),a
                out (GGdcParamPort),a
            dwnz
        pop hl
        ld a,h | add a,40h | ld h,a
        dec c
    while nz | wend
jp CmdLoop