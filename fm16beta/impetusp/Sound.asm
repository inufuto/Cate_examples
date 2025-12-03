include "Vram.inc"

Tempo equ 200

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
time:
    defw 0


cseg
InitSound: public InitSound
    ; mov dx,0fd38h | mov al,82h | out dx,al
    call OffAll
ret

OffAll:
    cli
        mov bx,Channels
        xor ax,ax
        mov cl,Count
        do
            mov [bx+Channel_Ptr],ax
            mov [bx+Channel_Tone],ax
            add bx,UnitSize
            dec cl
        while nz | wend
    sti
    call ToneOff
ret

ToneOn:
;   cx : cycle
    push ax | push dx
        mov dx,0fd3ah
        mov al,ch | out dx,al
        inc dx
        mov al,cl | out dx,al

        mov al,[es:0ff98h]
    pop dx| pop ax
ret

ToneOff:
    mov [es:0ff98h],al
ret

cseg
SoundHandler: public SoundHandler
    push ax
        mov ax,[time]
        sub ax,Tempo
        if b
            push es
            push ax | push bx | push cx | push dx | push si
                mov ax,SubSysSegment | mov es,ax
                mov si,Channels
                mov dl,Count
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            continue:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                offch:
                                mov word ptr [si+Channel_Tone],0
                                cmp dl,2
                                if z
                                    ; Channel0 end
                                    mov cx,[Channel1++Channel_Tone]
                                    or cx,cx
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
                            mov al,[bx] | inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            jz offch
                            dec al
                            add al,al
                            xor ah,ah
                            add ax,Cycles
                            mov bx,ax
                            mov cx,[bx]
                            mov [si+Channel_Tone],cx
                            cmp dl,1
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
                    dec dl
                while nz | wend
            pop si | pop dx | pop cx | pop bx | pop ax
            pop es
            add ax,600/2
        endif
        mov [time],ax
    pop ax
ret

Melody:
    cli
        mov [Channel0+Channel_Ptr],ax
        mov byte ptr [Channel0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channel0+Channel_Ptr],0
    while nz | wend
ret 


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push ax
        mov ax,fire_notes
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
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose_: public Sound_Loose_
    push ax
        mov ax,loose_notes
        call Melody
    pop ax
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push ax
        mov ax,up_notes
        call Melody
    pop ax
ret


; void Sound_Start();
start_notes:
	defb 5,E4,1,0, 11,F4S,1,0, 11,G4,1,0
	defb 11,G4,1,0, 5,E4,1,0, 11,A4,1,0
	defb 11,A4,1,0, 5,G4,1,0, 17,A4,1,0
	defb 35,B4,1,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push ax
        mov ax,start_notes
        call MelodyWait
    pop ax
ret


; void Sound_GameOver();
over_notes: 
	defb 11,E4,1,0, 5,B3,1,0, 5,E4,1,0
	defb 5,D4,1,0, 5,C4,1,0, 5,B3,1,0, 5,A3,1,0
	defb 35,B3,1,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax
        mov ax,over_notes
        call MelodyWait
    pop ax
ret


BGM_B:
	defb 17,E4,1,0, 17,F4S,1,0
	defb 23,G4,1,0
	defb 11,G4,1,0, 11,F4S,1,0
	defb 11,G4,1,0, 17,F4S,1,0
	defb 17,D4,1,0, 35,D4,1,0
	defb 24,0
	defb 17,E4,1,0, 17,F4S,1,0
	defb 23,G4,1,0
	defb 11,G4,1,0, 11,F4S,1,0
	defb 11,G4,1,0, 17,D5,1,0
	defb 17,A4,1,0, 35,A4,1,0
	defb 24,0
	defb 17,C5,1,0, 17,B4,1,0
	defb 23,C5,1,0
	defb 11,C5,1,0, 11,B4,1,0
	defb 11,C5,1,0, 17,B4,1,0
	defb 17,G4,1,0, 35,G4,1,0
	defb 24,0
	defb 5,E4,1,0, 5,E4,1,0, 5,F4S,1,0, 11,G4,1,0
	defb 11,G4,1,0, 5,G4,1,0, 5,F4S,1,0
	defb 5,F4S,1,0, 5,G4,1,0, 11,A4,1,0
	defb 11,A4,1,0, 5,A4,1,0, 5,G4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 11,B4,1,0
	defb 11,B4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 11,C5,1,0, 17,B4,1,0
	defb 12,0
    defb 0ffh

StartBGM_: public StartBGM_
    push ax
        cli
            mov ax,BGM_B
            mov [Channel1+Channel_Start],ax
            mov [Channel1+Channel_Ptr],ax
            mov byte ptr [Channel1+Channel_Len],1
        sti
    pop ax
ret

StopBGM_: public StopBGM_
    push ax
        do
            cmp word ptr[Channel0+Channel_Ptr],0
        while nz | wend
        call OffAll
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

Cycles:
defw 97 ; G3
defw 92 ; G#3
defw 87 ; A3
defw 82 ; A#3
defw 77 ; B3
defw 73 ; C4
defw 69 ; C#4
defw 65 ; D4
defw 61 ; D#4
defw 58 ; E4
defw 54 ; F4
defw 51 ; F#4
defw 48 ; G4
defw 46 ; G#4
defw 43 ; A4
defw 41 ; A#4
defw 38 ; B4
defw 36 ; C5
defw 34 ; C#5
defw 32 ; D5
defw 30 ; D#5
defw 29 ; E5
defw 27 ; F5
defw 25 ; F#5
defw 24 ; G5
