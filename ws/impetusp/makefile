name=impetusp

all: $(name).ws

cseg=0000
dseg=0000

.c.asm:
	Cate86.exe -dseg $*.c

.asm.obj:
	Asm86.exe -v2 -dseg $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Movable.h Vram.h Math.h \
	Main.h Chars.h Bang.h Movable.h Main.h Fighter.h \
	Movable.h Sound.h 
Enemy.asm: Enemy.c Enemy.h Movable.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Movable.h Sprite.h Movable.h Chars.h \
	Vram.h Math.h Fighter.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Vram.h Sprite.h Movable.h \
	Chars.h Main.h Status.h ScanKeys.h FighterBullet.h Movable.h \
	Bang.h Movable.h Barrier.h Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Movable.h Sprite.h Movable.h Chars.h \
	Fighter.h Movable.h Sound.h Vram.h SkyEnemy.h Enemy.h \
	Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h Barrier.h \
	Fort.h 
Fort.asm: Fort.c Fort.h VVram.h Main.h Chars.h Stage.h \
	Movable.h Bang.h Movable.h EnemyBullet.h Movable.h Math.h \
	Sound.h Vram.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Stage.h Enemy.h Movable.h Sprite.h \
	Movable.h Vram.h Chars.h Stage.h Math.h Main.h \
	Bang.h Movable.h Sound.h EnemyBullet.h Movable.h 
Item.asm: Item.c Item.h Movable.h Vram.h Sprite.h Movable.h \
	Chars.h Fighter.h Movable.h Status.h Main.h Sound.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Vram.h Stage.h \
	Sound.h Sprite.h Movable.h Fighter.h Movable.h SkyEnemy.h \
	Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h \
	FighterBullet.h Movable.h EnemyBullet.h Movable.h Bang.h Movable.h \
	Barrier.h Fort.h Item.h Movable.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Enemy.h Movable.h Sprite.h Movable.h \
	Chars.h Main.h Math.h Stage.h Vram.h Fighter.h \
	Movable.h Bang.h Movable.h Sound.h EnemyBullet.h Movable.h \
	Barrier.h Item.h Movable.h 
Stage.asm: Stage.c Stage.h Main.h VVram.h Math.h CopyMemory.h \
	Movable.h Status.h Sprite.h Movable.h Fighter.h Movable.h \
	SkyEnemy.h Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h \
	Movable.h FighterBullet.h Movable.h EnemyBullet.h Movable.h Barrier.h \
	Bang.h Movable.h Fort.h Item.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
VVram.asm: VVram.c VVram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FortA.obj: FortA.asm Vram.inc VVram.inc Chars.inc 
Map.obj: Map.asm 
Math.obj: Math.asm 
Metadata.obj: Metadata.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm ws.inc 
Sound.obj: Sound.asm ws.inc 
Sprite.obj: Sprite.asm ws.inc Vram.inc Chars.inc 
StageA.obj: StageA.asm Vram.inc VVram.inc Chars.inc 
Startup.obj: Startup.asm ws.inc Vram.inc 
TerrainChars.obj: TerrainChars.asm 
Tiles.obj: Tiles.asm Chars.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ws.inc Vram.inc VVram.inc Chars.inc 

objects = Vectors.obj Startup.obj \
	Bang.obj Barrier.obj Enemy.obj EnemyBullet.obj Fighter.obj FighterBullet.obj \
	Fort.obj GroundEnemy.obj Item.obj Main.obj SkyEnemy.obj Stage.obj \
	Stages.obj Status.obj VVram.obj Chars.obj CopyMemory.obj FortA.obj \
	Map.obj Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	StageA.obj TerrainChars.obj Tiles.obj VramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe -dseg $(name).bin $(cseg) $(dseg) $(objects)

Metadata.bin: Metadata.obj makefile
	LinkLE.exe Metadata.bin fff0 0000 Metadata.obj

$(name).ws: $(name).bin  Metadata.bin ws.csx
	dotnet script ws.csx $(name)
