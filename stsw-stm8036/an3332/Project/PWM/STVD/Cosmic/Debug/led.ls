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
  60  0004 ae500a        	ldw	x,#20490
  61  0007 cd0000        	call	_GPIO_Init
  63  000a 85            	popw	x
  64                     ; 44 	GPIO_Init(LED_PORTD,(LED_1|LED_2), GPIO_MODE_OUT_PP_HIGH_FAST );		//定义LED的管脚为输出模式
  66  000b 4bf0          	push	#240
  67  000d 4b22          	push	#34
  68  000f ae500f        	ldw	x,#20495
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
 108  0002 ae500a        	ldw	x,#20490
 109  0005 cd0000        	call	_GPIO_WriteHigh
 111  0008 84            	pop	a
 112                     ; 57 	GPIO_WriteHigh(LED_PORTD, LED_1);
 114  0009 4b02          	push	#2
 115  000b ae500f        	ldw	x,#20495
 116  000e cd0000        	call	_GPIO_WriteHigh
 118  0011 84            	pop	a
 119                     ; 58 	GPIO_WriteHigh(LED_PORTD, LED_2);
 121  0012 4b20          	push	#32
 122  0014 ae500f        	ldw	x,#20495
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
 270  0003 2620          	jrne	L711
 271                     ; 72 	  	switch (ledx) {
 273  0005 9e            	ld	a,xh
 275                     ; 80 			break;
 276  0006 a002          	sub	a,#2
 277  0008 2708          	jreq	L33
 278  000a a006          	sub	a,#6
 279  000c 270c          	jreq	L53
 280  000e a018          	sub	a,#24
 281  0010 262b          	jrne	L521
 282  0012               L33:
 283                     ; 73 			case LED_1: 
 283                     ; 74 			case LED_2:
 283                     ; 75 		  		GPIO_WriteLow(LED_PORTD, ledx);
 285  0012 7b01          	ld	a,(OFST+1,sp)
 286  0014 88            	push	a
 287  0015 ae500f        	ldw	x,#20495
 289                     ; 76 			break;
 291  0018 2006          	jp	LC003
 292  001a               L53:
 293                     ; 78 			case LED_3:
 293                     ; 79 		  		GPIO_WriteLow(LED_PORTC, ledx);
 295  001a 7b01          	ld	a,(OFST+1,sp)
 296  001c 88            	push	a
 297  001d ae500a        	ldw	x,#20490
 298  0020               LC003:
 299  0020 cd0000        	call	_GPIO_WriteLow
 301                     ; 80 			break;
 303  0023 2017          	jp	LC001
 305  0025               L711:
 306                     ; 83 	  	switch (ledx) {
 308  0025 7b01          	ld	a,(OFST+1,sp)
 310                     ; 91 			break;
 311  0027 a002          	sub	a,#2
 312  0029 2708          	jreq	L73
 313  002b a006          	sub	a,#6
 314  002d 2710          	jreq	L14
 315  002f a018          	sub	a,#24
 316  0031 260a          	jrne	L521
 317  0033               L73:
 318                     ; 84 			case LED_1: 
 318                     ; 85 			case LED_2:
 318                     ; 86 		  		GPIO_WriteHigh(LED_PORTD, ledx);
 320  0033 7b01          	ld	a,(OFST+1,sp)
 321  0035 88            	push	a
 322  0036 ae500f        	ldw	x,#20495
 323  0039               LC002:
 324  0039 cd0000        	call	_GPIO_WriteHigh
 326  003c               LC001:
 327  003c 84            	pop	a
 328                     ; 87 			break;
 329  003d               L521:
 330                     ; 94 }
 333  003d 85            	popw	x
 334  003e 81            	ret	
 335  003f               L14:
 336                     ; 89 			case LED_3:
 336                     ; 90 		  		GPIO_WriteHigh(LED_PORTC, ledx);
 338  003f 7b01          	ld	a,(OFST+1,sp)
 339  0041 88            	push	a
 340  0042 ae500a        	ldw	x,#20490
 342                     ; 91 			break;
 344  0045 20f2          	jp	LC002
 380                     ; 103 void LED_Reverse(GPIO_Pin_TypeDef ledx)
 380                     ; 104 {
 381                     .text:	section	.text,new
 382  0000               _LED_Reverse:
 384  0000 88            	push	a
 385       00000000      OFST:	set	0
 388                     ; 105 	switch (ledx) {
 391                     ; 113 		break;
 392  0001 a002          	sub	a,#2
 393  0003 2708          	jreq	L331
 394  0005 a006          	sub	a,#6
 395  0007 270c          	jreq	L531
 396  0009 a018          	sub	a,#24
 397  000b 2612          	jrne	L751
 398  000d               L331:
 399                     ; 106 		case LED_1: 
 399                     ; 107 		case LED_2:
 399                     ; 108 			GPIO_WriteReverse(LED_PORTD, ledx);
 401  000d 7b01          	ld	a,(OFST+1,sp)
 402  000f 88            	push	a
 403  0010 ae500f        	ldw	x,#20495
 405                     ; 109 		break;
 407  0013 2006          	jp	LC004
 408  0015               L531:
 409                     ; 111 		case LED_3:
 409                     ; 112 			GPIO_WriteReverse(LED_PORTC, ledx);
 411  0015 7b01          	ld	a,(OFST+1,sp)
 412  0017 88            	push	a
 413  0018 ae500a        	ldw	x,#20490
 415  001b               LC004:
 416  001b cd0000        	call	_GPIO_WriteReverse
 417  001e 84            	pop	a
 418                     ; 113 		break;
 420  001f               L751:
 421                     ; 115 }
 424  001f 84            	pop	a
 425  0020 81            	ret	
 450                     ; 124 void LED_ShowOneToOne(void)
 450                     ; 125 {
 451                     .text:	section	.text,new
 452  0000               _LED_ShowOneToOne:
 456                     ; 126     LED_Operation(LED_1, ON);
 458  0000 5f            	clrw	x
 459  0001 a602          	ld	a,#2
 460  0003 95            	ld	xh,a
 461  0004 cd0000        	call	_LED_Operation
 463                     ; 127     LED_Operation(LED_2, OFF);
 465  0007 ae0001        	ldw	x,#1
 466  000a ad0f          	call	LC005
 468                     ; 131     LED_Operation(LED_2, ON);
 470  000c 5f            	clrw	x
 471  000d ad0c          	call	LC005
 473                     ; 135     LED_Operation(LED_2, OFF);
 475  000f ae0001        	ldw	x,#1
 476  0012 a620          	ld	a,#32
 477  0014 95            	ld	xh,a
 478  0015 cd0000        	call	_LED_Operation
 480                     ; 136     LED_Operation(LED_3, ON);
 482  0018 5f            	clrw	x
 483                     ; 139 }
 486  0019 2014          	jp	LC006
 487  001b               LC005:
 488  001b a620          	ld	a,#32
 489  001d 95            	ld	xh,a
 490  001e cd0000        	call	_LED_Operation
 492                     ; 132     LED_Operation(LED_3, OFF);
 494  0021 ae0001        	ldw	x,#1
 495  0024 ad09          	call	LC006
 496                     ; 134     LED_Operation(LED_1, OFF);
 498  0026 ae0001        	ldw	x,#1
 499  0029 a602          	ld	a,#2
 500  002b 95            	ld	xh,a
 501  002c cc0000        	jp	_LED_Operation
 502  002f               LC006:
 503  002f a608          	ld	a,#8
 504  0031 95            	ld	xh,a
 505  0032 cd0000        	call	_LED_Operation
 507                     ; 137     Delay(0x1ffff);
 509  0035 aeffff        	ldw	x,#65535
 510  0038 89            	pushw	x
 511  0039 ae0001        	ldw	x,#1
 512  003c 89            	pushw	x
 513  003d cd0000        	call	L3_Delay
 515  0040 5b04          	addw	sp,#4
 516  0042 81            	ret	
 550                     ; 148 static void Delay(u32 nCount)
 550                     ; 149 {
 551                     .text:	section	.text,new
 552  0000               L3_Delay:
 554       00000000      OFST:	set	0
 557  0000 2009          	jra	L112
 558  0002               L702:
 559                     ; 153 		nCount--;
 561  0002 96            	ldw	x,sp
 562  0003 1c0003        	addw	x,#OFST+3
 563  0006 a601          	ld	a,#1
 564  0008 cd0000        	call	c_lgsbc
 566  000b               L112:
 567                     ; 151 	while (nCount != 0)
 569  000b 96            	ldw	x,sp
 570  000c 1c0003        	addw	x,#OFST+3
 571  000f cd0000        	call	c_lzmp
 573  0012 26ee          	jrne	L702
 574                     ; 155 }
 577  0014 81            	ret	
 590                     	xdef	_LED_ShowOneToOne
 591                     	xdef	_LED_Reverse
 592                     	xdef	_LED_Operation
 593                     	xdef	_SetLedOFF
 594                     	xdef	_LED_Init
 595                     	xref	_GPIO_WriteReverse
 596                     	xref	_GPIO_WriteLow
 597                     	xref	_GPIO_WriteHigh
 598                     	xref	_GPIO_Init
 617                     	xref	c_lzmp
 618                     	xref	c_lgsbc
 619                     	end
