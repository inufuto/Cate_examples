include "ZeroPage.inc"

pDestination equ ZW1
pSource equ ZW0
count equ ZW2


; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
dseg
CopyMemory_@Param1:	public	CopyMemory_@Param1
CopyMemory_pSource:	
    defw 0
CopyMemory_@Param2:	public	CopyMemory_@Param2
CopyMemory_length:	
    defw 0
cseg
CopyMemory_:   public	CopyMemory_
    sty <pDestination
    stx <pDestination+1
    
    lda CopyMemory_pSource | sta <pSource
    lda CopyMemory_pSource+1 | sta <pSource+1

    lda CopyMemory_length | sta <count
    lda CopyMemory_length+1 | sta <count+1

    ldx #0
    do
        lda (<pSource,x)
        sta (<pDestination,x)

        lda <pSource | clc | adc #1 | sta <pSource
        lda <pSource+1 | adc #0 | sta <pSource+1

        lda <pDestination | clc | adc #1 | sta <pDestination
        lda <pDestination+1 | adc #0 | sta <pDestination+1

        lda <count | sec | sbc #1 | sta <count
        lda <count+1 | sbc #0 | sta <count+1
        ora <count
    while ne | wend
rts


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; dseg
; FillMemory_@Param1:	public	FillMemory_@Param1
; FillMemory_length:	
;     defw 0
; FillMemory_@Param2:	public	FillMemory_@Param2
; FillMemory_b:	
;     defb 0
; cseg
; FillMemory_ : public FillMemory_
;     sty <pDestination
;     stx <pDestination+1
    
;     lda FillMemory_length | sta count
;     lda FillMemory_length+1 | sta count+1

;     ldx #0
;     do
;         lda FillMemory_b
;         sta (<pDestination,x)

;         lda <pDestination | clc | adc #1 | sta <pDestination
;         lda <pDestination+1 | adc #0 | sta <pDestination+1

;         lda <count | sec | sbc #1 | sta <count
;         lda <count+1 | sbc #0 | sta <count+1
;         ora <count
;     while ne | wend
; rts
