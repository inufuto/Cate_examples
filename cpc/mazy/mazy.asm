include "cpc.inc"
include "KeyBits.inc"

	
dseg
Score	defw 0	| public Score
HiScore defw 0 | public HiScore
Man.Count defb 0 | public Man.Count 
Snd.Address defw 0 | public Snd.Address
Clock defb 0
TimeRate defb 0 | public TimeRate

extrn Init, Fin, WaitTimer
extrn InitMap
extrn stage, Stage.Clear, Stage.Time
extrn BaseX, BaseY
extrn man.status.die
extrn MapToVVram, VVramToVram
extrn ScanKeys
extrn Man.Move, Man.Draw, Man.Die
extrn Kn.Move, Kn.Draw, Kn.Invnt
extrn Mon.Move, Mon.Draw
extrn Goal.Draw
extrn PrintStatus, Print.Over, TitleScreen, PrintTime, PrintTimeup, PrintScore
extrn Sound_Get,Sound_Start, Sound_Clear, Sound_GameOver, Sound_Loose
extrn StartBGM, StopBGM

cseg

entry:	public entry
	call Init

	ld hl,0
	ld (Score),hl
	ld (HiScore),hl
	ld (Stage.Time),hl
	ld a,3
	ld (Man.Count),a
	xor	a
	ld (Kn.Invnt),a
	ld	(stage), a
	Title: public Title
	call TitleScreen
	do
		; call ScanStop
		; jr z, Exit
		call ScanKeys
		ld c,a
		and  Keys_Button0
	while z | wend

	StartGame:
	ld hl,0
	ld (Score),hl
	ld a,3
	ld (Man.Count),a
	ld a,c
	and Keys_Button1
	if z
		xor a
		ld	(stage), a
	endif	
	StartStage:
	xor	a
	ld (man.status.die),a
	ld (Clock),a
	ld (BaseX),a
	ld (BaseY),a
	ld (Stage.Clear),a
	call InitMap
	call PrintStatus
	call MapToVVram
	call Man.Draw
	call Mon.Draw
	call Goal.Draw
	call kn.Draw
	call VVramToVram
	call Sound_Start
	call StartBGM
	ld hl,0
	ld (Snd.Address),hl
	loop:
		call kn.Move
		call Man.Move
		call Mon.Move
		call kn.Move

		call MapToVVram
		call Man.Draw
		call Mon.Draw
		call Goal.Draw
		call kn.Draw

		ld a,5
		call WaitTimer
		call VVramToVram
		call Sound
		;do
		;	ld a,(TimerCount)
		;	or a
		;while nz
		;wend
		
		ld hl,(clock)
		ld a,l
		inc a
		cp h
		if nc
			xor a
			ld (clock),a
			ld hl,(Stage.Time)
			dec hl
			ld (Stage.Time),hl
			push hl
				call PrintTime
			pop hl
			ld a,l
			or h
			if z 
				call StopBGM
				call PrintTimeup
				ld b,15
				do
					call Sound_Loose
				dwnz
				jr Die
			endif
		else
			ld (clock),a
		endif

		ld a,(man.status.die)
		or a
		if nz
			call StopBGM
			call Man.Die
			Die:
			ld hl,Man.Count 
			dec (hl)
			jr z, GameOver
			jr StartStage
		endif
		ld a,(Stage.Clear)
		or a
		if nz
			call StopBGM
			call Man.Draw
			call VVramToVram
			call Sound_Clear
			ld hl,(Stage.Time)
			do
				ld a,l
				or h
			while nz
				push hl
					ld de,1
					call AddScore
					call PrintTime
					call Sound_Get
					ld a,1
					call WaitTimer
				pop hl
				dec hl
				ld (Stage.Time),hl
			wend
			ld a,(Stage)
			inc a
			ld (Stage),a
			jr StartStage
		endif
		; call ScanStop
		; jr z, Exit
	jr loop
	GameOver: public GameOver
		call Print.Over
		call Sound_GameOver
	jr Title
	; Exit:
    ; call Fin
ret	


Sound:
	ld hl,(Snd.Address)
	ld a,l
	or h
	ret z
	xor a
	ld (Snd.Address),a
	ld (Snd.Address+1),a
jp (hl)

AddScore: public AddScore
; in:
;	de points to add
	push hl
	ld hl,(Score)
	add hl,de
	ld (Score),hl
	ex de,hl
	ld hl,(HiScore)
	sbc hl,de
	if c
		ex de,hl
		ld (HiScore),hl
	endif
	call PrintScore
	pop hl
ret