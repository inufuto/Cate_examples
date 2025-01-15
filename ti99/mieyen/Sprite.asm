include "Vdp.inc"
include "Vram.inc"
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

dseg
Sprites_: public Sprites_
Buffer:
    defs BufferUnitSize * Sprite_End
FirstIndex:
    defs 2
FirstAddress:
    defs 2


cseg
InitSprites: public InitSprites
    dect r10 | mov r11,*r10
        li r0,Vram_SpriteGenerator
        li r1,SpritePattern
        li r2,CharHeight*4*Pattern_End
        bl @CopyToVram_

        li r0,Sprites_+Offset_color
        li r1,>80 shl 8
        li r2,Sprite_End
        do 
            movb r1,*r0
            ai r0,BufferUnitSize
            dec r2
        while ne | wend

        clr @FirstIndex
        li r0,Sprites_
        mov r0,@FirstAddress
    mov *r10+,r11
rt


; void ShowSprite(ptr<Movable> pMovable, byte pattern, byte color);
cseg
ShowSprite_: public ShowSprite_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r3,*r10
    dect r10 | mov r4,*r10
        mov r0,r4
        
        movb @0(r4),r3 ; x
        swpb r3
        
        movb @1(r4),r3 ; y
        sla r3,1 ; CoordShift = 2
        ai r3,Top shl 8

        clr r0
        movb @2(r4),r0 ; index
        srl r0,8-2 | ai r0,Sprites_

        movb r3,*r0+ ; y
        swpb r3
        ci r2,>8000
        if he
            ai r3,32 shl 8
        endif
        movb r3,*r0+ ; x
        swpb r3
        sla r1,2
        movb r1,*r0+ ; pattern
        swpb r15 ; wait
        movb r2,*r0+ ; color | EC

    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r0
    bl @PollVSync_
    mov *r10+,r11
rt


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
        srl r0,8-2
        ai r0,Sprites_+Offset_color
        li r1,>80 shl 8 | movb r1,*r0
    mov *r10+,r1
    mov *r10+,r0
    bl @PollVSync_
    mov *r10+,r11
rt


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
        li r0,Sprites_+Offset_color
        li r1,>80 shl 8
        li r2,Sprite_End
        do
             movb r1,*r0
             ai r0,BufferUnitSize
             dec r2
        while ne | wend
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
    bl @PollVSync_
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
    dect r10 | mov r6,*r10
        li r5,Vram_SpriteAttribute
        mov @FirstAddress,r6
        mov @FirstIndex,r1
        li r2,Sprite_End
        do
            mov r5,r0 | bl @PrepareWriteVram
            movb *r6+,@VdpWrite
            swpb r0 | swpb r0
            movb *r6+,@VdpWrite
            swpb r0 | swpb r0
            movb *r6+,@VdpWrite
            swpb r0 | swpb r0
            movb *r6+,@VdpWrite
            swpb r0 | swpb r0

            ai r5,BufferUnitSize
            inc r1
            ci r1,Sprite_End
            if he
                clr r1
                li r6,Sprites_
            endif
            dec r2
        while ne | wend
        mov r6,@FirstAddress
        mov r1,@FirstIndex
    mov *r10+,r6
    mov *r10+,r5
    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r0
    bl @PollVSync_
    mov *r10+,r11
rt
