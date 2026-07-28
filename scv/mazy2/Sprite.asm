include "Vram.inc"

SpriteLeft equ LeftOrgin*CharWidth+4
SpriteTop equ TopOrgin*CharHeight*2-2


; ptr<byte> SpritePtr(byte index);
cseg
SpritePtr_: public SpritePtr_
    push b
        mvi c,0
        shal | rcl
        shal | rcl
        mov l,a
        mov a,c
        adi a,high Attribute
        mov h,a
    pop b
ret

WaitBlank:
    do
    while offi mk,20h | wend
ret

ShowSprite: ; a,d,e,b,c
    push b
        mvi c,0
        shal | rcl ;*2
        shal | rcl ;*4
        mov l,a
        mov a,c
        adi a,high Attribute
        mov h,a
        mov h,a
    pop b
    call WaitBlank
    mov a,e ; y
    adi a,SpriteTop
    ; ori a,01h
    stax h+

    mov a,c ; color
    stax h+

    mov a,d ; x
    adi a,SpriteLeft
    ani a,0feh
    stax h+

    mov a,b ; pattern
    stax h
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSprite_: public ShowSprite_
    push v | push h | push d | push b
        mov a,e ; pattern
        mov b,a

        ldax h+
        shal
        mov d,a ; x
        
        ldax h+ ; y
        push b
            mov e,a
            shal ;*2
            add a,e ;*3
            ori a,01h
            adi a,CharHeight*2
            mov e,a ; y
        pop b
        
        ldax h ; index
        
        call ShowSprite
    pop b | pop d | pop h | pop v
ret


; void ShowSpriteXY(byte index, byte x, byte y, byte pattern, byte color);
dseg
ShowSpriteXY_@Param3: public ShowSpriteXY_@Param3
    defb 0
ShowSpriteXY_@Param4: public ShowSpriteXY_@Param4
    defb 0
cseg
ShowSpriteXY_: public ShowSpriteXY_
    push v | push h | push d | push b
        push v
            mov a,e | mov d,a ; x
            mov a,c | mov e,a ; y
            mov b,ShowSpriteXY_@Param3
            mov c,ShowSpriteXY_@Param4
        pop v
        call ShowSprite
    pop b | pop d | pop h | pop v
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    push v | push h
        call SpritePtr_
        call WaitBlank
        mvix h,0     
    pop h | pop v
ret


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    calt 8eh 
ret
