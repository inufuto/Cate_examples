#include "Stage.h"
#include "Stages.h"

static const byte[] Bytes0 = {
	(1 << 2) | 1, (9 << 2) | 0, (4 << 2) | 1, (4 << 2) | 3, 
	(1 << 2) | 0, (1 << 2) | 1, (6 << 2) | 3, (1 << 2) | 1, 
	(0 << 2) | 3, (3 << 2) | 1, (5 << 2) | 1, (1 << 2) | 0, 
};

static const byte[] Enemies0 = {
	(0 << 4) | 5,
	(2 << 4) | 0,
};

static const byte[] Blocks0 = {
	(1 << 4) | 6,
	(3 << 4) | 5,
};

static const byte[] Bytes1 = {
	(7 << 2) | 2, (3 << 2) | 1, (2 << 2) | 1, (1 << 2) | 2, 
	(0 << 2) | 3, (0 << 2) | 1, (1 << 2) | 1, (2 << 2) | 3, 
	(3 << 2) | 1, (7 << 2) | 0, (2 << 2) | 1, (8 << 2) | 1, 
	(6 << 2) | 1, (4 << 2) | 0, 
};

static const byte[] Enemies1 = {
	(1 << 4) | 0,
	(1 << 4) | 9,
	(3 << 4) | 8,
};

static const byte[] Blocks1 = {
	(2 << 4) | 1,
	(2 << 4) | 9,
};

static const byte[] Bytes2 = {
	(1 << 2) | 3, (0 << 2) | 1, (8 << 2) | 0, (5 << 2) | 2, 
	(0 << 2) | 3, (3 << 2) | 1, (0 << 2) | 0, (2 << 2) | 1, 
	(0 << 2) | 3, (0 << 2) | 1, (3 << 2) | 1, (2 << 2) | 3, 
	(1 << 2) | 1, (9 << 2) | 0, (2 << 2) | 1, (4 << 2) | 1, 
	(3 << 2) | 0, 
};

static const byte[] Enemies2 = {
	(2 << 4) | 7,
	(3 << 4) | 7,
};

static const byte[] Blocks2 = {
	(3 << 4) | 9,
	(4 << 4) | 3,
	(4 << 4) | 5,
};

static const byte[] Bytes3 = {
	(5 << 2) | 1, (4 << 2) | 3, (0 << 2) | 0, (2 << 2) | 1, 
	(6 << 2) | 2, (1 << 2) | 3, (3 << 2) | 1, (7 << 2) | 0, 
	(0 << 2) | 1, (6 << 2) | 1, (0 << 2) | 2, (2 << 2) | 3, 
	(0 << 2) | 3, (0 << 2) | 1, (4 << 2) | 1, (3 << 2) | 1, 
	(0 << 2) | 3, (2 << 2) | 1, (5 << 2) | 1, (2 << 2) | 0, 
};

static const byte[] Enemies3 = {
	(1 << 4) | 7,
	(2 << 4) | 11,
	(3 << 4) | 2,
	(4 << 4) | 9,
};

static const byte[] Blocks3 = {
	(2 << 4) | 5,
	(3 << 4) | 9,
	(5 << 4) | 5,
};

static const byte[] Bytes4 = {
	(8 << 2) | 1, (2 << 2) | 3, (2 << 2) | 3, (2 << 2) | 1, 
	(5 << 2) | 0, (5 << 2) | 2, (4 << 2) | 1, (0 << 2) | 0, 
	(4 << 2) | 1, (0 << 2) | 2, (2 << 2) | 1, (2 << 2) | 0, 
	(0 << 2) | 3, (0 << 2) | 1, (8 << 2) | 1, (0 << 2) | 0, 
	(2 << 2) | 1, (0 << 2) | 2, (5 << 2) | 1, (1 << 2) | 0, 
	(2 << 2) | 1, (3 << 2) | 1, (4 << 2) | 1, 
};

static const byte[] Enemies4 = {
	(0 << 4) | 3,
	(2 << 4) | 8,
	(4 << 4) | 4,
	(5 << 4) | 7,
};

static const byte[] Blocks4 = {
	(1 << 4) | 9,
	(3 << 4) | 7,
	(6 << 4) | 5,
};

static const byte[] Bytes5 = {
	(2 << 2) | 1, (8 << 2) | 0, (0 << 2) | 1, (1 << 2) | 3, 
	(5 << 2) | 1, (2 << 2) | 1, (6 << 2) | 1, (4 << 2) | 3, 
	(0 << 2) | 3, (0 << 2) | 1, (2 << 2) | 1, (1 << 2) | 2, 
	(0 << 2) | 3, (3 << 2) | 0, (3 << 2) | 1, (7 << 2) | 1, 
	(3 << 2) | 3, (2 << 2) | 1, (4 << 2) | 0, (1 << 2) | 1, 
	(8 << 2) | 1, (0 << 2) | 0, 
};

static const byte[] Enemies5 = {
	(1 << 4) | 3,
	(2 << 4) | 0,
	(4 << 4) | 10,
	(5 << 4) | 4,
};

static const byte[] Blocks5 = {
	(3 << 4) | 8,
	(6 << 4) | 5,
};

static const byte[] Bytes6 = {
	(5 << 2) | 1, (5 << 2) | 0, (7 << 2) | 1, (3 << 2) | 0, 
	(10 << 2) | 1, (0 << 2) | 0, (0 << 2) | 3, (3 << 2) | 2, 
	(3 << 2) | 1, (2 << 2) | 0, (1 << 2) | 1, (0 << 2) | 2, 
	(0 << 2) | 1, (2 << 2) | 2, (0 << 2) | 1, (3 << 2) | 0, 
	(0 << 2) | 1, (3 << 2) | 2, (0 << 2) | 1, (2 << 2) | 1, 
	(2 << 2) | 3, (2 << 2) | 1, (7 << 2) | 3, (0 << 2) | 0, 
	(3 << 2) | 1, (4 << 2) | 1, (2 << 2) | 0, 
};

static const byte[] Enemies6 = {
	(1 << 4) | 4,
	(3 << 4) | 9,
	(5 << 4) | 10,
	(6 << 4) | 6,
};

static const byte[] Blocks6 = {
	(2 << 4) | 2,
	(4 << 4) | 9,
	(6 << 4) | 9,
};

static const byte[] Bytes7 = {
	(9 << 2) | 1, (1 << 2) | 0, (1 << 2) | 1, (5 << 2) | 1, 
	(0 << 2) | 2, (2 << 2) | 1, (0 << 2) | 1, (6 << 2) | 1, 
	(0 << 2) | 2, (2 << 2) | 1, (0 << 2) | 3, (0 << 2) | 1, 
	(3 << 2) | 1, (5 << 2) | 1, (1 << 2) | 2, (2 << 2) | 2, 
	(0 << 2) | 3, (3 << 2) | 1, (1 << 2) | 0, (0 << 2) | 1, 
	(0 << 2) | 2, (0 << 2) | 1, (1 << 2) | 2, (1 << 2) | 1, 
	(4 << 2) | 1, (0 << 2) | 1, (0 << 2) | 2, (0 << 2) | 1, 
	(4 << 2) | 1, (2 << 2) | 1, (0 << 2) | 0, (0 << 2) | 1, 
	(7 << 2) | 1, (2 << 2) | 0, (4 << 2) | 1, (4 << 2) | 1, 
	(1 << 2) | 0, 
};

static const byte[] Enemies7 = {
	(0 << 4) | 5,
	(1 << 4) | 2,
	(2 << 4) | 3,
	(3 << 4) | 10,
	(5 << 4) | 9,
	(7 << 4) | 7,
};

static const byte[] Blocks7 = {
	(1 << 4) | 10,
	(3 << 4) | 4,
	(4 << 4) | 3,
	(6 << 4) | 5,
	(8 << 4) | 2,
};

static const byte[] Bytes8 = {
	(7 << 2) | 2, (2 << 2) | 1, (0 << 2) | 0, (0 << 2) | 3, 
	(3 << 2) | 1, (0 << 2) | 2, (0 << 2) | 1, (0 << 2) | 2, 
	(3 << 2) | 1, (4 << 2) | 1, (0 << 2) | 2, (0 << 2) | 1, 
	(0 << 2) | 2, (2 << 2) | 1, (0 << 2) | 0, (0 << 2) | 3, 
	(2 << 2) | 1, (1 << 2) | 2, (0 << 2) | 1, (0 << 2) | 2, 
	(3 << 2) | 1, (1 << 2) | 1, (3 << 2) | 2, (0 << 2) | 1, 
	(0 << 2) | 2, (2 << 2) | 1, (0 << 2) | 0, (3 << 2) | 1, 
	(1 << 2) | 2, (0 << 2) | 1, (0 << 2) | 2, (3 << 2) | 1, 
	(3 << 2) | 1, (1 << 2) | 2, (0 << 2) | 1, (0 << 2) | 2, 
	(2 << 2) | 1, (0 << 2) | 0, (4 << 2) | 1, (0 << 2) | 2, 
	(0 << 2) | 1, (0 << 2) | 2, (0 << 2) | 1, (2 << 2) | 0, 
	(3 << 2) | 1, (1 << 2) | 2, (0 << 2) | 1, (3 << 2) | 1, 
	(0 << 2) | 0, 
};

static const byte[] Enemies8 = {
	(1 << 4) | 1,
	(1 << 4) | 8,
	(2 << 4) | 9,
	(5 << 4) | 0,
	(5 << 4) | 8,
	(6 << 4) | 4,
};

static const byte[] Blocks8 = {
	(3 << 4) | 9,
	(6 << 4) | 9,
	(7 << 4) | 2,
};

static const byte[] Bytes9 = {
	(7 << 2) | 1, (3 << 2) | 3, (3 << 2) | 1, (4 << 2) | 2, 
	(2 << 2) | 1, (1 << 2) | 1, (2 << 2) | 2, (4 << 2) | 2, 
	(1 << 2) | 1, (0 << 2) | 1, (3 << 2) | 3, (0 << 2) | 2, 
	(1 << 2) | 1, (1 << 2) | 2, (1 << 2) | 1, (0 << 2) | 1, 
	(4 << 2) | 2, (1 << 2) | 1, (1 << 2) | 2, (1 << 2) | 1, 
	(0 << 2) | 1, (4 << 2) | 2, (1 << 2) | 1, (1 << 2) | 2, 
	(1 << 2) | 1, (4 << 2) | 1, (2 << 2) | 1, (1 << 2) | 2, 
	(1 << 2) | 1, (5 << 2) | 1, (5 << 2) | 1, (6 << 2) | 1, 
	(4 << 2) | 0, (1 << 2) | 1, (9 << 2) | 0, 
};

static const byte[] Enemies9 = {
	(0 << 4) | 3,
	(1 << 4) | 2,
	(3 << 4) | 2,
	(6 << 4) | 2,
	(7 << 4) | 0,
	(8 << 4) | 8,
};

static const byte[] Blocks9 = {
	(1 << 4) | 9,
	(2 << 4) | 5,
	(7 << 4) | 3,
	(8 << 4) | 2,
	(9 << 4) | 7,
};

const Stage[] Stages = {
	{
		4, Bytes0,
		2, Enemies0,
		2, Blocks0,
	},
	{
		5, Bytes1,
		3, Enemies1,
		2, Blocks1,
	},
	{
		5, Bytes2,
		2, Enemies2,
		3, Blocks2,
	},
	{
		6, Bytes3,
		4, Enemies3,
		3, Blocks3,
	},
	{
		7, Bytes4,
		4, Enemies4,
		3, Blocks4,
	},
	{
		7, Bytes5,
		4, Enemies5,
		2, Blocks5,
	},
	{
		8, Bytes6,
		4, Enemies6,
		3, Blocks6,
	},
	{
		9, Bytes7,
		6, Enemies7,
		5, Blocks7,
	},
	{
		9, Bytes8,
		6, Enemies8,
		3, Blocks8,
	},
	{
		10, Bytes9,
		6, Enemies9,
		5, Blocks9,
	},
};
