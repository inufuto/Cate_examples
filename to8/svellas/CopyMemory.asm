; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
dseg
CopyMemory_@Param2: public CopyMemory_@Param2
    defw 0

cseg
CopyMemory_:	public	CopyMemory_
    pshs a,b,x,y
        ldd CopyMemory_@Param2
        do
            pshs a
                lda ,y+
                sta ,x+
            puls a
            subd #1
        while ne | wend
    puls a,b,x,y
rts


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; dseg
; FillMemory_@Param2: public FillMemory_@Param2
;     defb 0
; cseg
; FillMemory_: public FillMemory_
;     pshs a,x,y
;         lda FillMemory_@Param2
;         do
;             sta ,x+
;             leay -1,y
;         while ne | wend
;     puls a,x,y
; rts
