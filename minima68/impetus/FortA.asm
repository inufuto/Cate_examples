include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

Width equ 6
Height equ 6+1
BytesPerRow equ CharWidth/2
CharPatternSize equ BytesPerRow*CharHeight

ext FortPattern
ext FortY_, FortCharOffset_

scope
pUpper equ @Temp@Word
pLower equ @Temp@Word2
pDestination equ @Temp@Word3
upperCount equ @Temp@Byte
lowerCount equ @Temp@Byte2
; upperCount6 equ @Temp@Byte3
; lowerCount6 equ @Temp@Byte4

; void UpdateFortChars();
cseg
UpdateFortChars_: public UpdateFortChars_
    psha | pshb
        ldx #FortPattern | stx pLower
        ldaa FortCharOffset_
        if eq
            ldx #CharPatternRam+CharPatternSize*Char_Fort
        else
            ldx #CharPatternRam+CharPatternSize*Char_FortAlter
        endif
        stx pDestination

        ldaa FortY_
        anda #3
        asla | asla ;*BytesPerRow*2
        staa upperCount
        ; asla | adda upperCount
        ; staa upperCount6
        ldaa #CharPatternSize
        suba upperCount
        staa lowerCount
        ; ldaa #CharPatternSize
        ; suba upperCount6
        ; staa lowerCount6

        ;top
        ldab #Width
        do
            pshb
                ldab upperCount
                if ne
                    ldx pDestination
                    do
                        clr 0,x | inx
                        decb
                    while ne | wend
                    stx pDestination
                endif
                bsr CopyLower
            pulb
            decb
        while ne | wend

        ; middle
                    _deb: public _deb
        ldaa #low FortPattern | adda lowerCount | staa pUpper+1
        ldaa #high FortPattern | adca #0 | staa pUpper
        ldab #6*5
        do
            pshb
                bsr CopyUpper
                bsr CopyLower
            pulb
            decb
        while ne | wend

        ;bottom
        ldab #Width
        do
            pshb
                bsr CopyUpper
                ldx pDestination
                ldab lowerCount
                do
                    clr 0,x | inx
                    decb
                while ne | wend
                stx pDestination
                ldaa pLower+1 | adda lowerCount | staa pLower+1
                ldaa pLower | adca #0 | staa pLower
            pulb
            decb
        while ne | wend
    pulb | pula
rts
CopyLower: public CopyLower
    ldab lowerCount
    do
        ldx pLower | ldaa 0,x | inx | stx pLower
        ldx pDestination | staa 0,x | inx | stx pDestination
        decb
    while ne | wend
    ldaa pLower+1 | adda upperCount | staa pLower+1
    ldaa pLower | adca #0 | staa pLower
rts
CopyUpper: public CopyUpper
    ldab upperCount
    if ne
        do
            ldx pUpper | ldaa 0,x | inx | stx pUpper
            ldx pDestination | staa 0,x | inx | stx pDestination
            decb
        while ne | wend
    endif
    ldaa pUpper+1 | adda lowerCount | staa pUpper+1
    ldaa pUpper | adca #0 | staa pUpper
rts
endscope
