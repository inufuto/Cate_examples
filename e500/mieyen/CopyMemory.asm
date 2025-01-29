; void CopyMemory(ptr<byte> pDestination, ptr<byte> pSource, word length);
dseg
CopyMemory_@Param2: public	CopyMemory_@Param2
CopyMemory_length:
	defw 0
cseg
CopyMemory_: public	CopyMemory_
    pushs a | pushs i | pushs x | pushs y
        mv i,[CopyMemory_length]
        do
            mv a,[y++]
            mv [x++],a
            dec i
        while nz | wend
    pops y | pops x | pops i | pops a
ret


; ; void FillMemory(ptr<byte> pDestination, word length, byte b);
; dseg
; FillMemory_@Param2: public	FillMemory_@Param2
; FillMemory_b:
; 	defs 1
; cseg
; FillMemory_: public FillMemory_
;     pushs a | pushs i | pushs x
;         mv a,[FillMemory_b]
;         do
;             mv [x++],a
;             dec i
;         while nz | wend
;     pops x | pops i | pops a
; ret
