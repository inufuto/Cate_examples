cseg

AsciiPattern: public AsciiPattern
;	ascii 28
	; " 0123456789=ACEGHKMNOPRSTUVY"
	defb &h00,&h00,&h00,&h00,&hf8,&h88,&hf8,&h00
	defb &h00,&h00,&hf8,&h00,&hb8,&ha8,&he8,&h00
	defb &ha8,&ha8,&hf8,&h00,&he0,&h20,&hf8,&h00
	defb &he8,&ha8,&hb8,&h00,&hf8,&ha8,&hb8,&h00
	defb &h80,&hb8,&hc0,&h00,&hf8,&ha8,&hf8,&h00
	defb &he8,&ha8,&hf8,&h00,&h50,&h50,&h50,&h00
	defb &h78,&h90,&h78,&h00,&h70,&h88,&h50,&h00
	defb &hf8,&ha8,&h88,&h00,&h70,&h88,&hb0,&h00
	defb &hf8,&h20,&hf8,&h00,&hf8,&h20,&hd8,&h00
	defb &hf8,&h60,&hf8,&h00,&hf8,&h80,&h78,&h00
	defb &h70,&h88,&h70,&h00,&hf8,&ha0,&he0,&h00
	defb &hf8,&ha0,&h58,&h00,&h68,&ha8,&hb0,&h00
	defb &h80,&hf8,&h80,&h00,&hf8,&h08,&hf8,&h00
	defb &hf0,&h08,&hf0,&h00,&hc0,&h38,&hc0,&h00

CharPattern: public CharPattern
;	bg
	defb &h00,&h00,&h00,&h00,&h00,&h00,&h00,&h01
	defb &h00,&h00,&h00,&h00,&h00,&h00,&h00,&hff
	defb &h01,&h01,&h01,&h01,&h01,&h01,&h01,&h01
	defb &h01,&h01,&h01,&h01,&h01,&h01,&h01,&hff
	defb &h00,&h00,&h00,&h18,&h18,&h00,&h00,&h01
	defb &h00,&h00,&h00,&h18,&h18,&h00,&h00,&hff
	defb &h01,&h01,&h01,&h19,&h19,&h01,&h01,&h01
	defb &h01,&h01,&h01,&h19,&h19,&h01,&h01,&hff
	defb &h00,&h22,&h6a,&h6a,&h6a,&h6a,&h22,&h01
	defb &h00,&h22,&h6a,&h6a,&h6a,&h6a,&h22,&hff
	defb &h01,&h23,&h6b,&h6b,&h6b,&h6b,&h23,&h01
	defb &h01,&h23,&h6b,&h6b,&h6b,&h6b,&h23,&hff
	defb &h00,&h22,&h6a,&h6a,&h6a,&h6a,&h22,&h00
;	sprite
	defb &h00,&h20,&h2a,&h7c,&h6c,&h52,&h10,&h00
	defb &h00,&h10,&h52,&h6c,&h7c,&h2a,&h20,&h00
	defb &h00,&h20,&h7a,&h7c,&h7c,&h3a,&h20,&h00
	defb &h00,&h20,&h2a,&h7c,&h6c,&h7a,&h20,&h00
	defb &h00,&h28,&h7c,&h6e,&h3e,&h3a,&h00,&h00
	defb &h00,&h00,&h3a,&h3e,&h6e,&h7c,&h28,&h00
	defb &h00,&h38,&h7c,&h7e,&h7c,&h38,&h00,&h00
	defb &h00,&h00,&h38,&h6c,&h7e,&h6c,&h38,&h00
	defb &h00,&h00,&h0c,&h12,&h14,&h18,&h00,&h00
	defb &h00,&h00,&h1c,&h22,&h4a,&h22,&h1c,&h00
