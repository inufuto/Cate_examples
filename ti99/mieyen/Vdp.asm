include "Vdp.inc"
include "Vram.inc"


cseg
VdpValues:
    defb >02, >c2
    defb Vram_PatternName shr 10
    defb (Vram_Color shr 6) or >7f
    defb (Vram_PatternGenerator shr 11) or >03
    defb Vram_SpriteAttribute shr 7
    defb Vram_SpriteGenerator shr 11
    defb >f4
InitVdp: public InitVdp
    li r1,VdpValues
    li r2,8
    li r0,>0080
    do
        movb *r1+,r0
        movb r0,@VdpWrite+2 | swpb r0
        movb r0,@VdpWrite+2 | swpb r0
        inc r0
        dec r2
    while ne | wend
rt


cseg
PrepareWriteVram: public PrepareWriteVram
    swpb r0
    movb r0,@VdpWrite+2
    ori r0,>40
    swpb r0
    movb r0,@VdpWrite+2
    andi r0,not >4000
rt

; void WriteVram(word vram, byte b);
cseg
WriteVram_: public WriteVram_
    mov r11,r12
        bl @PrepareWriteVram
    mov r12,r11
    swpb r15 ; wait
    movb r1,@VdpWrite
    swpb r0 | swpb r0
rt

; ; void WriteVramWord(word vram, word w);
; cseg
; WriteVramWord_: public WriteVramWord_
;     mov r11,r12
;         bl @PrepareWriteVram
;     mov r12,r11
;     movb r1,@VdpWrite | swpb r1
;     ; nop ;| nop
;     movb r1,@VdpWrite | swpb r1
; rt

cseg
PrepareReadVram: public PrepareReadVram
    swpb r0
    movb r0,@VdpWrite+2
    ori r0,>0
    swpb r0
    movb r0,@VdpWrite+2
    andi r0,not 0
rt

; byte ReadVram(word vram);
cseg
ReadVram_: public ReadVram_
    mov r11,r12
        bl @PrepareReadVram
    mov r12,r11
    swpb r15 ; wait
    clr r0 | movb @VdpRead,r0
    swpb r0 | swpb r0
rt

; ; word ReadReadVramWord(word vram);
; cseg
; ReadVramWord_: public ReadVramWord_
;     mov r11,r12
;         bl @PrepareReadVram
;     mov r12,r11
;     movb @VdpRead,r1 | swpb r1
;     ; nop ;| nop
;     movb @VdpRead,r1 | swpb r1
; rt

; void FillVram(word vram, byte b, word count);
FillVram_: public FillVram_
    dect r10 | mov r11,*r10
    dect r10 | mov r2,*r10
        bl @PrepareWriteVram
        mov r12,r11
        do
            movb r1,@VdpWrite
            swpb r0 | swpb r0
            dec r2
        while ne | wend
    mov *r10+,r2
    mov *r10+,r11
rt

; void CopyToVram(word vram, ptr<byte> pBytes, word count);
cseg
CopyToVram_: public CopyToVram_
    dect r10 | mov r3,*r10
        mov r11,r12
            bl @PrepareWriteVram
        mov r12,r11
        do
            movb *r1+,r3
            movb r3,@VdpWrite
            swpb r0 | swpb r0
            dec r2
        while ne | wend
    mov *r10+,r3
rt
