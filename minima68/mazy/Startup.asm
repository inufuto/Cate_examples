include "Vram.inc"

ext InitVram
ext InitSound, SoundHandler
; ext InitSprites
ext Main_

dseg
TimerCount: 
    defb 0

cseg
lds #$d000-1

jsr InitVram
jsr InitSprites
jsr InitSound

ldx #Handler | stx $fff8
cli
jmp Main_

Handler: public Handler
    inc TimerCount
    jsr SoundHandler
rti


; void WaitTimer(byte t);
dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    staa WaitTimer_param
        do
            ldaa TimerCount
            cmpa WaitTimer_param
        while cs
        wend
    ldaa <WaitTimer_param
    clr TimerCount
rts


InitSprites:
    ldx #SpriteAttributeRam
    ldaa #-SpriteHeight
    do
        staa 0,x | inx
        cpx #SpriteAttributeRam+4*MaxSpriteCount
    while ne | wend
rts
