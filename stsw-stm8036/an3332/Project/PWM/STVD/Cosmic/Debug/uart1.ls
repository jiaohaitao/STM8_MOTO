   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _UartRxI2cAddr:
  22  0000 00            	dc.b	0
  23  0001               _UartRxI2cAddrFlag:
  24  0001 00            	dc.b	0
  57                     ; 44 void Uart1_Init(void)
  57                     ; 45 {
  59                     .text:	section	.text,new
  60  0000               _Uart1_Init:
  64                     ; 46     UART1_DeInit();		/* 将寄存器的值复位 */
  66  0000 cd0000        	call	_UART1_DeInit
  68                     ; 57     UART1_Init((u32)115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, \
  68                     ; 58     	UART1_PARITY_NO , UART1_SYNCMODE_CLOCK_DISABLE , UART1_MODE_TXRX_ENABLE);
  70  0003 4b0c          	push	#12
  71  0005 4b80          	push	#128
  72  0007 4b00          	push	#0
  73  0009 4b00          	push	#0
  74  000b 4b00          	push	#0
  75  000d aec200        	ldw	x,#49664
  76  0010 89            	pushw	x
  77  0011 ae0001        	ldw	x,#1
  78  0014 89            	pushw	x
  79  0015 cd0000        	call	_UART1_Init
  81  0018 5b09          	addw	sp,#9
  82                     ; 59     UART1_ITConfig(UART1_IT_RXNE_OR, DISABLE);
  84  001a 4b00          	push	#0
  85  001c ae0205        	ldw	x,#517
  86  001f cd0000        	call	_UART1_ITConfig
  88  0022 84            	pop	a
  89                     ; 60     UART1_Cmd(ENABLE);
  91  0023 a601          	ld	a,#1
  93                     ; 61 }
  96  0025 cc0000        	jp	_UART1_Cmd
 132                     ; 70 void UART1_SendByte(u8 data)
 132                     ; 71 {
 133                     .text:	section	.text,new
 134  0000               _UART1_SendByte:
 138                     ; 72 	UART1_SendData8((unsigned char)data);
 140  0000 cd0000        	call	_UART1_SendData8
 143  0003               L14:
 144                     ; 75 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 146  0003 ae0080        	ldw	x,#128
 147  0006 cd0000        	call	_UART1_GetFlagStatus
 149  0009 4d            	tnz	a
 150  000a 27f7          	jreq	L14
 151                     ; 76 }
 154  000c 81            	ret	
 200                     ; 94 void UART1_SendString(u8* Data)
 200                     ; 95 {
 201                     .text:	section	.text,new
 202  0000               _UART1_SendString:
 204  0000 89            	pushw	x
 205  0001 89            	pushw	x
 206       00000002      OFST:	set	2
 209                     ; 96 	u16 i=0;
 211  0002 5f            	clrw	x
 213  0003 200c          	jra	L37
 214  0005               L76:
 215                     ; 98 		UART1_SendByte(Data[i]);	/* 循环调用发送一个字符函数 */
 217  0005 1e03          	ldw	x,(OFST+1,sp)
 218  0007 72fb01        	addw	x,(OFST-1,sp)
 219  000a f6            	ld	a,(x)
 220  000b cd0000        	call	_UART1_SendByte
 222                     ; 97 	for(; i < strlen(Data); i++)
 224  000e 1e01          	ldw	x,(OFST-1,sp)
 225  0010 5c            	incw	x
 226  0011               L37:
 227  0011 1f01          	ldw	(OFST-1,sp),x
 230  0013 1e03          	ldw	x,(OFST+1,sp)
 231  0015 cd0000        	call	_strlen
 233  0018 1301          	cpw	x,(OFST-1,sp)
 234  001a 22e9          	jrugt	L76
 235                     ; 99 }
 238  001c 5b04          	addw	sp,#4
 239  001e 81            	ret	
 330                     ; 112 static char *itoa(int value, char *string, int radix)
 330                     ; 113 {
 331                     .text:	section	.text,new
 332  0000               L77_itoa:
 334  0000 89            	pushw	x
 335  0001 520a          	subw	sp,#10
 336       0000000a      OFST:	set	10
 339                     ; 115     int     flag = 0;
 341  0003 5f            	clrw	x
 342  0004 1f03          	ldw	(OFST-7,sp),x
 343                     ; 116     char    *ptr = string;
 345  0006 1e0f          	ldw	x,(OFST+5,sp)
 346  0008 1f05          	ldw	(OFST-5,sp),x
 347                     ; 119     if (radix != 10)
 349  000a 1e11          	ldw	x,(OFST+7,sp)
 350  000c a3000a        	cpw	x,#10
 351                     ; 121         *ptr = 0;
 352                     ; 122         return string;
 354  000f 2660          	jrne	LC001
 355                     ; 125     if (!value)
 357  0011 1e0b          	ldw	x,(OFST+1,sp)
 358  0013 260e          	jrne	L151
 359                     ; 127         *ptr++ = 0x30;
 361  0015 1e05          	ldw	x,(OFST-5,sp)
 362  0017 a630          	ld	a,#48
 363  0019 f7            	ld	(x),a
 364  001a 5c            	incw	x
 365  001b 1f05          	ldw	(OFST-5,sp),x
 366                     ; 128         *ptr = 0;
 368                     ; 129         return string;
 371  001d               L43:
 372  001d 7f            	clr	(x)
 375  001e 1e0f          	ldw	x,(OFST+5,sp)
 377  0020 5b0c          	addw	sp,#12
 378  0022 81            	ret	
 379  0023               L151:
 380                     ; 133     if (value < 0)
 382  0023 2a0d          	jrpl	L351
 383                     ; 135         *ptr++ = '-';
 385  0025 1e05          	ldw	x,(OFST-5,sp)
 386  0027 a62d          	ld	a,#45
 387  0029 f7            	ld	(x),a
 388  002a 5c            	incw	x
 389  002b 1f05          	ldw	(OFST-5,sp),x
 390                     ; 138         value *= -1;
 392  002d 1e0b          	ldw	x,(OFST+1,sp)
 393  002f 50            	negw	x
 394  0030 1f0b          	ldw	(OFST+1,sp),x
 395  0032               L351:
 396                     ; 141     for (i = 10000; i > 0; i /= 10)
 398  0032 ae2710        	ldw	x,#10000
 399  0035 1f09          	ldw	(OFST-1,sp),x
 400  0037               L551:
 401                     ; 143         d = value / i;
 403  0037 1e0b          	ldw	x,(OFST+1,sp)
 404  0039 1609          	ldw	y,(OFST-1,sp)
 405  003b cd0000        	call	c_idiv
 407  003e 1f07          	ldw	(OFST-3,sp),x
 408                     ; 145         if (d || flag)
 410  0040 2604          	jrne	L561
 412  0042 1e03          	ldw	x,(OFST-7,sp)
 413  0044 271f          	jreq	L361
 414  0046               L561:
 415                     ; 147             *ptr++ = (char)(d + 0x30);
 417  0046 7b08          	ld	a,(OFST-2,sp)
 418  0048 1e05          	ldw	x,(OFST-5,sp)
 419  004a ab30          	add	a,#48
 420  004c f7            	ld	(x),a
 421  004d 5c            	incw	x
 422  004e 1f05          	ldw	(OFST-5,sp),x
 423                     ; 148             value -= (d * i);
 425  0050 1609          	ldw	y,(OFST-1,sp)
 426  0052 1e07          	ldw	x,(OFST-3,sp)
 427  0054 cd0000        	call	c_imul
 429  0057 1f01          	ldw	(OFST-9,sp),x
 430  0059 1e0b          	ldw	x,(OFST+1,sp)
 431  005b 72f001        	subw	x,(OFST-9,sp)
 432  005e 1f0b          	ldw	(OFST+1,sp),x
 433                     ; 149             flag = 1;
 435  0060 ae0001        	ldw	x,#1
 436  0063 1f03          	ldw	(OFST-7,sp),x
 437  0065               L361:
 438                     ; 141     for (i = 10000; i > 0; i /= 10)
 440  0065 1e09          	ldw	x,(OFST-1,sp)
 441  0067 a60a          	ld	a,#10
 442  0069 cd0000        	call	c_sdivx
 444  006c 1f09          	ldw	(OFST-1,sp),x
 447  006e 9c            	rvf	
 448  006f 2cc6          	jrsgt	L551
 449                     ; 154     *ptr = 0;
 451  0071               LC001:
 453  0071 1e05          	ldw	x,(OFST-5,sp)
 454                     ; 156     return string;
 456  0073 20a8          	jra	L43
 533                     ; 173 void UART1_printf( uint8_t *Data,...)
 533                     ; 174 {
 534                     .text:	section	.text,new
 535  0000               _UART1_printf:
 537  0000 89            	pushw	x
 538  0001 5214          	subw	sp,#20
 539       00000014      OFST:	set	20
 542                     ; 179 	va_start(ap, Data);
 544  0003 96            	ldw	x,sp
 545  0004 1c0019        	addw	x,#OFST+5
 546  0007 1f11          	ldw	(OFST-3,sp),x
 548  0009 cc00a1        	jra	L342
 549  000c               L142:
 550                     ; 187 		if ( *Data == 0x5c )  //'\'
 552  000c a15c          	cp	a,#92
 553  000e 261c          	jrne	L742
 554                     ; 189 			switch ( *++Data )
 556  0010 0c16          	inc	(OFST+2,sp)
 557  0012 2602          	jrne	L04
 558  0014 0c15          	inc	(OFST+1,sp)
 559  0016               L04:
 560  0016 1e15          	ldw	x,(OFST+1,sp)
 561  0018 f6            	ld	a,(x)
 563                     ; 203 				break;
 564  0019 a06e          	sub	a,#110
 565  001b 2708          	jreq	L171
 566  001d a004          	sub	a,#4
 567                     ; 201 				default:
 567                     ; 202 					Data ++;
 568                     ; 203 				break;
 570  001f 266f          	jrne	LC002
 571                     ; 191 				case 'r':							          //回车符
 571                     ; 192 					UART1_SendData8(0x0d);
 573  0021 a60d          	ld	a,#13
 575                     ; 193 					Data ++;
 576                     ; 194 				break;
 578  0023 2002          	jp	LC004
 579  0025               L171:
 580                     ; 196 				case 'n':							          //换行符
 580                     ; 197 					UART1_SendData8(0x0a);	
 582  0025 a60a          	ld	a,#10
 583  0027               LC004:
 584  0027 cd0000        	call	_UART1_SendData8
 586                     ; 198 					Data ++;
 587                     ; 199 				break;
 589  002a 2062          	jp	LC003
 590                     ; 203 				break;
 591  002c               L742:
 592                     ; 206 		else if ( *Data == '%')
 594  002c a125          	cp	a,#37
 595  002e 2665          	jrne	L752
 596                     ; 208 			switch ( *++Data )
 598  0030 0c16          	inc	(OFST+2,sp)
 599  0032 2602          	jrne	L64
 600  0034 0c15          	inc	(OFST+1,sp)
 601  0036               L64:
 602  0036 1e15          	ldw	x,(OFST+1,sp)
 603  0038 f6            	ld	a,(x)
 605                     ; 233 				break;
 606  0039 a064          	sub	a,#100
 607  003b 2722          	jreq	L771
 608  003d a00f          	sub	a,#15
 609                     ; 231 				default:
 609                     ; 232 					Data++;
 610                     ; 233 				break;
 612  003f 264f          	jrne	LC002
 613                     ; 210 				case 's':						//字符串
 613                     ; 211 				s = va_arg(ap, const char *);
 615  0041 1e11          	ldw	x,(OFST-3,sp)
 616  0043 1c0002        	addw	x,#2
 617  0046 1f11          	ldw	(OFST-3,sp),x
 618  0048 1d0002        	subw	x,#2
 619  004b fe            	ldw	x,(x)
 621  004c 200a          	jra	L172
 622  004e               L562:
 623                     ; 214 					UART1_SendData8(*s);
 625  004e cd0000        	call	_UART1_SendData8
 628  0051               L772:
 629                     ; 215 					while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 631  0051 ad59          	call	LC005
 632  0053 27fc          	jreq	L772
 633                     ; 212 				for ( ; *s; s++) 
 635  0055 1e13          	ldw	x,(OFST-1,sp)
 636  0057 5c            	incw	x
 637  0058               L172:
 638  0058 1f13          	ldw	(OFST-1,sp),x
 641  005a f6            	ld	a,(x)
 642  005b 26f1          	jrne	L562
 643                     ; 217 				Data++;
 644                     ; 218 				break;
 646  005d 202f          	jp	LC003
 647  005f               L771:
 648                     ; 220 				case 'd':	//十进制
 648                     ; 221 					d = va_arg(ap, int);
 650  005f 1e11          	ldw	x,(OFST-3,sp)
 651  0061 1c0002        	addw	x,#2
 652  0064 1f11          	ldw	(OFST-3,sp),x
 653  0066 1d0002        	subw	x,#2
 654  0069 fe            	ldw	x,(x)
 655  006a 1f13          	ldw	(OFST-1,sp),x
 656                     ; 222 					itoa(d, buf, 10);
 658  006c ae000a        	ldw	x,#10
 659  006f 89            	pushw	x
 660  0070 96            	ldw	x,sp
 661  0071 1c0003        	addw	x,#OFST-17
 662  0074 89            	pushw	x
 663  0075 1e17          	ldw	x,(OFST+3,sp)
 664  0077 cd0000        	call	L77_itoa
 666  007a 5b04          	addw	sp,#4
 667                     ; 223 				for (s = buf; *s; s++) 
 669  007c 96            	ldw	x,sp
 671  007d 2009          	jra	L703
 672  007f               L303:
 673                     ; 225 					UART1_SendData8(*s);
 675  007f cd0000        	call	_UART1_SendData8
 678  0082               L513:
 679                     ; 226 					while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 681  0082 ad28          	call	LC005
 682  0084 27fc          	jreq	L513
 683                     ; 223 				for (s = buf; *s; s++) 
 685  0086 1e13          	ldw	x,(OFST-1,sp)
 686  0088               L703:
 687  0088 5c            	incw	x
 688  0089 1f13          	ldw	(OFST-1,sp),x
 691  008b f6            	ld	a,(x)
 692  008c 26f1          	jrne	L303
 693                     ; 228 				Data++;
 695  008e               LC003:
 699  008e 1e15          	ldw	x,(OFST+1,sp)
 700  0090               LC002:
 703  0090 5c            	incw	x
 704  0091 1f15          	ldw	(OFST+1,sp),x
 705                     ; 229 				break;
 707  0093 2008          	jra	L523
 708                     ; 233 				break;
 709  0095               L752:
 710                     ; 236 		else UART1_SendData8(*Data++);
 712  0095 5c            	incw	x
 713  0096 1f15          	ldw	(OFST+1,sp),x
 714  0098 5a            	decw	x
 715  0099 f6            	ld	a,(x)
 716  009a cd0000        	call	_UART1_SendData8
 718  009d               L523:
 719                     ; 238 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 721  009d ad0d          	call	LC005
 722  009f 27fc          	jreq	L523
 723  00a1               L342:
 724                     ; 185 	while ( *Data != 0)     // 判断是否到达字符串结束符
 726  00a1 1e15          	ldw	x,(OFST+1,sp)
 727  00a3 f6            	ld	a,(x)
 728  00a4 2703cc000c    	jrne	L142
 729                     ; 240 }
 732  00a9 5b16          	addw	sp,#22
 733  00ab 81            	ret	
 734  00ac               LC005:
 735  00ac ae0080        	ldw	x,#128
 736  00af cd0000        	call	_UART1_GetFlagStatus
 738  00b2 4d            	tnz	a
 739  00b3 81            	ret	
 772                     	xdef	_UartRxI2cAddrFlag
 773                     	xdef	_UartRxI2cAddr
 774                     	xref	_strlen
 775                     	xdef	_UART1_printf
 776                     	xdef	_UART1_SendString
 777                     	xdef	_UART1_SendByte
 778                     	xdef	_Uart1_Init
 779                     	xref	_UART1_GetFlagStatus
 780                     	xref	_UART1_SendData8
 781                     	xref	_UART1_ITConfig
 782                     	xref	_UART1_Cmd
 783                     	xref	_UART1_Init
 784                     	xref	_UART1_DeInit
 785                     	xref.b	c_x
 804                     	xref	c_sdivx
 805                     	xref	c_imul
 806                     	xref	c_idiv
 807                     	end
