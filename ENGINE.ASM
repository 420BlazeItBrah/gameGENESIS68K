; cmd /c "cd /d ""C:\dos\snasm68k\"" && ""C:\dos\snasm68k\build.bat"""	

;Add Palette Macro (to VDP CRAM)
ADD_PALETTE: MACRO CRAM_LOC, PALETTE		
	LEA VDP_CRAM_WRITE+\CRAM_LOC, A4	; Load address of Palette CRAM location into A4
	MOVE.L A4, VDP_CONTROL				; Move A4 into VDP Control
	LEA \PALETTE, A0					; Load address of Palette map into A0
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)	
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)	
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)	
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0)+, VDP_DATA				; Move A0 into VDP_DATA (auto increment)
	MOVE.W (A0), VDP_DATA				; Move A0 into VDP_DATA
	ADD.B #$01, NUM_PALETTES			; Increment Memory Address (Number of Palettes) by 1
	ENDM
	

;Add Graphics Macro (to VDP VRAM)
ADD_GRAPHICS: MACRO GRAPHICS, GRAPHICS_END
	MOVEQ #$00000000, D0						; Initialize D0
	LEA VDP_VRAM_WRITE, A4						; Load Address of VRAM location into A4
	MOVE.L NUM_GRAPHICS, D0						; Move NUM_GRAPHICS value into D0
	LSL.W #$02, D0
	SWAP D0

	ADD.L D0, A4
	MOVE.L A4, VDP_CONTROL						; Move A4 into VDP Control (VRAM location + offset (80000))
	
	MOVE.L #(\GRAPHICS_END-\GRAPHICS), D1		
	LSR.W #$02, D1	
	ADD.L D1, NUM_GRAPHICS
	

	
	LEA \GRAPHICS, A0

\@LOOP_G:
	MOVE.L (A0)+, VDP_DATA						; Move Graphics Data to VDP
	DBRA D1, \@LOOP_G							; Decrement D1, Jump to LOOP_G
	ENDM


 ; DC.W 0x00F4 ; y coord
 ; DC.B %0101 ;width/height (can be 1x1, 2x2, 2x1, ... 4x4)
 ; DC.B 0x00 ;next sprite on linked list?
 ; DC.B %00000000 ;0-2 = tile hi (???); 3-4 = h/v flip, palette = 5/6, prio = 7
 ; DC.B 0x5F ;tile index
 ; DC.W 0x094 ; x coord

;Add Sprite Macro (to VDP Sprite Table)
ADD_SPRITE: MACRO X_COORDINATE, Y_COORDINATE, DIMENSIONS, TILE_INDEX, FLAGS, VEL_X, VEL_Y
	LEA VDP_SPRITE_TABLE_ADDR, A4		; load sprite vdp address into A4 (base address)
	MOVEQ #$00000000, D4				; Initialize D4
	MOVE.B NUM_SPRITES, D4				; move NUM_SPRITES to D4	
	LSL.L #$03, D4						; Multiply D4 to the power of 3 	
	SWAP D4								; SWAP D4 From X to Y (00YY00XX)	
	ADD.L D4, A4						; Add D4 to A4 (vdp sprite address base + D4)
	MOVE.L A4, VDP_CONTROL				; Move A4 to VDP_CONTROL (we do this because $70000003 is the base address, but following sprites are offset by $80000)			
	MOVEQ #$00000000, D2				; initialize D2	
	MOVEQ #$00000000, D3				; initialize D3	
	MOVE.L D2, A4						; initialize A4 (Move Cleared D2 to A4)
	MOVE.W #\Y_COORDINATE, D2			; Add Y_COORDINATE $XXXX0000 to D2
	SWAP D2								; SWAP D2 From X to Y (YYYYXXXX)
	MOVE.W #\DIMENSIONS, D3				; Add DIMENSIONS $0000XX00 to D3	
	ADD.L D2, A4						; Add D2 (Y_COORDINATE to A4)
	ADD.L D3, A4						; Add D3 (DIMENSIONS to A4)
	MOVE.L A4, VDP_DATA					; Move A4 to VDP_DATA (Do not set the linked list index because we re-sort later)		
	MOVEQ #$00000000, D2				; initialize D2	
	MOVEQ #$00000000, D3				; initialize D3
	MOVEQ #$00000000, D4				; initialize D4
	MOVE.L D2, A4						; initialize A4 (Move Cleared D2 to A4)
	MOVE.W #\FLAGS, D2					; Add FLAGS $XX000000 to D2
	SWAP D2								; SWAP D2 From X to Y (YYYYXXXX)
	MOVE.B #\TILE_INDEX, D3				; Add TILE_INDEX $00XX0000 to D3	
	SWAP D3								; SWAP D3 From X to Y (00YY00XX)
	MOVE.W #\X_COORDINATE, D4			; Add X_COORDINATE $0000XXXX to D4
	ADD.L D2, A4						; Add D2 (FLAGS to A4)
	ADD.L D3, A4						; Add D3 (TILE_INDEX to A4)
	ADD.L D4, A4						; Add D4 (X_COORDINATE to A4)
	MOVE.L A4, VDP_DATA					; Move A4 to VDP_DATA	
	MOVEQ #$00000000, D1				; Initialize D1	
	MOVE.B NUM_SPRITES, D1				; Move Number of Sprites to D1
	LEA SPRITE_VELOCITY_X, A5 			; Velocity for Sprite stored in RAM. Always at SPRITE_VELOCITY_X memory location + offset (2)
	LSL.B D1							; Multiply D1 by 2	
	ADD.W D1, A5						; Add D1 to A5
	MOVE.W \#VEL_X, (A5) 			    ; Move VEL_X to Address at A5
	LEA SPRITE_VELOCITY_Y, A5 			; Velocity for Sprite stored in RAM. Always at SPRITE_VELOCITY_Y memory location + offset (2)
	ADD.W D1, A5						; Add D1 to A5
	MOVE.W \#VEL_Y, (A5) 			    ; Move VEL_Y to Address at A5
	ADD.B #$01, NUM_SPRITES				; Increment number of sprites by 1 to assist in calculations above	
	BSR RESORT_SPRITE_LINKED_LIST   	; Resort Sprite Linked List
	ENDM

;Re-Sort Sprite Linked List
RESORT_SPRITE_LINKED_LIST:	
	MOVEQ #$00000000, D0					; Initialize D0
@LOOP:	
	CMP.B NUM_SPRITES, D0
	BEQ @DONE
	LEA VDP_SPRITE_TABLE_ADDR_READ, A2
	MOVEQ #$00000000, D2					; Initialize D2
	MOVE.L D0, D2
	LSL.B #$03, D2							; Multiply D2 to the power of 3 
	SWAP D2									; SWAP D2 From X to Y (00YY00XX)
	ADD.L D2, A2						
	MOVE.L A2, VDP_CONTROL
	MOVE.L VDP_DATA, D3
	CLR.B D3								; Clear first byte of D3
	ADD.B D0, D3
	ADD.L #$01, D3	
	LEA VDP_SPRITE_TABLE_ADDR, A2
	MOVEQ #$00000000, D2					; Initialize D2
	MOVE.L D0, D2
	LSL.B #$03, D2							; Multiply D2 to the power of 3 
	SWAP D2									; SWAP D2 From X to Y (00YY00XX)
	ADD.L D2, A2	
	MOVE.L A2, VDP_CONTROL
	MOVE.L D3, VDP_DATA	
	ADD.B #$01, D0	
	BRA @LOOP
@DONE:
	RTS
	
; Draw String at location
DRAW_STRING: MACRO STRING, LOC
	LEA \LOC, A2
	MOVE.L A2, VDP_CONTROL	
	MOVE.W \STRING, A1		
LOOP\@:		
	CMP.W #TILE_END, (A1)
	BEQ EXIT\@
	MOVE.W (A1)+, VDP_DATA	
	BRA LOOP\@	
EXIT\@:
	ENDM
	
DRAW_LEVEL: MACRO TILE_MAP
	MOVEQ #$00000000, D1				; Initialize D4
	MOVEQ #$00000000, D2				; Initialize D4
	MOVEQ #$00000000, D4				; Initialize D4
	LEA VDP_PLANEB_BASE_ADDR, A5		; load PLANE B Address into A5
	MOVE.L A5, VDP_CONTROL				; MOVE A5 to VDP Control
	MOVE.W \#TILE_MAP, A2				; load MAP Data address into A2	
	MOVE.B (A2)+, D1 					; Size of MAP in Height
	MOVE.B (A2)+, D2 					; Size of MAP in Width	
\@LOOP1:								
	MOVE.W D2, D4						; Move D2 (Width) into D4 (Every DBRA, D4 gets lowered. Reset D4 to reset the Loop counter)
\@LOOP2:
	MOVE.W (A2)+, VDP_DATA				; Move MAP Data (Size Word) to VDP 
	DBRA D4, \@LOOP2					; Jump to \@LOOP2	
	ADD.L #$00800000, A5				; Add $00800000 to A5 (because the next row is offset by 800000)
	MOVE.L A5, VDP_CONTROL				; Move A5 (Plane B Address + $800000 to VDP Control, new place to draw)		
	DBRA D1, \@LOOP1					; Jump to \@LOOP1
	ENDM

;XGM Playback Routine (To be ran in VINT)
VINT_XGMPLAYBACK:
	;($A11100) = Z80HALT
	;($A11200) = Z80RESET
	CMP.B #$01, XGM_READY
	BNE @NOT_READY
@xgm_loop:
	MOVE.W  #$0100, ($A11100).l 		;TAKE BUS
@Waitforz80b:
	btst	#$00, ($A11100).l
	bne	@Waitforz80b				;Wait for z80 to halt	
	CMP.W #$0000, ($A00112).l 		;Z80 not accessing ?
	BEQ @xgm_end
	MOVE.W  #$0000, ($A11100).l 		;RELEASE BUS
	MOVEM.L D0-D3, -(SP)			;WAIT A BIT (80 cycles)
	MOVEM.L (SP)+, D0-D3	
	BRA @xgm_loop
@xgm_end:	
	MOVE.B #$01, ($A00113).l	 	;increment frame to process
	MOVE.W #$0000,($A11100).l		;RELEASE BUS
@NOT_READY:
	RTS

;
VINT_UPDATESPRITEPOSITIONS:		
	MOVEQ #$00000000, D2					; Initialize D2, the OFFSET for DP SPRITE TABLE (Read / Write) (Loop counter as well, based off of NUM_SPRITES)
	MOVEQ #$00000000, D4					; Initialize D4, the X Velocity to add to a sprite
	MOVEQ #$00000000, D5					; Initialize D5, the Y Velocity to add to a sprite	
@LOOP:	
	LEA VDP_SPRITE_TABLE_ADDR_READ, A6
	
	LSL.B #$03, D2
	SWAP D2
	
	ADD.L D2, A6
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D5						;Y	
	ADD.L #$60000, A6	
	MOVE.L A6, VDP_CONTROL	
	MOVE.W VDP_DATA, D4						;X
		
	SWAP D2	
	LSR.B #$03, D2	
	
	
	LSL.B D2	
		
	LEA SPRITE_VELOCITY_Y, A5 				; Y Velocity for Sprite stored in RAM. Always at SPRITE_VELOCITY_Y memory location + offset (2)	
	ADD.W D2, A5							; Add D1 to A5			
	ADD.W (A5), D5	
		
	LEA SPRITE_VELOCITY_X, A5 				; Y Velocity for Sprite stored in RAM. Always at SPRITE_VELOCITY_Y memory location + offset (2)
	ADD.W D2, A5							; Add D1 to A5	
	ADD.W (A5), D4	
	
	LSR.B D2
	
	LSL.B #$03, D2
	SWAP D2

	LEA VDP_SPRITE_TABLE_ADDR, A6
	ADD.L D2, A6
	MOVE.L A6, VDP_CONTROL	
	MOVE.W D5, VDP_DATA						;Y	
	ADD.L #$60000, A6			
	MOVE.L A6, VDP_CONTROL			
	MOVE.W D4, VDP_DATA						;X
		
	SWAP D2
	LSR.B #$03, D2
	
	ADDQ #$01, D2
	CMP.B NUM_SPRITES, D2
	BNE @LOOP	
	RTS

;
VINT_CHECKCOLLISION_BOUNDRIES:
	MOVEQ #$00000000, D2					
	MOVEQ #$00000000, D4					
	MOVEQ #$00000000, D5					
	
@LOOPz:	
	LEA VDP_SPRITE_TABLE_ADDR_READ, A6
	
	LSL.B #$03, D2
	SWAP D2
	
	ADD.L D2, A6
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D5					

	SWAP D2	
	LSR.B #$03, D2	
		
	MOVEQ #$00000000, D1				
	MOVE.B D2, D1
	LEA SPRITE_VELOCITY_Y, A5 			
	LSL.B D1							
	ADD.W D1, A5						
	
	
	CMP.W #SCREEN_BOUNDRY_BOTTOM, D5
	BGT @INVERSE
	CMP.W #SCREEN_BOUNDRY_TOP, D5
	BLT @INVERSE	
	BRA @GO
@INVERSE:	
	NEG.W (A5)	
@GO:	
	ADD.W (A5), D5	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	LEA VDP_SPRITE_TABLE_ADDR_READ+$60000, A6
	
	LSL.B #$03, D2
	SWAP D2
	
	ADD.L D2, A6
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D4					

	SWAP D2	
	LSR.B #$03, D2	
		
	MOVEQ #$00000000, D1				
	MOVE.B D2, D1
	LEA SPRITE_VELOCITY_X, A5 			
	LSL.B D1							
	ADD.W D1, A5						
	
	
	CMP.W #SCREEN_BOUNDRY_RIGHT, D4
	BGT @INVERSE2
	CMP.W #SCREEN_BOUNDRY_LEFT, D4
	BLT @INVERSE2	
	BRA @GO2
@INVERSE2:	
	NEG.W (A5)	
@GO2:	
	ADD.W (A5), D4	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ADDQ #$01, D2
	CMP.B NUM_SPRITES, D2
	BNE @LOOPz			
	RTS

;;;;;;SPRITE COLLISION
VINT_CHECKCOLLISION_SPRITE:	
	MOVEQ #$00000000, D1	;x1
	MOVEQ #$00000000, D2	;y1
	MOVEQ #$00000000, D3	;x2			
	MOVEQ #$00000000, D4	;y2
	
	MOVEQ #$00000000, D5	; Loop through Sprites being Against
	MOVEQ #$00000000, D6	; Loop through Sprites being Compared to
	MOVEQ #$00000000, D7	; SIZE OF NUM_SPRITES, used for looping
	
	MOVE.B NUM_SPRITES, D7	; Set D7 to NUM_SPRITES
		
	; As D5 = 0, Loop through D6 until Num of sprites
	; Reset D6, increment D5, repeat above
	; If D5 == NUM_SPRITES, RTS

MASTER_LOOP:
	MOVEQ #$00000000, D6	; reset sub loop counter
	
	LEA SPRITE_VELOCITY_X, A4
	LEA SPRITE_VELOCITY_Y, A5
	
SUB_LOOP:
	;Sprite being Compared Against
	LEA VDP_SPRITE_TABLE_ADDR_READ+$80000, A6

	LSL.B #$03, D5
	SWAP D5
	ADD.L D5, A6	
	
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D2
	ADD.L #$00060000, A6
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D1
	
	SWAP D5
	LSR.B #$03, D5
	
	MOVEQ #$00000000, D3	;x2			
	MOVEQ #$00000000, D4	;y2
	;Sprite being Compared To
	LEA VDP_SPRITE_TABLE_ADDR_READ, A6
	
	LSL.B #$03, D6
	SWAP D6
	ADD.L D6, A6
	
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D4
	ADD.L #$60000, A6		
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D3
	
	SWAP D6
	LSR.B #$03, D6	

	;Consider maybe using D1 as X1/Y1, then SWAP when required
COLLISION_BOTTOM:
	ADD.W #$0010, D2
	CMP.W D4, D2
	BLE COLLISION_FINISHED
	SUB.W #$0010, D2
COLLISION_TOP:
	ADD.W #$0010, D4
	CMP.W D4, D2
	BGE COLLISION_FINISHED
	SUB.W #$0010, D4
;		
COLLISION_RIGHT:
	ADD.W #$0010, D1	
	CMP.W D3, D1
	BLE COLLISION_FINISHED
	SUB.W #$0010, D1
COLLISION_LEFT:
	ADD.W #$0010, D3	
	CMP.W D3, D1
	BGE COLLISION_FINISHED
	SUB.W #$0010, D3
HIT:		
	NEG.W (A4)
	NEG.W (A5)
COLLISION_FINISHED:

	ADDQ #$01, D6				;increment sub loop counter
	CMP.B D7, D6		
	BNE SUB_LOOP

COLLISION_FINALE:
	RTS

;;;;;;SPRITES COLLISION
;This was written as a test but is horribly optimized. Cycle count gets too high when exceeding 10 sprites
VINT_CHECKCOLLISION_SPRITES:	
	MOVEQ #$00000000, D1	;x1
	MOVEQ #$00000000, D2	;y1
	MOVEQ #$00000000, D3	;x2			
	MOVEQ #$00000000, D4	;y2
	
	MOVEQ #$00000000, D5	; Loop through Sprites being Against
	MOVEQ #$00000000, D6	; Loop through Sprites being Compared to
	MOVEQ #$00000000, D7	; SIZE OF NUM_SPRITES, used for looping
	
	MOVE.B NUM_SPRITES, D7	; Set D7 to NUM_SPRITES
		
	; As D5 = 0, Loop through D6 until Num of sprites
	; Reset D6, increment D5, repeat above
	; If D5 == NUM_SPRITES, RTS

XMASTER_LOOP:
	MOVEQ #$00000000, D6	; reset sub loop counter
	
	LEA SPRITE_VELOCITY_X, A4
	LEA SPRITE_VELOCITY_Y, A5
	LSL.B #$01, D5
	ADD.W D5, A4
	ADD.W D5, A5
	LSR.B #$01, D5
	
XSUB_LOOP:
	;Sprite being Compared Against
	LEA VDP_SPRITE_TABLE_ADDR_READ, A6

	LSL.B #$03, D5
	SWAP D5
	ADD.L D5, A6	
	
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D2
	ADD.L #$00060000, A6
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D1
	
	SWAP D5
	LSR.B #$03, D5
	
	;ensure sprite never tries to collide with itself
	CMP.W D5, D6
	BEQ XINCREMENT_SUB_LOOP
	BRA XSUB_LOOP_GO
XINCREMENT_SUB_LOOP:
	ADD.B #$01, D6
	CMP.B D7, D6
	BGE XCOLLISION_FINALE
XSUB_LOOP_GO:
	MOVEQ #$00000000, D3	;x2			
	MOVEQ #$00000000, D4	;y2
	;Sprite being Compared To
	LEA VDP_SPRITE_TABLE_ADDR_READ, A6
	
	LSL.B #$03, D6
	SWAP D6
	ADD.L D6, A6
	
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D4
	ADD.L #$60000, A6		
	MOVE.L A6, VDP_CONTROL
	MOVE.W VDP_DATA, D3
	
	SWAP D6
	LSR.B #$03, D6	

	;Consider maybe using D1 as X1/Y1, then SWAP when required
XCOLLISION_BOTTOM:
	ADD.W #$0010, D2
	CMP.W D4, D2
	BLE XCOLLISION_FINISHED
	SUB.W #$0010, D2
XCOLLISION_TOP:
	ADD.W #$0010, D4
	CMP.W D4, D2
	BGE XCOLLISION_FINISHED
	SUB.W #$0010, D4
;		
XCOLLISION_RIGHT:
	ADD.W #$0010, D1	
	CMP.W D3, D1
	BLE XCOLLISION_FINISHED
	SUB.W #$0010, D1
XCOLLISION_LEFT:
	ADD.W #$0010, D3	
	CMP.W D3, D1
	BGE XCOLLISION_FINISHED
	SUB.W #$0010, D3
XHIT:		
	NEG.W (A4)
	NEG.W (A5)
XCOLLISION_FINISHED:

	ADDQ #$01, D6				;increment sub loop counter
	CMP.B D7, D6		
	BNE XSUB_LOOP
	ADDQ #$01, D5
	CMP.B D7, D5
	BNE XMASTER_LOOP	
XCOLLISION_FINALE:
	RTS
	
	;set bg color
	;MOVE.W #$8732, VDP_CONTROL  
	
	;SetVRAMWrite $FC00 ;hscroll addr
	;MOVE.W #$0000, VDP_DATA	; Plane A h-scroll  
	;MOVE.W #$0000, VDP_DATA	; Plane B h-scroll
	