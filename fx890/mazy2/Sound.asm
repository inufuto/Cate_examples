Port_Sound equ 206H
Tempo equ 220

dseg
SoundProc:
    defw 0

cseg
InitSound: public InitSound
    mov word ptr[SoundProc],0
ret


; void CallSound();
cseg
CallSound_: public CallSound_
    push ax
        mov ax,[SoundProc]
        or ax,ax
        if nz
            call ax
            mov word ptr [SoundProc],0
        endif
    pop ax
ret


cseg
Tone: ; cx=cycle, bx=length
    push dx
        mov al,3
        cli
            mov dx,Port_Sound
            do
                push cx
                    out dx,al
                    do | wloop
                pop cx
                dec bx
            while nz | wend
        sti
    pop dx
ret

Rest: ; cx=cycle, bx=length
    push dx
        mov al,3
        cli
            mov dx,Port_Sound
            do
                push cx
                    in al,dx
                    do | wloop
                pop cx
                dec bx
            while nz | wend
        sti
    pop dx
ret


cseg
Melody:
    push ax | push bx | push cx | push dx
        do
            mov dl,[si] | inc si
            or dl,dl
        while ne
            mov al,[si] | inc si
            or al,al
            if nz
                dec al
                shl al,1 | shl al,1
                xor ah,ah
                add ax,cycles
                mov bx,ax
                mov cx,[bx]
                mov al,[bx+2]
                mul dl
                mov bx,ax
                call Tone
            else
                mov cx,[cycles]
                mov al,[cycles+2]
                mul dl
                mov bx,ax
                call Rest
            endif
        wend
    pop dx | pop cx | pop bx | pop ax
ret


; void Sound_Beep();
cseg
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    mov si,beep_notes
jmp Melody


; void Sound_Get();
Sound_Get_: public Sound_Get_
    mov word ptr [SoundProc],Sound_Beep_
ret


; void Sound_Hit();
cseg
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    mov si,hit_notes
jmp Melody
Sound_Hit_: public Sound_Hit_
    mov word ptr[SoundProc],Sound_Hit
ret


; void Sound_Loose();
cseg
loose_notes:
    defb 1,C4, 0
Sound_Loose:
    mov si,loose_notes
jmp Melody
Sound_Loose_: public Sound_Loose_
    mov word ptr[SoundProc],Sound_Loose
ret


; void Sound_Start();
cseg
start_notes: public start_notes
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    mov si,start_notes
jmp Melody


; void Sound_Clear();
clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    mov si,clear_notes
jmp Melody


; void Sound_GameOver();
cseg
over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    mov si,over_notes
jmp Melody


C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18

cycles:
defw 1177,1000000/Tempo/1177 ; C4
defw 1111,1000000/Tempo/1111 ; C4S
defw 1048,1000000/Tempo/1048 ; D4
defw 989,1000000/Tempo/989 ; D4S
defw 934,1000000/Tempo/934 ; E4
defw 881,1000000/Tempo/881 ; F4
defw 832,1000000/Tempo/832 ; F4S
defw 785,1000000/Tempo/785 ; G4
defw 741,1000000/Tempo/741 ; G4S
defw 700,1000000/Tempo/700 ; A4
defw 660,1000000/Tempo/660 ; A4S
defw 623,1000000/Tempo/623 ; B4
defw 588,1000000/Tempo/588 ; C5
defw 555,1000000/Tempo/555 ; C5S
defw 524,1000000/Tempo/524 ; D5
defw 494,1000000/Tempo/494 ; D5S
defw 467,1000000/Tempo/467 ; E5
defw 440,1000000/Tempo/440 ; F5
