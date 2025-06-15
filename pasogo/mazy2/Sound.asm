include "Pasogo.inc"

ext WaitTimer_

Tempo equ 220

BeepOn equ 0c00h
BeepOff equ 0400h

dseg
SoundProc:
    defw 0
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
            mov ax,BeepOn or GpioControl
            out Vg230Index,ax | defb 0ebh,0, 0ebh,0
            mov cx,dx
            do | wloop

            mov ax,BeepOff or GpioControl
            out Vg230Index,ax | defb 0ebh,0, 0ebh,0
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
            mov ax,BeepOff or GpioControl
            out Vg230Index,ax | defb 0ebh,0, 0ebh,0
            mov cx,dx
            do | wloop

            mov ax,BeepOff or GpioControl
            out Vg230Index,ax | defb 0ebh,0, 0ebh,0
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
        mov ax,BeepOn or GpioControl
        out Vg230Index,ax | defb 0ebh,0, 0ebh,0

        mov al,6
        call WaitTimer_

        mov ax,BeepOff or GpioControl
        out Vg230Index,ax | defb 0ebh,0, 0ebh,0

        mov al,2
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
defw 1272,817/tempo  ; C4
defw 1200,866/tempo  ; C#4
defw 1133,917/tempo  ; D4
defw 1069,972/tempo  ; D#4
defw 1009,1030/tempo  ; E4
defw 952,1091/tempo  ; F4
defw 898,1157/tempo  ; F#4
defw 848,1225/tempo  ; G4
defw 800,1298/tempo  ; G#4
defw 755,1375/tempo  ; A4
defw 713,1456/tempo  ; A#4
defw 673,1542/tempo  ; B4
defw 635,1634/tempo  ; C5
defw 599,1732/tempo  ; C#5
defw 565,1836/tempo  ; D5
defw 533,1946/tempo  ; D#5
defw 503,2061/tempo  ; E5
defw 475,2182/tempo  ; F5
