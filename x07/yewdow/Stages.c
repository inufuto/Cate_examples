#include "Stage.h"
#include "Stages.h"

static const byte[] Cars0 = {
	(1 << 4) | 4,
};

static const byte[] Enemies0 = {
	(10 << 4) | 1,
};

static const byte[] Cars1 = {
	(5 << 4) | 5,
};

static const byte[] Enemies1 = {
	(2 << 4) | 2,
};

static const byte[] Cars2 = {
	(9 << 4) | 1,
};

static const byte[] Enemies2 = {
	(7 << 4) | 4,
	(3 << 4) | 6,
};

static const byte[] Cars3 = {
	(7 << 4) | 1,
};

static const byte[] Enemies3 = {
	(9 << 4) | 1,
	(4 << 4) | 6,
};

static const byte[] Cars4 = {
	(9 << 4) | 4,
};

static const byte[] Enemies4 = {
	(8 << 4) | 4,
	(1 << 4) | 6,
};

static const byte[] Cars5 = {
	(2 << 4) | 3,
	(6 << 4) | 5,
};

static const byte[] Enemies5 = {
	(1 << 4) | 5,
	(8 << 4) | 6,
};

static const byte[] Cars6 = {
	(4 << 4) | 4,
	(5 << 4) | 6,
};

static const byte[] Enemies6 = {
	(11 << 4) | 4,
	(0 << 4) | 6,
};

const Stage[] Stages = {
	{
		(6 << 4) | 4,
		{
			(4 << 4) | 2,
			(10 << 4) | 4,
			(2 << 4) | 3,
			(3 << 4) | 3,
			(5 << 4) | 1,
			(6 << 4) | 2,
			(1 << 4) | 1,
			(2 << 4) | 5,
		},
		1, Cars0,
		1, Enemies0,
		{
			0x55, 0x55, 0x55, 0x01, 0x40, 0x44, 0x51, 0x40, 
			0x40, 0x01, 0x00, 0x40, 0x01, 0x40, 0x44, 0x01, 
			0x02, 0x40, 0x55, 0x55, 0x55, 		},
	},
	{
		(10 << 4) | 5,
		{
			(2 << 4) | 0,
			(9 << 4) | 1,
			(3 << 4) | 5,
			(5 << 4) | 6,
			(4 << 4) | 4,
			(3 << 4) | 6,
			(7 << 4) | 0,
			(10 << 4) | 3,
		},
		1, Cars1,
		1, Enemies1,
		{
			0x01, 0x00, 0x00, 0x40, 0x04, 0x00, 0x01, 0x00, 
			0x00, 0x15, 0x14, 0x44, 0x15, 0x04, 0x44, 0x00, 
			0x00, 0x40, 0x05, 0x50, 0x51, 		},
	},
	{
		(5 << 4) | 1,
		{
			(8 << 4) | 3,
			(5 << 4) | 6,
			(5 << 4) | 2,
			(2 << 4) | 3,
			(11 << 4) | 3,
			(8 << 4) | 4,
			(4 << 4) | 4,
			(10 << 4) | 4,
		},
		1, Cars2,
		2, Enemies2,
		{
			0x00, 0x00, 0x15, 0x44, 0x01, 0x00, 0x40, 0x00, 
			0x21, 0x00, 0x10, 0x00, 0x55, 0x18, 0x00, 0x05, 
			0x50, 0x04, 0x15, 0x00, 0x00, 		},
	},
	{
		(4 << 4) | 2,
		{
			(1 << 4) | 1,
			(4 << 4) | 3,
			(7 << 4) | 3,
			(1 << 4) | 6,
			(5 << 4) | 1,
			(6 << 4) | 1,
			(8 << 4) | 2,
			(6 << 4) | 5,
		},
		1, Cars3,
		2, Enemies3,
		{
			0x55, 0x05, 0x40, 0x01, 0x00, 0x40, 0x01, 0x00, 
			0x40, 0x10, 0x08, 0x50, 0x11, 0x44, 0x01, 0x61, 
			0x05, 0x00, 0x00, 0x04, 0x91, 		},
	},
	{
		(10 << 4) | 3,
		{
			(11 << 4) | 1,
			(11 << 4) | 2,
			(6 << 4) | 3,
			(8 << 4) | 5,
			(2 << 4) | 3,
			(5 << 4) | 3,
			(2 << 4) | 1,
			(3 << 4) | 5,
		},
		1, Cars4,
		2, Enemies4,
		{
			0x50, 0x15, 0x00, 0x44, 0x64, 0x19, 0x14, 0x04, 
			0x10, 0x04, 0x00, 0x00, 0x14, 0x00, 0x50, 0x04, 
			0x68, 0x54, 0x50, 0x55, 0x55, 		},
	},
	{
		(4 << 4) | 2,
		{
			(3 << 4) | 2,
			(9 << 4) | 3,
			(9 << 4) | 5,
			(10 << 4) | 5,
			(3 << 4) | 5,
			(4 << 4) | 5,
			(4 << 4) | 3,
			(5 << 4) | 3,
		},
		2, Cars5,
		2, Enemies5,
		{
			0x51, 0x55, 0x01, 0x91, 0x65, 0x22, 0x11, 0x00, 
			0x00, 0x05, 0x00, 0x11, 0x51, 0x54, 0x19, 0x11, 
			0x44, 0x01, 0x59, 0x15, 0x94, 		},
	},
	{
		(8 << 4) | 4,
		{
			(2 << 4) | 3,
			(9 << 4) | 6,
			(4 << 4) | 0,
			(3 << 4) | 3,
			(5 << 4) | 2,
			(8 << 4) | 2,
			(9 << 4) | 1,
			(2 << 4) | 2,
		},
		2, Cars6,
		2, Enemies6,
		{
			0x01, 0x50, 0x00, 0x09, 0x00, 0x10, 0x01, 0x20, 
			0x10, 0x01, 0x42, 0x14, 0x01, 0x00, 0x10, 0x01, 
			0x04, 0x40, 0x14, 0x01, 0x51, 		},
	},
};