#include "Stage.h"
#include "Stages.h"

static const byte[] Cars0 = {
	(1 << 4) | 6,
};

static const byte[] Enemies0 = {
	(14 << 4) | 1,
};

static const byte[] Cars1 = {
	(6 << 4) | 8,
};

static const byte[] Enemies1 = {
	(3 << 4) | 3,
};

static const byte[] Cars2 = {
	(12 << 4) | 2,
};

static const byte[] Enemies2 = {
	(9 << 4) | 7,
	(8 << 4) | 9,
};

static const byte[] Cars3 = {
	(9 << 4) | 1,
};

static const byte[] Enemies3 = {
	(12 << 4) | 2,
	(2 << 4) | 9,
};

static const byte[] Cars4 = {
	(12 << 4) | 7,
};

static const byte[] Enemies4 = {
	(10 << 4) | 7,
	(2 << 4) | 9,
};

static const byte[] Cars5 = {
	(3 << 4) | 4,
	(9 << 4) | 8,
};

static const byte[] Enemies5 = {
	(13 << 4) | 6,
	(1 << 4) | 8,
};

static const byte[] Cars6 = {
	(5 << 4) | 6,
	(6 << 4) | 9,
};

static const byte[] Enemies6 = {
	(15 << 4) | 3,
	(15 << 4) | 5,
};

static const byte[] Cars7 = {
	(10 << 4) | 5,
	(3 << 4) | 6,
};

static const byte[] Enemies7 = {
	(1 << 4) | 3,
	(15 << 4) | 7,
};

const Stage[] Stages = {
	{
		(8 << 4) | 6,
		{
			(5 << 4) | 3,
			(13 << 4) | 8,
			(2 << 4) | 5,
			(5 << 4) | 5,
			(6 << 4) | 2,
			(8 << 4) | 3,
			(6 << 4) | 7,
			(3 << 4) | 9,
		},
		1, Cars0,
		1, Enemies0,
		{
			0x55, 0x55, 0x55, 0x55, 0x01, 0x00, 0x00, 0x40, 
			0x41, 0x41, 0x04, 0x45, 0x41, 0x01, 0x04, 0x40, 
			0x01, 0x00, 0x40, 0x40, 0x01, 0x50, 0x04, 0x41, 
			0x01, 0x00, 0x04, 0x40, 0x41, 0x00, 0x44, 0x40, 
			0x41, 0x08, 0x04, 0x40, 0x01, 0x00, 0x00, 0x40, 
			0x55, 0x55, 0x55, 0x55, 		},
	},
	{
		(13 << 4) | 8,
		{
			(2 << 4) | 1,
			(12 << 4) | 2,
			(4 << 4) | 8,
			(6 << 4) | 9,
			(5 << 4) | 6,
			(4 << 4) | 9,
			(6 << 4) | 2,
			(13 << 4) | 5,
		},
		1, Cars1,
		1, Enemies1,
		{
			0x00, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x20, 0x80, 0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 
			0x15, 0x40, 0x01, 0x00, 0x05, 0x40, 0x00, 0x11, 
			0x15, 0x40, 0x00, 0x11, 0x05, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x10, 0x50, 
			0x05, 0x00, 0x15, 0x54, 		},
	},
	{
		(7 << 4) | 2,
		{
			(12 << 4) | 4,
			(7 << 4) | 9,
			(7 << 4) | 4,
			(2 << 4) | 5,
			(14 << 4) | 4,
			(11 << 4) | 7,
			(5 << 4) | 6,
			(13 << 4) | 6,
		},
		1, Cars2,
		2, Enemies2,
		{
			0x04, 0x00, 0x10, 0x05, 0x04, 0x05, 0x00, 0x00, 
			0x04, 0x01, 0x00, 0x00, 0x00, 0x01, 0x10, 0x20, 
			0x00, 0x00, 0x11, 0x00, 0x00, 0x00, 0x10, 0x00, 
			0x55, 0x81, 0x01, 0x00, 0x00, 0x00, 0x11, 0x14, 
			0x05, 0x00, 0x15, 0x04, 0x00, 0x20, 0x00, 0x00, 
			0x15, 0x10, 0x01, 0x00, 		},
	},
	{
		(3 << 4) | 1,
		{
			(1 << 4) | 1,
			(5 << 4) | 4,
			(9 << 4) | 4,
			(1 << 4) | 9,
			(8 << 4) | 1,
			(6 << 4) | 2,
			(11 << 4) | 3,
			(8 << 4) | 8,
		},
		1, Cars3,
		2, Enemies3,
		{
			0x45, 0x15, 0x00, 0x10, 0x01, 0x00, 0x00, 0x00, 
			0x21, 0x00, 0x00, 0x10, 0x01, 0x00, 0x00, 0x10, 
			0x00, 0x90, 0x00, 0x00, 0x00, 0x00, 0x04, 0x15, 
			0x01, 0x01, 0x00, 0x00, 0x51, 0x15, 0x44, 0x00, 
			0x91, 0x15, 0x00, 0x00, 0x00, 0x00, 0x40, 0x24, 
			0x50, 0x54, 0x00, 0x00, 		},
	},
	{
		(13 << 4) | 5,
		{
			(14 << 4) | 3,
			(14 << 4) | 5,
			(7 << 4) | 5,
			(11 << 4) | 9,
			(2 << 4) | 4,
			(6 << 4) | 4,
			(3 << 4) | 2,
			(4 << 4) | 9,
		},
		1, Cars4,
		2, Enemies4,
		{
			0x40, 0x45, 0x01, 0x00, 0x54, 0x00, 0x40, 0x02, 
			0x04, 0x05, 0x06, 0x54, 0x14, 0x11, 0x00, 0x04, 
			0x44, 0x00, 0x00, 0x44, 0x24, 0x00, 0x00, 0x00, 
			0x14, 0x00, 0x00, 0x44, 0x54, 0x00, 0x01, 0x00, 
			0x40, 0x28, 0x00, 0x55, 0x40, 0x04, 0x00, 0x51, 
			0x40, 0x40, 0x05, 0x01, 		},
	},
	{
		(8 << 4) | 4,
		{
			(8 << 4) | 5,
			(12 << 4) | 5,
			(5 << 4) | 8,
			(13 << 4) | 8,
			(9 << 4) | 4,
			(5 << 4) | 6,
			(5 << 4) | 4,
			(7 << 4) | 5,
		},
		2, Cars5,
		2, Enemies5,
		{
			0x51, 0x55, 0x55, 0x55, 0x51, 0x56, 0x96, 0x64, 
			0x51, 0x55, 0x56, 0x54, 0x51, 0x15, 0x50, 0x54, 
			0x05, 0x00, 0x50, 0x54, 0x51, 0x11, 0x08, 0x50, 
			0x51, 0x11, 0x00, 0x51, 0x51, 0x55, 0x55, 0x56, 
			0x51, 0x51, 0x51, 0x51, 0x59, 0x55, 0x55, 0x61, 
			0x51, 0x55, 0x55, 0x55, 		},
	},
	{
		(11 << 4) | 6,
		{
			(3 << 4) | 3,
			(13 << 4) | 9,
			(2 << 4) | 2,
			(2 << 4) | 8,
			(6 << 4) | 1,
			(10 << 4) | 1,
			(11 << 4) | 1,
			(7 << 4) | 8,
		},
		2, Cars6,
		2, Enemies6,
		{
			0x41, 0x40, 0x45, 0x00, 0x19, 0x00, 0x02, 0x24, 
			0x01, 0x00, 0x00, 0x10, 0x01, 0x00, 0x00, 0x04, 
			0x01, 0x00, 0x04, 0x55, 0x00, 0x08, 0x04, 0x15, 
			0x01, 0x00, 0x00, 0x20, 0x01, 0x44, 0x00, 0x10, 
			0x00, 0x00, 0x00, 0x10, 0x05, 0x44, 0x40, 0x10, 
			0x55, 0x40, 0x40, 0x10, 		},
	},
	{
		(10 << 4) | 6,
		{
			(8 << 4) | 2,
			(5 << 4) | 5,
			(10 << 4) | 2,
			(12 << 4) | 9,
			(12 << 4) | 7,
			(7 << 4) | 8,
			(7 << 4) | 3,
			(1 << 4) | 7,
		},
		2, Cars7,
		2, Enemies7,
		{
			0x40, 0x55, 0x55, 0x00, 0x08, 0x50, 0x55, 0x11, 
			0x44, 0x52, 0x40, 0x11, 0x10, 0x00, 0x40, 0x11, 
			0x05, 0x40, 0x40, 0x11, 0x55, 0x00, 0x00, 0x11, 
			0x05, 0x00, 0x40, 0x15, 0x01, 0x45, 0x01, 0x14, 
			0x51, 0x05, 0x00, 0x54, 0x55, 0x99, 0x01, 0x54, 
			0x55, 0x56, 0x55, 0x55, 		},
	},
};