include 'ZeroPage.inc'

; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
dseg
CopyMemory_@Param0: public	CopyMemory_@Param0
CopyMemory_pDestination:
	defw 0
CopyMemory_@Param1:	public	CopyMemory_@Param1
CopyMemory_pSource:	
    defw 0
CopyMemory_@Param2:	public	CopyMemory_@Param2
CopyMemory_length:	
    defw 0
CopyMemory_pd equ Zp.TmpX1
CopyMemory_ps equ Zp.TmpX0
CopyMemory_l equ Zp.Word
cseg
CopyMemory_:   public	CopyMemory_
    lda CopyMemory_pDestination | sta CopyMemory_pd
    lda CopyMemory_pDestination+1 | sta CopyMemory_pd+1
    
    lda CopyMemory_pSource | sta CopyMemory_ps
    lda CopyMemory_pSource+1 | sta CopyMemory_ps+1

    lda CopyMemory_length | sta CopyMemory_l
    lda CopyMemory_length+1 | sta CopyMemory_l+1

    ldx #0
    do
        lda (CopyMemory_ps,x)
        sta (CopyMemory_pd,x)

        lda CopyMemory_ps | clc | adc #1 | sta CopyMemory_ps
        lda CopyMemory_ps+1 | adc #0 | sta CopyMemory_ps+1

        lda CopyMemory_pd | clc | adc #1 | sta CopyMemory_pd
        lda CopyMemory_pd+1 | adc #0 | sta CopyMemory_pd+1

        lda CopyMemory_l | sec | sbc #1 | sta CopyMemory_l
        lda CopyMemory_l+1 | sbc #0 | sta CopyMemory_l+1
        ora CopyMemory_l
    while ne | wend
rts


; void FillMemory(ptr<byte> pDestination, word length, byte b);
dseg
FillMemory_@Param0: public	FillMemory_@Param0
FillMemory_pDestination:
    defw 0
FillMemory_@Param1:	public	FillMemory_@Param1
FillMemory_length:	
    defw 0
FillMemory_@Param2:	public	FillMemory_@Param2
FillMemory_b:	
    defb 0
FillMemory_pd equ Zp.TmpX1
FillMemory_l equ Zp.Word
cseg
FillMemory_ : public FillMemory_
    lda FillMemory_pDestination | sta FillMemory_pd
    lda FillMemory_pDestination+1 | sta FillMemory_pd+1
    
    lda FillMemory_length | sta FillMemory_l
    lda FillMemory_length+1 | sta FillMemory_l+1

    ldx #0
    do
        lda FillMemory_b
        sta (FillMemory_pd,x)

        lda FillMemory_pd | clc | adc #1 | sta FillMemory_pd
        lda FillMemory_pd+1 | adc #0 | sta FillMemory_pd+1

        lda FillMemory_l | sec | sbc #1 | sta FillMemory_l
        lda FillMemory_l+1 | sbc #0 | sta FillMemory_l+1
        ora FillMemory_l
    while ne | wend
rts
