include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

VramTop equ Vram+VramWidth*StatusHeight

ext @Temp@Word
ext @Temp@word2
ext @Temp@Word3
ext @Temp@Word4
ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3

pVVram equ @Temp@Word
pVram equ @Temp@Word2
pBackup equ @Temp@Word3
xCount equ @Temp@Byte
yCount equ @Temp@Byte2
charGen equ @Temp@Byte3
pSource equ @Temp@Word
pDestination equ @Temp@Word2
pColor equ @Temp@Word4

dseg
CharColors: public CharColors
    defs 256
Backup:
    defs VVramWidth*VVramHeight


cseg
ColorSource:
defb 16,Char_Wall,$41 ; Wall
defb 16,Char_Monster,$43 ; Monster
defb 4,Char_FireBullet,$42 ; FireBullet
defb 4,Char_Fire,$42 ; Fire
defb 4,Char_Dot,$46 ; Dot
defb 4,Char_Food,$46 ; Food
defb 4,Char_Man,$47 ; Man
defb 4,Char_Remain,$47 ; Remain
defb 0
InitVram: public InitVram
    ldaa #$07
    ldx #CharColors
    do
        staa 0,x | inx
        cpx #CharColors+256
    while ne | wend

    ldx #ColorSource | stx <pSource
    do
        ldx <pSource
        ldab 0,x
    while ne
        inx
        stx <pSource
        pshb
            ldaa 0,x | inx
            clrb
            adda #low CharColors | adcb #high CharColors
            staa <pDestination+1 | stab <pDestination
           
            ldaa 0,x | inx
        pulb
        stx <pSource
        ldx <pDestination
        do
            staa 0,x | inx
            decb
        while ne | wend
    wend

    ldx #CharPattern+CharHeight*Pattern_Wall | stx <pSource
    ldx #CharGen0+CharHeight*(Char_Wall) | stx <pDestination
    ldab #Char_Monster-Char_Wall
    bsr CopyBytes

    ldx #CharPattern+CharHeight*Pattern_FireBullet | stx <pSource
    ldx #CharGen1+CharHeight*(Char_FireBullet-$80) | stx <pDestination
    ldab #Char_End1-Char_FireBullet
    bsr CopyBytes
rts

CopyBytes:
    do
        pshb
            ldab #8
            do
                ldx <pSource
                ldaa 0,x | inx
                stx <pSource

                ldx <pDestination
                staa 0,x | inx
                stx <pDestination
        
                decb
            while ne | wend
        pulb
        decb
    while ne | wend
rts


; void SetPattern(byte c, byte pattern, byte count);
dseg
SetPattern_@Param1: public SetPattern_@Param1
    defb 0
SetPattern_@Param2: public SetPattern_@Param2
    defb 0
cseg
SetPattern_: public SetPattern_
    psha | pshb
        suba #$80
        if cc
            ldab #high CharGen1
            stab <charGen
        else
            adda #$80
            ldab #high CharGen0
            stab <charGen
        endif
        clrb
        asla | rolb ;*2
        asla | rolb ;*4
        asla | rolb ;*8
        addb <charGen
        staa <pDestination+1 | stab <pDestination

        ldaa SetPattern_@Param1
        clrb
        asla | rolb ;*2
        asla | rolb ;*4
        asla | rolb ;*8
        adda #low CharPattern | adcb #high CharPattern
        staa <pSource+1 | stab <pSource

        ldab SetPattern_@Param2
        bsr CopyBytes
    pulb | pula
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    psha
        ldx #Vram
        do
            clr 0,x | inx
            cpx #Vram+VramRowSize*VramHeight
        while ne | wend

        ldaa #$07
        ldx #Attr
        do
            staa 0,x | inx
            cpx #Attr+VramRowSize*VramHeight
        while ne | wend

        ldaa #Char_Space
        ldx #Backup
        do
            staa 0,x | inx
            cpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        ldx #VVramBack_
        do
            staa 0,x | inx
            cpx #VVramBack_+VVramWidth*VVramHeight*2
        while ne | wend
    pula
rts


; void Put(ptr<byte> pVram, byte c, byte color);
dseg
Put_@Param0: public Put_@Param0
Put_pVram:
    defw 0
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
Put_@Param2: public Put_@Param2
Put_color:
    defb 0
cseg
Put_: public Put_
    psha
        ldx Put_pVram
        ldaa Put_c
        staa 0,x
        stx <pVram

        ldaa <pVram | adda #$04 | staa <pVram
        ldx <pVram
        ldaa Put_color
        staa 0,x
        ldx Put_pVram
        inx
    pula
rts


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
dseg
PrintC_@Param0: public PrintC_@Param0
PrintC_pVram:
    defw 0
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
    defw 1
cseg
PrintC_: public PrintC_
    psha
        ldx PrintC_pVram
        ldaa PrintC_c
        staa 0,x
        stx <pVram
        ldaa <pVram | adda #$04 | staa <pVram
        ldaa #$07 | ldx <pVram | staa 0,x
        ldaa <pVram | adda #-$04 | staa <pVram
        ldx <pVram
        inx
    pula
rts


; void VVramToVram();
cseg
VVramToVram_:　public VVramToVram_
    psha | pshb
        ldx #VramTop | stx <pVram
        ldx #Backup | stx <pBackup
        ldx #VVramFront_ | stx <pVVram
        ldab #VVramHeight | stab <yCount
        do
            ldab #VVramWidth
            stab <xCount
            do
                ldx <pVVram | ldaa 0,x | inx | stx <pVVram
                ldx <pBackup | cmpa 0,x
                if ne
                    staa 0,x
                    ldx <pVram | staa 0,x
                    staa VVramToVram_load+1
                    ldx #CharColors
                    VVramToVram_load:
                    ldab 0,x
                    ldaa <pVram | adda #$04 | staa <pVram
                    ldx <pVram | stab 0,x
                    ldaa <pVram | adda #-$04 | staa <pVram
                endif    
                ldx <pVram | inx | stx <pVram
                ldx <pBackup | inx | stx <pBackup
                dec <xCount
            while ne | wend
            dec <yCount
        while ne | wend
    pulb | pula
rts
