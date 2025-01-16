include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext InitVdp, PrepareWriteVram, ReadVram_, WriteVram_, FillVram_, CopyToVram_
ext PollVSync_

ext MonoPattern
ext BlockPattern, UfoPattern
ext UfoRowCenterXd_

cseg
ColorSource:
defb 64, >f0 ; Ascii
defb 16, >70 ; Logo
defb 16, >70 ; Wall
defb 4, >a0 ; Dot
defb 4, >b0 ; Food
defb 4, >f0 ; Remain
defw 0
InitVram: public InitVram
    dect r10 | mov r11,*r10
        bl @InitVdp
        li r0,0
        do
            dect r10 | mov r0,*r10
                ai r0,Vram_PatternGenerator
                li r1,MonoPattern
                li r2,Char_End*CharHeight
                bl @CopyToVram_
            mov *r10+,r0
            dect r10 | mov r0,*r10
                ai r0,Vram_Color
                li r4,ColorSource
                do
                    clr r2
                    movb *r4+,r2
                while ne
                    srl r2,8-3
                    movb *r4+,r1
                    bl @FillVram_
                    a r2,r0
                wend
            mov *r10+,r0
            ai r0,>0800
            ci r0,>1800
        while ne | wend
    mov *r10+,r11
rt


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    dect r10 | mov r11,*r10
        li r0,Vram
        li r1,Char_Space shl 8
        li r2,VramWidth*VramHeight
        bl @FillVram_

        li r0,Vram_SpriteAttribute
        li r1,>c0 shl 8
        li r2,4*32
        bl @FillVram_
    mov *r10+,r11
rt


; word VramAddress(byte x, byte y);
cseg
VramAddress_: public VramAddress_
    dect r10 | mov r1,*r10
        srl r1,8-5
        srl r0,8
        a r1,r0
        ai r0,Vram
    mov *r10+,r1
rt


; word Put(word vram, byte c);
cseg
Put_: public Put_
    dect r10 | mov r11,*r10
        bl @WriteVram_
        inc r0
    mov *r10+,r11
rt


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    dect r10 | mov r11,*r10
    dect r10 | mov r1,*r10
        ai r1,-(' ' shl 8)
        bl @WriteVram_
        inc r0
    mov *r10+,r1
    mov *r10+,r11
rt
