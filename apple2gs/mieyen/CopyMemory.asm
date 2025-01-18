include "ZeroPage.inc"

; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
CopyMemory_pDestination equ @zp+0
CopyMemory_pSource equ @zp+2
CopyMemory_length equ @zp+4
cseg
CopyMemory_: public	CopyMemory_
    php
        phx | phy
        sep #$20 | a8
        pha
            ldx <CopyMemory_length
            ldy #0
            do
                lda (<CopyMemory_pSource),y
                sta (<CopyMemory_pDestination),y
                iny
                dex
            while ne | wend
        pla
        ply | plx
    plp
rts


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; FillMemory_pDestination equ @zp+0
; FillMemory_length equ @zp+2
; FillMemory_b equ @zp+4
; cseg
; FillMemory_: public FillMemory_
;     php
;         phx | phy
;         sep #$20 | a8
;         pha
;             ldx <FillMemory_pDestination
;             ldy <FillMemory_length
;             lda <FillMemory_b
;             do
;                 sta 0,x
;                 inx
;                 dey
;             while ne | wend
;         pla
;         ply | plx
;     plp
; rts
