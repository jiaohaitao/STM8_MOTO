   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _Sys_10ms_Flag:
  22  0000 00            	dc.b	0
  23  0001               _Sys_20ms_Flag:
  24  0001 00            	dc.b	0
  25  0002               _Sys_50ms_Flag:
  26  0002 00            	dc.b	0
  27  0003               _Sys_100ms_Flag:
  28  0003 00            	dc.b	0
  29  0004               _Sys_200ms_Flag:
  30  0004 00            	dc.b	0
  31  0005               _Sys_500ms_Flag:
  32  0005 00            	dc.b	0
  33  0006               _Sys_1000ms_Flag:
  34  0006 00            	dc.b	0
  68                     ; 48 void Tim1_Init(void)
  68                     ; 49 {
  70                     .text:	section	.text,new
  71  0000               _Tim1_Init:
  75                     ; 51 	TIM1_TimeBaseInit(15, TIM1_COUNTERMODE_UP, 999, 0);
  77  0000 4b00          	push	#0
  78  0002 ae03e7        	ldw	x,#999
  79  0005 89            	pushw	x
  80  0006 4b00          	push	#0
  81  0008 ae000f        	ldw	x,#15
  82  000b cd0000        	call	_TIM1_TimeBaseInit
  84  000e 5b04          	addw	sp,#4
  85                     ; 52 	TIM1_SetCounter(0);/* 将计数器初值设为0 */
  87  0010 5f            	clrw	x
  88  0011 cd0000        	call	_TIM1_SetCounter
  90                     ; 53 	TIM1_ARRPreloadConfig(DISABLE);	/* 预装载不使能 */
  92  0014 4f            	clr	a
  93  0015 cd0000        	call	_TIM1_ARRPreloadConfig
  95                     ; 54 	TIM1_ITConfig(TIM1_IT_UPDATE , ENABLE);	/* 计数器向上计数/向下计数溢出更新中断 */
  97  0018 ae0001        	ldw	x,#1
  98  001b a601          	ld	a,#1
  99  001d 95            	ld	xh,a
 100  001e cd0000        	call	_TIM1_ITConfig
 102                     ; 55 	TIM1_Cmd(ENABLE);			/* 使能TIM1 */
 104  0021 a601          	ld	a,#1
 106                     ; 56 }
 109  0023 cc0000        	jp	_TIM1_Cmd
 112                     	bsct
 113  0007               L12_sys_10ms_cnt:
 114  0007 0000          	dc.w	0
 115  0009               L32_sys_20ms_cnt:
 116  0009 0000          	dc.w	0
 117  000b               L52_sys_50ms_cnt:
 118  000b 0000          	dc.w	0
 119  000d               L72_sys_100ms_cnt:
 120  000d 0000          	dc.w	0
 121  000f               L13_sys_200ms_cnt:
 122  000f 0000          	dc.w	0
 123  0011               L33_sys_500ms_cnt:
 124  0011 0000          	dc.w	0
 125  0013               L53_sys_1000ms_cnt:
 126  0013 0000          	dc.w	0
 221                     ; 65 void TimingDelay_Decrement(void)
 221                     ; 66 {
 222                     .text:	section	.text,new
 223  0000               _TimingDelay_Decrement:
 227                     ; 76 	TimingDelay--;
 229  0000 be00          	ldw	x,_TimingDelay
 230  0002 5a            	decw	x
 231  0003 bf00          	ldw	_TimingDelay,x
 232                     ; 79 	sys_10ms_cnt++;
 234  0005 be07          	ldw	x,L12_sys_10ms_cnt
 235  0007 5c            	incw	x
 236  0008 bf07          	ldw	L12_sys_10ms_cnt,x
 237                     ; 80 	sys_20ms_cnt++;
 239  000a be09          	ldw	x,L32_sys_20ms_cnt
 240  000c 5c            	incw	x
 241  000d bf09          	ldw	L32_sys_20ms_cnt,x
 242                     ; 81 	sys_50ms_cnt++;
 244  000f be0b          	ldw	x,L52_sys_50ms_cnt
 245  0011 5c            	incw	x
 246  0012 bf0b          	ldw	L52_sys_50ms_cnt,x
 247                     ; 82 	sys_100ms_cnt++;
 249  0014 be0d          	ldw	x,L72_sys_100ms_cnt
 250  0016 5c            	incw	x
 251  0017 bf0d          	ldw	L72_sys_100ms_cnt,x
 252                     ; 83 	sys_200ms_cnt++;
 254  0019 be0f          	ldw	x,L13_sys_200ms_cnt
 255  001b 5c            	incw	x
 256  001c bf0f          	ldw	L13_sys_200ms_cnt,x
 257                     ; 84 	sys_500ms_cnt++;
 259  001e be11          	ldw	x,L33_sys_500ms_cnt
 260  0020 5c            	incw	x
 261  0021 bf11          	ldw	L33_sys_500ms_cnt,x
 262                     ; 85 	sys_1000ms_cnt++;
 264  0023 be13          	ldw	x,L53_sys_1000ms_cnt
 265  0025 5c            	incw	x
 266  0026 bf13          	ldw	L53_sys_1000ms_cnt,x
 267                     ; 87 	if(sys_10ms_cnt>10)
 269  0028 be07          	ldw	x,L12_sys_10ms_cnt
 270  002a a3000b        	cpw	x,#11
 271  002d 2507          	jrult	L501
 272                     ; 89 		sys_10ms_cnt=0;
 274  002f 5f            	clrw	x
 275  0030 bf07          	ldw	L12_sys_10ms_cnt,x
 276                     ; 90 		Sys_10ms_Flag=1;
 278  0032 35010000      	mov	_Sys_10ms_Flag,#1
 279  0036               L501:
 280                     ; 93 	if(sys_20ms_cnt>20){
 282  0036 be09          	ldw	x,L32_sys_20ms_cnt
 283  0038 a30015        	cpw	x,#21
 284  003b 2507          	jrult	L701
 285                     ; 94 		sys_20ms_cnt=0;
 287  003d 5f            	clrw	x
 288  003e bf09          	ldw	L32_sys_20ms_cnt,x
 289                     ; 95 		Sys_20ms_Flag=1;
 291  0040 35010001      	mov	_Sys_20ms_Flag,#1
 292  0044               L701:
 293                     ; 98 	if(sys_50ms_cnt>50){
 295  0044 be0b          	ldw	x,L52_sys_50ms_cnt
 296  0046 a30033        	cpw	x,#51
 297  0049 2507          	jrult	L111
 298                     ; 99 		sys_50ms_cnt=0;
 300  004b 5f            	clrw	x
 301  004c bf0b          	ldw	L52_sys_50ms_cnt,x
 302                     ; 100 		Sys_50ms_Flag=1;
 304  004e 35010002      	mov	_Sys_50ms_Flag,#1
 305  0052               L111:
 306                     ; 103 	if(sys_100ms_cnt>100){
 308  0052 be0d          	ldw	x,L72_sys_100ms_cnt
 309  0054 a30065        	cpw	x,#101
 310  0057 2507          	jrult	L311
 311                     ; 104 		sys_100ms_cnt=0;
 313  0059 5f            	clrw	x
 314  005a bf0d          	ldw	L72_sys_100ms_cnt,x
 315                     ; 105 		Sys_100ms_Flag=1;
 317  005c 35010003      	mov	_Sys_100ms_Flag,#1
 318  0060               L311:
 319                     ; 108 	if(sys_200ms_cnt>200){
 321  0060 be0f          	ldw	x,L13_sys_200ms_cnt
 322  0062 a300c9        	cpw	x,#201
 323  0065 2507          	jrult	L511
 324                     ; 109 		sys_200ms_cnt=0;
 326  0067 5f            	clrw	x
 327  0068 bf0f          	ldw	L13_sys_200ms_cnt,x
 328                     ; 110 		Sys_200ms_Flag=1;
 330  006a 35010004      	mov	_Sys_200ms_Flag,#1
 331  006e               L511:
 332                     ; 113 	if(sys_500ms_cnt>500){
 334  006e be11          	ldw	x,L33_sys_500ms_cnt
 335  0070 a301f5        	cpw	x,#501
 336  0073 2507          	jrult	L711
 337                     ; 114 		sys_500ms_cnt=0;
 339  0075 5f            	clrw	x
 340  0076 bf11          	ldw	L33_sys_500ms_cnt,x
 341                     ; 115 		Sys_500ms_Flag=1;
 343  0078 35010005      	mov	_Sys_500ms_Flag,#1
 344  007c               L711:
 345                     ; 118 	if(sys_1000ms_cnt>1000){
 347  007c be13          	ldw	x,L53_sys_1000ms_cnt
 348  007e a303e9        	cpw	x,#1001
 349  0081 2507          	jrult	L121
 350                     ; 119 		sys_1000ms_cnt=0;
 352  0083 5f            	clrw	x
 353  0084 bf13          	ldw	L53_sys_1000ms_cnt,x
 354                     ; 120 		Sys_1000ms_Flag=1;
 356  0086 35010006      	mov	_Sys_1000ms_Flag,#1
 357  008a               L121:
 358                     ; 123 }
 361  008a 81            	ret	
 396                     ; 131 void delay_ms(u16 nTime)
 396                     ; 132 {
 397                     .text:	section	.text,new
 398  0000               _delay_ms:
 402                     ; 133 	TimingDelay = nTime;
 404  0000 bf00          	ldw	_TimingDelay,x
 406  0002               L541:
 407                     ; 135 	while(0 != TimingDelay)
 409  0002 be00          	ldw	x,_TimingDelay
 410  0004 26fc          	jrne	L541
 411                     ; 137 }
 414  0006 81            	ret	
 501                     	xdef	_Sys_1000ms_Flag
 502                     	xdef	_Sys_500ms_Flag
 503                     	xdef	_Sys_200ms_Flag
 504                     	xdef	_Sys_100ms_Flag
 505                     	xdef	_Sys_50ms_Flag
 506                     	xdef	_Sys_20ms_Flag
 507                     	xdef	_Sys_10ms_Flag
 508                     	xdef	_delay_ms
 509                     	xdef	_TimingDelay_Decrement
 510                     	xdef	_Tim1_Init
 511                     	switch	.ubsct
 512  0000               _TimingDelay:
 513  0000 0000          	ds.b	2
 514                     	xdef	_TimingDelay
 515                     	xref	_TIM1_SetCounter
 516                     	xref	_TIM1_ARRPreloadConfig
 517                     	xref	_TIM1_ITConfig
 518                     	xref	_TIM1_Cmd
 519                     	xref	_TIM1_TimeBaseInit
 539                     	end
