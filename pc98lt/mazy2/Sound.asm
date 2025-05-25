ext WaitTimer_

Tempo equ 220

BeepPort equ 35h
BeepBit equ 08h

dseg
SoundProc:
    defw 0,0
time:
    defw 0

cseg
InitSound: public InitSound
    mov word ptr [SoundProc],0
ret


CallSound_: public CallSound_
    push bx
        mov bx,[SoundProc]
        cmp bx,0
        if ne
            call bx
            mov word ptr [SoundProc],0
        endif
    pop bx
ret


Tone: public Tone
;   dx : cycle
;   bx : length
    push ax | push cx
        do
            in al,BeepPort
            and al,not BeepBit
            out BeepPort,al
            mov cx,dx
            do | wloop

            in al,BeepPort
            or al,BeepBit
            out BeepPort,al
            mov cx,dx
            do | wloop

            dec bx
        while nz | wend
    pop cx| pop ax
ret


Rest:
;   dx : cycle
;   bx : length
    push ax | push cx
        do
            in al,BeepPort
            or al,BeepBit
            out BeepPort,al
            mov cx,dx
            do | wloop

            in al,BeepPort
            or al,BeepBit
            out BeepPort,al
            mov cx,dx
            do | wloop
            dec bx
        while nz | wend
    pop cx| pop ax
ret


Melody: public Melody
    push ax | push bx | push cx | push dx
        cli
            do
                mov cl,[si] | inc si
                or cl,cl
            while ne
                mov al,[si] | inc si
                or al,al
                if nz
                    dec al
                    shl al,1 | shl al,1
                    xor ah,ah
                    add ax,cycles
                    mov bx,ax
                    mov dx,[bx] | add bx,2
                    mov al,[bx]
                    mul cl
                    mov bx,ax
                    call Tone
                else
                    mov dx,[cycles]
                    mov al,[cycles+2]
                    mul cl
                    mov bx,ax
                    call Rest
                endif
            wend
        sti
    pop dx | pop cx | pop bx | pop ax
ret


Sound_Beep_: public Sound_Beep_
    push ax
        in al,BeepPort
        and al,not BeepBit
        out BeepPort,al

        mov al,4
        call WaitTimer_

        in al,BeepPort
        or al,BeepBit
        out BeepPort,al

        mov al,1
        call WaitTimer_
    pop ax
ret


Sound_Get_: public Sound_Get_
    mov word ptr[SoundProc],Sound_Beep_
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    push si
        mov si,hit_notes
        call Melody
    pop si
ret
Sound_Hit_: public Sound_Hit_
    mov word ptr[SoundProc],Sound_Hit
ret


loose_notes:
    defb 2,C4, 2,0, 0
Sound_Loose_: public Sound_Loose_
    push si
        mov si,loose_notes
        call Melody
    pop si
ret


start_notes: public start_notes
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    mov si,start_notes
jmp Melody

clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    mov si,clear_notes
jmp Melody

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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defw 1272,980/Tempo  ; C4
defw 1200,1039/Tempo  ; C#4
defw 1133,1101/Tempo  ; D4
defw 1069,1166/Tempo  ; D#4
defw 1009,1236/Tempo  ; E4
defw 952,1309/Tempo  ; F4
defw 898,1388/Tempo  ; F#4
defw 848,1470/Tempo  ; G4
defw 800,1558/Tempo  ; G#4
defw 755,1650/Tempo  ; A4
defw 713,1747/Tempo  ; A#4
defw 673,1851/Tempo  ; B4
defw 635,1961/Tempo  ; C5
defw 599,2079/Tempo  ; C#5
defw 565,2203/Tempo  ; D5
defw 533,2335/Tempo  ; D#5
defw 503,2474/Tempo  ; E5
defw 475,2619/tempo  ; F5
