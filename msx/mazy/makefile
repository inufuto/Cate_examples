name=mazy

filename=$(name)
all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Knife.asm: Knife.c Knife.h Map.h Math.h VVram.h Chars.h \
	Man.h Status.h Sound.h Monster.h Main.h 
Main.asm: Main.c Main.h ScanKeys.h Man.h Knife.h Monster.h \
	Status.h Vram.h Sound.h VVram.h Map.h 
Man.asm: Man.c Man.h Map.h ScanKeys.h Chars.h Vram.h \
	VVram.h Main.h Knife.h Sound.h 
Map.asm: Map.c Map.h CopyMemory.h Main.h Stages.h Man.h \
	Knife.h Monster.h VVram.h Chars.h 
Monster.asm: Monster.c Monster.h Map.h Chars.h VVram.h Man.h \
	Main.h Sound.h 
Status.asm: Status.c Status.h Vram.h Main.h Chars.h Print.h \
	Knife.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Map.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm BIOS.inc BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
stages.obj: stages.asm 
Startup.obj: Startup.asm BIOS.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc Chars.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Map.obj Monster.obj Status.obj \
	Vram.obj VVram.obj Chars.obj CopyMemory.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj stages.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).rom: chead.obj $(objects) makefile 
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8500 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas C500 C000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8500

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8500 8000 $(objects)

Loader.bin: Loader.obj
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
