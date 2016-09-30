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
  59  0002 4b08          	push	#8
  60  0004 ae5005        	ldw	x,#20485
  61  0007 cd0000        	call	_GPIO_Init
  63  000a 85            	popw	x
  64                     ; 44 	GPIO_Init(LED_PORTD,(LED_1|LED_2), GPIO_MODE_OUT_PP_HIGH_FAST );		//定义LED的管脚为输出模式
  66  000b 4bf0          	push	#240
  67  000d 4b22          	push	#34
  68  000f ae5005        	ldw	x,#20485
  69  0012 cd0000        	call	_GPIO_Init
  71  0015 85            	popw	x
  72                     ; 45 }
  75  0016 81            	ret	
  99                     ; 54 void SetLedOFF(void)
  99                     ; 55 {
 100                     .text:	section	.text,new
 101  0000               _SetLedOFF:
 105                     ; 56 	GPIO_WriteHigh(LED_PORTC, LED_3);
 107  0000 4b08          	push	#8
 108  0002 ae5005        	ldw	x,#20485
 109  0005 cd0000        	call	_GPIO_WriteHigh
 111  0008 84            	pop	a
 112                     ; 57 	GPIO_WriteHigh(LED_PORTD, LED_1);
 114  0009 4b02          	push	#2
 115  000b ae5005        	ldw	x,#20485
 116  000e cd0000        	call	_GPIO_WriteHigh
 118  0011 84            	pop	a
 119                     ; 58 	GPIO_WriteHigh(LED_PORTD, LED_2);
 121  0012 4b20          	push	#32
 122  0014 ae5005        	ldw	x,#20485
 123  0017 cd0000        	call	_GPIO_WriteHigh
 125  001a 84            	pop	a
 126                     ; 59 }
 129  001b 81            	ret	
 258                     ; 69 void LED_Operation(GPIO_Pin_TypeDef ledx, u8 state)
 258                     ; 70 {
 259                     .text:	section	.text,new
 260  0000               _LED_Operation:
 262  0000 89            	pushw	x
 263       00000000      OFST:	set	0
 266                     ; 71 	if(ON == state) {
 268  0001 9f            	ld	a,xl
 269  0002 4d            	tnz	a
 270  0003 2618          	jrne	L711
 271                     ; 72 	  	switch (ledx) {
 273  0005 9e            	ld	a,xh
 275                     ; 80 			break;
 276  0006 a002          	sub	a,#2
 277  0008 2708          	jreq	L33
 278  000a a006          	sub	a,#6
 279  000c 2704          	jreq	L33
 280  000e a018          	sub	a,#24
 281  0010 2623          	jrne	L521
 282  0012               L33:
 283                     ; 73 			case LED_1: 
 283                     ; 74 			case LED_2:
 283                     ; 75 		  		GPIO_WriteLow(LED_PORTD, ledx);
 285                     ; 76 			break;
 287                     ; 78 			case LED_3:
 287                     ; 79 		  		GPIO_WriteLow(LED_PORTC, ledx);
 290  0012 7b01          	ld	a,(OFST+1,sp)
 291  0014 88            	push	a
 292  0015 ae5005        	ldw	x,#20485
 293  0018 cd0000        	call	_GPIO_WriteLow
 295                     ; 80 			break;
 297  001b 2017          	jp	LC001
 299  001d               L711:
 300                     ; 83 	  	switch (ledx) {
 302  001d 7b01          	ld	a,(OFST+1,sp)
 304                     ; 91 			break;
 305  001f a002          	sub	a,#2
 306  0021 2708          	jreq	L73
 307  0023 a006          	sub	a,#6
 308  0025 2704          	jreq	L73
 309  0027 a018          	sub	a,#24
 310  0029 260a          	jrne	L521
 311  002b               L73:
 312                     ; 84 			case LED_1: 
 312                     ; 85 			case LED_2:
 312                     ; 86 		  		GPIO_WriteHigh(LED_PORTD, ledx);
 315  002b 7b01          	ld	a,(OFST+1,sp)
 316  002d 88            	push	a
 317  002e ae5005        	ldw	x,#20485
 318  0031 cd0000        	call	_GPIO_WriteHigh
 320  0034               LC001:
 321  0034 84            	pop	a
 322                     ; 87 			break;
 323  0035               L521:
 324                     ; 94 }
 327  0035 85            	popw	x
 328  0036 81            	ret	
 329                     ; 89 			case LED_3:
 329                     ; 90 		  		GPIO_WriteHigh(LED_PORTC, ledx);
 331                     ; 91 			break;
 368                     ; 103 void LED_Reverse(GPIO_Pin_TypeDef ledx)
 368                     ; 104 {
 369                     .text:	section	.text,new
 370  0000               _LED_Reverse:
 372  0000 88            	push	a
 373       00000000      OFST:	set	0
 376                     ; 105 	switch (ledx) {
 379                     ; 113 		break;
 380  0001 a002          	sub	a,#2
 381  0003 2708          	jreq	L331
 382  0005 a006          	sub	a,#6
 383  0007 2704          	jreq	L331
 384  0009 a018          	sub	a,#24
 385  000b 260a          	jrne	L751
 386  000d               L331:
 387                     ; 106 		case LED_1: 
 387                     ; 107 		case LED_2:
 387                     ; 108 			GPIO_WriteReverse(LED_PORTD, ledx);
 389                     ; 109 		break;
 391                     ; 111 		case LED_3:
 391                     ; 112 			GPIO_WriteReverse(LED_PORTC, ledx);
 395  000d 7b01          	ld	a,(OFST+1,sp)
 396  000f 88            	push	a
 397  0010 ae5005        	ldw	x,#20485
 398  0013 cd0000        	call	_GPIO_WriteReverse
 399  0016 84            	pop	a
 400                     ; 113 		break;
 402  0017               L751:
 403                     ; 115 }
 406  0017 84            	pop	a
 407  0018 81            	ret	
 432                     ; 124 void LED_ShowOneToOne(void)
 432                     ; 125 {
 433                     .text:	section	.text,new
 434  0000               _LED_ShowOneToOne:
 438                     ; 126     LED_Operation(LED_1, ON);
 440  0000 5f            	clrw	x
 441  0001 a602          	ld	a,#2
 442  0003 95            	ld	xh,a
 443  0004 cd0000        	call	_LED_Operation
 445                     ; 127     LED_Operation(LED_2, OFF);
 447  0007 ae0001        	ldw	x,#1
 448  000a ad0f          	call	LC005
 450                     ; 131     LED_Operation(LED_2, ON);
 452  000c 5f            	clrw	x
 453  000d ad0c          	call	LC005
 455                     ; 135     LED_Operation(LED_2, OFF);
 457  000f ae0001        	ldw	x,#1
 458  0012 a620          	ld	a,#32
 459  0014 95            	ld	xh,a
 460  0015 cd0000        	call	_LED_Operation
 462                     ; 136     LED_Operation(LED_3, ON);
 464  0018 5f            	clrw	x
 465                     ; 139 }
 468  0019 2014          	jp	LC006
 469  001b               LC005:
 470  001b a620          	ld	a,#32
 471  001d 95            	ld	xh,a
 472  001e cd0000        	call	_LED_Operation
 474                     ; 132     LED_Operation(LED_3, OFF);
 476  0021 ae0001        	ldw	x,#1
 477  0024 ad09          	call	LC006
 478                     ; 134     LED_Operation(LED_1, OFF);
 480  0026 ae0001        	ldw	x,#1
 481  0029 a602          	ld	a,#2
 482  002b 95            	ld	xh,a
 483  002c cc0000        	jp	_LED_Operation
 484  002f               LC006:
 485  002f a608          	ld	a,#8
 486  0031 95            	ld	xh,a
 487  0032 cd0000        	call	_LED_Operation
 489                     ; 137     Delay(0x1ffff);
 491  0035 aeffff        	ldw	x,#65535
 492  0038 89            	pushw	x
 493  0039 ae0001        	ldw	x,#1
 494  003c 89            	pushw	x
 495  003d cd0000        	call	L3_Delay
 497  0040 5b04          	addw	sp,#4
 498  0042 81            	ret	
 532                     ; 148 static void Delay(u32 nCount)
 532                     ; 149 {
 533                     .text:	section	.text,new
 534  0000               L3_Delay:
 536       00000000      OFST:	set	0
 539  0000 2009          	jra	L112
 540  0002               L702:
 541                     ; 153 		nCount--;
 543  0002 96            	ldw	x,sp
 544  0003 1c0003        	addw	x,#OFST+3
 545  0006 a601          	ld	a,#1
 546  0008 cd0000        	call	c_lgsbc
 548  000b               L112:
 549                     ; 151 	while (nCount != 0)
 551  000b 96            	ldw	x,sp
 552  000c 1c0003        	addw	x,#OFST+3
 553  000f cd0000        	call	c_lzmp
 555  0012 26ee          	jrne	L702
 556                     ; 155 }
 559  0014 81            	ret	
 572                     	xdef	_LED_ShowOneToOne
 573                     	xdef	_LED_Reverse
 574                     	xdef	_LED_Operation
 575                     	xdef	_SetLedOFF
 576                     	xdef	_LED_Init
 577                     	xref	_GPIO_WriteReverse
 578                     	xref	_GPIO_WriteLow
 579                     	xref	_GPIO_WriteHigh
 580                     	xref	_GPIO_Init
 599                     	xref	c_lzmp
 600                     	xref	c_lgsbc
 601                     	end
