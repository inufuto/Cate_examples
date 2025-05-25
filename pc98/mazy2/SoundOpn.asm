ext WaitTimer_

Tempo equ 220

Port_Register equ 0188h
Port_Out equ 018ah

Psg_Tone_A equ 0
Psg_Tone_B equ 2
Psg_Tone_C equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_Volume_A equ 8
Psg_Volume_B equ 9
Psg_Volume_C equ 10

Opn_OnOff equ 28h
Opn_Part equ 30h

MaxVol equ 63

PsgCount equ 3
OpnCount equ 3
AllCount equ PsgCount+OpnCount
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
OpnAvailable: public OpnAvailable
    defb 0
Channels defs unitSize*AllCount
time: defw 0
wcount:defb 0

cseg
WaitPort:
    push ax | push dx
        mov byte ptr [wcount],0
        mov dx,Port_Register
        do
            inc byte ptr [wcount]
            in al,dx
            and al,80h
        while nz | wend
    pop dx | pop ax
ret

Wait1:
    push cx
        mov cl,[wcount]
        do
            dec cl
        while nz | wend
    pop cx
ret

WriteRegister:
; al:register, ah:value
    push dx
        mov dx,Port_Register | out dx,al
        mov al,ah
        mov dx,Port_Out | out dx,al
    pop dx
ret

WriteRegisterW:
; al:register, ah:value
    push dx
        mov dx,Port_Register | out dx,al
        call Wait1
        mov al,ah
        mov dx,Port_Out | out dx,al
    pop dx
ret


; BassTone:
;     defb 58,48,48,48
;     defb 36,18,45,0
;     defb 31,95,31,95
;     defb 18,10,14,10
;     defb 0,4,4,3
;     defb 38,38,38,38
;     defb 58
; BassTone:
;     defb 96,96,96,96
;     defb 23,23,63,0
;     defb 158,156,152,156
;     defb 14,4,10,5
;     defb 8,9,9,9
;     defb 182,198,198,198
;     defb 48
BassTone:
    defb 96,96,102,97
    defb 33,40,20,0
    defb 31,31,148,31
    defb 15,5,16,13
    defb 7,6,6,7
    defb 40,23,71,87
    defb 58
PianoTone:
    defb 15,82,50,2
    defb 65,27,0,0
    defb 94,94,94,158
    defb 15,8,7,8
    defb 5,5,5,5
    defb 143,143,143,143
    defb 60
SnareTone:
    defb 15,0,0,0
    defb 14,19,17,0
    defb 31,31,31,31
    defb 0,24,15,19
    defb 0,0,17,16
    defb 8,184,44,44
    defb 60

Tones:
    defw BassTone,PianoTone,SnareTone

SetTone: public SetTone
    push dx
        mov ch,24
        do
            call WaitPort
            mov al,cl
            mov ah[bx] | inc bx
            call WriteRegisterW
            add cl,4
            dec ch
        while nz | wend
        call WaitPort
        mov al,cl | add al,20h
        mov ah,[bx] | inc bx
        call WriteRegisterW
    pop dx
ret


InitSoundOpn: public InitSoundOpn
    mov ah,38h or 80h
    mov al,Psg_Mixer
    call WriteRegister

    mov al,Psg_Mixer
    mov dx,Port_Register | out dx,al
    mov dx,Port_Out | in al,dx
    cmp al,38h or 80h
    if z
        mov byte ptr [OpnAvailable],1

        mov bx,Channels
        xor al,al
        mov ch,AllCount*unitSize
        do
            mov [bx],al | inc bx
            dec ch
        while nz | wend
        xor ax,ax
        mov [time],ax

        mov cx,OpnCount * 256
        do
            mov al,Opn_OnOff
            mov ah,cl
            call WriteRegisterW
            inc cl
            dec ch
        while nz | wend
    else
        mov byte ptr [OpnAvailable],0
    endif
ret


SoundHandlerOpn: public SoundHandlerOpn
    push ax | push dx | push bx
        mov ax,[time]
        sub ax,Tempo
        if b
            push ax | push cx | push si
                mov si,Channels
                mov cx,PsgCount*100h ; ch=count; cl=register
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
                                mov al,cl
                                add al,Psg_Volume_A
                                xor ah,ah
                                call WriteRegister
                                jmp next
                            endif
                            inc al
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue
                            endif
                            dec al
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            if nz
                                dec al
                                shl al,1
                                xor ah,ah
                                add ax,cycles
                                mov bx,ax
                                mov al,cl
                                shl al,1
                                push ax
                                    mov ah,[bx]
                                    call WriteRegister
                                pop ax
                                inc bx
                                inc al
                                mov ah,[bx]
                                call WriteRegister

                                mov byte ptr [si+Channel_Vol],MaxVol
                            else
                                mov byte ptr [si+Channel_Vol],0
                            endif
                            EndWriteCycle:
                        endif
                        mov al,cl
                        add al,Psg_Volume_A
                        mov ah,[si+Channel_Vol]
                        shr ah,1 | shr ah,1
                        call WriteRegister

                        mov al,[si+Channel_Vol]
                        or al,al
                        if nz
                            dec al
                            mov [si+Channel_Vol],al
                        endif
                    endif
                    next:
                    inc cl
                    add si,unitSize
                    dec ch
                while nz | wend

                mov cx,300h ; ch=count; cl=channel
                do
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            mov al,[si+Channel_Vol]
                            or al,al
                            if nz
                                call WaitPort
                                mov al,Opn_OnOff
                                mov ah,cl
                                call WriteRegisterW
                                mov byte ptr [si+Channel_Vol],0
                            endif
                            continue2:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                jmp next2
                            endif
                            inc al
                            if z 
                                ; repeat
                                mov bx,[si+Channel_Start]
                                jmp continue2
                            endif
                            dec al
                            mov [si+Channel_Len],al
                            inc bx
                            mov al,[bx]
                            inc bx
                            mov [si+Channel_Ptr],bx
                            or al,al
                            if nz
                                dec al
                                shl al,1
                                xor ah,ah
                                add ax,OpnScales
                                mov bx,ax

                                mov al,cl
                                add al,0a4h
                                call WaitPort
                                mov ah,[bx]
                                inc bx
                                call WriteRegisterW

                                mov al,cl
                                add al,0a0h
                                call WaitPort
                                mov ah,[bx]
                                call WriteRegisterW

                                push bx | push cx
                                    mov bl,cl
                                    add cl,Opn_Part
                                    add bl,bl
                                    xor bh,bh
                                    add bx,Tones
                                    mov bx,[bx]
                                    call SetTone
                                pop cx | pop bx

                                call WaitPort
                                mov al,Opn_OnOff
                                mov ah,cl
                                or ah,0f0h
                                call Wait1
                                call WriteRegisterW
                                mov byte ptr [si+Channel_Vol],0ffh
                            endif
                        endif
                    endif
                    next2:
                    inc cl
                    add si,unitSize
                    dec ch
                while nz | wend
            pop si | pop cx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop bx | pop dx | pop ax
ret


Melody0:
    cli
        mov [Channels+unitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*0+Channel_Len],1
        push ax | push dx
            mov al,Psg_Volume_A
            mov dx,Port_Register | out dx,al
            xor al,al
            mov dx,Port_Out | out dx,al
        pop dx | pop ax
    sti
ret

MelodyWait0:
    call Melody0
    do
        cmp word ptr [Channels+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


Melody4:
    cli
        mov [Channels+unitSize*4+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*4+Channel_Len],1
        push ax | push dx
            mov al,Psg_Volume_A
            mov dx,Port_Register | out dx,al
            xor al,al
            mov dx,Port_Out | out dx,al
        pop dx | pop ax
    sti
ret

MelodyWait4:
    call Melody4
    do
        cmp word ptr [Channels+unitSize*4+Channel_Ptr],0
    while nz | wend
ret 


beep_notes:
    defb 1,A4, 0
Sound_BeepOpn: public Sound_BeepOpn
    push bx
        mov bx,beep_notes
        call MelodyWait0
    pop bx
ret


Sound_GetOpn: public Sound_GetOpn
    push bx
        mov bx,beep_notes
        call MelodyWait0
    pop bx
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_HitOpn: public Sound_HitOpn
    push bx
        mov bx,hit_notes
        call Melody0
    pop bx
ret


loose_notes:
    defb 1,A3, 0
Sound_LooseOpn: public Sound_LooseOpn
    push bx
        mov bx,loose_notes
        call MelodyWait0
    pop bx
ret


start_notes: 
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0
Sound_StartOpn: public Sound_StartOpn
    push bx
        mov bx,start_notes
        call MelodyWait4
    pop bx
ret

clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_ClearOpn: public Sound_ClearOpn
    push bx
        mov bx,clear_notes
        call MelodyWait4
    pop bx
ret

over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0
Sound_GameOverOpn: public Sound_GameOverOpn
    push bx
        mov bx,over_notes
        call MelodyWait4
    pop bx
ret


BGM_B:
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,A4
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,F4
    defb 0ffh

BGM_C:
    defb N4P,0
    defb N4P,F3, N4P,F3, N4,F3
    defb N4P,C4, N4P,C4, N4,C4
    defb N2,F3, N2,G3, N2+N8,A3, N4P,0
    defb N4P,A3, N4P,A3, N4,A3
    defb N4P,G3, N4P,G3, N4,G3
    defb N2,F3, N2,C4, N2+N8,F3
    defb 0ffh

BGM_D: 
    defb N8,A4, N8,A4, N8,A4
    defb N4,0, N4,A4, N4,0, N4,A4  
    defb N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N8,0
    defb 0ffh

StartBGMOpn: public StartBGMOpn
    push ax | push bx
        cli
            mov al,1
            mov bx,BGM_B
            mov [Channels+unitSize*4+Channel_Start],bx
            mov [Channels+unitSize*4+Channel_Ptr],bx
            mov [Channels+unitSize*4+Channel_Len],al
            mov bx,BGM_C
            mov [Channels+unitSize*3+Channel_Start],bx
            mov [Channels+unitSize*3+Channel_Ptr],bx
            mov [Channels+unitSize*3+Channel_Len],al
            mov bx,BGM_D
            mov [Channels+unitSize*5+Channel_Start],bx
            mov [Channels+unitSize*5+Channel_Ptr],bx
            mov [Channels+unitSize*5+Channel_Len],al
        sti
    pop bx | pop ax
ret

StopBGMOpn: public StopBGMOpn
    push ax | push bx | push cx | push dx
        cli
            mov bx,0
            mov [Channels+unitSize*4+Channel_Ptr],bx
            mov [Channels+unitSize*3+Channel_Ptr],bx
            mov [Channels+unitSize*5+Channel_Ptr],bx

            mov cx,2*256 or Psg_Volume_B
            do
                mov al,cl
                mov dx,Port_Register | out dx,al
                xor al,al
                mov dx,Port_Out | out dx,al
                inc cl
                dec ch
            while nz | wend
            mov ch,300h
            do
                call WaitPort
                mov al,Opn_OnOff
                mov dx,Port_Register | out dx,al
                call Wait1
                mov al,cl
                mov dx,Port_Out | out dx,al
                inc cl
                dec ch
            while nz | wend
        sti
    pop dx | pop cx | pop bx | pop ax
ret


E3 equ 1
F3 equ 2
F3S equ 3
G3 equ 4
G3S equ 5
A3 equ 6
A3S equ 7
B3 equ 8
C4 equ 9
C4S equ 10
D4 equ 11
D4S equ 12
E4 equ 13
F4 equ 14
F4S equ 15
G4 equ 16
G4S equ 17
A4 equ 18
A4S equ 19
B4 equ 20
C5 equ 21
C5S equ 22
D5 equ 23
D5S equ 24
E5 equ 25
F5 equ 26
F5S equ 27
G5 equ 28

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defw 757 ; E3
defw 714 ; F3
defw 674 ; F#3
defw 636 ; G3
defw 601 ; G#3
defw 567 ; A3
defw 535 ; A#3
defw 505 ; B3
defw 477 ; C4
defw 450 ; C#4
defw 424 ; D4
defw 401 ; D#4
defw 378 ; E4
defw 357 ; F4
defw 337 ; F#4
defw 318 ; G4
defw 300 ; G#4
defw 283 ; A4
defw 267 ; A#4
defw 252 ; B4
defw 238 ; C5
defw 225 ; C#5
defw 212 ; D5
defw 200 ; D#5
defw 189 ; E5
defw 178 ; F5
defw 168 ; F#5
defw 159 ; G5

OpnScales:
defb 19,11 ; E3
defb 19,57 ; F3
defb 19,106 ; F#3
defb 19,158 ; G3
defb 19,213 ; G#3
defb 20,16 ; A3
defb 20,78 ; A#3
defb 20,143 ; B3
defb 26,106 ; C4
defb 26,143 ; C#4
defb 26,182 ; D4
defb 26,223 ; D#4
defb 27,11 ; E4
defb 27,57 ; F4
defb 27,106 ; F#4
defb 27,158 ; G4
defb 27,213 ; G#4
defb 28,16 ; A4
defb 28,78 ; A#4
defb 28,143 ; B4
defb 34,106 ; C5
defb 34,143 ; C#5
defb 34,182 ; D5
defb 34,223 ; D#5
defb 35,11 ; E5
defb 35,57 ; F5
defb 35,106 ; F#5
defb 35,158 ; G5
