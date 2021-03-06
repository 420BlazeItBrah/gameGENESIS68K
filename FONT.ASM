FONT_COUNT EQU $40

TILE_SPACE EQU $00
TILE_EXCLAMATION EQU $01
TILE_QUOTE EQU $02
TILE_POUND EQU $03
TILE_DOLLAR EQU $04
TILE_PERCENT EQU $05
TILE_AND EQU $06
TILE_APOSTROPHE EQU $07
TILE_BRACKETL EQU $08
TILE_BRACKETR EQU $09
TILE_ASTERISK EQU $0A
TILE_PLUS EQU $0B
TILE_COMMA EQU $0C
TILE_DASH EQU $0D
TILE_PERIOD EQU $0E
TILE_FSLASH EQU $0F
TILE_0 EQU $10
TILE_1 EQU $11
TILE_2 EQU $12
TILE_3 EQU $13
TILE_4 EQU $14
TILE_5 EQU $15
TILE_6 EQU $16
TILE_7 EQU $17
TILE_8 EQU $18
TILE_9 EQU $19
TILE_COLON	EQU $1A
TILE_SEMICOLON	EQU $1B
TILE_GREATERTHAN	EQU $1C
TILE_EQUALS	EQU $1D
TILE_SMALLERTHAN	EQU $1E
TILE_QUESTION	EQU $1F
TILE_ATSIGN	EQU $20
TILE_A EQU $21
TILE_B EQU $22
TILE_C EQU $23
TILE_D EQU $24
TILE_E EQU $25
TILE_F EQU $26
TILE_G EQU $27
TILE_H EQU $28
TILE_I EQU $29
TILE_J EQU $2A
TILE_K EQU $2B
TILE_L EQU $2C
TILE_M EQU $2D
TILE_N EQU $2E
TILE_O EQU $2F
TILE_P EQU $30
TILE_Q EQU $31
TILE_R EQU $32
TILE_S EQU $33
TILE_T EQU $34
TILE_U EQU $35
TILE_V EQU $36
TILE_W EQU $37
TILE_X EQU $38
TILE_Y EQU $39
TILE_Z EQU $3A
TILE_PARENTHESISL EQU $3B
TILE_PARENTHESISR EQU $3C
TILE_POWEROF EQU $3D
TILE_UNDERSCORE EQU $3E
TILE_END EQU $3F

GRAPHICS_FONT:
	DC.L $00000000	;  Tile: 0
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $11400000	;  Tile: 1
	DC.L $11400000
	DC.L $11400000
	DC.L $33400000
	DC.L $FF400000
	DC.L $33400000
	DC.L $33400000
	DC.L $FF400000
	DC.L $11421F00	;  Tile: 2
	DC.L $11421F00
	DC.L $11421F00
	DC.L $FFFFFF00
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000	;  Tile: 3
	DC.L $01401F00
	DC.L $11111140
	DC.L $422F3F40
	DC.L $03403F00
	DC.L $33333340
	DC.L $42FF3F40
	DC.L $0F40FF00
	DC.L $00114000	;  Tile: 4
	DC.L $01111140
	DC.L $11FFFF40
	DC.L $40333F00
	DC.L $0FFF3340
	DC.L $33333F40
	DC.L $FF33FF00
	DC.L $00FF4000
	DC.L $00000000	;  Tile: 5
	DC.L $11401140
	DC.L $11401F40
	DC.L $FF33FF00
	DC.L $403FFF00
	DC.L $33FF3340
	DC.L $3F403340
	DC.L $FF00FF40
	DC.L $00111F00	;  Tile: 6
	DC.L $011F1140
	DC.L $0F111F40
	DC.L $0333FF40
	DC.L $3344333F
	DC.L $33FF33FF
	DC.L $4433443F
	DC.L $0FFFFFFF
	DC.L $11400000	;  Tile: 7
	DC.L $11400000
	DC.L $1F000000
	DC.L $40000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $01114000	;  Tile: 8
	DC.L $111F4000
	DC.L $11FF0000
	DC.L $33400000
	DC.L $33400000
	DC.L $333F0000
	DC.L $41334000
	DC.L $0FFF4000
	DC.L $111F0000	;  Tile: 9
	DC.L $41114000
	DC.L $0F114000
	DC.L $00334000
	DC.L $00334000
	DC.L $03334000
	DC.L $333F4000
	DC.L $FFFF0000
	DC.L $00000000	;  Tile: 10
	DC.L $11401140
	DC.L $41111F40
	DC.L $33333340
	DC.L $41333F40
	DC.L $33FF3340
	DC.L $FF40FF40
	DC.L $00000000
	DC.L $00000000	;  Tile: 11
	DC.L $00114000
	DC.L $0011FF00
	DC.L $33333340
	DC.L $FF33FF40
	DC.L $00334000
	DC.L $00FF4000
	DC.L $00000000
	DC.L $00000000	;  Tile: 12
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $33400000
	DC.L $33400000
	DC.L $41400000
	DC.L $0F400000
	DC.L $00000000	;  Tile: 13
	DC.L $00000000
	DC.L $00000000
	DC.L $33333340
	DC.L $FFFFFF40
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000	;  Tile: 14
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $33400000
	DC.L $33400000
	DC.L $FF400000
	DC.L $00000000	;  Tile: 15
	DC.L $00001140
	DC.L $00011F40
	DC.L $0033FF00
	DC.L $033F4000
	DC.L $33FF0000
	DC.L $3F400000
	DC.L $FF000000
	DC.L $01111F00	;  Tile: 16
	DC.L $11401140
	DC.L $11401140
	DC.L $33403340
	DC.L $33403340
	DC.L $33403340
	DC.L $41333F40
	DC.L $0FFFFF00
	DC.L $00114000	;  Tile: 17
	DC.L $01114000
	DC.L $0F114000
	DC.L $00334000
	DC.L $00334000
	DC.L $00334000
	DC.L $03333F00
	DC.L $0FFFFF00
	DC.L $01111F00	;  Tile: 18
	DC.L $11FF1140
	DC.L $11401140
	DC.L $FF403340
	DC.L $0033FF40
	DC.L $03FF4000
	DC.L $33333340
	DC.L $FFFFFF40
	DC.L $01111F00	;  Tile: 19
	DC.L $11FF1140
	DC.L $11401140
	DC.L $FF133F40
	DC.L $33FF3340
	DC.L $33403340
	DC.L $41133F40
	DC.L $0FFFFF00
	DC.L $00011F00	;  Tile: 20
	DC.L $00111F00
	DC.L $01411F00
	DC.L $3F033F00
	DC.L $3F033F00
	DC.L $33333340
	DC.L $FF413F40
	DC.L $000FFF00
	DC.L $11111140	;  Tile: 21
	DC.L $1FFFFF40
	DC.L $11111F00
	DC.L $FFFF3340
	DC.L $33403340
	DC.L $33403340
	DC.L $41333F40
	DC.L $0FFFFF00
	DC.L $01111F00	;  Tile: 22
	DC.L $11FF1140
	DC.L $1140FF40
	DC.L $33333F00
	DC.L $33FF3340
	DC.L $33403340
	DC.L $41333F40
	DC.L $0FFFFF00
	DC.L $11111140	;  Tile: 23
	DC.L $FFFF1140
	DC.L $00011F40
	DC.L $00033F00
	DC.L $0033FF00
	DC.L $00334000
	DC.L $00334000
	DC.L $00FF4000
	DC.L $01111F00	;  Tile: 24
	DC.L $11FF1140
	DC.L $11401140
	DC.L $41333F40
	DC.L $33FF3340
	DC.L $33403340
	DC.L $41333F40
	DC.L $0FFFFF00
	DC.L $01111F00	;  Tile: 25
	DC.L $11FF1140
	DC.L $11401140
	DC.L $41333340
	DC.L $0FFF3340
	DC.L $33403340
	DC.L $41333F40
	DC.L $0FFFFF00
	DC.L $00000000	;  Tile: 26
	DC.L $00000000
	DC.L $11400000
	DC.L $33400000
	DC.L $FF400000
	DC.L $33400000
	DC.L $33400000
	DC.L $FF400000
	DC.L $00000000	;  Tile: 27
	DC.L $11400000
	DC.L $11400000
	DC.L $FF400000
	DC.L $33400000
	DC.L $33400000
	DC.L $41400000
	DC.L $0F400000
	DC.L $00011F00	;  Tile: 28
	DC.L $0011FF00
	DC.L $011F4000
	DC.L $33FF0000
	DC.L $413F0000
	DC.L $0F334000
	DC.L $00413F00
	DC.L $000FFF00
	DC.L $00000000	;  Tile: 29
	DC.L $00000000
	DC.L $11111140
	DC.L $FFFFFF40
	DC.L $00000000
	DC.L $33333340
	DC.L $FFFFFF40
	DC.L $00000000
	DC.L $11400000	;  Tile: 30
	DC.L $011F0000
	DC.L $00114000
	DC.L $00033F00
	DC.L $0033FF00
	DC.L $033F4000
	DC.L $33FF0000
	DC.L $FF400000
	DC.L $00000000	;  Tile: 31
	DC.L $01111F00
	DC.L $11FF1140
	DC.L $FF403F40
	DC.L $0033FF00
	DC.L $00FF4000
	DC.L $00334000
	DC.L $00FF4000
	DC.L $00000000	;  Tile: 32
	DC.L $01111F00
	DC.L $11FF1140
	DC.L $33403340
	DC.L $33403340
	DC.L $33FFFF40
	DC.L $41333340
	DC.L $0FFFFF40
	DC.L $00114000	;  Tile: 33
	DC.L $01FF1F00
	DC.L $1F001140
	DC.L $33333340
	DC.L $3FFF3340
	DC.L $3F003340
	DC.L $3F003340
	DC.L $FF00FF40
	DC.L $11111F00	;  Tile: 34
	DC.L $11FF1140
	DC.L $11401140
	DC.L $33333F40
	DC.L $33FF3340
	DC.L $33403340
	DC.L $33333F40
	DC.L $FFFFFF00
	DC.L $01111F00	;  Tile: 35
	DC.L $11FF4140
	DC.L $11400F40
	DC.L $33400000
	DC.L $33400000
	DC.L $33400340
	DC.L $41333F40
	DC.L $0FFFFF00
	DC.L $11111F00	;  Tile: 36
	DC.L $11FF1140
	DC.L $11401140
	DC.L $33403340
	DC.L $33403340
	DC.L $33403340
	DC.L $33333F40
	DC.L $FFFFFF00
	DC.L $11111140	;  Tile: 37
	DC.L $11FFFF40
	DC.L $11400000
	DC.L $33333F00
	DC.L $33FFFF00
	DC.L $33400000
	DC.L $33333340
	DC.L $FFFFFF40
	DC.L $11111140	;  Tile: 38
	DC.L $11FFFF40
	DC.L $11400000
	DC.L $33333F00
	DC.L $33FFFF00
	DC.L $33400000
	DC.L $33400000
	DC.L $FF400000
	DC.L $01111F00	;  Tile: 39
	DC.L $31FF4240
	DC.L $31400000
	DC.L $33403340
	DC.L $33FF4140
	DC.L $33401340
	DC.L $42333340
	DC.L $0FFFFF00
	DC.L $11401140	;  Tile: 40
	DC.L $11401140
	DC.L $11401140
	DC.L $33333340
	DC.L $33FF3340
	DC.L $33403340
	DC.L $33403340
	DC.L $FF40FF40
	DC.L $01111F00	;  Tile: 41
	DC.L $0011FF00
	DC.L $00114000
	DC.L $00334000
	DC.L $00334000
	DC.L $00334000
	DC.L $03333F00
	DC.L $00FFFF00
	DC.L $00001140	;  Tile: 42
	DC.L $00001140
	DC.L $00001140
	DC.L $00003340
	DC.L $3F003340
	DC.L $3F003340
	DC.L $43333F40
	DC.L $0FFFFF00
	DC.L $11401140	;  Tile: 43
	DC.L $11401F00
	DC.L $11114000
	DC.L $333F0000
	DC.L $33334000
	DC.L $33433F00
	DC.L $33FF3340
	DC.L $FF40FF40
	DC.L $11400000	;  Tile: 44
	DC.L $11400000
	DC.L $11400000
	DC.L $33400000
	DC.L $33400000
	DC.L $33400000
	DC.L $33333340
	DC.L $FFFFFF40
	DC.L $1F00001F	;  Tile: 45
	DC.L $1140011F
	DC.L $111F111F
	DC.L $3343433F
	DC.L $33FF433F
	DC.L $3340033F
	DC.L $3340033F
	DC.L $FF400FFF
	DC.L $1F000140	;  Tile: 46
	DC.L $11400140
	DC.L $111F0140
	DC.L $33334340
	DC.L $33433340
	DC.L $33FF3340
	DC.L $33404340
	DC.L $FF400F40
	DC.L $01111F00	;  Tile: 47
	DC.L $11FF1140
	DC.L $11401140
	DC.L $33403340
	DC.L $33403340
	DC.L $33403340
	DC.L $43333F40
	DC.L $0FFFFF00
	DC.L $11111F00	;  Tile: 48
	DC.L $11FF1140
	DC.L $11401140
	DC.L $33403340
	DC.L $33333F40
	DC.L $33FFFF00
	DC.L $33400000
	DC.L $FF400000
	DC.L $01111F00	;  Tile: 49
	DC.L $11FF1140
	DC.L $11401140
	DC.L $33403340
	DC.L $33404340
	DC.L $33FF3F40
	DC.L $43334340
	DC.L $0FFFFF00
	DC.L $11111F00	;  Tile: 50
	DC.L $11FF1140
	DC.L $11401140
	DC.L $33333F40
	DC.L $33FF3340
	DC.L $33403340
	DC.L $33403340
	DC.L $FF40FF40
	DC.L $01111F00	;  Tile: 51
	DC.L $11FF4340
	DC.L $11400F40
	DC.L $43333F00
	DC.L $0FFF3340
	DC.L $3F003340
	DC.L $43333F40
	DC.L $0FFFFF00
	DC.L $11111140	;  Tile: 52
	DC.L $FF11FF40
	DC.L $00114000
	DC.L $00334000
	DC.L $00334000
	DC.L $00334000
	DC.L $00334000
	DC.L $00FF4000
	DC.L $11400140	;  Tile: 53
	DC.L $11400140
	DC.L $11400140
	DC.L $33400340
	DC.L $33400340
	DC.L $33400340
	DC.L $43333F40
	DC.L $0FFFFF00
	DC.L $11400140	;  Tile: 54
	DC.L $11400140
	DC.L $11400140
	DC.L $33400340
	DC.L $433F3F40
	DC.L $433F3F00
	DC.L $0F33FF00
	DC.L $00FF4000
	DC.L $1140001F	;  Tile: 55
	DC.L $1140001F
	DC.L $11401F1F
	DC.L $33403F3F
	DC.L $33403F3F
	DC.L $33403F3F
	DC.L $433F33FF
	DC.L $0FFFFF40
	DC.L $11400140	;  Tile: 56
	DC.L $11401140
	DC.L $43111F40
	DC.L $0F33FF00
	DC.L $03333F00
	DC.L $33FF3340
	DC.L $3F004340
	DC.L $FF000F40
	DC.L $11400140	;  Tile: 57
	DC.L $11400140
	DC.L $43141F40
	DC.L $0F33FF00
	DC.L $00334000
	DC.L $00334000
	DC.L $00334000
	DC.L $00FF4000
	DC.L $11111140	;  Tile: 58
	DC.L $FFFF1140
	DC.L $00011F40
	DC.L $0033FF00
	DC.L $033F4000
	DC.L $33FF0000
	DC.L $33333340
	DC.L $FFFFFF40
	DC.L $11114000	;  Tile: 59
	DC.L $11FF4000
	DC.L $11400000
	DC.L $33400000
	DC.L $33400000
	DC.L $33400000
	DC.L $33334000
	DC.L $FFFF4000
	DC.L $00000000	;  Tile: 60
	DC.L $1F000000
	DC.L $11400000
	DC.L $433F0000
	DC.L $0F334000
	DC.L $00433F00
	DC.L $000F3340
	DC.L $0000FF40
	DC.L $11114000	;  Tile: 61
	DC.L $FF114000
	DC.L $00114000
	DC.L $00334000
	DC.L $00334000
	DC.L $00334000
	DC.L $33334000
	DC.L $FFFF4000
	DC.L $00000000	;  Tile: 62
	DC.L $00014000
	DC.L $00111F00
	DC.L $033F3340
	DC.L $33FF433F
	DC.L $FF400FFF
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000	;  Tile: 63
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $00000000
	DC.L $3333333F
	DC.L $FFFFFFFF
GRAPHICS_FONT_END: