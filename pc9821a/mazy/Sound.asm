ext WaitTimer_

Tempo equ 220

Port0 equ 0188h
Port1 equ 018ch
StatusPort equ 0188h

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10

Opn_OnOff equ 28h
Opn_Operator equ 30h
Opn_Channel equ 0a0h

HighNoise equ 0f0h
LowNoise equ 0f1h

MaxVol equ 63
LowNoiseValue equ 31
HighNoiseValue equ LowNoiseValue*3/2


Def_Port equ 0
Def_Tone equ Def_Port+2
Def_Declease equ Def_Tone+2
Def_Register equ Def_Declease+2
Def_UnitSize equ Def_Register+1

PsgCount equ 3
OpnCount equ 3
AllCount equ PsgCount+OpnCount*2+1
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
Channel_Port equ Channel_Vol+1
Channel_StartProc equ Channel_Port+2
Channel_EndProc equ Channel_StartProc+2
Channel_DecProc equ Channel_EndProc+2
Channel_ToneRegister equ Channel_DecProc+2
Channel_VolumeRegister equ Channel_ToneRegister+1
Channel_Bit equ Channel_VolumeRegister+1
Channel_UnitSize equ Channel_Bit+1

dseg
Channels: public Channels
Channel0: ; PSG
    defs Channel_UnitSize
Channel1: ; PSG
    defs Channel_UnitSize
Channel2: ; PSG
    defs Channel_UnitSize
Channel3: ; OPN0
    defs Channel_UnitSize
Channel4: ; OPN0
    defs Channel_UnitSize
Channel5: ; OPN0
    defs Channel_UnitSize
Channel6: ; OPN1
    defs Channel_UnitSize
Channel7: ; OPN1
    defs Channel_UnitSize
Channel8: ; OPN1
    defs Channel_UnitSize
Channel9: ; Rhythm
    defs Channel_UnitSize
time: 
    defw 0
mixerValue: 
defb 0

cseg
WaitPort: ;(dx)
    push ax | push dx
        xor ah,ah
        mov dx,StatusPort
        do
            inc ah
            in al,dx
            and al,80h
        while nz | wend
    pop dx | pop ax
ret

WaitOut:
    push cx
        mov cx,50
        do
            out 5fh,al
        wloop
    pop cx
ret

WriteRegister:
; al:register, ah:value, dx:port
    out dx,al
    inc dx | inc dx
    out 5fh,al | out 5fh,al
    mov al,ah
    out dx,al
    dec dx | dec dx
    out 5fh,al | out 5fh,al
ret

WriteRegisterW:
; al:register, ah:value, dx:port
    out dx,al
    call WaitOut
    inc dx | inc dx
    mov al,ah
    out dx,al
    call WaitOut
    dec dx | dec dx
ret

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
OrganTone:
    defb 114,116,20,18
    defb 50,0,0,0
    defb 31,29,29,29
    defb 20,0,0,0
    defb 0,0,0,0
    defb 72,10,10,10
    defb 54

Tones:
    defw BassTone,PianoTone,OrganTone
    defw PianoTone,PianoTone,PianoTone

SetTone: ; (dx=port, bx=pTone, cl=register)
    mov ch,24
    do
        call WaitPort
        mov al,cl
        mov ah,[bx] | inc bx
        call WriteRegisterW
        add cl,4
        dec ch
    while nz | wend
    call WaitPort
    mov al,cl | add al,20h
    mov ah,[bx] | inc bx
    call WriteRegisterW
    ; add al,4
    ; mov ah,[bx] | inc bx
    ; call WriteRegisterW
ret


StartPsg: ;(al=note)
    cmp al,HighNoise
    if z
        mov ah,HighNoiseValue
        startNoise:
        mov al,Psg_Noise
        call WriteRegister
        mov ah,[mixerValue]
        mov bl,[si+Channel_Bit]
        or ah,bl
        shl bl,1 | shl bl,1 | shl bl,1
        not bl
        and ah,bl
        mov [mixerValue],ah
        mov al,Psg_Mixer
        call WriteRegister
        ret
    endif
    cmp al,LowNoise
    if z
        mov ah,LowNoiseValue
        jmp startNoise
    endif
    dec al
    shl al,1
    xor ah,ah
    add ax,cycles
    mov bx,ax
    mov al,[si+Channel_ToneRegister]
    push ax
        mov ah,[bx]
        call WriteRegister
    pop ax
    inc bx
    inc al
    mov ah,[bx]
    call WriteRegister

    mov ah,[mixerValue]
    mov bl,[si+Channel_Bit] | mov bh,bl
    shl bl,1 | shl bl,1 | shl bl,1
    or ah,bl
    not bh
    and ah,bh
    mov [mixerValue],ah
    mov al,Psg_Mixer
    call WriteRegister
ret

EndPsg:
    mov al,[si+Channel_VolumeRegister]
    xor ah,ah
    call WriteRegister
ret

DecleasePsg:
    mov al,[si+Channel_VolumeRegister]
    mov ah,[si+Channel_Vol]
    shr ah,1 | shr ah,1
    call WriteRegister
ret

StartOpn:
    dec al
    shl al,1
    xor ah,ah
    add ax,OpnScales
    mov bx,ax

    call WaitPort
    mov al,[si+Channel_ToneRegister]
    add al,04h
    mov ah,[bx]
    inc bx
    call WriteRegisterW

    call WaitPort
    mov al,[si+Channel_ToneRegister]
    mov ah,[bx]
    call WriteRegisterW

    call WaitPort
    push dx
        mov dx,Port0
        mov al,Opn_OnOff
        mov ah,[si+Channel_Bit]
        or ah,0f0h
        call WriteRegisterW
    pop dx
ret

EndOpn:
    call WaitPort
    push dx
        mov dx,Port0
        mov al,Opn_OnOff
        mov ah,[si+Channel_Bit]
        call WriteRegisterW
    pop dx
ret

StartRhythm: ;(al=note)
    call WaitPort
    mov ah,al
    mov al,10h
    call WriteRegisterW
ret

EndRhythm:
ret

DummyProc:
ret

InitSound: public InitSound
    mov dx,0A460h
    mov al,1 | out dx,al

    call WaitPort
    mov dx,Port0
    mov ax,8029h
    call WriteRegisterW

    mov dx,Port0
    mov ah,(0b8h and 03fh) or 80h
    mov [mixerValue],ah
    mov al,Psg_Mixer
    call WriteRegister

    xor al,al
    mov bx,Channels
    mov cl,Channel_UnitSize*AllCount
    do
        mov [bx],al
        inc bx
        dec cl
    while nz | wend

    mov di,Channels
    mov ax,01h or (Psg_VolumeA shl 8)
    mov cx,PsgCount or (Psg_ToneA shr 8)
    mov dx,Port0
    do
        mov [di+Channel_Port],dx
        mov word ptr [di+Channel_StartProc],StartPsg
        mov word ptr [di+Channel_EndProc],EndPsg
        mov word ptr [di+Channel_DecProc],DecleasePsg
        mov [di+Channel_ToneRegister],ch
        mov [di+Channel_VolumeRegister],ah
        mov [di+Channel_Bit],al
        shl al,1
        inc ch | inc ch
        inc ah
        add di,Channel_UnitSize
        dec cl
    while nz | wend
    mov si,Tones
    mov dx,Port0
    xor ah,ah
    mov cl,2
    do
        push cx
            mov cx,OpnCount or (Opn_Operator shl 8)
            do
                mov [di+Channel_Port],dx
                mov word ptr [di+Channel_StartProc],StartOpn
                mov word ptr [di+Channel_EndProc],EndOpn
                mov word ptr [di+Channel_DecProc],DummyProc
                mov al,ch | add al,Opn_Channel-Opn_Operator
                mov [di+Channel_ToneRegister],al
                mov [di+Channel_Bit],ah
                push ax | push cx
                    mov bx,[si] | inc si | inc si
                    mov cl,ch
                    call SetTone
                pop cx | pop ax
                inc ch
                inc ah
                add di,Channel_UnitSize
                dec cl
            while nz | wend
            push ax
                mov ax,Opn_OnOff
                call WriteRegisterW
            pop ax
            inc ah
        pop cx
        add dx,Port1-Port0
        dec cl
    while nz | wend
    mov dx,Port0
    mov [di+Channel_Port],dx
    mov word ptr [di+Channel_StartProc],StartRhythm
    mov word ptr [di+Channel_EndProc],EndRhythm
    mov word ptr [di+Channel_DecProc],DummyProc

    mov ax,3f11h
    call WriteRegisterW
    mov ax,0df18h
    do
        push ax
            call WriteRegisterW
        pop ax
        inc al
        cmp al,1dh+1
    while nz | wend

    mov si,Channels
    mov cl,AllCount
    do
        mov dx,[si+Channel_Port]
        push cx | push di
            call word ptr [si+Channel_EndProc]
        pop di | pop cx
        add si,Channel_UnitSize
        dec cl
    while nz | wend

    xor ax,ax
    mov [time],ax
ret


SoundHandler: public SoundHandler
    push ax
        mov ax,[time]
        sub ax,Tempo
        if b
            push ax | push bx | push cx | push dx| push si
                mov si,Channels
                mov ch,AllCount
                do
                    mov dx,[si+Channel_Port]
                    mov bx,[si+Channel_Ptr]
                    or bx,bx
                    if nz
                        dec byte ptr [si+Channel_Len]
                        if z
                            call word ptr [si+Channel_EndProc]
                            continue:
                            mov al,[bx]
                            or al,al
                            if z
                                ; end
                                mov word ptr [si+Channel_Ptr],0
                                mov byte ptr [si+Channel_Vol],0
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
                                call word ptr [si+Channel_StartProc]
                                mov byte ptr [si+Channel_Vol],MaxVol
                            else
                                mov byte ptr [si+Channel_Vol],0
                            endif
                            EndWriteCycle:
                        endif
                        call word ptr [si+Channel_DecProc]

                        mov al,[si+Channel_Vol]
                        or al,al
                        if nz
                            dec al
                            mov [si+Channel_Vol],al
                        endif
                    endif
                    next:
                    inc cl
                    add si,Channel_UnitSize
                    dec ch
                while nz | wend
            pop si | pop dx | pop cx | pop bx | pop ax
            add ax,600/2
        endif
        mov [time],ax
    pop ax
ret

Melody:
    push ax | push dx
        mov dx,[si+Channel_Port]
        cli
            mov [si+Channel_Ptr],bx
            mov byte ptr [si+Channel_Len],1
        sti
    pop dx | pop ax
ret

MelodyWait: 
    call Melody
    do
        cmp word ptr [si+Channel_Ptr],0
    while nz | wend
ret

Melody0:
    push si
        mov si,Channel0
        call Melody
    pop si
ret

MelodyWait0:
    push si
        mov si,Channel0
        call MelodyWait
    pop si
ret

Melody1:
    push si
        mov si,Channel1
        call Melody
    pop si
ret

MelodyWait1:
    push si
        mov si,Channel1
        call MelodyWait
    pop si
ret

Melody4:
    push si
        mov si,Channel4
        call Melody
    pop si
ret

MelodyWait4:
    push si
        mov si,Channel4
        call MelodyWait
    pop si
ret


; void Sound_Get();
beep_notes:
    defb 1,A4, 0
Sound_Get_: public Sound_Get_
    push bx
        mov bx,beep_notes
        call Melody0
    pop bx
ret
; void Sound_Beep();
Sound_Beep_: public Sound_Beep_
    push bx
        mov bx,beep_notes
        call MelodyWait0
    pop bx
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push bx
        mov bx,hit_notes
        call Melody0
    pop bx
ret

; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push bx
        mov bx,loose_notes
        call MelodyWait0
    pop bx
ret


; void Sound_Start();
start_notes: 
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0
Sound_Start_: public Sound_Start_
    push ax | push bx
        mov bx,start_notes
        call MelodyWait4
    pop bx | pop ax
ret

; void Sound_Clear();
clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_Clear_: public Sound_Clear_
    push bx
        mov bx,clear_notes
        call MelodyWait4
    pop bx
ret

; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax | push bx
        mov bx,over_notes
        call MelodyWait4
    pop bx | pop ax
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

BGM_D1:
    defb N4P,0
    defb N4P,F4, N4P,F4, N4,F4  ;F
    defb N4P,E4, N4P,E4, N4,E4  ;C
    defb N2,F4, N2,G4, N2+N8,E4, N4P,0 ;F G Am
    defb N4P,E4, N4P,E4, N4,E4  ;Am
    defb N4P,G4, N4P,G4, N4,G4  ;G
    defb N2,F4, N2,E4, N2+N8,F4 ;F C F
    defb 0ffh

BGM_D2:
    defb N4P,0
    defb N4P,C4, N4P,C4, N4,C4  ;F
    defb N4P,C4, N4P,C4, N4,C4  ;C
    defb N2,C4, N2,D4, N2+N8,C4, N4P,0 ;F G Am
    defb N4P,C4, N4P,C4, N4,C4  ;Am
    defb N4P,D4, N4P,D4, N4,D4  ;G
    defb N2,C4, N2,C4, N2+N8,C4 ;F C F
    defb 0ffh

BGM_D3:
    defb N4P,0
    defb N4P,A3, N4P,A3, N4,A3  ;F
    defb N4P,G3, N4P,G3, N4,G3  ;C
    defb N2,A3, N2,B3, N2+N8,A3, N4P,0 ;F G Am
    defb N4P,A3, N4P,A3, N4,A3  ;Am
    defb N4P,B3, N4P,B3, N4,B3  ;G
    defb N2,A3, N2,G3, N2+N8,A3 ;F C F
    defb 0ffh

BGM_R:
    defb N8,SD, N8,SD, N8,SD
    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD
    defb 0ffh

BGM:
    defw BGM_C,BGM_B,0
    defw BGM_D1,BGM_D2,BGM_D3
    defw BGM_R

StartBGM_: public StartBGM_
    push ax | push bx | push cx | push dx | push si
        cli
            mov bx,BGM
            mov si,Channel3
            mov cl,OpnCount*2+1
            do
                mov ax,[bx] | inc bx | inc bx
                mov [si+Channel_Start],ax
                mov [si+Channel_Ptr],ax
                mov byte ptr[si+Channel_Len],1
                add si,Channel_UnitSize
                dec cl
            while nz | wend
        sti
    pop si | pop dx | pop cx | pop bx | pop ax
ret

StopBGM_: public StopBGM_
    push ax | push bx | push cx | push dx | push si
        cli
            mov si,Channel3
            mov cl,OpnCount*2+1
            do
                xor ax,ax
                mov [si+Channel_Ptr],ax
                mov [si+Channel_Len],al
                call word ptr[si+Channel_EndProc]
                add si,Channel_UnitSize
                dec cl
            while nz | wend
        sti
    pop si | pop dx | pop cx | pop bx | pop ax
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

BD equ 01h
SD equ 02h
CY equ 04h
HH equ 08h

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
