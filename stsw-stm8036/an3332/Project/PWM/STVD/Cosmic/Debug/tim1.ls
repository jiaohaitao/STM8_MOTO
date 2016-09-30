   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _Sys_20ms_Flag:
  22  0000 00            	dc.b	0
  23  0001               _Sys_50ms_Flag:
  24  0001 00            	dc.b	0
  25  0002               _Sys_100ms_Flag:
  26  0002 00            	dc.b	0
  27  0003               _Sys_200ms_Flag:
  28  0003 00            	dc.b	0
  29  0004               _Sys_500ms_Flag:
  30  0004 00            	dc.b	0
  31  0005               _Sys_1000ms_Flag:
  32  0005 00            	dc.b	0
  66                     ; 47 void Tim1_Init(void)
  66                     ; 48 {
  68                     .text:	section	.text,new
  69  0000               _Tim1_Init:
  73                     ; 50 	TIM1_TimeBaseInit(15, TIM1_COUNTERMODE_UP, 999, 0);
  75  0000 4b00          	push	#0
  76  0002 ae03e7        	ldw	x,#999
  77  0005 89            	pushw	x
  78  0006 4b00          	push	#0
  79  0008 ae000f        	ldw	x,#15
  80  000b cd0000        	call	_TIM1_TimeBaseInit
  82  000e 5b04          	addw	sp,#4
  83                     ; 51 	TIM1_SetCounter(0);/* 将计数器初值设为0 */
  85  0010 5f            	clrw	x
  86  0011 cd0000        	call	_TIM1_SetCounter
  88                     ; 52 	TIM1_ARRPreloadConfig(DISABLE);	/* 预装载不使能 */
  90  0014 4f            	clr	a
  91  0015 cd0000        	call	_TIM1_ARRPreloadConfig
  93                     ; 53 	TIM1_ITConfig(TIM1_IT_UPDATE , ENABLE);	/* 计数器向上计数/向下计数溢出更新中断 */
  95  0018 ae0001        	ldw	x,#1
  96  001b a601          	ld	a,#1
  97  001d 95            	ld	xh,a
  98  001e cd0000        	call	_TIM1_ITConfig
 100                     ; 54 	TIM1_Cmd(ENABLE);			/* 使能TIM1 */
 102  0021 a601          	ld	a,#1
 104                     ; 55 }
 107  0023 cc0000        	jp	_TIM1_Cmd
 110                     	bsct
 111  0006               L12_sys_20ms_cnt:
 112  0006 0000          	dc.w	0
 113  0008               L32_sys_50ms_cnt:
 114  0008 0000          	dc.w	0
 115  000a               L52_sys_100ms_cnt:
 116  000a 0000          	dc.w	0
 117  000c               L72_sys_200ms_cnt:
 118  000c 0000          	dc.w	0
 119  000e               L13_sys_500ms_cnt:
 120  000e 0000          	dc.w	0
 121  0010               L33_sys_1000ms_cnt:
 122  0010 0000          	dc.w	0
 207                     ; 64 void TimingDelay_Decrement(void)
 207                     ; 65 {
 208                     .text:	section	.text,new
 209  0000               _TimingDelay_Decrement:
 213                     ; 74 	TimingDelay--;
 215  0000 be00          	ldw	x,_TimingDelay
 216  0002 5a            	decw	x
 217  0003 bf00          	ldw	_TimingDelay,x
 218                     ; 77 	sys_20ms_cnt++;
 220  0005 be06          	ldw	x,L12_sys_20ms_cnt
 221  0007 5c            	incw	x
 222  0008 bf06          	ldw	L12_sys_20ms_cnt,x
 223                     ; 78 	sys_50ms_cnt++;
 225  000a be08          	ldw	x,L32_sys_50ms_cnt
 226  000c 5c            	incw	x
 227  000d bf08          	ldw	L32_sys_50ms_cnt,x
 228                     ; 79 	sys_100ms_cnt++;
 230  000f be0a          	ldw	x,L52_sys_100ms_cnt
 231  0011 5c            	incw	x
 232  0012 bf0a          	ldw	L52_sys_100ms_cnt,x
 233                     ; 80 	sys_200ms_cnt++;
 235  0014 be0c          	ldw	x,L72_sys_200ms_cnt
 236  0016 5c            	incw	x
 237  0017 bf0c          	ldw	L72_sys_200ms_cnt,x
 238                     ; 81 	sys_500ms_cnt++;
 240  0019 be0e          	ldw	x,L13_sys_500ms_cnt
 241  001b 5c            	incw	x
 242  001c bf0e          	ldw	L13_sys_500ms_cnt,x
 243                     ; 82 	sys_1000ms_cnt++;
 245  001e be10          	ldw	x,L33_sys_1000ms_cnt
 246  0020 5c            	incw	x
 247  0021 bf10          	ldw	L33_sys_1000ms_cnt,x
 248                     ; 84 	if(sys_20ms_cnt>20){
 250  0023 be06          	ldw	x,L12_sys_20ms_cnt
 251  0025 a30015        	cpw	x,#21
 252  0028 2507          	jrult	L77
 253                     ; 85 		sys_20ms_cnt=0;
 255  002a 5f            	clrw	x
 256  002b bf06          	ldw	L12_sys_20ms_cnt,x
 257                     ; 86 		Sys_20ms_Flag=1;
 259  002d 35010000      	mov	_Sys_20ms_Flag,#1
 260  0031               L77:
 261                     ; 89 	if(sys_50ms_cnt>50){
 263  0031 be08          	ldw	x,L32_sys_50ms_cnt
 264  0033 a30033        	cpw	x,#51
 265  0036 2507          	jrult	L101
 266                     ; 90 		sys_50ms_cnt=0;
 268  0038 5f            	clrw	x
 269  0039 bf08          	ldw	L32_sys_50ms_cnt,x
 270                     ; 91 		Sys_50ms_Flag=1;
 272  003b 35010001      	mov	_Sys_50ms_Flag,#1
 273  003f               L101:
 274                     ; 94 	if(sys_100ms_cnt>100){
 276  003f be0a          	ldw	x,L52_sys_100ms_cnt
 277  0041 a30065        	cpw	x,#101
 278  0044 2507          	jrult	L301
 279                     ; 95 		sys_100ms_cnt=0;
 281  0046 5f            	clrw	x
 282  0047 bf0a          	ldw	L52_sys_100ms_cnt,x
 283                     ; 96 		Sys_100ms_Flag=1;
 285  0049 35010002      	mov	_Sys_100ms_Flag,#1
 286  004d               L301:
 287                     ; 99 	if(sys_200ms_cnt>200){
 289  004d be0c          	ldw	x,L72_sys_200ms_cnt
 290  004f a300c9        	cpw	x,#201
 291  0052 2507          	jrult	L501
 292                     ; 100 		sys_200ms_cnt=0;
 294  0054 5f            	clrw	x
 295  0055 bf0c          	ldw	L72_sys_200ms_cnt,x
 296                     ; 101 		Sys_200ms_Flag=1;
 298  0057 35010003      	mov	_Sys_200ms_Flag,#1
 299  005b               L501:
 300                     ; 104 	if(sys_500ms_cnt>500){
 302  005b be0e          	ldw	x,L13_sys_500ms_cnt
 303  005d a301f5        	cpw	x,#501
 304  0060 2507          	jrult	L701
 305                     ; 105 		sys_500ms_cnt=0;
 307  0062 5f            	clrw	x
 308  0063 bf0e          	ldw	L13_sys_500ms_cnt,x
 309                     ; 106 		Sys_500ms_Flag=1;
 311  0065 35010004      	mov	_Sys_500ms_Flag,#1
 312  0069               L701:
 313                     ; 109 	if(sys_1000ms_cnt>1000){
 315  0069 be10          	ldw	x,L33_sys_1000ms_cnt
 316  006b a303e9        	cpw	x,#1001
 317  006e 2507          	jrult	L111
 318                     ; 110 		sys_1000ms_cnt=0;
 320  0070 5f            	clrw	x
 321  0071 bf10          	ldw	L33_sys_1000ms_cnt,x
 322                     ; 111 		Sys_1000ms_Flag=1;
 324  0073 35010005      	mov	_Sys_1000ms_Flag,#1
 325  0077               L111:
 326                     ; 114 }
 329  0077 81            	ret	
 364                     ; 122 void delay_ms(u16 nTime)
 364                     ; 123 {
 365                     .text:	section	.text,new
 366  0000               _delay_ms:
 370                     ; 124 	TimingDelay = nTime;
 372  0000 bf00          	ldw	_TimingDelay,x
 374  0002               L531:
 375                     ; 126 	while(0 != TimingDelay)
 377  0002 be00          	ldw	x,_TimingDelay
 378  0004 26fc          	jrne	L531
 379                     ; 128 }
 382  0006 81            	ret	
 460                     	xdef	_Sys_1000ms_Flag
 461                     	xdef	_Sys_500ms_Flag
 462                     	xdef	_Sys_200ms_Flag
 463                     	xdef	_Sys_100ms_Flag
 464                     	xdef	_Sys_50ms_Flag
 465                     	xdef	_Sys_20ms_Flag
 466                     	xdef	_delay_ms
 467                     	xdef	_TimingDelay_Decrement
 468                     	xdef	_Tim1_Init
 469                     	switch	.ubsct
 470  0000               _TimingDelay:
 471  0000 0000          	ds.b	2
 472                     	xdef	_TimingDelay
 473                     	xref	_TIM1_SetCounter
 474                     	xref	_TIM1_ARRPreloadConfig
 475                     	xref	_TIM1_ITConfig
 476                     	xref	_TIM1_Cmd
 477                     	xref	_TIM1_TimeBaseInit
 497                     	end
