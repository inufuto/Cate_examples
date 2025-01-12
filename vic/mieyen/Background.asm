include "Chars.inc"

cseg
UpperChars0: public UpperChars0 ; 12 $d1
	defb $00 ,Char_Space,Char_Space,Char_Space,Char_Space,Char_Space,Char_Space
	defb $10 ,Char_Space,Char_Space,Char_T10SW2,Char_Space,Char_Space,Char_T10SW2
	defb $40 ,Char_Space,Char_T40DD1,Char_Space,Char_Space,Char_C40DD1,Char_Space
	defb $50 ,Char_Space,Char_T40DD1,Char_T10SW2,Char_Space,Char_C40DD1,Char_T10SW2
	defb $80 ,Char_T80SF0,Char_T80FF1,Char_T80FS2,Char_C80SF0,Char_C80FF1,Char_C80FS2
	defb $90 ,Char_T80SF0,Char_T80FF1,Char_T90FW2,Char_C80SF0,Char_C80FF1,Char_C90FW2
	defb $01 ,Char_T01WS0,Char_Space,Char_Space,Char_T01WS0,Char_Space,Char_Space
	defb $11 ,Char_T01WS0,Char_Space,Char_T10SW2,Char_T01WS0,Char_Space,Char_T10SW2
	defb $41 ,Char_T01WS0,Char_T40DD1,Char_Space,Char_T01WS0,Char_C40DD1,Char_Space
	defb $51 ,Char_T01WS0,Char_T40DD1,Char_T10SW2,Char_T01WS0,Char_C40DD1,Char_T10SW2
	defb $81 ,Char_T81WF0,Char_T80FF1,Char_T80FS2,Char_C81WF0,Char_C80FF1,Char_C80FS2
	defb $91 ,Char_T81WF0,Char_T80FF1,Char_T90FW2,Char_C81WF0,Char_C80FF1,Char_C90FW2
LowerChars0: public LowerChars0 ; 2 $20
	defb $00 ,Char_T01WS0,Char_Space,Char_T10SW2
	defb $20 ,Char_B20WW0,Char_B20WW0,Char_B20WW0
UpperChars1: public UpperChars1 ; 18 $cd
	defb $00 ,Char_Space,Char_Space,Char_Space,Char_Space,Char_Space,Char_Space
	defb $40 ,Char_Space,Char_Space,Char_T40SD2,Char_Space,Char_Space,Char_C40SD2
	defb $80 ,Char_Space,Char_Space,Char_T80SF2,Char_Space,Char_Space,Char_C80SF2
	defb $01 ,Char_Space,Char_T01SW1,Char_T01WS2,Char_Space,Char_T01SW1,Char_T01WS2
	defb $41 ,Char_Space,Char_T01SW1,Char_T41WD2,Char_Space,Char_T01SW1,Char_C41WD2
	defb $81 ,Char_Space,Char_T01SW1,Char_T81WF2,Char_Space,Char_T01SW1,Char_C81WF2
	defb $04 ,Char_T04DD0,Char_Space,Char_Space,Char_C04DD0,Char_Space,Char_Space
	defb $44 ,Char_T04DD0,Char_Space,Char_T40SD2,Char_C04DD0,Char_Space,Char_C40SD2
	defb $84 ,Char_T04DD0,Char_Space,Char_T80SF2,Char_C04DD0,Char_Space,Char_C80SF2
	defb $05 ,Char_T04DD0,Char_T01SW1,Char_T01WS2,Char_C04DD0,Char_T01SW1,Char_T01WS2
	defb $45 ,Char_T04DD0,Char_T01SW1,Char_T41WD2,Char_C04DD0,Char_T01SW1,Char_C41WD2
	defb $85 ,Char_T04DD0,Char_T01SW1,Char_T81WF2,Char_C04DD0,Char_T01SW1,Char_C81WF2
	defb $08 ,Char_T08FF0,Char_T08FS1,Char_Space,Char_C08FF0,Char_C08FS1,Char_Space
	defb $48 ,Char_T08FF0,Char_T08FS1,Char_T40SD2,Char_C08FF0,Char_C08FS1,Char_C40SD2
	defb $88 ,Char_T08FF0,Char_T08FS1,Char_T80SF2,Char_C08FF0,Char_C08FS1,Char_C80SF2
	defb $09 ,Char_T08FF0,Char_T09FW1,Char_T01WS2,Char_C08FF0,Char_C09FW1,Char_T01WS2
	defb $49 ,Char_T08FF0,Char_T09FW1,Char_T41WD2,Char_C08FF0,Char_C09FW1,Char_C41WD2
	defb $89 ,Char_T08FF0,Char_T09FW1,Char_T81WF2,Char_C08FF0,Char_C09FW1,Char_C81WF2
LowerChars1: public LowerChars1 ; 4 $22
	defb $00 ,Char_Space,Char_T01SW1,Char_T01WS2
	defb $20 ,Char_Space,Char_T01SW1,Char_B20WW0
	defb $02 ,Char_B20WW0,Char_B20WW0,Char_T01WS2
	defb $22 ,Char_B20WW0,Char_B20WW0,Char_B20WW0
UpperChars2: public UpperChars2 ; 18 $cd
	defb $00 ,Char_Space,Char_Space,Char_Space,Char_Space,Char_Space,Char_Space
	defb $40 ,Char_Space,Char_Space,Char_T40DD2,Char_Space,Char_Space,Char_C40DD2
	defb $80 ,Char_Space,Char_T80SF1,Char_T80FF2,Char_Space,Char_C80SF1,Char_C80FF2
	defb $01 ,Char_T01SW0,Char_T01WS1,Char_Space,Char_T01SW0,Char_T01WS1,Char_Space
	defb $41 ,Char_T01SW0,Char_T01WS1,Char_T40DD2,Char_T01SW0,Char_T01WS1,Char_C40DD2
	defb $81 ,Char_T01SW0,Char_T81WF1,Char_T80FF2,Char_T01SW0,Char_C81WF1,Char_C80FF2
	defb $04 ,Char_T04DS0,Char_Space,Char_Space,Char_C04DS0,Char_Space,Char_Space
	defb $44 ,Char_T04DS0,Char_Space,Char_T40DD2,Char_C04DS0,Char_Space,Char_C40DD2
	defb $84 ,Char_T04DS0,Char_T80SF1,Char_T80FF2,Char_C04DS0,Char_C80SF1,Char_C80FF2
	defb $05 ,Char_T05DW0,Char_T01WS1,Char_Space,Char_C05DW0,Char_T01WS1,Char_Space
	defb $45 ,Char_T05DW0,Char_T01WS1,Char_T40DD2,Char_C05DW0,Char_T01WS1,Char_C40DD2
	defb $85 ,Char_T05DW0,Char_T81WF1,Char_T80FF2,Char_C05DW0,Char_C81WF1,Char_C80FF2
	defb $08 ,Char_T08FS0,Char_Space,Char_Space,Char_C08FS0,Char_Space,Char_Space
	defb $48 ,Char_T08FS0,Char_Space,Char_T40DD2,Char_C08FS0,Char_Space,Char_C40DD2
	defb $88 ,Char_T08FS0,Char_T80SF1,Char_T80FF2,Char_C08FS0,Char_C80SF1,Char_C80FF2
	defb $09 ,Char_T09FW0,Char_T01WS1,Char_Space,Char_C09FW0,Char_T01WS1,Char_Space
	defb $49 ,Char_T09FW0,Char_T01WS1,Char_T40DD2,Char_C09FW0,Char_T01WS1,Char_C40DD2
	defb $89 ,Char_T09FW0,Char_T81WF1,Char_T80FF2,Char_C09FW0,Char_C81WF1,Char_C80FF2
LowerChars2: public LowerChars2 ; 4 $22
	defb $00 ,Char_T01SW0,Char_T01WS1,Char_Space
	defb $20 ,Char_T01SW0,Char_B20WW0,Char_B20WW0
	defb $02 ,Char_B20WW0,Char_T01WS1,Char_Space
	defb $22 ,Char_B20WW0,Char_B20WW0,Char_B20WW0
