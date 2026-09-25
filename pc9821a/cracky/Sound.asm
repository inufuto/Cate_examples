ext WaitTimer_

Tempo equ 160

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

MaxVol equ 63

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
Channel_UnitSize equ Channel_VolumeRegister+1
Channel_Bits equ Channel_VolumeRegister

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
time: defw 0

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
        mov ah,[si+Channel_Bits]
        or ah,0f0h
        call WriteRegisterW
    pop dx
ret

EndOpn:
    call WaitPort
    push dx
        mov dx,Port0
        mov al,Opn_OnOff
        mov ah,[si+Channel_Bits]
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
    ; call WaitPort
    ; mov ax,0010h
    ; call WriteRegisterW
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
    mov ah,38h or 80h
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
    mov ah,Psg_VolumeA
    mov cx,PsgCount or (Psg_ToneA shr 8)
    do
        mov dx,Port0
        mov word ptr [di+Channel_Port],dx
        mov word ptr [di+Channel_StartProc],StartPsg
        mov word ptr [di+Channel_EndProc],EndPsg
        mov word ptr [di+Channel_DecProc],DecleasePsg
        mov word ptr [di+Channel_ToneRegister],ch
        mov word ptr [di+Channel_VolumeRegister],ah
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
                mov word ptr [di+Channel_Port],dx
                mov word ptr [di+Channel_StartProc],StartOpn
                mov word ptr [di+Channel_EndProc],EndOpn
                mov word ptr [di+Channel_DecProc],DummyProc
                mov al,ch | add al,Opn_Channel-Opn_Operator
                mov word ptr [di+Channel_ToneRegister],al
                mov word ptr [di+Channel_Bits],ah
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
    mov word ptr [di+Channel_Port],dx
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


Melody0:
    push ax | push dx
        mov dx,Port0
        cli
            mov [Channel0+Channel_Ptr],bx
            mov byte ptr [Channel0+Channel_Len],1
            mov al,Psg_VolumeA
            out dx,al
            inc dx | inc dx
            xor al,al
            out dx,al
            dec dx | dec dx
        sti
    pop dx | pop ax
ret

MelodyWait0:
    call Melody0
    do
        cmp word ptr [Channel0+Channel_Ptr],0
    while nz | wend
ret 


Melody4:
    push ax | push dx
        mov dx,Port0
        cli
            mov [Channel4+Channel_Ptr],bx
            mov byte ptr [Channel4+Channel_Len],1
            mov al,Psg_VolumeA
            out dx,al
            inc dx | inc dx
            xor al,al
            out dx,al
            dec dx | dec dx
        sti
    pop dx | pop ax
ret

MelodyWait4:
    call Melody4
    do
        cmp word ptr [Channel4+Channel_Ptr],0
    while nz | wend
ret 


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push ax | push bx
        mov bx,hit_notes
        call Melody0
    pop bx | pop ax
ret


beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push ax | push bx
        mov bx,beep_notes
        call MelodyWait0
    pop bx | pop ax
ret


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push ax | push bx
        mov bx,loose_notes
        call MelodyWait0
    pop bx | pop ax
ret


start_notes: 
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N1,C5
    defb 0
Sound_Start_: public Sound_Start_
    push ax | push bx
        mov bx,start_notes
        call MelodyWait4
    pop bx | pop ax
ret

clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5,0       
    defb 0
Sound_Clear_: public Sound_Clear_
    push ax | push bx
        mov bx,clear_notes
        call MelodyWait4
    pop bx | pop ax
ret

over_notes: 
    defb N8,C5, N8,C5, N8,G4, N8,G4, N8,A4, N8,A4, N8,B4, N8,B4
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push ax | push bx
        mov bx,over_notes
        call MelodyWait4
    pop bx | pop ax
ret


BGM_B:
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,D5, N4,F5
    defb N8,F5, N8,E5, N8,C5, N4,C5, N4,D5
    
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N4,F5, N4,F5, N4,E5, N4,E5
    defb N4,D5, N8,D5, N4,E5, N8,E5, N8,D5, N8,C5
    
    defb N4,C5, N4,C5, N8,D5, N4,D5, N4P,C5, N2P,0
    defb 0ffh

BGM_C:
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0 ; 3
    defb N8,A3, N4,0, N4P,C4, N8,E4, N8,0 ; 4
    defb N8,D4, N4,0, N4P,F3, N8,A3, N8,0 ; 5
    defb N8,G3, N4,0, N4P,B3, N8,D4, N8,0 ; 6
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0 ; 7
    defb N8,A3, N4,0, N4P,C4, N8,E4, N8,0 ; 8
    defb N8,F3, N4,0, N4P,A3, N8,C4, N8,0 ; 9
    defb N8,D4, N4,0, N4P,E4, N8,A3, N8,0 ; 10
    defb N8,F3, N4,0, N8,F3, N8,G3, N8,0, N8,B3, N8,D4 ; 11
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0 ; 12
    defb 0ffh

BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4  ;3  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4  ;4  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,F4  ;5  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4, N8,0, N8,G4  ;6  G

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4  ;7  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4  ;8  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,F4  ;9  F
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,F4  ;10 Dm

    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4, N8,0, N8,G4  ;11 F G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4  ;12 C

    defb 0ffh
BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4  ;3  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4  ;4  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4  ;5  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4  ;6  G

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4  ;7  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4  ;8  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4  ;9  F
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4  ;10 Dm

    defb N4,C4, N8,0, N8,C4, N8,0, N8,D4, N8,0, N8,D4  ;11 F G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4  ;12 C

    defb 0ffh
BGM_D3:
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3  ;3  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3  ;4  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3  ;5  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3, N8,0, N8,B3  ;6  G

    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3  ;7  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3  ;8  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3  ;9  F
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3  ;10 Dm

    defb N4,A3, N8,0, N8,A3, N8,0, N8,G3, N8,0, N8,G3  ;11 F G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3  ;12 C

    defb 0ffh

BGM_E:
    defb N8,C3, N16,G3, N16,C4, N16,E4, N16,0, N16,G4, N16,0,  N8,0, N8,G3, N8,G4, N8,0 ; C
    defb N8,E3, N16,A3, N16,C4, N16,E4, N16,0, N16,A4, N16,0,  N8,0, N8,A3, N8,A4, N8,0 ; Am
    defb N8,D3, N16,A3, N16,D4, N16,F4, N16,0, N16,A4, N16,0,  N8,0, N8,A3, N8,A4, N8,0 ; Dm
    defb N8,G2, N16,G3, N16,B3, N16,D4, N16,0, N16,G4, N16,0,  N8,0, N8,G3, N8,G4, N8,0 ; G

    defb N8,C3, N16,G3, N16,C4, N16,E4, N16,0, N16,G4, N16,0,  N8,0, N8,G3, N8,G4, N8,0 ; C
    defb N8,E3, N16,A3, N16,C4, N16,E4, N16,0, N16,A4, N16,0,  N8,0, N8,A3, N8,A4, N8,0 ; Am
    ; defb N8,F4, N8,0, N8,F4, N8,F4,  N8,0, N8,F4, N8,F4, N8,0 ; F
    defb N8,F3, N16,A3, N16,C4, N16,F4, N16,0, N16,A4, N16,0,  N8,F3, N16,A3, N16,C4, N16,F4, N16,0, N16,A4, N16,0 ;F
    defb N8,D3, N16,A3, N16,D4, N16,F4, N16,0, N16,A4, N16,0,  N8,D3, N16,A3, N16,D4, N16,F4, N16,0, N16,A4, N16,0 ; Dm
    ; defb N8,D4, N8,0, N8,D4, N8,D4,  N8,0, N8,D4, N8,D4, N8,0 ; Dm

    defb N8,F3, N16,A3, N16,C4, N16,F4, N16,0, N16,A4, N16,0,  N8,G2, N16,G3, N16,B3, N16,D4, N16,0, N16,G4, N16,0 ;F G
    ; defb N8,C4, N8,0, N8,C4, N8,C4,  N8,0, N8,C4, N8,C4, N8,0 ; C
    defb N8,C3, N16,G3, N16,C4, N16,E4, N16,0, N16,G4, N16,0,  N8,0, N8,G3, N8,G4, N8,0 ; C
    
    defb 0ffh

BGM_R:
    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,SD, N8,SD
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,SD, N8,SD, N8,SD

    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,SD, N8,SD

    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,SD, N8,SD, N8,SD, N8,BD+SD, N8,SD, N8,SD, N8,SD

    defb 0ffh

BGM:
    defw BGM_C,BGM_B,BGM_E
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


C2 equ 1
C2S equ 2
D2 equ 3
D2S equ 4
E2 equ 5
F2 equ 6
F2S equ 7
G2 equ 8
G2S equ 9
A2 equ 10
A2S equ 11
B2 equ 12
C3 equ 13
C3S equ 14
D3 equ 15
D3S equ 16
E3 equ 17
F3 equ 18
F3S equ 19
G3 equ 20
G3S equ 21
A3 equ 22
A3S equ 23
B3 equ 24
C4 equ 25
C4S equ 26
D4 equ 27
D4S equ 28
E4 equ 29
F4 equ 30
F4S equ 31
G4 equ 32
G4S equ 33
A4 equ 34
A4S equ 35
B4 equ 36
C5 equ 37
C5S equ 38
D5 equ 39
D5S equ 40
E5 equ 41
F5 equ 42

BD equ 01h
SD equ 02h
CY equ 04h
HH equ 08h

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

cycles:
defw 1908 ; C2
defw 1800 ; C#2
defw 1699 ; D2
defw 1604 ; D#2
defw 1514 ; E2
defw 1429 ; F2
defw 1349 ; F#2
defw 1273 ; G2
defw 1202 ; G#2
defw 1134 ; A2
defw 1070 ; A#2
defw 1010 ; B2
defw 954 ; C3
defw 900 ; C#3
defw 849 ; D3
defw 802 ; D#3
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
defw 357 ; F
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

OpnScales:
defb 10,106 ; C2
defb 10,143 ; C#2
defb 10,182 ; D2
defb 10,223 ; D#2
defb 11,11 ; E2
defb 11,57 ; F2
defb 11,106 ; F#2
defb 11,158 ; G2
defb 11,213 ; G#2
defb 12,16 ; A2
defb 12,78 ; A#2
defb 12,143 ; B2
defb 18,106 ; C3
defb 18,143 ; C#3
defb 18,182 ; D3
defb 18,223 ; D#3
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
defb 27,57 ; F
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
