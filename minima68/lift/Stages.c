#include "Stage.h"
#include "Stages.h"

static const byte[] Monsters0 = {
	2 | (4 << 4),
};

static const byte[] Items0 = {
	6 | (0 << 4), 0,
	13 | (0 << 4), 0,
	4 | (1 << 4), 1,
	11 | (1 << 4), 1,
	7 | (2 << 4), 2,
	13 | (2 << 4), 2,
	4 | (3 << 4), 3,
	3 | (4 << 4), 3,
};

static const byte[] Lifts0 = {
	0 | (0 << 4), (4 << 4) | 4,
	15 | (0 << 4), (4 << 4) | 1,
};

static const byte[] Monsters1 = {
	2 | (0 << 4),
};

static const byte[] Items1 = {
	9 | (0 << 4), 3,
	13 | (0 << 4), 0,
	11 | (1 << 4), 0,
	7 | (2 << 4), 3,
	13 | (2 << 4), 1,
	4 | (3 << 4), 2,
	13 | (3 << 4), 1,
	3 | (4 << 4), 2,
};

static const byte[] Lifts1 = {
	0 | (0 << 4), (4 << 4) | 4,
	15 | (0 << 4), (4 << 4) | 1,
};

static const byte[] Monsters2 = {
	1 | (4 << 4),
};

static const byte[] Items2 = {
	2 | (0 << 4), 0,
	3 | (1 << 4), 3,
	13 | (1 << 4), 3,
	8 | (2 << 4), 1,
	12 | (2 << 4), 2,
	2 | (3 << 4), 0,
	7 | (3 << 4), 1,
	13 | (3 << 4), 2,
};

static const byte[] Lifts2 = {
	0 | (0 << 4), (4 << 4) | 4,
	5 | (0 << 4), (4 << 4) | 3,
	10 | (0 << 4), (4 << 4) | 2,
	15 | (0 << 4), (4 << 4) | 1,
};

static const byte[] Monsters3 = {
	1 | (1 << 4),
};

static const byte[] Items3 = {
	3 | (0 << 4), 0,
	13 | (0 << 4), 0,
	4 | (1 << 4), 1,
	11 | (1 << 4), 1,
	7 | (2 << 4), 2,
	13 | (2 << 4), 2,
	4 | (3 << 4), 3,
	9 | (3 << 4), 3,
};

static const byte[] Lifts3 = {
	0 | (0 << 4), (2 << 4) | 1,
	15 | (0 << 4), (2 << 4) | 1,
	6 | (1 << 4), (3 << 4) | 2,
	12 | (2 << 4), (4 << 4) | 4,
};

static const byte[] Monsters4 = {
	1 | (0 << 4),
};

static const byte[] Items4 = {
	2 | (0 << 4), 0,
	3 | (1 << 4), 3,
	13 | (1 << 4), 3,
	8 | (2 << 4), 1,
	12 | (2 << 4), 0,
	2 | (3 << 4), 2,
	7 | (3 << 4), 1,
	13 | (3 << 4), 2,
};

static const byte[] Lifts4 = {
	0 | (0 << 4), (4 << 4) | 4,
	6 | (0 << 4), (2 << 4) | 1,
	11 | (0 << 4), (1 << 4) | 1,
	15 | (0 << 4), (3 << 4) | 1,
	10 | (2 << 4), (4 << 4) | 3,
	5 | (3 << 4), (4 << 4) | 4,
};

static const byte[] Monsters5 = {
	12 | (0 << 4),
	12 | (4 << 4),
};

static const byte[] Items5 = {
	3 | (0 << 4), 0,
	9 | (0 << 4), 1,
	14 | (0 << 4), 3,
	13 | (1 << 4), 2,
	3 | (2 << 4), 2,
	9 | (2 << 4), 3,
	1 | (3 << 4), 1,
	10 | (3 << 4), 0,
};

static const byte[] Lifts5 = {
	1 | (0 << 4), (2 << 4) | 2,
	7 | (0 << 4), (4 << 4) | 1,
	11 | (0 << 4), (2 << 4) | 2,
	15 | (0 << 4), (4 << 4) | 3,
	0 | (2 << 4), (4 << 4) | 3,
	13 | (2 << 4), (4 << 4) | 4,
};

static const byte[] Monsters6 = {
	3 | (0 << 4),
	1 | (4 << 4),
};

static const byte[] Items6 = {
	2 | (0 << 4), 0,
	3 | (1 << 4), 3,
	13 | (1 << 4), 3,
	8 | (2 << 4), 1,
	12 | (2 << 4), 2,
	2 | (3 << 4), 0,
	7 | (3 << 4), 1,
	13 | (3 << 4), 2,
};

static const byte[] Lifts6 = {
	0 | (0 << 4), (4 << 4) | 4,
	5 | (0 << 4), (4 << 4) | 3,
	10 | (0 << 4), (4 << 4) | 2,
	15 | (0 << 4), (4 << 4) | 1,
};

static const byte[] Monsters7 = {
	1 | (1 << 4),
	1 | (4 << 4),
};

static const byte[] Items7 = {
	3 | (0 << 4), 0,
	13 | (0 << 4), 0,
	4 | (1 << 4), 1,
	11 | (1 << 4), 1,
	7 | (2 << 4), 2,
	13 | (2 << 4), 2,
	4 | (3 << 4), 3,
	9 | (3 << 4), 3,
};

static const byte[] Lifts7 = {
	0 | (0 << 4), (4 << 4) | 3,
	6 | (0 << 4), (3 << 4) | 2,
	15 | (0 << 4), (4 << 4) | 1,
	12 | (1 << 4), (4 << 4) | 4,
};

static const byte[] Monsters8 = {
	2 | (2 << 4),
	2 | (4 << 4),
};

static const byte[] Items8 = {
	3 | (0 << 4), 0,
	13 | (0 << 4), 0,
	4 | (1 << 4), 1,
	11 | (1 << 4), 1,
	7 | (2 << 4), 2,
	13 | (2 << 4), 2,
	4 | (3 << 4), 3,
	1 | (4 << 4), 3,
};

static const byte[] Lifts8 = {
	5 | (0 << 4), (4 << 4) | 3,
	10 | (0 << 4), (4 << 4) | 1,
};

static const byte[] Monsters9 = {
	1 | (4 << 4),
};

static const byte[] Items9 = {
	1 | (0 << 4), 2,
	14 | (0 << 4), 1,
	4 | (1 << 4), 0,
	1 | (2 << 4), 2,
	2 | (3 << 4), 3,
	9 | (3 << 4), 0,
	11 | (3 << 4), 1,
	12 | (4 << 4), 3,
};

static const byte[] Lifts9 = {
	0 | (0 << 4), (4 << 4) | 3,
	7 | (0 << 4), (4 << 4) | 4,
	15 | (0 << 4), (4 << 4) | 1,
};

const Stage[] Stages = {
	{
		{ 0xfa, 0x7f, 0xfe, 0x7f, 0xf6, 0x7f, 0xfe, 0x7f,  }, // floorBits
		14 | (4 << 4), // manPosition
		1, Monsters0,
		8, Items0,
		2, Lifts0,
	},
	{
		{ 0xfe, 0x7b, 0xfa, 0x7d, 0xde, 0x7f, 0xfa, 0x7f,  }, // floorBits
		14 | (4 << 4), // manPosition
		1, Monsters1,
		8, Items1,
		2, Lifts1,
	},
	{
		{ 0xde, 0x7b, 0xde, 0x7b, 0xde, 0x7b, 0xde, 0x7b,  }, // floorBits
		13 | (0 << 4), // manPosition
		1, Monsters2,
		8, Items2,
		4, Lifts2,
	},
	{
		{ 0xfa, 0x7f, 0xbe, 0x7f, 0xb6, 0x6f, 0xbe, 0xef,  }, // floorBits
		14 | (4 << 4), // manPosition
		1, Monsters3,
		8, Items3,
		4, Lifts3,
	},
	{
		{ 0xbe, 0x77, 0xbe, 0x77, 0xbe, 0x7b, 0xde, 0x7b,  }, // floorBits
		13 | (0 << 4), // manPosition
		1, Monsters4,
		8, Items4,
		6, Lifts4,
	},
	{
		{ 0x7d, 0x77, 0x7d, 0x77, 0x7c, 0x57, 0x7e, 0x5f,  }, // floorBits
		2 | (4 << 4), // manPosition
		2, Monsters5,
		8, Items5,
		6, Lifts5,
	},
	{
		{ 0xde, 0x7b, 0xde, 0x7b, 0xde, 0x7b, 0xde, 0x7b,  }, // floorBits
		13 | (0 << 4), // manPosition
		2, Monsters6,
		8, Items6,
		4, Lifts6,
	},
	{
		{ 0xba, 0x7f, 0xbe, 0x6f, 0xb6, 0x6f, 0xbe, 0x6f,  }, // floorBits
		13 | (4 << 4), // manPosition
		2, Monsters7,
		8, Items7,
		4, Lifts7,
	},
	{
		{ 0xde, 0x7b, 0xda, 0x7b, 0xde, 0x7b, 0xde, 0x7b,  }, // floorBits
		14 | (4 << 4), // manPosition
		2, Monsters8,
		8, Items8,
		2, Lifts8,
	},
	{
		{ 0x42, 0x40, 0x10, 0x00, 0x02, 0x00, 0x04, 0x0e,  }, // floorBits
		13 | (4 << 4), // manPosition
		1, Monsters9,
		8, Items9,
		3, Lifts9,
	},
};
