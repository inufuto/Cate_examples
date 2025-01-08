ext @Temp@word
ext @Temp@word2
ext @Temp@Word3

; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
dseg
CopyMemory_@Param0: public	CopyMemory_@Param0
CopyMemory_.pDestination_:	
    defs 2
CopyMemory_@Param1: public	CopyMemory_@Param1
CopyMemory_.pSource_:
    defs 2
CopyMemory_@Param2: public	CopyMemory_@Param2
CopyMemory_.length_:
	defs 2
cseg
CopyMemory_: public	CopyMemory_
    psha
        ldx	CopyMemory_.pSource_
        stx <@Temp@word
        ldx	CopyMemory_.pDestination_
        stx <@Temp@word2
        ldx	CopyMemory_.length_
        stx <@Temp@Word3
        do
            ldx	<@Temp@word
            ldaa 0,x
            inx
            stx <@Temp@word
            ldx	<@Temp@word2
            staa 0,x
            inx
            stx	<@Temp@word2
            ldx	<@Temp@Word3
	        dex
	        stx	<@Temp@Word3
        while ne | wend
    pula
rts


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; dseg
; FillMemory_@Param0: public	FillMemory_@Param0
; FillMemory_.pDestination_:	
;     defs 2
; FillMemory_@Param1: public	FillMemory_@Param1
; FillMemory_.length_:
;     defs 2
; FillMemory_@Param2: public	FillMemory_@Param2
; FillMemory_.b_:
; 	defs 1
; cseg
; FillMemory_: public FillMemory_
;     psha
;         ldx	FillMemory_.pDestination_
;         stx <@Temp@word
;         ldx FillMemory_.length_
;         stx <@Temp@Word3
;         ldaa FillMemory_.b_
;         do
;             ldx <@Temp@word
;             staa 0,x
;             inx
;             stx <@Temp@word
            
;             ldx <@Temp@Word3
;             dex
;             stx <@Temp@Word3
;         while ne | wend
;     pula
; rts
