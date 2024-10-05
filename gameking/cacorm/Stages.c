#include "Stage.h"
#include "Stages.h"

static const byte[] Items0 = {
	(1 << 4) | 1,
	(10 << 4) | 4,
	(3 << 4) | 5,
	(9 << 4) | 5,
};

static const byte[] Enemies0 = {
	(11 << 4) | 2,
};

static const byte[] Items1 = {
	(5 << 4) | 1,
	(10 << 4) | 1,
	(8 << 4) | 3,
	(1 << 4) | 5,
	(9 << 4) | 5,
};

static const byte[] Enemies1 = {
	(6 << 4) | 1,
};

static const byte[] Items2 = {
	(10 << 4) | 2,
	(1 << 4) | 3,
	(5 << 4) | 3,
	(3 << 4) | 5,
};

static const byte[] Enemies2 = {
	(11 << 4) | 4,
};

static const byte[] Items3 = {
	(3 << 4) | 1,
	(2 << 4) | 3,
	(6 << 4) | 3,
	(10 << 4) | 4,
	(10 << 4) | 5,
};

static const byte[] Enemies3 = {
	(2 << 4) | 0,
	(1 << 4) | 6,
};

static const byte[] Items4 = {
	(1 << 4) | 1,
	(8 << 4) | 1,
	(8 << 4) | 3,
	(9 << 4) | 3,
	(8 << 4) | 4,
	(2 << 4) | 5,
};

static const byte[] Enemies4 = {
	(11 << 4) | 1,
	(11 << 4) | 6,
};

static const byte[] Items5 = {
	(6 << 4) | 2,
	(1 << 4) | 4,
	(3 << 4) | 4,
	(10 << 4) | 4,
	(3 << 4) | 5,
	(8 << 4) | 5,
};

static const byte[] Enemies5 = {
	(11 << 4) | 1,
	(2 << 4) | 6,
};

static const byte[] Items6 = {
	(3 << 4) | 1,
	(9 << 4) | 1,
	(10 << 4) | 3,
	(5 << 4) | 4,
	(1 << 4) | 5,
	(2 << 4) | 5,
};

static const byte[] Enemies6 = {
	(10 << 4) | 0,
	(1 << 4) | 1,
	(2 << 4) | 4,
};

static const byte[] Items7 = {
	(1 << 4) | 1,
	(2 << 4) | 1,
	(7 << 4) | 2,
	(5 << 4) | 3,
	(1 << 4) | 5,
	(3 << 4) | 5,
	(7 << 4) | 5,
	(8 << 4) | 5,
};

static const byte[] Enemies7 = {
	(0 << 4) | 0,
	(5 << 4) | 0,
	(11 << 4) | 0,
	(7 << 4) | 6,
};

const Stage[] Stages = {
	{
		(6 << 4) | 4,
		4, Items0,
		1, Enemies0,
		{
			0x80, 0x80, 
			0x62, 0x88, 
			0x00, 0x02, 
			0x84, 0x00, 
			0x0e, 0xe0, 
			0x00, 		},
	},
	{
		(6 << 4) | 5,
		5, Items1,
		1, Enemies1,
		{
			0x00, 0xe0, 
			0x10, 0x00, 
			0xc0, 0x42, 
			0x28, 0x04, 
			0x00, 0xb0, 
			0x00, 		},
	},
	{
		(2 << 4) | 1,
		4, Items2,
		1, Enemies2,
		{
			0x07, 0x04, 
			0x06, 0x00, 
			0x80, 0x00, 
			0x00, 0x23, 
			0x12, 0x60, 
			0x08, 		},
	},
	{
		(11 << 4) | 6,
		5, Items3,
		2, Enemies3,
		{
			0x00, 0x22, 
			0x0e, 0x00, 
			0x00, 0x11, 
			0x11, 0x21, 
			0x06, 0x08, 
			0x01, 		},
	},
	{
		(5 << 4) | 4,
		6, Items4,
		2, Enemies4,
		{
			0x00, 0x8c, 
			0x06, 0x40, 
			0x10, 0x05, 
			0x51, 0x08, 
			0x00, 0x20, 
			0x01, 		},
	},
	{
		(5 << 4) | 4,
		6, Items5,
		2, Enemies5,
		{
			0x81, 0x10, 
			0x01, 0x14, 
			0x04, 0x10, 
			0x00, 0x00, 
			0x00, 0x40, 
			0x00, 		},
	},
	{
		(10 << 4) | 6,
		6, Items6,
		3, Enemies6,
		{
			0x00, 0x10, 
			0x46, 0x00, 
			0xb0, 0x10, 
			0x00, 0x01, 
			0x01, 0x00, 
			0x08, 		},
	},
	{
		(6 << 4) | 3,
		8, Items7,
		4, Enemies7,
		{
			0x00, 0x00, 
			0x03, 0x00, 
			0x40, 0x60, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 		},
	},
};
