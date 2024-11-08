#include "Stage.h"
#include "Stages.h"
#include "Chars.h"


const byte[] MapBytes = {
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	1,2,3,0,0,4,1,1,2,0,5,6,6,6,7,8,0,0,9,10,11,11,11,11,
	12,12,13,2,3,14,12,12,12,0,15,0,0,0,15,0,9,10,16,17,17,17,17,17,
	12,12,12,12,18,19,20,20,20,19,21,19,19,19,21,19,22,17,17,17,17,17,17,17,
	12,12,12,12,23,0,0,0,0,0,15,0,0,0,15,0,24,17,17,17,17,17,17,17,
	12,12,23,25,26,6,6,6,6,6,27,6,28,29,30,0,31,32,32,32,32,32,33,34,
	12,23,35,0,15,0,0,36,37,0,15,0,38,39,40,6,6,6,6,6,6,41,42,39,
	43,44,0,0,15,0,0,45,12,0,15,0,0,0,0,0,0,36,37,3,0,15,0,0,
	0,0,0,0,15,0,0,14,46,0,15,4,1,1,2,0,36,47,12,18,3,48,6,6,
	6,6,41,6,49,6,6,6,6,6,50,51,52,53,23,0,47,12,54,12,18,15,4,1,
	0,0,15,4,55,9,10,11,11,11,11,11,56,57,44,0,12,12,58,12,12,15,51,43,
	0,0,15,51,44,22,17,17,17,17,17,17,17,59,60,0,53,12,12,12,23,48,6,6,
	6,6,61,8,0,17,17,17,17,17,17,17,17,17,59,0,14,53,12,23,35,15,0,62,
	0,0,15,0,9,17,17,17,17,17,17,17,17,17,17,60,0,51,43,44,0,15,0,12,
	0,0,15,0,22,17,17,17,17,17,17,17,17,17,17,59,60,0,0,0,0,15,0,53,
	0,0,15,0,17,17,17,17,17,63,64,17,17,17,17,17,65,56,0,62,2,66,6,67,
	6,6,61,0,17,17,17,17,17,59,68,17,17,17,17,17,17,17,0,12,12,0,0,0,
	0,0,15,0,24,17,17,17,17,17,69,17,17,17,17,17,17,17,19,20,20,19,19,19,
	0,0,15,8,31,64,24,17,17,17,17,17,17,17,17,17,17,70,0,0,0,71,72,0,
	6,6,49,6,6,7,73,24,17,17,17,17,17,17,17,70,74,75,76,0,5,67,77,6,
	0,0,36,62,2,15,0,73,17,70,74,32,64,78,74,79,37,38,80,0,15,0,0,0,
	1,1,81,12,12,15,4,55,82,83,0,0,0,0,0,45,23,0,0,0,48,6,6,6,
	12,12,12,12,12,48,67,77,84,6,6,6,6,6,6,67,77,41,6,6,61,62,1,1,
	12,12,12,12,23,15,62,2,85,62,1,2,0,0,62,1,2,15,0,0,15,12,12,12,
	12,12,12,12,35,15,53,23,85,53,12,12,0,0,53,12,23,15,62,2,15,12,12,12,
	12,12,12,23,0,48,67,77,84,67,86,46,0,0,51,43,44,15,53,23,15,12,12,12,
	12,12,25,44,0,15,0,0,85,0,66,6,6,6,6,6,6,49,87,44,15,53,12,12,
	20,20,19,19,19,21,19,19,88,62,2,0,0,0,0,0,62,2,66,6,61,14,53,12,
	0,0,71,72,0,15,0,0,0,53,23,0,0,0,0,0,53,23,0,0,15,0,14,12,
	6,6,67,77,6,61,8,0,0,51,44,5,6,6,6,6,67,89,0,0,15,8,0,53,
	0,4,55,0,0,66,6,6,6,6,6,50,0,4,1,1,55,66,6,6,49,6,6,67,
	0,51,44,0,0,0,0,0,0,0,0,0,0,51,43,43,44,0,0,0,0,0,0,0,
};


const Tile[] Tiles = {
	{ // 0
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 1
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 2
		{
			Char_Terrain+106, Char_Terrain+106, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+100, Char_Terrain+100, Char_Space, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+100, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+82, Char_Terrain+82, Char_Space, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+82, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+54, Char_Terrain+54, Char_Space, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+54, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+35, Char_Terrain+35, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+35, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+28, Char_Terrain+28, Char_Space, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+28, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+14, Char_Terrain+14, Char_Space, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+14, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+4, Char_Terrain+4, Char_Space, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+4, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 3
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+100, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+82, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+54, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+35, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+28, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+14, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+4, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 4
		{
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+100, Char_Terrain+100, 
			Char_Space, Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+82, Char_Terrain+82, 
			Char_Space, Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+54, Char_Terrain+54, 
			Char_Space, Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+35, Char_Terrain+35, 
			Char_Space, Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+28, Char_Terrain+28, 
			Char_Space, Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+14, Char_Terrain+14, 
			Char_Space, Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+4, Char_Terrain+4, 
			Char_Space, Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 5
		{
			Char_Space, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+122, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+45, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+118, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+37, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+114, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+30, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+110, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+20, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+102, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+16, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+96, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+6, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+84, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+0, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+57, 
		},
	},
	{ // 6
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 7
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+44, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+38, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+31, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+21, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+17, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+7, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+1, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 8
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+100, Char_Terrain+100, Char_Space, 
			Char_Space, Char_Terrain+107, Char_Terrain+107, Char_Space, 
			Char_Space, Char_Terrain+5, Char_Terrain+5, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+82, Char_Terrain+82, Char_Space, 
			Char_Space, Char_Terrain+108, Char_Terrain+108, Char_Space, 
			Char_Space, Char_Terrain+15, Char_Terrain+15, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+54, Char_Terrain+54, Char_Space, 
			Char_Space, Char_Terrain+109, Char_Terrain+109, Char_Space, 
			Char_Space, Char_Terrain+29, Char_Terrain+29, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+35, Char_Terrain+35, Char_Space, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Space, Char_Terrain+36, Char_Terrain+36, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+28, Char_Terrain+28, Char_Space, 
			Char_Space, Char_Terrain+107, Char_Terrain+107, Char_Space, 
			Char_Space, Char_Terrain+55, Char_Terrain+55, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+14, Char_Terrain+14, Char_Space, 
			Char_Space, Char_Terrain+108, Char_Terrain+108, Char_Space, 
			Char_Space, Char_Terrain+83, Char_Terrain+83, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+4, Char_Terrain+4, Char_Space, 
			Char_Space, Char_Terrain+109, Char_Terrain+109, Char_Space, 
			Char_Space, Char_Terrain+101, Char_Terrain+101, Char_Space, 
		},
	},
	{ // 9
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+63, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+39, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+41, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+22, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+23, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+8, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+9, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 10
		{
			Char_Space, Char_Space, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+39, Char_Terrain+39, 
			Char_Space, Char_Terrain+39, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+39, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+41, Char_Terrain+41, 
			Char_Space, Char_Terrain+41, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+41, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+22, Char_Terrain+22, 
			Char_Space, Char_Terrain+22, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+22, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+23, Char_Terrain+23, 
			Char_Space, Char_Terrain+23, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+23, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+8, Char_Terrain+8, 
			Char_Space, Char_Terrain+8, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+8, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+9, Char_Terrain+9, 
			Char_Space, Char_Terrain+9, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+9, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 11
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 12
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 13
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+106, Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 14
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+5, Char_Terrain+107, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+5, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+15, Char_Terrain+108, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+15, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+29, Char_Terrain+109, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+29, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+36, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+36, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+55, Char_Terrain+107, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+55, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+83, Char_Terrain+108, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+83, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+101, Char_Terrain+109, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 15
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 16
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 17
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 18
		{
			Char_Terrain+106, Char_Terrain+106, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+100, Char_Space, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+100, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+82, Char_Space, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+82, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+54, Char_Space, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+54, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+106, Char_Terrain+35, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+35, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+28, Char_Space, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+28, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+14, Char_Space, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+14, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+4, Char_Space, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+4, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 19
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 20
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, 
			Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, 
			Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, 
			Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, 
			Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, 
			Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, 
			Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 21
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+46, Char_Terrain+39, Char_Terrain+39, Char_Terrain+50, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+86, Char_Terrain+10, Char_Terrain+10, Char_Terrain+93, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+77, Char_Terrain+41, Char_Terrain+41, Char_Terrain+61, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+60, Char_Terrain+11, Char_Terrain+11, Char_Terrain+78, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+47, Char_Terrain+22, Char_Terrain+22, Char_Terrain+52, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+89, Char_Terrain+24, Char_Terrain+24, Char_Terrain+94, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+72, Char_Terrain+23, Char_Terrain+23, Char_Terrain+68, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+73, Char_Terrain+25, Char_Terrain+25, Char_Terrain+65, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+48, Char_Terrain+8, Char_Terrain+8, Char_Terrain+53, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+90, Char_Terrain+42, Char_Terrain+42, Char_Terrain+91, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+81, Char_Terrain+9, Char_Terrain+9, Char_Terrain+74, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+58, Char_Terrain+34, Char_Terrain+34, Char_Terrain+75, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+49, Char_Space, Char_Space, Char_Terrain+51, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+92, Char_Terrain+64, Char_Terrain+64, Char_Terrain+88, 
		},
	},
	{ // 22
		{
			Char_Space, Char_Space, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+39, Char_Terrain+59, 
			Char_Space, Char_Terrain+39, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+39, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+41, Char_Terrain+79, 
			Char_Space, Char_Terrain+41, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+41, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+22, Char_Terrain+64, 
			Char_Space, Char_Terrain+22, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+22, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+23, Char_Terrain+63, 
			Char_Space, Char_Terrain+23, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+23, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+8, Char_Terrain+59, 
			Char_Space, Char_Terrain+8, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+8, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+9, Char_Terrain+79, 
			Char_Space, Char_Terrain+9, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+9, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 23
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+5, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+5, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+15, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+15, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+29, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+29, Char_Space, 
		},
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+36, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+36, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+55, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+55, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+83, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+83, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+101, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+101, Char_Space, 
		},
	},
	{ // 24
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+10, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Space, Char_Terrain+10, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+11, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Space, Char_Terrain+11, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+24, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Terrain+24, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+25, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Terrain+25, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+42, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Space, Char_Terrain+42, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+34, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Space, Char_Terrain+34, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 25
		{
			Char_Terrain+106, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, 
			Char_Terrain+5, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, 
			Char_Terrain+15, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, 
			Char_Terrain+29, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+106, Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, 
			Char_Terrain+36, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, 
			Char_Terrain+55, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, 
			Char_Terrain+83, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, 
			Char_Terrain+101, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 26
		{
			Char_Space, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+122, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Space, Char_Space, 
			Char_Terrain+45, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+118, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Space, Char_Space, 
			Char_Terrain+37, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+114, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Space, Char_Space, 
			Char_Terrain+30, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+110, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Space, Char_Space, 
			Char_Terrain+20, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+102, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Space, Char_Space, 
			Char_Terrain+16, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+96, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Space, Char_Space, 
			Char_Terrain+6, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+84, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Space, Char_Space, 
			Char_Terrain+0, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+57, 
		},
	},
	{ // 27
		{
			Char_Terrain+124, Char_Space, Char_Space, Char_Terrain+125, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+122, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Space, Char_Space, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+118, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+87, Char_Space, Char_Space, Char_Terrain+95, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+114, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+98, Char_Space, Char_Space, Char_Terrain+99, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+110, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+104, Char_Space, Char_Space, Char_Terrain+105, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+102, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+112, Char_Space, Char_Space, Char_Terrain+113, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+96, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+116, Char_Space, Char_Space, Char_Terrain+117, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+84, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+120, Char_Space, Char_Space, Char_Terrain+121, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+57, 
		},
	},
	{ // 28
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 29
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 30
		{
			Char_Terrain+124, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+87, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+98, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+104, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+112, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+116, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+120, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 31
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+10, Char_Terrain+10, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+11, Char_Terrain+11, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+24, Char_Terrain+24, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+25, Char_Terrain+25, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+42, Char_Terrain+42, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+34, Char_Terrain+34, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 32
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 33
		{
			Char_Space, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
			Char_Terrain+45, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
			Char_Terrain+37, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
			Char_Terrain+30, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
			Char_Terrain+20, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
			Char_Terrain+16, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
			Char_Terrain+6, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+0, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 34
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 35
		{
			Char_Terrain+106, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+5, Char_Space, Char_Space, 
			Char_Terrain+5, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+15, Char_Space, Char_Space, 
			Char_Terrain+15, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+29, Char_Space, Char_Space, 
			Char_Terrain+29, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+106, Char_Terrain+36, Char_Space, Char_Space, 
			Char_Terrain+36, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+55, Char_Space, Char_Space, 
			Char_Terrain+55, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+83, Char_Space, Char_Space, 
			Char_Terrain+83, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+101, Char_Space, Char_Space, 
			Char_Terrain+101, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 36
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+100, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+82, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+54, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+35, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+28, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+14, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+4, 
		},
	},
	{ // 37
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+100, Char_Terrain+100, Char_Space, 
			Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+82, Char_Terrain+82, Char_Space, 
			Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+54, Char_Terrain+54, Char_Space, 
			Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+35, Char_Terrain+35, Char_Space, 
			Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+28, Char_Terrain+28, Char_Space, 
			Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+14, Char_Terrain+14, Char_Space, 
			Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+4, Char_Terrain+4, Char_Space, 
			Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 38
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+2, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+12, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+18, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+26, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+32, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+43, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+49, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 39
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 40
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+125, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+95, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+99, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+105, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+113, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+117, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+121, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 41
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+122, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+118, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+114, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+110, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+102, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+96, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+84, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+57, 
		},
	},
	{ // 42
		{
			Char_Terrain+124, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+87, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+98, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+104, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+112, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+116, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+120, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 43
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 44
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 45
		{
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+100, Char_Terrain+107, 
			Char_Space, Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+82, Char_Terrain+108, 
			Char_Space, Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+54, Char_Terrain+109, 
			Char_Space, Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+35, Char_Terrain+106, 
			Char_Space, Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+28, Char_Terrain+107, 
			Char_Space, Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+14, Char_Terrain+108, 
			Char_Space, Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+4, Char_Terrain+109, 
			Char_Space, Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 46
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, Char_Terrain+5, 
			Char_Space, Char_Terrain+5, Char_Terrain+5, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, Char_Terrain+15, 
			Char_Space, Char_Terrain+15, Char_Terrain+15, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, Char_Terrain+29, 
			Char_Space, Char_Terrain+29, Char_Terrain+29, Char_Space, 
		},
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, Char_Terrain+36, 
			Char_Space, Char_Terrain+36, Char_Terrain+36, Char_Space, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, Char_Terrain+55, 
			Char_Space, Char_Terrain+55, Char_Terrain+55, Char_Space, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, Char_Terrain+83, 
			Char_Space, Char_Terrain+83, Char_Terrain+83, Char_Space, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, Char_Terrain+101, 
			Char_Space, Char_Terrain+101, Char_Terrain+101, Char_Space, 
		},
	},
	{ // 47
		{
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+100, Char_Terrain+107, 
			Char_Space, Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+82, Char_Terrain+108, 
			Char_Space, Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+54, Char_Terrain+109, 
			Char_Space, Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+35, Char_Terrain+106, 
			Char_Space, Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+28, Char_Terrain+107, 
			Char_Space, Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+14, Char_Terrain+108, 
			Char_Space, Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+4, Char_Terrain+109, 
			Char_Space, Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 48
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+125, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+122, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+62, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+118, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+95, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+114, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+99, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+110, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+105, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+102, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+113, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+96, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+117, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+84, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+121, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+57, 
		},
	},
	{ // 49
		{
			Char_Terrain+124, Char_Space, Char_Space, Char_Terrain+125, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Space, Char_Space, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+87, Char_Space, Char_Space, Char_Terrain+95, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+98, Char_Space, Char_Space, Char_Terrain+99, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+104, Char_Space, Char_Space, Char_Terrain+105, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+112, Char_Space, Char_Space, Char_Terrain+113, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+116, Char_Space, Char_Space, Char_Terrain+117, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+120, Char_Space, Char_Space, Char_Terrain+121, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 50
		{
			Char_Terrain+124, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Space, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+3, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+87, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+13, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+98, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+19, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+104, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+27, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+112, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+33, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+116, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+40, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+120, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+51, 
		},
	},
	{ // 51
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+5, Char_Terrain+5, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+15, Char_Terrain+15, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+29, Char_Terrain+29, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+36, Char_Terrain+36, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+55, Char_Terrain+55, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+83, Char_Terrain+83, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+101, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 52
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, Char_Terrain+107, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+5, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, Char_Terrain+108, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+15, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, Char_Terrain+109, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+29, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+36, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, Char_Terrain+107, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+55, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, Char_Terrain+108, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+83, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, Char_Terrain+109, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 53
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 54
		{
			Char_Terrain+106, Char_Space, Char_Space, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Space, Char_Space, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+5, Char_Terrain+5, Char_Terrain+107, 
			Char_Terrain+5, Char_Space, Char_Space, Char_Terrain+5, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+100, Char_Space, Char_Space, Char_Terrain+100, 
		},
		{
			Char_Terrain+108, Char_Terrain+15, Char_Terrain+15, Char_Terrain+108, 
			Char_Terrain+15, Char_Space, Char_Space, Char_Terrain+15, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+82, Char_Space, Char_Space, Char_Terrain+82, 
		},
		{
			Char_Terrain+109, Char_Terrain+29, Char_Terrain+29, Char_Terrain+109, 
			Char_Terrain+29, Char_Space, Char_Space, Char_Terrain+29, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+54, Char_Space, Char_Space, Char_Terrain+54, 
		},
		{
			Char_Terrain+106, Char_Terrain+36, Char_Terrain+36, Char_Terrain+106, 
			Char_Terrain+36, Char_Space, Char_Space, Char_Terrain+36, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+35, Char_Space, Char_Space, Char_Terrain+35, 
		},
		{
			Char_Terrain+107, Char_Terrain+55, Char_Terrain+55, Char_Terrain+107, 
			Char_Terrain+55, Char_Space, Char_Space, Char_Terrain+55, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+28, Char_Space, Char_Space, Char_Terrain+28, 
		},
		{
			Char_Terrain+108, Char_Terrain+83, Char_Terrain+83, Char_Terrain+108, 
			Char_Terrain+83, Char_Space, Char_Space, Char_Terrain+83, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+14, Char_Space, Char_Space, Char_Terrain+14, 
		},
		{
			Char_Terrain+109, Char_Terrain+101, Char_Terrain+101, Char_Terrain+109, 
			Char_Terrain+101, Char_Space, Char_Space, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+4, Char_Space, Char_Space, Char_Terrain+4, 
		},
	},
	{ // 55
		{
			Char_Terrain+106, Char_Terrain+106, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+100, Char_Terrain+100, Char_Space, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+100, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+5, Char_Space, 
		},
		{
			Char_Terrain+82, Char_Terrain+82, Char_Space, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+82, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+15, Char_Space, 
		},
		{
			Char_Terrain+54, Char_Terrain+54, Char_Space, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+54, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+29, Char_Space, 
		},
		{
			Char_Terrain+35, Char_Terrain+35, Char_Space, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+35, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+36, Char_Space, 
		},
		{
			Char_Terrain+28, Char_Terrain+28, Char_Space, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+28, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Space, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+55, Char_Space, 
		},
		{
			Char_Terrain+14, Char_Terrain+14, Char_Space, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+14, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Space, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+83, Char_Space, 
		},
		{
			Char_Terrain+4, Char_Terrain+4, Char_Space, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+4, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Space, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+101, Char_Space, 
		},
	},
	{ // 56
		{
			Char_Terrain+63, Char_Terrain+63, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+39, Char_Terrain+39, Char_Space, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+39, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+39, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+41, Char_Terrain+41, Char_Space, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+41, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+41, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+22, Char_Terrain+22, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+22, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+22, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+23, Char_Terrain+23, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+23, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+23, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+8, Char_Terrain+8, Char_Space, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+8, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+8, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+9, Char_Terrain+9, Char_Space, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+9, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+9, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 57
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+5, Char_Terrain+5, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+39, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+15, Char_Terrain+15, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+41, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+29, Char_Terrain+29, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+22, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+36, Char_Terrain+36, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+23, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+55, Char_Terrain+55, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+8, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+83, Char_Terrain+83, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+9, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+101, Char_Terrain+101, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 58
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+100, Char_Terrain+100, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+82, Char_Terrain+82, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+54, Char_Terrain+54, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+106, Char_Terrain+35, Char_Terrain+35, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+107, Char_Terrain+28, Char_Terrain+28, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+108, Char_Terrain+14, Char_Terrain+14, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+109, Char_Terrain+4, Char_Terrain+4, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 59
		{
			Char_Terrain+63, Char_Terrain+63, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+39, Char_Space, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+39, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+39, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+41, Char_Space, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+41, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+41, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+22, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+22, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+22, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+63, Char_Terrain+23, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+23, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+23, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+8, Char_Space, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+8, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+8, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+9, Char_Space, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+9, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+9, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 60
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+39, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+41, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+22, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+23, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+8, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+9, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 61
		{
			Char_Terrain+124, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+87, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+98, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+104, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+112, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+116, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+120, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 62
		{
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+100, Char_Terrain+100, 
			Char_Space, Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+100, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+82, Char_Terrain+82, 
			Char_Space, Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+82, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+54, Char_Terrain+54, 
			Char_Space, Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+54, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+35, Char_Terrain+35, 
			Char_Space, Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+35, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+28, Char_Terrain+28, 
			Char_Space, Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+28, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+14, Char_Terrain+14, 
			Char_Space, Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+14, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+4, Char_Terrain+4, 
			Char_Space, Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+4, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 63
		{
			Char_Terrain+63, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
			Char_Terrain+10, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+39, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
			Char_Terrain+11, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+41, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
			Char_Terrain+24, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+22, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+63, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
			Char_Terrain+25, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+23, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
			Char_Terrain+42, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+8, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
			Char_Terrain+34, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+9, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 64
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Terrain+59, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+10, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Terrain+79, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+11, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+24, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+25, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Terrain+59, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+42, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Terrain+79, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+34, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 65
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+39, Char_Terrain+39, Char_Terrain+39, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+41, Char_Terrain+41, Char_Terrain+41, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+22, Char_Terrain+22, Char_Terrain+22, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+63, Char_Terrain+23, Char_Terrain+23, Char_Terrain+23, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+8, Char_Terrain+8, Char_Terrain+8, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+9, Char_Terrain+9, Char_Terrain+9, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 66
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+125, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+62, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+2, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+95, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+12, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+99, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+18, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+105, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+26, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+113, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+32, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+117, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+43, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Terrain+121, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+49, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 67
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+5, Char_Terrain+5, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+15, Char_Terrain+15, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+29, Char_Terrain+29, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+36, Char_Terrain+36, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+55, Char_Terrain+55, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+83, Char_Terrain+83, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+101, Char_Terrain+101, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 68
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+63, Char_Space, Char_Space, Char_Terrain+63, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+39, Char_Space, Char_Space, Char_Terrain+39, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+41, Char_Space, Char_Space, Char_Terrain+41, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+22, Char_Space, Char_Space, Char_Terrain+22, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+23, Char_Space, Char_Space, Char_Terrain+23, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+8, Char_Space, Char_Space, Char_Terrain+8, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+9, Char_Space, Char_Space, Char_Terrain+9, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 69
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+39, Char_Terrain+39, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+41, Char_Terrain+41, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Terrain+22, Char_Terrain+22, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
		{
			Char_Terrain+63, Char_Terrain+23, Char_Terrain+23, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
		},
		{
			Char_Terrain+59, Char_Terrain+8, Char_Terrain+8, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
		},
		{
			Char_Terrain+79, Char_Terrain+9, Char_Terrain+9, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
		},
		{
			Char_Terrain+64, Char_Space, Char_Space, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
		},
	},
	{ // 70
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+10, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+10, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+11, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+11, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+24, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+24, Char_Space, 
		},
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+25, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+25, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+42, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+42, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+34, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+34, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
	},
	{ // 71
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Space, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+5, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+15, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+29, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Space, Char_Terrain+36, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Space, Char_Terrain+55, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Space, Char_Terrain+83, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Space, Char_Terrain+101, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 72
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Space, 
			Char_Terrain+106, Char_Terrain+106, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+5, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+5, Char_Space, 
		},
		{
			Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+15, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+15, Char_Space, 
		},
		{
			Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+29, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+29, Char_Space, 
		},
		{
			Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+36, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+36, Char_Space, 
		},
		{
			Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+55, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+55, Char_Space, 
		},
		{
			Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+83, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+83, Char_Space, 
		},
		{
			Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+101, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+101, Char_Space, 
		},
	},
	{ // 73
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+10, Char_Terrain+59, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+10, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+11, Char_Terrain+79, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+11, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+24, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+24, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+25, Char_Terrain+63, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+25, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+42, Char_Terrain+59, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+42, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+34, Char_Terrain+79, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+34, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+64, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 74
		{
			Char_Terrain+63, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, 
			Char_Terrain+10, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, 
			Char_Terrain+11, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, 
			Char_Terrain+24, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+63, Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, 
			Char_Terrain+25, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, 
			Char_Terrain+42, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, 
			Char_Terrain+34, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 75
		{
			Char_Space, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Space, Char_Space, 
			Char_Terrain+45, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Space, Char_Space, 
			Char_Terrain+37, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Space, Char_Space, 
			Char_Terrain+30, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Space, Char_Space, 
			Char_Terrain+20, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Space, Char_Space, 
			Char_Terrain+16, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Space, Char_Space, 
			Char_Terrain+6, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Space, Char_Space, 
			Char_Terrain+0, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+56, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 76
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+44, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+38, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+31, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+21, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+17, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+7, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+1, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 77
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, 
		},
	},
	{ // 78
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+10, Char_Terrain+59, Char_Terrain+59, Char_Terrain+10, 
			Char_Space, Char_Terrain+10, Char_Terrain+10, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+11, Char_Terrain+79, Char_Terrain+79, Char_Terrain+11, 
			Char_Space, Char_Terrain+11, Char_Terrain+11, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+24, Char_Terrain+64, Char_Terrain+64, Char_Terrain+24, 
			Char_Space, Char_Terrain+24, Char_Terrain+24, Char_Space, 
		},
		{
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, 
			Char_Terrain+25, Char_Terrain+63, Char_Terrain+63, Char_Terrain+25, 
			Char_Space, Char_Terrain+25, Char_Terrain+25, Char_Space, 
		},
		{
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, 
			Char_Terrain+42, Char_Terrain+59, Char_Terrain+59, Char_Terrain+42, 
			Char_Space, Char_Terrain+42, Char_Terrain+42, Char_Space, 
		},
		{
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, 
			Char_Terrain+34, Char_Terrain+79, Char_Terrain+79, Char_Terrain+34, 
			Char_Space, Char_Terrain+34, Char_Terrain+34, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
	},
	{ // 79
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+106, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+100, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+82, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+54, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+35, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+28, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+14, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+4, 
		},
	},
	{ // 80
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Space, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+3, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+13, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+19, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+27, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+33, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+40, 
		},
		{
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Terrain+51, 
		},
	},
	{ // 81
		{
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+100, Char_Terrain+100, Char_Terrain+100, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+82, Char_Terrain+82, Char_Terrain+82, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+54, Char_Terrain+54, Char_Terrain+54, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
		{
			Char_Terrain+35, Char_Terrain+35, Char_Terrain+35, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
			Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, Char_Terrain+106, 
		},
		{
			Char_Terrain+28, Char_Terrain+28, Char_Terrain+28, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
			Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, Char_Terrain+107, 
		},
		{
			Char_Terrain+14, Char_Terrain+14, Char_Terrain+14, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
			Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, Char_Terrain+108, 
		},
		{
			Char_Terrain+4, Char_Terrain+4, Char_Terrain+4, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
			Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, Char_Terrain+109, 
		},
	},
	{ // 82
		{
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+59, Char_Terrain+59, Char_Terrain+10, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+79, Char_Terrain+79, Char_Terrain+11, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+64, Char_Terrain+64, Char_Terrain+24, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+63, Char_Terrain+63, Char_Terrain+25, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+59, Char_Terrain+59, Char_Terrain+42, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+79, Char_Terrain+79, Char_Terrain+34, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
	},
	{ // 83
		{
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+10, Char_Terrain+10, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+11, Char_Terrain+11, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+24, Char_Terrain+24, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+25, Char_Terrain+25, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+42, Char_Terrain+42, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+34, Char_Terrain+34, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Terrain+64, Char_Terrain+64, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
	},
	{ // 84
		{
			Char_Terrain+57, Char_Terrain+63, Char_Terrain+63, Char_Terrain+57, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+62, Char_Terrain+63, Char_Terrain+63, Char_Terrain+62, 
		},
		{
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+62, Char_Terrain+59, Char_Terrain+59, Char_Terrain+62, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+66, Char_Terrain+59, Char_Terrain+59, Char_Terrain+66, 
		},
		{
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+66, Char_Terrain+79, Char_Terrain+79, Char_Terrain+66, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+69, Char_Terrain+79, Char_Terrain+79, Char_Terrain+69, 
		},
		{
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+69, Char_Terrain+64, Char_Terrain+64, Char_Terrain+69, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+70, Char_Terrain+64, Char_Terrain+64, Char_Terrain+70, 
		},
		{
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+70, Char_Terrain+63, Char_Terrain+63, Char_Terrain+70, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+71, Char_Terrain+63, Char_Terrain+63, Char_Terrain+71, 
		},
		{
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+71, Char_Terrain+59, Char_Terrain+59, Char_Terrain+71, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+76, Char_Terrain+59, Char_Terrain+59, Char_Terrain+76, 
		},
		{
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+76, Char_Terrain+79, Char_Terrain+79, Char_Terrain+76, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+80, Char_Terrain+79, Char_Terrain+79, Char_Terrain+80, 
		},
		{
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+80, Char_Terrain+64, Char_Terrain+64, Char_Terrain+80, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+57, Char_Terrain+64, Char_Terrain+64, Char_Terrain+57, 
		},
	},
	{ // 85
		{
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
	},
	{ // 86
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, Char_Terrain+5, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+44, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, Char_Terrain+15, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+38, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, Char_Terrain+29, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+31, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, Char_Terrain+36, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+21, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, Char_Terrain+55, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+17, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, Char_Terrain+83, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+7, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, Char_Terrain+101, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+1, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 87
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+5, Char_Terrain+5, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+44, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+15, Char_Terrain+15, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+38, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+29, Char_Terrain+29, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+31, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+36, Char_Terrain+36, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+21, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+55, Char_Terrain+55, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+17, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+83, Char_Terrain+83, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+7, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Space, Char_Space, Char_Terrain+101, Char_Terrain+101, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+1, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
	{ // 88
		{
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+39, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+10, Char_Terrain+10, Char_Terrain+10, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+41, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+11, Char_Terrain+11, Char_Terrain+11, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+22, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+24, Char_Terrain+24, Char_Terrain+24, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+23, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+63, Char_Terrain+63, Char_Terrain+63, Char_Space, 
			Char_Terrain+25, Char_Terrain+25, Char_Terrain+25, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+8, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+59, Char_Terrain+59, Char_Terrain+59, Char_Space, 
			Char_Terrain+42, Char_Terrain+42, Char_Terrain+42, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+9, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+79, Char_Terrain+79, Char_Terrain+79, Char_Space, 
			Char_Terrain+34, Char_Terrain+34, Char_Terrain+34, Char_Space, 
		},
		{
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Space, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Space, 
			Char_Terrain+64, Char_Terrain+64, Char_Terrain+64, Char_Space, 
		},
	},
	{ // 89
		{
			Char_Terrain+57, Char_Terrain+57, Char_Terrain+57, Char_Space, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+123, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+5, Char_Terrain+5, Char_Space, Char_Space, 
			Char_Terrain+62, Char_Terrain+62, Char_Terrain+62, Char_Terrain+44, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+119, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+15, Char_Terrain+15, Char_Space, Char_Space, 
			Char_Terrain+66, Char_Terrain+66, Char_Terrain+66, Char_Terrain+38, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+115, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+29, Char_Terrain+29, Char_Space, Char_Space, 
			Char_Terrain+69, Char_Terrain+69, Char_Terrain+69, Char_Terrain+31, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+111, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+36, Char_Terrain+36, Char_Space, Char_Space, 
			Char_Terrain+70, Char_Terrain+70, Char_Terrain+70, Char_Terrain+21, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+103, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+55, Char_Terrain+55, Char_Space, Char_Space, 
			Char_Terrain+71, Char_Terrain+71, Char_Terrain+71, Char_Terrain+17, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+97, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+83, Char_Terrain+83, Char_Space, Char_Space, 
			Char_Terrain+76, Char_Terrain+76, Char_Terrain+76, Char_Terrain+7, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+85, Char_Space, Char_Space, Char_Terrain+67, 
		},
		{
			Char_Terrain+101, Char_Terrain+101, Char_Space, Char_Space, 
			Char_Terrain+80, Char_Terrain+80, Char_Terrain+80, Char_Terrain+1, 
			Char_Space, Char_Space, Char_Space, Char_Terrain+67, 
			Char_Terrain+57, Char_Space, Char_Space, Char_Terrain+67, 
		},
	},
};

static const SkyElement[] SkyElements0 = {
	{ 124, 0x01 },
	{ 96, 0x03 },
	{ 92, 0x02 },
	{ 64, 0x0a },
	{ 60, 0x08 },
	{ 48, 0x00 },
	{ 44, 0x04 },
	{ 16, 0x00 },
	{ 12, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements1 = {
	{ 124, 0x01 },
	{ 96, 0x03 },
	{ 88, 0x02 },
	{ 76, 0x0a },
	{ 56, 0x08 },
	{ 36, 0x0c },
	{ 32, 0x04 },
	{ 20, 0x05 },
	{ 16, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements2 = {
	{ 124, 0x01 },
	{ 104, 0x03 },
	{ 80, 0x02 },
	{ 76, 0x0a },
	{ 48, 0x08 },
	{ 44, 0x0c },
	{ 36, 0x04 },
	{ 20, 0x05 },
	{ 8, 0x01 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements3 = {
	{ 124, 0x01 },
	{ 112, 0x03 },
	{ 72, 0x02 },
	{ 52, 0x06 },
	{ 40, 0x04 },
	{ 16, 0x0c },
	{ 4, 0x08 },
	{ 0, 0x00 },
};

static const SkyElement[] SkyElements4 = {
	{ 124, 0x01 },
	{ 120, 0x03 },
	{ 76, 0x0b },
	{ 64, 0x0a },
	{ 60, 0x0e },
	{ 40, 0x06 },
	{ 32, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements5 = {
	{ 124, 0x02 },
	{ 120, 0x03 },
	{ 76, 0x0b },
	{ 68, 0x0f },
	{ 56, 0x0e },
	{ 48, 0x06 },
	{ 24, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements6 = {
	{ 124, 0x02 },
	{ 120, 0x03 },
	{ 76, 0x07 },
	{ 68, 0x0f },
	{ 48, 0x0e },
	{ 44, 0x06 },
	{ 16, 0x04 },
	{ 4, 0x00 },
};

static const SkyElement[] SkyElements7 = {
	{ 124, 0x02 },
	{ 120, 0x03 },
	{ 92, 0x07 },
	{ 40, 0x06 },
	{ 24, 0x0e },
	{ 8, 0x0c },
	{ 4, 0x04 },
	{ 0, 0x00 },
};

static const Route[] Route0A7 = {
};

static const Route[] Route0B1 = {
	{ 1, 0, 20 },
	{ -1, 0, 22 },
};

static const Route[] Route0A8 = {
};

static const Route[] Route0B2 = {
	{ 0, 1, 28 },
};

static const Route[] Route0A6 = {
};

static const Route[] Route0A13 = {
};

static const Route[] Route0A2 = {
};

static const Route[] Route0B3 = {
	{ -1, 0, 22 },
};

static const Route[] Route0A17 = {
};

static const Route[] Route0A16 = {
};

static const Route[] Route0A12 = {
};

static const Route[] Route0A15 = {
};

static const Route[] Route0A10 = {
};

static const Route[] Route0A4 = {
};

static const Route[] Route0A11 = {
};

static const Route[] Route0B5 = {
	{ 0, 1, 8 },
	{ 1, 0, 87 },
};

static const Route[] Route0B0 = {
	{ 1, 0, 20 },
};

static const Route[] Route0A9 = {
};

static const Route[] Route1A0 = {
};

static const Route[] Route1A7 = {
};

static const Route[] Route1A3 = {
};

static const Route[] Route1B4 = {
	{ 1, 0, 20 },
	{ 0, -1, 20 },
};

static const Route[] Route1A8 = {
};

static const Route[] Route1B3 = {
	{ -1, 0, 8 },
	{ 0, 1, 16 },
};

static const Route[] Route1A2 = {
};

static const Route[] Route1A5 = {
};

static const Route[] Route1A12 = {
};

static const Route[] Route1A10 = {
};

static const Route[] Route1A4 = {
};

static const Route[] Route1A11 = {
};

static const Route[] Route1B5 = {
	{ -1, 0, 22 },
};

static const Route[] Route2A7 = {
};

static const Route[] Route2A14 = {
};

static const Route[] Route2A3 = {
};

static const Route[] Route2B4 = {
	{ 1, 0, 95 },
};

static const Route[] Route2A8 = {
};

static const Route[] Route2B2 = {
	{ -1, 0, 8 },
	{ 0, -1, 24 },
	{ -1, 0, 10 },
};

static const Route[] Route2A1 = {
};

static const Route[] Route2A6 = {
};

static const Route[] Route2A13 = {
};

static const Route[] Route2B3 = {
	{ -1, 0, 8 },
};

static const Route[] Route2A16 = {
};

static const Route[] Route2A5 = {
};

static const Route[] Route2A12 = {
};

static const Route[] Route2A15 = {
};

static const Route[] Route2A11 = {
};

static const Route[] Route2B5 = {
	{ -1, 0, 16 },
	{ 0, 1, 16 },
};

static const Route[] Route2B0 = {
	{ -1, 0, 12 },
	{ 0, -1, 4 },
	{ -1, 0, 10 },
};

static const Route[] Route3A7 = {
};

static const Route[] Route3A14 = {
};

static const Route[] Route3A3 = {
};

static const Route[] Route3B4 = {
	{ -1, 0, 4 },
	{ 1, 0, 4 },
	{ -1, 0, 22 },
};

static const Route[] Route3A18 = {
};

static const Route[] Route3A8 = {
};

static const Route[] Route3B2 = {
	{ 0, -1, 48 },
	{ 1, 0, 83 },
};

static const Route[] Route3A6 = {
};

static const Route[] Route3A2 = {
};

static const Route[] Route3B3 = {
	{ 1, 0, 12 },
	{ 0, -1, 8 },
	{ 1, 0, 83 },
};

static const Route[] Route3A17 = {
};

static const Route[] Route3A19 = {
};

static const Route[] Route3A16 = {
};

static const Route[] Route3A12 = {
};

static const Route[] Route3A15 = {
};

static const Route[] Route3A10 = {
};

static const Route[] Route3A4 = {
};

static const Route[] Route3B5 = {
	{ -1, 0, 4 },
	{ 1, 0, 4 },
	{ 1, 0, 75 },
};

static const Route[] Route3B0 = {
	{ -1, 0, 16 },
	{ 0, -1, 16 },
	{ -1, 0, 6 },
};

static const Route[] Route3A9 = {
};

static const Route[] Route4A0 = {
};

static const Route[] Route4A14 = {
};

static const Route[] Route4A3 = {
};

static const Route[] Route4B1 = {
	{ -1, 0, 4 },
	{ 0, -1, 16 },
	{ 1, 0, 79 },
};

static const Route[] Route4B4 = {
	{ 1, 0, 95 },
};

static const Route[] Route4A18 = {
};

static const Route[] Route4A8 = {
};

static const Route[] Route4A13 = {
};

static const Route[] Route4B3 = {
	{ 1, 0, 16 },
	{ 0, 1, 16 },
};

static const Route[] Route4A17 = {
};

static const Route[] Route4A19 = {
};

static const Route[] Route4A5 = {
};

static const Route[] Route4A12 = {
};

static const Route[] Route4A15 = {
};

static const Route[] Route4A10 = {
};

static const Route[] Route4A4 = {
};

static const Route[] Route4A11 = {
};

static const Route[] Route4B5 = {
	{ 1, 0, 95 },
};

static const Route[] Route4B0 = {
	{ -1, 0, 8 },
	{ 1, 0, 4 },
	{ -1, 0, 18 },
};

static const Route[] Route4A9 = {
};

static const Route[] Route5A0 = {
};

static const Route[] Route5A3 = {
};

static const Route[] Route5B1 = {
	{ 0, -1, 4 },
	{ 0, -1, 12 },
	{ 1, 0, 75 },
};

static const Route[] Route5B4 = {
	{ 1, 0, 8 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route5A18 = {
};

static const Route[] Route5A8 = {
};

static const Route[] Route5B2 = {
	{ -1, 0, 22 },
};

static const Route[] Route5A13 = {
};

static const Route[] Route5A2 = {
};

static const Route[] Route5B3 = {
	{ 1, 0, 8 },
	{ 0, -1, 12 },
	{ -1, 0, 10 },
};

static const Route[] Route5A17 = {
};

static const Route[] Route5A20 = {
};

static const Route[] Route5A19 = {
};

static const Route[] Route5A16 = {
};

static const Route[] Route5A5 = {
};

static const Route[] Route5A12 = {
};

static const Route[] Route5A15 = {
};

static const Route[] Route5A10 = {
};

static const Route[] Route5B5 = {
	{ -1, 0, 4 },
	{ 0, -1, 16 },
	{ 1, 0, 79 },
};

static const Route[] Route5B0 = {
	{ 1, 0, 20 },
	{ 0, 1, 4 },
	{ 1, 0, 75 },
};

static const Route[] Route5A9 = {
};

static const Route[] Route6A7 = {
};

static const Route[] Route6B8 = {
	{ 1, 0, 12 },
	{ 0, 1, 36 },
};

static const Route[] Route6A14 = {
};

static const Route[] Route6B1 = {
	{ 1, 0, 20 },
};

static const Route[] Route6A18 = {
};

static const Route[] Route6A8 = {
};

static const Route[] Route6B2 = {
	{ 0, 1, 40 },
};

static const Route[] Route6B7 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 83 },
};

static const Route[] Route6A6 = {
};

static const Route[] Route6A2 = {
};

static const Route[] Route6B3 = {
	{ 1, 0, 8 },
	{ 0, 1, 24 },
};

static const Route[] Route6A17 = {
};

static const Route[] Route6A16 = {
};

static const Route[] Route6A5 = {
};

static const Route[] Route6A12 = {
};

static const Route[] Route6A15 = {
};

static const Route[] Route6A4 = {
};

static const Route[] Route6A11 = {
};

static const Route[] Route6A9 = {
};

static const Route[] Route7A0 = {
};

static const Route[] Route7A7 = {
};

static const Route[] Route7A3 = {
};

static const Route[] Route7B1 = {
	{ -1, 0, 8 },
	{ 0, -1, 12 },
	{ 1, 0, 83 },
};

static const Route[] Route7B4 = {
	{ -1, 0, 12 },
	{ 0, 1, 16 },
	{ 1, 0, 87 },
};

static const Route[] Route7A8 = {
};

static const Route[] Route7A6 = {
};

static const Route[] Route7A13 = {
};

static const Route[] Route7A2 = {
};

static const Route[] Route7B3 = {
	{ -1, 0, 12 },
	{ 0, -1, 40 },
	{ 1, 0, 95 },
};

static const Route[] Route7A12 = {
};

static const Route[] Route7A10 = {
};

static const Route[] Route7A11 = {
};

static const Route[] Route7B0 = {
	{ 1, 0, 12 },
	{ 0, 1, 4 },
	{ 1, 0, 8 },
};

static const GroundElement[] GroundElements0 = {
	{ // B0
		1, 117,
		1,
		Route0B0
	},
	{ // A2
		9, 113,
		0,
		Route0A2
	},
	{ // B1
		1, 105,
		2,
		Route0B1
	},
	{ // A4
		5, 97,
		0,
		Route0A4
	},
	{ // B2
		21, 93,
		1,
		Route0B2
	},
	{ // B3
		21, 89,
		1,
		Route0B3
	},
	{ // A6
		21, 85,
		0,
		Route0A6
	},
	{ // A7
		9, 81,
		0,
		Route0A7
	},
	{ // A8
		21, 77,
		0,
		Route0A8
	},
	{ // A9
		13, 49,
		0,
		Route0A9
	},
	{ // A10
		17, 49,
		0,
		Route0A10
	},
	{ // A11
		9, 41,
		0,
		Route0A11
	},
	{ // A12
		1, 25,
		0,
		Route0A12
	},
	{ // A13
		5, 25,
		0,
		Route0A13
	},
	{ // A15
		1, 21,
		0,
		Route0A15
	},
	{ // A16
		5, 21,
		0,
		Route0A16
	},
	{ // B5
		9, 17,
		2,
		Route0B5
	},
	{ // A17
		1, 9,
		0,
		Route0A17
	},
};

static const GroundElement[] GroundElements1 = {
	{ // A0
		21, 113,
		0,
		Route1A0
	},
	{ // A2
		9, 97,
		0,
		Route1A2
	},
	{ // B3
		9, 89,
		2,
		Route1B3
	},
	{ // A3
		21, 85,
		0,
		Route1A3
	},
	{ // A4
		5, 77,
		0,
		Route1A4
	},
	{ // A5
		21, 61,
		0,
		Route1A5
	},
	{ // B4
		1, 37,
		2,
		Route1B4
	},
	{ // A7
		5, 33,
		0,
		Route1A7
	},
	{ // A8
		5, 25,
		0,
		Route1A8
	},
	{ // B5
		21, 21,
		1,
		Route1B5
	},
	{ // A10
		13, 17,
		0,
		Route1A10
	},
	{ // A11
		21, 9,
		0,
		Route1A11
	},
	{ // A12
		1, 5,
		0,
		Route1A12
	},
};

static const GroundElement[] GroundElements2 = {
	{ // B0
		21, 121,
		3,
		Route2B0
	},
	{ // A1
		21, 113,
		0,
		Route2A1
	},
	{ // B2
		17, 101,
		3,
		Route2B2
	},
	{ // A3
		5, 97,
		0,
		Route2A3
	},
	{ // B3
		17, 89,
		1,
		Route2B3
	},
	{ // A5
		17, 85,
		0,
		Route2A5
	},
	{ // A6
		9, 73,
		0,
		Route2A6
	},
	{ // A7
		1, 69,
		0,
		Route2A7
	},
	{ // A8
		1, 61,
		0,
		Route2A8
	},
	{ // B4
		1, 37,
		1,
		Route2B4
	},
	{ // A11
		9, 33,
		0,
		Route2A11
	},
	{ // A12
		9, 29,
		0,
		Route2A12
	},
	{ // A13
		13, 25,
		0,
		Route2A13
	},
	{ // B5
		21, 21,
		2,
		Route2B5
	},
	{ // A14
		17, 17,
		0,
		Route2A14
	},
	{ // A15
		5, 9,
		0,
		Route2A15
	},
	{ // A16
		1, 5,
		0,
		Route2A16
	},
};

static const GroundElement[] GroundElements3 = {
	{ // B2
		13, 121,
		2,
		Route3B2
	},
	{ // B0
		21, 121,
		3,
		Route3B0
	},
	{ // A2
		9, 117,
		0,
		Route3A2
	},
	{ // A3
		21, 117,
		0,
		Route3A3
	},
	{ // A4
		9, 113,
		0,
		Route3A4
	},
	{ // B3
		1, 89,
		3,
		Route3B3
	},
	{ // A6
		5, 85,
		0,
		Route3A6
	},
	{ // A7
		5, 81,
		0,
		Route3A7
	},
	{ // A8
		9, 81,
		0,
		Route3A8
	},
	{ // A9
		9, 77,
		0,
		Route3A9
	},
	{ // A10
		9, 73,
		0,
		Route3A10
	},
	{ // B4
		21, 65,
		3,
		Route3B4
	},
	{ // A12
		13, 57,
		0,
		Route3A12
	},
	{ // A14
		9, 53,
		0,
		Route3A14
	},
	{ // A15
		13, 49,
		0,
		Route3A15
	},
	{ // B5
		21, 45,
		3,
		Route3B5
	},
	{ // A16
		5, 37,
		0,
		Route3A16
	},
	{ // A17
		13, 29,
		0,
		Route3A17
	},
	{ // A18
		21, 21,
		0,
		Route3A18
	},
	{ // A19
		1, 5,
		0,
		Route3A19
	},
};

static const GroundElement[] GroundElements4 = {
	{ // A0
		21, 125,
		0,
		Route4A0
	},
	{ // B0
		21, 121,
		3,
		Route4B0
	},
	{ // A3
		1, 113,
		0,
		Route4A3
	},
	{ // A4
		1, 109,
		0,
		Route4A4
	},
	{ // A5
		5, 109,
		0,
		Route4A5
	},
	{ // B1
		21, 109,
		3,
		Route4B1
	},
	{ // B3
		1, 105,
		2,
		Route4B3
	},
	{ // B4
		1, 89,
		1,
		Route4B4
	},
	{ // A8
		17, 85,
		0,
		Route4A8
	},
	{ // A9
		17, 81,
		0,
		Route4A9
	},
	{ // A10
		21, 81,
		0,
		Route4A10
	},
	{ // A11
		21, 77,
		0,
		Route4A11
	},
	{ // A12
		9, 49,
		0,
		Route4A12
	},
	{ // A13
		5, 41,
		0,
		Route4A13
	},
	{ // A14
		17, 37,
		0,
		Route4A14
	},
	{ // A15
		9, 29,
		0,
		Route4A15
	},
	{ // B5
		1, 25,
		1,
		Route4B5
	},
	{ // A17
		5, 21,
		0,
		Route4A17
	},
	{ // A18
		1, 9,
		0,
		Route4A18
	},
	{ // A19
		9, 9,
		0,
		Route4A19
	},
};

static const GroundElement[] GroundElements5 = {
	{ // A0
		13, 121,
		0,
		Route5A0
	},
	{ // B0
		1, 117,
		3,
		Route5B0
	},
	{ // A2
		17, 113,
		0,
		Route5A2
	},
	{ // A3
		9, 105,
		0,
		Route5A3
	},
	{ // B1
		21, 105,
		3,
		Route5B1
	},
	{ // A5
		5, 81,
		0,
		Route5A5
	},
	{ // B3
		1, 77,
		3,
		Route5B3
	},
	{ // B2
		21, 77,
		1,
		Route5B2
	},
	{ // A8
		1, 73,
		0,
		Route5A8
	},
	{ // A9
		13, 61,
		0,
		Route5A9
	},
	{ // A10
		1, 53,
		0,
		Route5A10
	},
	{ // B4
		1, 49,
		3,
		Route5B4
	},
	{ // A12
		17, 45,
		0,
		Route5A12
	},
	{ // A13
		5, 41,
		0,
		Route5A13
	},
	{ // B5
		21, 37,
		3,
		Route5B5
	},
	{ // A15
		5, 33,
		0,
		Route5A15
	},
	{ // A16
		9, 29,
		0,
		Route5A16
	},
	{ // A17
		13, 25,
		0,
		Route5A17
	},
	{ // A18
		17, 9,
		0,
		Route5A18
	},
	{ // A19
		21, 9,
		0,
		Route5A19
	},
	{ // A20
		9, 5,
		0,
		Route5A20
	},
};

static const GroundElement[] GroundElements6 = {
	{ // B1
		1, 121,
		1,
		Route6B1
	},
	{ // A2
		5, 113,
		0,
		Route6A2
	},
	{ // A4
		13, 113,
		0,
		Route6A4
	},
	{ // B3
		1, 89,
		2,
		Route6B3
	},
	{ // A5
		1, 85,
		0,
		Route6A5
	},
	{ // A6
		21, 85,
		0,
		Route6A6
	},
	{ // A7
		1, 77,
		0,
		Route6A7
	},
	{ // B2
		9, 77,
		1,
		Route6B2
	},
	{ // A8
		13, 77,
		0,
		Route6A8
	},
	{ // A9
		21, 77,
		0,
		Route6A9
	},
	{ // A11
		5, 53,
		0,
		Route6A11
	},
	{ // A12
		9, 53,
		0,
		Route6A12
	},
	{ // B7
		21, 45,
		3,
		Route6B7
	},
	{ // A14
		1, 37,
		0,
		Route6A14
	},
	{ // A15
		9, 29,
		0,
		Route6A15
	},
	{ // B8
		1, 25,
		2,
		Route6B8
	},
	{ // A16
		21, 25,
		0,
		Route6A16
	},
	{ // A17
		17, 21,
		0,
		Route6A17
	},
	{ // A18
		1, 5,
		0,
		Route6A18
	},
};

static const GroundElement[] GroundElements7 = {
	{ // A0
		9, 121,
		0,
		Route7A0
	},
	{ // B0
		1, 117,
		3,
		Route7B0
	},
	{ // A2
		9, 113,
		0,
		Route7A2
	},
	{ // A3
		21, 113,
		0,
		Route7A3
	},
	{ // B1
		21, 101,
		3,
		Route7B1
	},
	{ // B3
		13, 77,
		3,
		Route7B3
	},
	{ // A6
		5, 61,
		0,
		Route7A6
	},
	{ // A7
		9, 53,
		0,
		Route7A7
	},
	{ // A8
		9, 45,
		0,
		Route7A8
	},
	{ // A10
		5, 29,
		0,
		Route7A10
	},
	{ // A11
		17, 29,
		0,
		Route7A11
	},
	{ // B4
		21, 21,
		3,
		Route7B4
	},
	{ // A12
		1, 5,
		0,
		Route7A12
	},
	{ // A13
		5, 5,
		0,
		Route7A13
	},
};

const Stage[] Stages = {
	{
		12,
		10,SkyElements0,
		18,GroundElements0,
	},
	{
		5,
		10,SkyElements1,
		13,GroundElements1,
	},
	{
		3,
		10,SkyElements2,
		17,GroundElements2,
	},
	{
		17,
		8,SkyElements3,
		20,GroundElements3,
	},
	{
		14,
		8,SkyElements4,
		20,GroundElements4,
	},
	{
		0,
		8,SkyElements5,
		21,GroundElements5,
	},
	{
		18,
		8,SkyElements6,
		19,GroundElements6,
	},
	{
		2,
		8,SkyElements7,
		14,GroundElements7,
	},
};

