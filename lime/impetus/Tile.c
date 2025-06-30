#include "Tile.h"
#include "Chars.h"

const Tile[] Tiles  = {
	{
		// Sand
		{ Char_Space, Char_Space, Char_Space, Char_Space }, // full
		{ Char_Sand + 1, Char_Space, Char_Sand + 1, Char_Space }, // left
		{ Char_Space, Char_Sand + 0, Char_Space, Char_Sand + 0 }, // right
		{ Char_Sand + 3, Char_Sand + 3, Char_Space, Char_Space }, // top
		{ Char_Space, Char_Space, Char_Sand + 2, Char_Sand + 2 }, // bottom
		{ Char_Space, Char_Sand + 3, Char_Sand + 1, Char_Space }, // leftAndTop
		{ Char_Sand + 3, Char_Space, Char_Space, Char_Sand + 0 }, // rightAndTop
		{ Char_Sand + 1, Char_Space, Char_Space, Char_Sand + 2 }, // leftAndBottom
		{ Char_Space, Char_Sand + 0, Char_Sand + 2, Char_Space }, // rightAndBottom
		{ Char_Sand + 7, Char_Space, Char_Space, Char_Space }, // leftTop
		{ Char_Space, Char_Sand + 6, Char_Space, Char_Space }, // rightTop
		{ Char_Space, Char_Space, Char_Sand + 5, Char_Space }, // leftBottom
		{ Char_Space, Char_Space, Char_Space, Char_Sand + 4 }, // rightBottom
	},
	{
		// Forest
		{ Char_Forest + 0, Char_Forest + 0, Char_Forest + 0, Char_Forest + 0 }, // full
		{ Char_Space, Char_Forest + 0, Char_Space, Char_Forest + 0 }, // left
		{ Char_Forest + 0, Char_Space, Char_Forest + 0, Char_Space }, // right
		{ Char_Space, Char_Space, Char_Forest + 0, Char_Forest + 0 }, // top
		{ Char_Forest + 0, Char_Forest + 0, Char_Space, Char_Space }, // bottom
		{ Char_Space, Char_Space, Char_Space, Char_Forest + 4 }, // leftAndTop
		{ Char_Space, Char_Space, Char_Forest + 3, Char_Space }, // rightAndTop
		{ Char_Space, Char_Forest + 2, Char_Space, Char_Space }, // leftAndBottom
		{ Char_Forest + 1, Char_Space, Char_Space, Char_Space }, // rightAndBottom
		{ Char_Forest + 4, Char_Forest + 0, Char_Forest + 0, Char_Forest + 0 }, // leftTop
		{ Char_Forest + 0, Char_Forest + 3, Char_Forest + 0, Char_Forest + 0 }, // rightTop
		{ Char_Forest + 0, Char_Forest + 0, Char_Forest + 2, Char_Forest + 0 }, // leftBottom
		{ Char_Forest + 0, Char_Forest + 0, Char_Forest + 0, Char_Forest + 1 }, // rightBottom
	},
	{
		// Water
		{ Char_Water + 0, Char_Water + 0, Char_Water + 0, Char_Water + 0 }, // full
		{ Char_Space, Char_Water + 0, Char_Space, Char_Water + 0 }, // left
		{ Char_Water + 0, Char_Space, Char_Water + 0, Char_Space }, // right
		{ Char_Space, Char_Space, Char_Water + 0, Char_Water + 0 }, // top
		{ Char_Water + 0, Char_Water + 0, Char_Space, Char_Space }, // bottom
		{ Char_Space, Char_Space, Char_Space, Char_Water + 4 }, // leftAndTop
		{ Char_Space, Char_Space, Char_Water + 3, Char_Space }, // rightAndTop
		{ Char_Space, Char_Water + 2, Char_Space, Char_Space }, // leftAndBottom
		{ Char_Water + 1, Char_Space, Char_Space, Char_Space }, // rightAndBottom
		{ Char_Water + 4, Char_Water + 0, Char_Water + 0, Char_Water + 0 }, // leftTop
		{ Char_Water + 0, Char_Water + 3, Char_Water + 0, Char_Water + 0 }, // rightTop
		{ Char_Water + 0, Char_Water + 0, Char_Water + 2, Char_Water + 0 }, // leftBottom
		{ Char_Water + 0, Char_Water + 0, Char_Water + 0, Char_Water + 1 }, // rightBottom
	},
	{
		// Concrete
		{ Char_Space, Char_Space, Char_Space, Char_Space }, // full
		{ Char_Concrete + 1, Char_Space, Char_Concrete + 1, Char_Space }, // left
		{ Char_Space, Char_Concrete + 0, Char_Space, Char_Concrete + 0 }, // right
		{ Char_Concrete + 3, Char_Concrete + 3, Char_Space, Char_Space }, // top
		{ Char_Space, Char_Space, Char_Concrete + 2, Char_Concrete + 2 }, // bottom
		{ Char_Space, Char_Concrete + 3, Char_Concrete + 1, Char_Space }, // leftAndTop
		{ Char_Concrete + 3, Char_Space, Char_Space, Char_Concrete + 0 }, // rightAndTop
		{ Char_Concrete + 1, Char_Space, Char_Space, Char_Concrete + 2 }, // leftAndBottom
		{ Char_Space, Char_Concrete + 0, Char_Concrete + 2, Char_Space }, // rightAndBottom
		{ Char_Concrete + 7, Char_Space, Char_Space, Char_Space }, // leftTop
		{ Char_Space, Char_Concrete + 6, Char_Space, Char_Space }, // rightTop
		{ Char_Space, Char_Space, Char_Concrete + 5, Char_Space }, // leftBottom
		{ Char_Space, Char_Space, Char_Space, Char_Concrete + 4 }, // rightBottom
	},
};
