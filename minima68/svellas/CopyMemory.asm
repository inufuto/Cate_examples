zext @Temp@word
zext @Temp@word2
zext @Temp@Word3

; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
scope
pDestination equ @Temp@word
pSource equ @Temp@word2
length equ @Temp@word3
dseg
CopyMemory_@Param0: public	CopyMemory_@Param0
CopyMemory_pDestination:	
    defs 2
CopyMemory_@Param1: public	CopyMemory_@Param1
CopyMemory_pSource:
    defs 2
CopyMemory_@Param2: public	CopyMemory_@Param2
CopyMemory_length:
	defs 2
cseg
CopyMemory_: public	CopyMemory_
    psha
        ldx	CopyMemory_pSource
        stx pSource
        ldx	CopyMemory_pDestination
        stx pDestination
        ldx	CopyMemory_length
        stx length
        do
            ldx	pSource
            ldaa 0,x
            inx
            stx pSource
            ldx	pDestination
            staa 0,x
            inx
            stx	pDestination
            ldx	length
	        dex
	        stx	length
        while ne | wend
    pula
rts
endscope

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
