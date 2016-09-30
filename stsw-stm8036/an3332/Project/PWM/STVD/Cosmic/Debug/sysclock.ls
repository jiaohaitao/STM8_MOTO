   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
 129                     ; 33 static void HSE_ClockStartUpConfiguration(HSE_Clock_TypeDef HSE_Clock,HSE_ClockStartUpTime_TypeDef HSE_ClockStartUpTime)
 129                     ; 34 {
 131                     .text:	section	.text,new
 132  0000               L3_HSE_ClockStartUpConfiguration:
 134  0000 89            	pushw	x
 135       00000000      OFST:	set	0
 138                     ; 35   FLASH_Unlock(FLASH_MEMTYPE_DATA);/*要对选项字节写操作，必须要先解锁FLASH*/
 140  0001 a6f7          	ld	a,#247
 141  0003 cd0000        	call	_FLASH_Unlock
 144  0006               L36:
 145                     ; 36   while(!(FLASH->IAPSR & FLASH_IAPSR_DUL));/*等待解锁完毕*/
 147  0006 7207505ffb    	btjf	20575,#3,L36
 148                     ; 38   if(HSE_Clock==HSE_24MHz)   
 150  000b 7b01          	ld	a,(OFST+1,sp)
 151  000d a101          	cp	a,#1
 152  000f 2608          	jrne	L76
 153                     ; 39   FLASH_ProgramOptionByte(FLASH_WAIT_STATES_ADDRESS,HSE_Clock);
 155  0011 88            	push	a
 156  0012 ae480d        	ldw	x,#18445
 157  0015 cd0000        	call	_FLASH_ProgramOptionByte
 159  0018 84            	pop	a
 160  0019               L76:
 161                     ; 40   FLASH_ProgramOptionByte(HSE_CLOCK_STARTUP_ADDRESS,HSE_ClockStartUpTime);
 163  0019 7b02          	ld	a,(OFST+2,sp)
 164  001b 88            	push	a
 165  001c ae4809        	ldw	x,#18441
 166  001f cd0000        	call	_FLASH_ProgramOptionByte
 168  0022 84            	pop	a
 169                     ; 42   FLASH_Lock(FLASH_MEMTYPE_DATA);/*操作完要加锁*/
 171  0023 a6f7          	ld	a,#247
 172  0025 cd0000        	call	_FLASH_Lock
 174                     ; 44 }
 177  0028 85            	popw	x
 178  0029 81            	ret	
 205                     ; 52 void DefaultSystemClockForHSI(void)
 205                     ; 53 {
 206                     .text:	section	.text,new
 207  0000               _DefaultSystemClockForHSI:
 211                     ; 54   FLASH_Unlock(FLASH_MEMTYPE_DATA);/*要对选项字节写操作，必须要先解锁FLASH*/
 213  0000 a6f7          	ld	a,#247
 214  0002 cd0000        	call	_FLASH_Unlock
 217  0005               L301:
 218                     ; 55   while(!(FLASH->IAPSR & FLASH_IAPSR_DUL));/*等待解锁完毕*/
 220  0005 7207505ffb    	btjf	20575,#3,L301
 221                     ; 56   FLASH_EraseOptionByte(FLASH_WAIT_STATES_ADDRESS);/*恢复HSI时钟*/
 223  000a ae480d        	ldw	x,#18445
 224  000d cd0000        	call	_FLASH_EraseOptionByte
 226                     ; 57   FLASH_EraseOptionByte(HSE_CLOCK_STARTUP_ADDRESS);
 228  0010 ae4809        	ldw	x,#18441
 229  0013 cd0000        	call	_FLASH_EraseOptionByte
 231                     ; 58   FLASH_Lock(FLASH_MEMTYPE_DATA);/*操作完要加锁*/
 233  0016 a6f7          	ld	a,#247
 235                     ; 59 }
 238  0018 cc0000        	jp	_FLASH_Lock
 297                     ; 73 void SystemClock_Init(SystemClock_TypeDef sysclk)
 297                     ; 74 {
 298                     .text:	section	.text,new
 299  0000               _SystemClock_Init:
 303                     ; 76    if(sysclk==HSE_Clock)/*选用外部时钟*/
 305  0000 4a            	dec	a
 306  0001 261a          	jrne	L531
 307                     ; 79      HSE_ClockStartUpConfiguration(HSE_24MHz,HSECNT_8CLK);
 309  0003 ae00d2        	ldw	x,#210
 310  0006 4c            	inc	a
 311  0007 95            	ld	xh,a
 312  0008 cd0000        	call	L3_HSE_ClockStartUpConfiguration
 315  000b               L141:
 316                     ; 81      while (!CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSE, DISABLE,\
 316                     ; 82             CLK_CURRENTCLOCKSTATE_DISABLE));
 318  000b 4b00          	push	#0
 319  000d 4b00          	push	#0
 320  000f ae00b4        	ldw	x,#180
 321  0012 a601          	ld	a,#1
 322  0014 95            	ld	xh,a
 323  0015 cd0000        	call	_CLK_ClockSwitchConfig
 325  0018 4d            	tnz	a
 326  0019 85            	popw	x
 327  001a 27ef          	jreq	L141
 330  001c 81            	ret	
 331  001d               L531:
 332                     ; 88      DefaultSystemClockForHSI();
 334  001d cd0000        	call	_DefaultSystemClockForHSI
 336                     ; 90      CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 338  0020 4f            	clr	a
 340                     ; 93 }
 343  0021 cc0000        	jp	_CLK_HSIPrescalerConfig
 356                     	xdef	_DefaultSystemClockForHSI
 357                     	xdef	_SystemClock_Init
 358                     	xref	_FLASH_EraseOptionByte
 359                     	xref	_FLASH_ProgramOptionByte
 360                     	xref	_FLASH_Lock
 361                     	xref	_FLASH_Unlock
 362                     	xref	_CLK_HSIPrescalerConfig
 363                     	xref	_CLK_ClockSwitchConfig
 382                     	end
