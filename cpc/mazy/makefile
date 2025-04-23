name=mazy

all: $(name).wav

cseg=4000
dseg=9000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

$(name).obj: $(name).asm cpc.inc KeyBits.inc
stages.obj:stages.asm
map.obj: map.asm char.inc
man.obj: man.asm KeyBits.inc mazy.inc char.inc
knife.obj: knife.asm char.inc
mon.obj: mon.asm char.inc

vram.obj: vram.asm cpc.inc  mazy.inc char.inc
Chars.obj: Chars.asm
Status.obj: Status.asm cpc.inc Mazy.inc Char.inc
sound.obj: sound.asm cpc.inc

objects=$(name).obj map.obj cpc.obj stages.obj vram.obj Chars.obj Status.obj \
	knife.obj man.obj mon.obj sound.obj Init.obj ScanKeys.obj

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cdt: $(name).bin
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
