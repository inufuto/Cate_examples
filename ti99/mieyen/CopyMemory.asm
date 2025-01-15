; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
cseg
CopyMemory_: public CopyMemory_
	dect r10 | mov r0,*r10
	dect r10 | mov r1,*r10
	dect r10 | mov r2,*r10
        do
            movb *r1+,*r0+
            dec r2
        while ne | wend
	mov *r10+,r2
	mov *r10+,r1
	mov *r10+,r0
rt


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; cseg
; FillMemory_: public FillMemory_
; 	dect r10 | mov r0,*r10
; 	dect r10 | mov r1,*r10
;         do
;             movb r2,*r0+
;             dec r1
;         while ne | wend
; 	mov *r10+,r1
; 	mov *r10+,r0
; rt
