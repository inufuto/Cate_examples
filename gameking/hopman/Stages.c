#include "Stage.h"
#include "Stages.h"

static const byte[] Monsters0 = {
	1, 28, 38,
	2, 84, 94,
	0, 23, 31,
	1, 85, 92,
};

static const byte[] Lifts0 = {
	144, 10, // VERTICAL,10,0,2,
	49, 65, // HORIZONTAL,65,1,6,
};

static const byte[] Monsters1 = {
	1, 76, 83,
	2, 56, 64,
	1, 26, 32,
};

static const byte[] Lifts1 = {
	144, 89, // VERTICAL,89,0,2,
	144, 2, // VERTICAL,2,0,2,
	57, 45, // HORIZONTAL,45,1,7,
};

static const byte[] Monsters2 = {
	1, 45, 52,
	0, 41, 48,
	2, 89, 92,
};

static const byte[] Lifts2 = {
	144, 71, // VERTICAL,71,0,2,
	50, 2, // HORIZONTAL,2,2,6,
	137, 29, // VERTICAL,29,1,1,
};

static const byte[] Monsters3 = {
	1, 35, 50,
	1, 76, 81,
};

static const byte[] Lifts3 = {
	49, 83, // HORIZONTAL,83,1,6,
	144, 20, // VERTICAL,20,0,2,
	144, 64, // VERTICAL,64,0,2,
};

static const byte[] Monsters4 = {
	2, 84, 91,
	1, 44, 47,
};

static const byte[] Lifts4 = {
	41, 62, // HORIZONTAL,62,1,5,
	57, 28, // HORIZONTAL,28,1,7,
	66, 75, // HORIZONTAL,75,2,8,
};

static const byte[] Monsters5 = {
	2, 11, 22,
	1, 68, 74,
	2, 50, 57,
	1, 34, 38,
	1, 58, 62,
};

static const byte[] Lifts5 = {
	144, 23, // VERTICAL,23,0,2,
	144, 39, // VERTICAL,39,0,2,
};

static const byte[] Monsters6 = {
	1, 75, 80,
	2, 40, 44,
	2, 58, 62,
	1, 17, 20,
};

static const byte[] Lifts6 = {
	33, 65, // HORIZONTAL,65,1,4,
	33, 10, // HORIZONTAL,10,1,4,
	144, 32, // VERTICAL,32,0,2,
};

static const byte[] Monsters7 = {
	2, 25, 32,
	2, 53, 59,
	2, 45, 52,
	1, 20, 23,
};

static const byte[] Lifts7 = {
};

const Stage[] Stages = {
	{
		7,
		4, Monsters0,
		2, Lifts0,
		{
			0x00, 0x00, 0x40, 0x55, 0x56, 0x41, 0x55, 0x55, 0x02, 0x50, 0x55, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x60, 0x00, 0x00, 0x40, 0x55, 0x15, 0x00, 0x95, 0x55, 0x15, 0x50, 0x15, 0x54, 0x41, 0x56, 0x41, 0x01, 0x00, 0x55, 0x01, 0x40, 0x57, 0x55, 0x01, 
			0x55, 0x75, 0x45, 0x55, 0x05, 0x55, 0x54, 0x01, 0x00, 0x00, 0x59, 0x55, 0x55, 0x55, 0x95, 0x15, 0x50, 0x15, 0x00, 0x54, 0x15, 0x55, 0x55, 0x55, 
		},
	},
	{
		9,
		3, Monsters1,
		3, Lifts1,
		{
			0x40, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x16, 0x00, 0x00, 0x00, 0x54, 0x59, 0x25, 0x00, 0x40, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 
			0x00, 0x00, 0x40, 0x75, 0x55, 0x56, 0x50, 0x55, 0xc5, 0x55, 0x19, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x00, 0x55, 0x55, 0x00, 0x40, 0x05, 
			0x05, 0x40, 0x55, 0x95, 0x55, 0x01, 0x05, 0x00, 0x00, 0x00, 0x00, 0x50, 0x55, 0x64, 0x95, 0x55, 0x55, 0x01, 0x50, 0x00, 0x55, 0x55, 0x51, 0x55, 
		},
	},
	{
		12,
		3, Monsters2,
		3, Lifts2,
		{
			0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x65, 0x55, 0x05, 0x00, 0x54, 0x55, 0x01, 0x54, 0x59, 0x00, 0x00, 0x00, 0x95, 0x55, 0x01, 0x50, 0x55, 0x09, 
			0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x50, 0x55, 0x65, 0x01, 0x54, 0x55, 0x0d, 0x00, 0x64, 0x55, 0x16, 0x01, 0x00, 0x50, 0x94, 0x05, 0x00, 
			0x05, 0x00, 0x54, 0x15, 0x77, 0x95, 0x15, 0x50, 0x00, 0x00, 0x14, 0x54, 0x55, 0x65, 0x55, 0x55, 0x55, 0x15, 0x54, 0x95, 0xd9, 0x55, 0x55, 0x55, 
		},
	},
	{
		10,
		2, Monsters3,
		3, Lifts3,
		{
			0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x56, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x00, 0x74, 0x47, 0xd7, 0x05, 0x00, 0x00, 0x00, 0x40, 0x65, 0x55, 0x55, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe0, 0x55, 0x16, 0x00, 0x50, 0x0d, 
			0x75, 0x57, 0x95, 0x00, 0x00, 0x94, 0x55, 0x55, 0x55, 0x55, 0xde, 0x01, 0xf0, 0x97, 0x55, 0x59, 0x94, 0x15, 0x00, 0x00, 0x00, 0x11, 0x01, 0x50, 
		},
	},
	{
		21,
		2, Monsters4,
		3, Lifts4,
		{
			0x76, 0x01, 0x50, 0x97, 0x06, 0x54, 0x59, 0x0c, 0x00, 0x00, 0x00, 0x50, 0x95, 0x01, 0x54, 0x16, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x00, 0x04, 0x00, 0x00, 0xd4, 0x15, 0x00, 0x00, 0x00, 0x55, 0x01, 0x55, 0x17, 0x44, 0x5d, 0x05, 0x00, 0x82, 0x20, 0x08, 0x82, 0x00, 0x00, 0x00, 
			0x55, 0xd4, 0x95, 0x19, 0x8a, 0xd5, 0x35, 0x71, 0x1f, 0x00, 0x74, 0x94, 0x55, 0x17, 0xc0, 0xd6, 0x01, 0x00, 0x10, 0x00, 0x00, 0x65, 0x65, 0x50, 
		},
	},
	{
		18,
		5, Monsters5,
		2, Lifts5,
		{
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x65, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0x06, 0x0c, 0x00, 0x00, 0x00, 
			0x40, 0x57, 0x51, 0x95, 0x03, 0x00, 0x90, 0x24, 0x90, 0x15, 0x00, 0x48, 0x2d, 0x00, 0x51, 0x16, 0x14, 0x65, 0x55, 0x55, 0x56, 0x50, 0x55, 0x0d, 
			0x25, 0x00, 0x75, 0x55, 0x56, 0x15, 0x00, 0x00, 0x56, 0x15, 0x00, 0x7f, 0x55, 0x55, 0x15, 0x40, 0xbd, 0x5d, 0xd7, 0x59, 0x55, 0x84, 0x55, 0x55, 
		},
	},
	{
		17,
		4, Monsters6,
		3, Lifts6,
		{
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x16, 0x00, 0x58, 0x00, 
			0x50, 0x95, 0x05, 0x40, 0x94, 0x01, 0x00, 0x00, 0x54, 0x79, 0x00, 0x40, 0x25, 0x05, 0xd0, 0x65, 0x01, 0x50, 0x7e, 0x59, 0x01, 0xc0, 0x19, 0x03, 
			0x55, 0x02, 0x20, 0x40, 0x66, 0x45, 0x75, 0x59, 0x00, 0x00, 0x55, 0x11, 0x00, 0x40, 0x5d, 0x15, 0x05, 0x00, 0x00, 0x00, 0xb0, 0x5d, 0x59, 0x57, 
		},
	},
	{
		20,
		4, Monsters7,
		0, Lifts7,
		{
			0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x02, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90, 0x24, 0x49, 0x92, 0x24, 0x00, 
			0x00, 0x00, 0x59, 0x00, 0x05, 0x55, 0x00, 0x00, 0xf5, 0x12, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0x59, 0x95, 0x55, 0x00, 0x05, 
			0x51, 0x19, 0xc0, 0xd5, 0x00, 0x00, 0x54, 0x55, 0x01, 0x80, 0x24, 0x54, 0x56, 0x55, 0x55, 0x75, 0x64, 0x55, 0x95, 0x44, 0x65, 0x51, 0x05, 0x5f, 
		},
	},
};