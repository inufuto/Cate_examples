include "Vram.inc"
include "Vdp.inc"
include "Chars.inc"

ext PrepareWriteVram, PrepareReadVram
ext WriteVram_, CopyToVram_
ext SpritePattern
ext PollVSync_

Sprite_End equ 13
Top equ 8*2-1

Offset_y equ 0
Offset_x equ 1
Offset_name equ 2
Offset_color equ 3
BufferUnitSize equ 4
Sprites_End equ Sprites+BufferUnitSize*Sprite_End

dseg
FirstAddress: public FirstAddress
    defs 2


cseg
InitSprites: public InitSprites
    dect r10 | mov r11,*r10
        li r0,Vram_SpriteGenerator
        li r1,SpritePattern
        li r2,CharHeight*4*Pattern_End
        bl @CopyToVram_

        li r0,Sprites
        li r1,>c0 shl 8
        li r2,Sprite_End
        do 
            bl @WriteVram_
            ai r0,BufferUnitSize
            dec r2
        while ne | wend

        li r0,Sprites
        mov r0,@FirstAddress
    mov *r10+,r11
rt


; void ShowSprite(word pMovable, byte pattern, byte color);
cseg
ShowSprite_: public ShowSprite_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
    dect r10 | mov r3,*r10
        bl @PrepareReadVram
        
        movb @VdpPort,r3 ; x
        swpb r3
        movb @VdpPort,r3 ; y
        sla r3,1 ; CoordShift = 2
        ai r3,Top shl 8

        clr r0
        movb @VdpPort,r0 ; index
        srl r0,8-2 | ai r0,Sprites

        bl @PrepareWriteVram
        movb r3,@VdpPort ; y
        swpb r3
        movb r3,@VdpPort ; x
        swpb r3
        sla r1,2
        movb r1,@VdpPort ; pattern
        swpb r15 ; wait
        movb r2,@VdpPort ; color
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
    mov *r10+,r11
rt


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
        srl r0,8-2
        ai r0,Sprites
        li r1,>c0 shl 8 | bl @WriteVram_
    mov *r10+,r1
    mov *r10+,r0
    mov *r10+,r11
rt


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
        li r0,Sprites
        li r1,>c0 shl 8
        li r2,Sprite_End
        do
             bl @WriteVram_
             ai r0,BufferUnitSize
             dec r2
        while ne | wend
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
    mov *r10+,r11
rt


; void UpdateSprites();
cseg
UpdateSprites_: public UpdateSprites_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
    dect r10 | mov r3,*r10
    dect r10 | mov r4,*r10
    dect r10 | mov r5,*r10
        li r4,Vram_SpriteAttribute
        mov @FirstAddress,r5
        li r1,Sprite_End
        do
            mov r5,r0 | bl @PrepareReadVram
            movb @VdpPort,r2 | swpb r2
            nop
            movb @VdpPort,r2 | swpb r2
            nop
            movb @VdpPort,r3 | swpb r3
            nop
            movb @VdpPort,r3 | swpb r3

            mov r4,r0 | bl @PrepareWriteVram
            movb r2,@VdpPort | swpb r2
            nop
            movb r2,@VdpPort | swpb r2
            nop
            movb r3,@VdpPort | swpb r3
            nop
            movb r3,@VdpPort | swpb r3

            ai r4,BufferUnitSize
            ai r5,BufferUnitSize
            ci r5,Sprites_End
            if he
                li r5,Sprites
            endif
            dec r1
        while ne | wend
        mov @FirstAddress,r5
        ai r5,BufferUnitSize
        ci r5,Sprites_End
        if he
            li r5,Sprites
        endif
        mov r5,@FirstAddress
    mov *r10+,r5
    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
        bl @PollVSync_
    mov *r10+,r11
rt
