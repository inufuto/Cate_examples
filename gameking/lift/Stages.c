#include "Stage.h"
#include "Stages.h"

static const byte[] Monsters0 = {
	2 | (2 << 4),
};

static const byte[] Items0 = {
	4 | (0 << 4), 0,
	9 | (0 << 4), 0,
	1 | (1 << 4), 3,
	3 | (1 << 4), 1,
	8 | (1 << 4), 1,
	1 | (2 << 4), 3,
	4 | (2 << 4), 2,
	7 | (2 << 4), 2,
};

static const byte[] Lifts0 = {
	0 | (0 << 4), (2 << 4) | 2,
	11 | (0 << 4), (2 << 4) | 1,
};

static const byte[] Monsters1 = {
	1 | (0 << 4),
};

static const byte[] Items1 = {
	6 | (0 << 4), 3,
	9 | (0 << 4), 0,
	1 | (1 << 4), 2,
	4 | (1 << 4), 3,
	7 | (1 << 4), 0,
	3 | (2 << 4), 2,
	6 | (2 << 4), 1,
	9 | (2 << 4), 1,
};

static const byte[] Lifts1 = {
	0 | (0 << 4), (2 << 4) | 2,
	11 | (0 << 4), (2 << 4) | 1,
};

static const byte[] Monsters2 = {
	1 | (1 << 4),
};

static const byte[] Items2 = {
	3 | (0 << 4), 0,
	9 | (0 << 4), 0,
	3 | (1 << 4), 1,
	5 | (1 << 4), 2,
	7 | (1 << 4), 1,
	3 | (2 << 4), 3,
	6 | (2 << 4), 3,
	9 | (2 << 4), 2,
};

static const byte[] Lifts2 = {
	0 | (0 << 4), (1 << 4) | 1,
	11 | (0 << 4), (2 << 4) | 1,
	4 | (1 << 4), (2 << 4) | 2,
	8 | (1 << 4), (2 << 4) | 2,
};

static const byte[] Monsters3 = {
	1 | (2 << 4),
};

static const byte[] Items3 = {
	2 | (0 << 4), 0,
	9 | (0 << 4), 2,
	3 | (1 << 4), 3,
	7 | (1 << 4), 1,
	10 | (1 << 4), 3,
	2 | (2 << 4), 0,
	6 | (2 << 4), 1,
	10 | (2 << 4), 2,
};

static const byte[] Lifts3 = {
	0 | (0 << 4), (2 << 4) | 2,
	6 | (0 << 4), (1 << 4) | 1,
	8 | (0 << 4), (2 << 4) | 1,
	11 | (0 << 4), (2 << 4) | 1,
	4 | (1 << 4), (2 << 4) | 2,
};

static const byte[] Monsters4 = {
	1 | (0 << 4),
};

static const byte[] Items4 = {
	2 | (0 << 4), 0,
	7 | (0 << 4), 1,
	3 | (1 << 4), 3,
	6 | (1 << 4), 1,
	10 | (1 << 4), 3,
	2 | (2 << 4), 2,
	7 | (2 << 4), 0,
	10 | (2 << 4), 2,
};

static const byte[] Lifts4 = {
	0 | (0 << 4), (2 << 4) | 2,
	9 | (0 << 4), (1 << 4) | 1,
	11 | (0 << 4), (2 << 4) | 1,
	4 | (1 << 4), (2 << 4) | 2,
};

static const byte[] Monsters5 = {
	3 | (0 << 4),
	9 | (2 << 4),
};

static const byte[] Items5 = {
	2 | (0 << 4), 0,
	2 | (1 << 4), 0,
	6 | (1 << 4), 1,
	9 | (1 << 4), 2,
	5 | (2 << 4), 1,
	10 | (2 << 4), 2,
};

static const byte[] Lifts5 = {
	0 | (0 << 4), (2 << 4) | 2,
	4 | (0 << 4), (2 << 4) | 1,
	8 | (0 << 4), (2 << 4) | 2,
	11 | (0 << 4), (2 << 4) | 1,
};

static const byte[] Monsters6 = {
	1 | (2 << 4),
};

static const byte[] Items6 = {
	1 | (0 << 4), 2,
	10 | (0 << 4), 1,
	1 | (1 << 4), 2,
	3 | (1 << 4), 0,
	6 | (1 << 4), 0,
	8 | (1 << 4), 1,
	2 | (2 << 4), 3,
	4 | (2 << 4), 3,
};

static const byte[] Lifts6 = {
	0 | (0 << 4), (2 << 4) | 1,
	5 | (0 << 4), (2 << 4) | 2,
	11 | (0 << 4), (2 << 4) | 1,
};

const Stage[] Stages = {
	{
		{ 0xfa, 0xe7, 0x7f }, // floorBits
		10 | (2 << 4), // manPosition
		1, Monsters0,
		8, Items0,
		2, Lifts0,
	},
	{
		{ 0x7e, 0xe7, 0x7b }, // floorBits
		10 | (2 << 4), // manPosition
		1, Monsters1,
		8, Items1,
		2, Lifts1,
	},
	{
		{ 0xfa, 0xe7, 0x6e }, // floorBits
		10 | (2 << 4), // manPosition
		1, Monsters2,
		8, Items2,
		4, Lifts2,
	},
	{
		{ 0xbe, 0xe6, 0x6a }, // floorBits
		10 | (0 << 4), // manPosition
		1, Monsters3,
		8, Items3,
		5, Lifts3,
	},
	{
		{ 0xfe, 0xe5, 0x5e }, // floorBits
		10 | (0 << 4), // manPosition
		1, Monsters4,
		8, Items4,
		4, Lifts4,
	},
	{
		{ 0xee, 0xe6, 0x6e }, // floorBits
		6 | (0 << 4), // manPosition
		2, Monsters5,
		6, Items5,
		4, Lifts5,
	},
	{
		{ 0x12, 0xa4, 0x1c }, // floorBits
		10 | (2 << 4), // manPosition
		1, Monsters6,
		8, Items6,
		3, Lifts6,
	},
};
