   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  49                     ; 41 void LED_Init(void)
  49                     ; 42 {
  51                     .text:	section	.text,new
  52  0000               _LED_Init:
  56                     ; 43 	GPIO_Init(LED_PORTC, LED_3, GPIO_MODE_OUT_PP_HIGH_FAST );	
  58  0000 4bf0          	push	#240
  59  0002 4b80          	push	#128
  60  0004 ae500a        	ldw	x,#20490
  61  0007 cd0000        	call	_GPIO_Init
  63  000a 85            	popw	x
  64                     ; 45 }
  67  000b 81            	ret	
  91                     ; 54 void SetLedOFF(void)
  91                     ; 55 {
  92                     .text:	section	.text,new
  93  0000               _SetLedOFF:
  97                     ; 56 	GPIO_WriteHigh(LED_PORTC, LED_3);
  99  0000 4b80          	push	#128
 100  0002 ae500a        	ldw	x,#20490
 101  0005 cd0000        	call	_GPIO_WriteHigh
 103  0008 84            	pop	a
 104                     ; 59 }
 107  0009 81            	ret	
 236                     ; 69 void LED_Operation(GPIO_Pin_TypeDef ledx, u8 state)
 236                     ; 70 {
 237                     .text:	section	.text,new
 238  0000               _LED_Operation:
 240  0000 89            	pushw	x
 241       00000000      OFST:	set	0
 244                     ; 71 	if(ON == state) {
 246  0001 9f            	ld	a,xl
 247  0002 4d            	tnz	a
 248  0003 2610          	jrne	L311
 249                     ; 72 	  	switch (ledx) {
 251  0005 9e            	ld	a,xh
 252  0006 a180          	cp	a,#128
 253  0008 2619          	jrne	L121
 256                     ; 79 			case LED_3:
 256                     ; 80 		  		GPIO_WriteLow(LED_PORTC, ledx);
 258  000a 7b01          	ld	a,(OFST+1,sp)
 259  000c 88            	push	a
 260  000d ae500a        	ldw	x,#20490
 261  0010 cd0000        	call	_GPIO_WriteLow
 263                     ; 81 			break;
 265  0013 200d          	jp	LC001
 266  0015               L311:
 267                     ; 84 	  	switch (ledx) {
 269  0015 7b01          	ld	a,(OFST+1,sp)
 270  0017 a180          	cp	a,#128
 271  0019 2608          	jrne	L121
 274                     ; 91 			case LED_3:
 274                     ; 92 		  		GPIO_WriteHigh(LED_PORTC, ledx);
 276  001b 88            	push	a
 277  001c ae500a        	ldw	x,#20490
 278  001f cd0000        	call	_GPIO_WriteHigh
 280  0022               LC001:
 281  0022 84            	pop	a
 282                     ; 93 			break;
 284  0023               L121:
 285                     ; 96 }
 288  0023 85            	popw	x
 289  0024 81            	ret	
 325                     ; 105 void LED_Reverse(GPIO_Pin_TypeDef ledx)
 325                     ; 106 {
 326                     .text:	section	.text,new
 327  0000               _LED_Reverse:
 329  0000 88            	push	a
 330       00000000      OFST:	set	0
 333                     ; 107 	switch (ledx) {
 335  0001 a180          	cp	a,#128
 336  0003 260a          	jrne	L151
 339                     ; 114 		case LED_3:
 339                     ; 115 			GPIO_WriteReverse(LED_PORTC, ledx);
 341  0005 7b01          	ld	a,(OFST+1,sp)
 342  0007 88            	push	a
 343  0008 ae500a        	ldw	x,#20490
 344  000b cd0000        	call	_GPIO_WriteReverse
 346  000e 84            	pop	a
 347                     ; 116 		break;
 349  000f               L151:
 350                     ; 118 }
 353  000f 84            	pop	a
 354  0010 81            	ret	
 379                     ; 127 void LED_ShowOneToOne(void)
 379                     ; 128 {
 380                     .text:	section	.text,new
 381  0000               _LED_ShowOneToOne:
 385                     ; 131     LED_Operation(LED_3, OFF);
 387  0000 ae0001        	ldw	x,#1
 388  0003 ad06          	call	LC002
 389                     ; 135     LED_Operation(LED_3, OFF);
 391  0005 ae0001        	ldw	x,#1
 392  0008 ad01          	call	LC002
 393                     ; 139     LED_Operation(LED_3, ON);
 395  000a 5f            	clrw	x
 396                     ; 142 }
 399  000b               LC002:
 400  000b a680          	ld	a,#128
 401  000d 95            	ld	xh,a
 402  000e cd0000        	call	_LED_Operation
 404                     ; 140     Delay(0x1ffff);
 406  0011 aeffff        	ldw	x,#65535
 407  0014 89            	pushw	x
 408  0015 ae0001        	ldw	x,#1
 409  0018 89            	pushw	x
 410  0019 cd0000        	call	L3_Delay
 412  001c 5b04          	addw	sp,#4
 413  001e 81            	ret	
 447                     ; 151 static void Delay(u32 nCount)
 447                     ; 152 {
 448                     .text:	section	.text,new
 449  0000               L3_Delay:
 451       00000000      OFST:	set	0
 454  0000 2009          	jra	L302
 455  0002               L102:
 456                     ; 156 		nCount--;
 458  0002 96            	ldw	x,sp
 459  0003 1c0003        	addw	x,#OFST+3
 460  0006 a601          	ld	a,#1
 461  0008 cd0000        	call	c_lgsbc
 463  000b               L302:
 464                     ; 154 	while (nCount != 0)
 466  000b 96            	ldw	x,sp
 467  000c 1c0003        	addw	x,#OFST+3
 468  000f cd0000        	call	c_lzmp
 470  0012 26ee          	jrne	L102
 471                     ; 158 }
 474  0014 81            	ret	
 487                     	xdef	_LED_ShowOneToOne
 488                     	xdef	_LED_Reverse
 489                     	xdef	_LED_Operation
 490                     	xdef	_SetLedOFF
 491                     	xdef	_LED_Init
 492                     	xref	_GPIO_WriteReverse
 493                     	xref	_GPIO_WriteLow
 494                     	xref	_GPIO_WriteHigh
 495                     	xref	_GPIO_Init
 514                     	xref	c_lzmp
 515                     	xref	c_lgsbc
 516                     	end
