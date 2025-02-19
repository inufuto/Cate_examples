name=impetus

filename=$(name)
filename1=$(name)1
filename2=$(name)2

all: $(filename) $(filename1) $(filename2)

cseg=8100
dseg=c400

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h VVram.h Sprite.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h VVram.h Math.h Main.h \
	Chars.h Stage.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h VVram.h \
	Math.h Chars.h 
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h VVram.h \
	SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h VVram.h Chars.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h Sound.h Vram.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h VVram.h Math.h \
	Main.h EnemyBullet.h Bang.h Main.h Sound.h Chars.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h Chars.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Vram.h Sprite.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h \
	Barrier.h GroundEnemy.h Fort.h Sound.h Item.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h VVram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h VVram.h Chars.h \
	CopyMemory.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h \
	Math.h Status.h Barrier.h GroundEnemy.h Fort.h Sprite.h \
	Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h VVram.h \
	Chars.h Print.h CopyMemory.h 
Vram.asm: Vram.c Vram.h VVram.h Barrier.h Fort.h Sprite.h 
VVram.asm: VVram.c VVram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm BIOS.inc Vram.inc VVram.inc Chars.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm 
SoundOpll.obj: SoundOpll.asm BIOS.inc 
SoundPsg.obj: SoundPsg.asm BIOS.inc 
Sprite.obj: Sprite.asm Vram.inc VVram.inc 
Startup.obj: Startup.asm BIOS.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj SoundOpll.obj SoundPsg.obj \
	Sprite.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name)1.hex: Init.obj Chars.obj makefile
	LinkLE.exe $(name)1.hex $(cseg) $(dseg) Init.obj Chars.obj

$(name)2.hex: $(objects) makefile
	LinkLE.exe $(name)2.hex $(cseg) $(dseg) $(objects)

$(filename1): $(name)1.hex
	ihx2bin $(name)1.hex $(filename1)

$(filename2): $(name)2.hex
	ihx2bin $(name)2.hex $(filename2)
