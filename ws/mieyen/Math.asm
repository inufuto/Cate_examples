RndCount equ 32

; dseg
; RndIndex_: public RndIndex_
;     defb 0
    
; cseg
; Numbers:
;     defb 26,30,1,16,9,13,12,5
;     defb 14,15,27,7,4,3,24,20
;     defb 8,18,22,10,19,21,23,6
;     defb 2,29,28,11,31,0,17,25

; ; byte Rnd();
; cseg
; Rnd_: public Rnd_
;     push bx
;         mov bl,[RndIndex_]
; 		xor bh,bh
; 		add bx,Numbers
;         mov bl,[cs:bx]
        
;         mov al,[RndIndex_]
;         inc al
;         and al,RndCount-1
;         mov [RndIndex_],al
        
;         mov al,bl
;     pop bx
; ret


; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
	sub al,dl
	if s
		neg al
	endif
ret


; ; sbyte Sign(byte from, byte to);
; cseg
; Sign_: public Sign_
;     sub	al,dl
;     if nz
; 		if s
; 			mov al,-1
; 		else
; 			mov al,1
; 		endif
; 	endif
; ret
