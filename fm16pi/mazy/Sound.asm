ext PortA0

OnValue equ 40h

Tempo equ 220

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1

dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
Time:
    defw 0

cseg
InitSound: public InitSound
    push ax | push bx | push cx
        xor ax,ax
        mov [Time],ax
        
        mov bx,Channels
        mov cl,Count
        do
            mov [bx+Channel_Ptr],ax
            mov [bx+Channel_Tone],ax
            add bx,UnitSize
            dec cl
        while nz | wend
        ; call ToneOff
    pop cx | pop bx | pop ax
ret

ToneOn:
;   ax : cycle
    out 0e4h,al
    mov al,ah
    out 0e4h,al
    mov al,[PortA0]
    or al,OnValue | out 0a0h,al
    mov [PortA0],al
ret

ToneOff:
    mov al,[PortA0]
    and al,not OnValue | out 0a0h,al
    mov [PortA0],al
ret


SoundHandler: public SoundHandler
    push ax
        mov ax,[Time]
        sub ax,Tempo
        if c
            push ax | push bx | push cx | push si
                mov si,Channels
                mov cl,Count
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr[si+Channel_Len]
                        if z
                            continue:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                offch:
                                mov word ptr [si+Channel_Tone],0
                                cmp cl,2
                                if z
                                    ; Channel0 end
                                    mov ax,[Channel1+Channel_Tone]
                                    or ax,ax
                                    if nz
                                        call ToneOn
                                        jmp next
                                    endif
                                endif
                                call ToneOff
                                jmp next
                            endif
                            cmp al,0ffh
                            if z
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue
                            endif
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            jz offch
                            mov bl,al
                            dec bl
                            xor bh,bh
                            add bx,bx
                            add bx,cycles
                            mov ax,[bx]
                            mov [si+Channel_Tone],ax
                            cmp cl,1
                            if z
                                ; Channel1
                                cmp word ptr[Channel0+Channel_Tone],0
                                jnz next
                            endif
                            call ToneOn
                        endif
                    endif
                    next:
                    add si,UnitSize
                    dec cl
                while nz | wend
            pop si | pop cx | pop bx | pop ax
            add ax,600/2
        endif
        mov [Time],ax
    pop ax
ret


Melody:
    cli
        mov [Channel0+Channel_Ptr],ax
        mov byte ptr[Channel0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        mov ax,[Channel0+Channel_Ptr]
        or ax,ax
    while nz | wend
ret 


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push ax
        mov ax,beep_notes
        call MelodyWait
    pop ax
ret

; void Sound_Get();
Sound_Get_: public Sound_Get_
    push ax
        mov ax,beep_notes
        call Melody
    pop ax
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push ax
        mov ax,hit_notes
        call Melody
    pop ax
ret


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push ax
        mov ax,loose_notes
        call MelodyWait
    pop ax
ret


; void Sound_Start();
start_notes:
	defb 5,G3,1,0, 5,D4,1,0, 5,B3,1,0, 5,D4,1,0, 23,G4,1,0
    defb 0
Sound_Start_: public Sound_Start_
    push ax
        mov ax,start_notes
        call MelodyWait
    pop ax
ret


; void Sound_Clear();
clear_notes:
	defb 5,G3,1,0, 5,B3,1,0, 5,D4,1,0, 5,A3,1,0, 5,C4,1,0, 5,E4,1,0, 5,B3,1,0, 5,D4,1,0
	defb 5,F4S,1,0, 17,G4,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push ax
        mov ax,clear_notes
        call MelodyWait
    pop ax
ret


; void Sound_GameOver();
over_notes:
	defb 5,G4,1,0, 5,D4,1,0, 5,B3,1,0, 5,G4,1,0, 5,F4S,1,0, 5,D4,1,0, 5,B3,1,0, 5,F4S,1,0
	defb 11,E4,1,0, 11,F4S,1,0, 23,G4,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax
        mov ax,over_notes
        call MelodyWait
    pop ax
ret


BGM_B:
	defb 5,A3,1,0, 5,C4,1,0, 5,D4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,E4,1,0, 5,D4,1,0, 23,C4,1,0, 23,D4,1,0
	defb 35,E4,1,0, 5,A3,1,0, 5,C4,1,0
	defb 5,D4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 5,E4,1,0
	defb 5,E4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0, 5,D4,1,0, 5,E4,1,0
	defb 5,D4,1,0, 23,C4,1,0, 23,D4,1,0
	defb 35,C4,1,0
    defb 0ffh

; void StartBGM();
StartBGM_: public StartBGM_
    push ax
        mov ax,BGM_B
        mov [Channel1+Channel_Start],ax
        mov [Channel1+Channel_Ptr],ax
        mov byte ptr[Channel1+Channel_Len],1
    pop ax
ret


StopBGM_: public StopBGM_
    push ax
        cli
            xor ax,ax
            mov [Channel1+Channel_Ptr],ax
            mov [Channel1+Channel_Tone],ax
            call ToneOff
        sti
    pop ax
ret




G3 equ 1
G3S equ 2
A3 equ 3
A3S equ 4
B3 equ 5
C4 equ 6
C4S equ 7
D4 equ 8
D4S equ 9
E4 equ 10
F4 equ 11
F4S equ 12
G4 equ 13
G4S equ 14
A4 equ 15
A4S equ 16
B4 equ 17
C5 equ 18
C5S equ 19
D5 equ 20
D5S equ 21
E5 equ 22
F5 equ 23
F5S equ 24
G5 equ 25

cycles:
defw 12538 ; G3
defw 11835 ; G#3
defw 11170 ; A3
defw 10543 ; A#3
defw 9952 ; B3
defw 9393 ; C4
defw 8866 ; C#4
defw 8368 ; D4
defw 7899 ; D#4
defw 7455 ; E4
defw 7037 ; F4
defw 6642 ; F#4
defw 6269 ; G4
defw 5917 ; G#4
defw 5585 ; A4
defw 5271 ; A#4
defw 4976 ; B4
defw 4696 ; C5
defw 4433 ; C#5
defw 4184 ; D5
defw 3949 ; D#5
defw 3727 ; E5
defw 3518 ; F5
defw 3321 ; F#5
defw 3134 ; G5
