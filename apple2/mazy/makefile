name=mazy

start=7000

all: $(name).dsk

.asm.obj:
	Asm65 $*.asm

apple2.obj: apple2.asm apple2.inc KeyBits.inc ZeroPage.inc 
knife.obj: knife.asm char.inc zeropage.inc 
Loader.obj: Loader.asm BinSize.inc
man.obj: man.asm KeyBits.inc mazy.inc char.inc zeropage.inc apple2.inc 
map.obj: map.asm zeropage.inc map.inc char.inc 
mazy.obj: mazy.asm KeyBits.inc ZeroPage.inc 
mon.obj: mon.asm char.inc zeropage.inc 
sound.obj: sound.asm apple2.inc zeropage.inc 
stages.obj: stages.asm 
status.obj: status.asm zeropage.inc apple2.inc mazy.inc char.inc 
vram.obj: vram.asm zeropage.inc apple2.inc mazy.inc char.inc map.inc 

objects = mazy.obj \
	apple2.obj knife.obj man.obj map.obj mon.obj sound.obj \
	stages.obj status.obj vram.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects)
	LinkLE $(name).bin $(start) 1000 $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(start)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
