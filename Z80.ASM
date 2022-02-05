z80_loadDriver:
    move.w  #$100,($A11100)         ; Send the Z80 a bus request.
    move.w  #$100,($A11200)

@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..
     
    MOVE.L  #(Z80drv_end-Z80drv),D0
    LEA     Z80drv,A0
    MOVE.L  #$A00000,A1
     
@loop:
    MOVE.B  (A0)+, (A1)+
    DBRA    D0, @loop               ; load driver
    
    move.l  #$A01C00,a0             ; point to Z80 sample id table (first entry = silent sample)
    move.l  #NULLpcm,d0             ; d0 = silent sample

    lsr.l   #8,d0
    move.b  d0,(a0)+                ; sample address
    lsr.l   #8,d0
    move.b  d0,(a0)+
    move.b  #$01,(a0)+              ; sample length
    move.b  #$00,(a0) 
     
    move.w  #$000,($A11200)         ; Start Z80 Reset
    move.w  #$000,($A11100)         ; release the Z80 bus

    move.l  #$A00102,a0             ; point to status

@test_ready:
    move.w  #100,d0                 ; 

@wait:
    DBRA    D0, @wait               ; wait a bit
    
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)         ; End Z80 Reset

@z80_wait2:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait2              ; not yet, wait...

    move.b (a0),d0
    move.w  #$000,($A11100)         ; release the Z80 bus
    
    btst   #7,d0                    ; not yet ready
    beq    @test_ready   
	RTS

;' a1 should point on XGM music
xgm_startPlayMusic:
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)
    
@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..

	LEA $00FF00FC, a0
    ;move.l  a3,a0                   ; a0 = reserved $FC array for sample id table
    moveq   #0,d0
     
@loop:                              ; prepare sample id table
    move.w  d0,d1
    add.w   d1,d1   
    add.w   d1,d1
    moveq   #0,d2   
    move.w  0(a1,d1.w),d2           ; get sample addr in song bank table
    rol.w   #8,d2                   ; revert endianess

    cmp.w   #$FFFF,d2               ; is null sample ?
    bne     @not_null
    
    move.l  NULLpcm,d2
    jmp     @addr_done
    
@not_null:
    addq.w  #1,d2                   ; add offset
    lsl.l   #8,d2                   ; pass to 24 bits
    add.l   a1,d2                   ; transform to absolute address

@addr_done
    lsr.l   #8,d2                   ; get high byte
    move.b  d2,0(a0,d1.w)
    lsr.w   #8,d2                   ; get low byte
    move.b  d2,1(a0,d1.w)
    move.w  2(a1,d1.w),2(a0,d1.w)   ; copy sample length

    addq.w  #1,d0
    cmp.w   #$3F,d0
    bne     @loop

    move.l  #$A01C04,a2             ; destination of sample id table
    lsl.w   #2,d0                   ; set size in bytes
    subq.w  #1,d0
     
@sampleIdLoop:
    move.b (a0)+,(a2)+
    dbra   d0,@sampleIdLoop         ; load sample id table

    move.l  a1,d0                   ; d0 = song address
    add.l   #$100,d0                ; bypass sample id table

    moveq   #0,d2
    move.w  $FC(a1),d2              ; get sample data size
    rol.w   #8,d2                   ; revert endianess
    lsl.l   #8,d2                   ; pass to 24 bits

    add.l   d2,d0                   ; bypass samples data
    addq.l  #4,d0                   ; bypass music data size field
    
    move.l  #$A00104,a2             ; XGM base parameters address

    move.b  d0,0(a2)                ; low byte
    lsr.l   #8,d0
    move.b  d0,1(a2)                ; med low byte
    lsr.l   #8,d0
    move.b  d0,2(a2)                ; med high byte
    lsr.l   #8,d0
    move.b  d0,3(a2)                ; high byte
    
    or.b    #$40,($A00100)          ; send play XGM command

    move.w  #$000,($A11100)         ; release the Z80 bus    
	RTS

;;;;;;;;;;;;;;;;;;;;;
xgm_isPlayingMusic:
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)

@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..

    move.b  ($A00102),d0            ; get channel playing status
    andi.l  #$40,d0                 ; keep play XGM bit only
    
    move.w  #$000,($A11100)         ; release the Z80 bus
	RTS
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;
xgm_resumePlayMusic:
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)

@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..
    
    or.b    #$20,($A00100)          ; send resume play command

    move.w  #$000,($A11100)         ; release the Z80 bus
	RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xgm_stopPlayMusic:
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)

@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..
    
    or.b    #$10,($A00100)          ; send stop play command

    move.w  #$000,($A11100)         ; release the Z80 bus
	RTS

;;;;;;;;;;;;;;;;;;;;;;;;;PCM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;parameter should contains channel mask to test: 3210 
xgm_isPlayingPCM;(d2.w)
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)

@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..

    and.b   ($A00102),d2            ; get channel playing status
    moveq   #0,d0
    move.b  d2,d0                   ; store in d0
    
    move.w  #$000,($A11100)         ; release the Z80 bus
	RTS

; a1 should point on PCM sample
; d1 should contains PCM length
; d2 should contains channel and priority informations: (prio << 4) | channel
xgm_playPCM
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)
    
@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..

    ;move.l  (__LONG_pcmid),d0
    lsl.l   #2,d0
    lea     $A01C00,a0
    adda.l  d0,a0                   ; a0 point on id table entry
    
    move.l  a1,d0                   ; d0 = sample address
    
    lsr.l   #8,d0                   ; get sample address (high byte)
    move.b  d0,(a0)+
    lsr.w   #8,d0                   ; get sample address (low byte)
    move.b  d0,(a0)+
    lsr.l   #8,d1                   ; get sample length (high byte)
    move.b  d1,(a0)+
    lsr.w   #8,d1                   ; get sample length (low byte)
    move.b  d1,(a0)+
    
    move.l  d2,d0
    and.l   #3,d0                   ; d0 = channel number
    
    lea     $A00100,a0
    moveq   #1,d1    
    lsl.l   d0,d1                   ; d1 = channel shift command
    or.b    d1,(a0)                 ; set PCM play command
    
    lea     $A00108,a0   
    add.l   d0,d0
    adda.l  d0,a0                   ; a0 point on channel info

    move.l  d2,d0
    lsr.l   #4,d0
    and.l   #$F,d0                  ; d0 = priority
    
    move.b  d0,(a0)+                ; set priority
    
    ;move.l  (__LONG_pcmid),d0       ; d0 = PCM id

    move.b  d0,(a0)                 ; set PCM id

    addq.l  #1,d0  
    and.l   #$FF,d0                
    or.l   #$40,d0                  ; id < 0x40 are reserved for music
    ;move.l  d0,(__LONG_pcmid)       ; pass to next id

    move.w  #$000,($A11100)         ; release the Z80 bus
	RTS

;parameter should contains channel number
xgm_stopPCM;(d2.w)
    move.w  #$100,($A11100)         ; Send the Z80 a bus request
    move.w  #$100,($A11200)
        
@z80_wait1:
    move.w  ($A11100),D0            ; read Z80 halted state
    btst    #8,D0                   ; Z80 halted ?
    bne     @z80_wait1              ; not yet, wait..

    move.l  d2,d0
    and.l   #3,d0                   ; d0 = channel number
    
    lea     $A00100,a0
    moveq   #1,d1    
    lsl.l   d0,d1                   ; d1 = channel shift command
    or.b    d1,(a0)                 ; set PCM play command
    
    lea     $A00108,a0   
    add.l   d0,d0
    adda.l  d0,a0                   ; a0 point on channel info

    moveq   #15,d0
    move.b  d0,(a0)+                ; set priority
    moveq   #0,d0
    move.b  d0,(a0)                 ; set PCM id

    move.w  #$000,($A11100)         ; release the Z80 bus
	RTS


