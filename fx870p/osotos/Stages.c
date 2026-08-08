#include "Stage.h"
#include "Stages.h"

static const byte[] Blocks0 = {
	(4 << 4) | 0,
	(1 << 4) | 2,
	(2 << 4) | 3,
	(9 << 4) | 3,
};

static const byte[] Enemies0 = {
	(0 << 4) | 0,
	(11 << 4) | 2,
};

static const byte[] Blocks1 = {
	(4 << 4) | 0,
	(8 << 4) | 0,
	(6 << 4) | 1,
	(1 << 4) | 2,
	(9 << 4) | 2,
};

static const byte[] Enemies1 = {
	(8 << 4) | 1,
	(0 << 4) | 3,
};

static const byte[] Blocks2 = {
	(4 << 4) | 0,
	(7 << 4) | 0,
	(10 << 4) | 0,
	(4 << 4) | 1,
	(7 << 4) | 1,
	(10 << 4) | 1,
	(3 << 4) | 3,
};

static const byte[] Enemies2 = {
	(4 << 4) | 2,
	(0 << 4) | 3,
};

static const byte[] Blocks3 = {
	(5 << 4) | 0,
	(4 << 4) | 1,
	(4 << 4) | 2,
	(7 << 4) | 2,
	(3 << 4) | 3,
};

static const byte[] Enemies3 = {
	(1 << 4) | 3,
	(4 << 4) | 3,
};

static const byte[] Blocks4 = {
	(8 << 4) | 0,
	(8 << 4) | 1,
	(3 << 4) | 2,
	(6 << 4) | 2,
};

static const byte[] Enemies4 = {
	(1 << 4) | 0,
	(6 << 4) | 1,
};

static const byte[] Blocks5 = {
	(3 << 4) | 0,
	(9 << 4) | 1,
	(8 << 4) | 2,
};

static const byte[] Enemies5 = {
	(0 << 4) | 2,
	(3 << 4) | 2,
};

static const byte[] Blocks6 = {
	(4 << 4) | 0,
	(9 << 4) | 0,
	(5 << 4) | 1,
	(7 << 4) | 1,
};

static const byte[] Enemies6 = {
	(4 << 4) | 2,
	(5 << 4) | 2,
	(6 << 4) | 2,
	(7 << 4) | 2,
};

static const byte[] Blocks7 = {
	(4 << 4) | 0,
	(7 << 4) | 0,
	(5 << 4) | 1,
	(8 << 4) | 1,
	(1 << 4) | 2,
	(6 << 4) | 3,
};

static const byte[] Enemies7 = {
	(2 << 4) | 0,
	(5 << 4) | 0,
};

const Stage[] Stages = {
	{
		(1 << 4) | 3,
		4, Blocks0,
		2, Enemies0,
		{
			0x5d, 0x55, 0x1c, 
			0x75, 0x27, 0x95, 
			0xc5, 0x58, 0x75, 
			0x56, 0x59, 0x55, 
		},
	},
	{
		(4 << 4) | 1,
		5, Blocks1,
		2, Enemies1,
		{
			0xd5, 0xdd, 0x31, 
			0x5b, 0x55, 0x41, 
			0xb7, 0x55, 0x15, 
			0x5d, 0x67, 0xd5, 
		},
	},
	{
		(6 << 4) | 1,
		7, Blocks2,
		2, Enemies2,
		{
			0x3c, 0x55, 0x15, 
			0x0f, 0x55, 0x95, 
			0x3c, 0x01, 0x80, 
			0x55, 0xff, 0xbf, 
		},
	},
	{
		(8 << 4) | 0,
		5, Blocks3,
		2, Enemies3,
		{
			0xd7, 0x74, 0xd5, 
			0xd9, 0x15, 0x63, 
			0x36, 0x4d, 0x6d, 
			0x56, 0x55, 0x65, 
		},
	},
	{
		(11 << 4) | 3,
		4, Blocks4,
		2, Enemies4,
		{
			0xf4, 0x45, 0xd1, 
			0x55, 0x92, 0x21, 
			0x75, 0xd6, 0x01, 
			0xde, 0x55, 0x56, 
		},
	},
	{
		(11 << 4) | 0,
		3, Blocks5,
		2, Enemies5,
		{
			0x77, 0xdf, 0x5d, 
			0x5c, 0xdd, 0x94, 
			0x51, 0x65, 0xd5, 
			0xd6, 0x55, 0x59, 
		},
	},
	{
		(5 << 4) | 0,
		4, Blocks6,
		4, Enemies6,
		{
			0x00, 0x45, 0x15, 
			0x00, 0x74, 0x80, 
			0xfc, 0x55, 0xbf, 
			0xfe, 0xff, 0xbf, 
		},
	},
	{
		(11 << 4) | 0,
		6, Blocks7,
		2, Enemies7,
		{
			0x54, 0x75, 0x70, 
			0xf2, 0x37, 0x35, 
			0xc6, 0x4f, 0x9d, 
			0x56, 0xd5, 0x95, 
		},
	},
};
