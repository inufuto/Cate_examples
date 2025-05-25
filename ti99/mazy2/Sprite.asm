include "Vdp.inc"
include "Vram.inc"
include "Chars.inc"

ext PrepareWriteVram, PrepareReadVram
ext WriteVram_, CopyToVram_
ext SpritePattern
ext PollVSync_

Sprite_End equ 15
Top equ 8*2-1
HiddenY equ 192
LastY equ >d0

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

        li r0,Sprites_+Offset_y
        li r1,HiddenY shl 8
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
        mov r0,r4 ; pMovable
        
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
        movb r3,*r0+ ; x
        swpb r3
        sla r1,2 ; pattern
        movb r1,*r0+
        swpb r15 ; wait
        movb r2,*r0+ ; color
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
        ai r0,Sprites_+Offset_y
        li r1,HiddenY shl 8 | movb r1,*r0
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
        li r0,Sprites_+Offset_y
        li r1,HiddenY shl 8
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


cseg
UpdateSprites: public UpdateSprites
    dect r10 | mov r11,*r10
    dect r10 | mov r0,*r10
    dect r10 | mov r1,*r10
    dect r10 | mov r2,*r10
    dect r10 | mov r3,*r10
    dect r10 | mov r4,*r10
    dect r10 | mov r5,*r10
    dect r10 | mov r6,*r10
        li r0,Vram_SpriteAttribute
        bl @PrepareWriteVram
        
        mov @FirstAddress,r6
        mov @FirstIndex,r1
        li r2,Sprite_End
        do
            movb *r6+,r0 ;y
            ci r0,HiddenY shl 8
            if l
                        _deb: public _deb
                movb r0,@VdpWrite ;y
                swpb r0 | swpb r0
                movb *r6+,@VdpWrite ;x
                swpb r0 | swpb r0
                movb *r6+,@VdpWrite ;pattern
                swpb r0 | swpb r0
                movb *r6+,@VdpWrite ; color
                ; swpb r0 | swpb r0
            else
                ai r6,BufferUnitSize-1
            endif
            inc r1
            ci r1,Sprite_End
            if he
                clr r1
                li r6,Sprites_
            endif
            dec r2
        while ne | wend
        li r0,>d0 shl 8
        movb r0,@VdpWrite ;y(last)

        mov @FirstAddress,r6
        mov @FirstIndex,r1
        ai r6,BufferUnitSize
        inc r1
        ci r1,Sprite_End
        if he
            clr r1
            li r6,Sprites_
        endif
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
