   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  53                     ; 40 void Tim1_Init(void)
  53                     ; 41 {
  55                     .text:	section	.text,new
  56  0000               _Tim1_Init:
  60                     ; 43 	TIM1_TimeBaseInit(15, TIM1_COUNTERMODE_UP, 999, 0);
  62  0000 4b00          	push	#0
  63  0002 ae03e7        	ldw	x,#999
  64  0005 89            	pushw	x
  65  0006 4b00          	push	#0
  66  0008 ae000f        	ldw	x,#15
  67  000b cd0000        	call	_TIM1_TimeBaseInit
  69  000e 5b04          	addw	sp,#4
  70                     ; 44 	TIM1_SetCounter(0);/* 将计数器初值设为0 */
  72  0010 5f            	clrw	x
  73  0011 cd0000        	call	_TIM1_SetCounter
  75                     ; 45 	TIM1_ARRPreloadConfig(DISABLE);	/* 预装载不使能 */
  77  0014 4f            	clr	a
  78  0015 cd0000        	call	_TIM1_ARRPreloadConfig
  80                     ; 46 	TIM1_ITConfig(TIM1_IT_UPDATE , ENABLE);	/* 计数器向上计数/向下计数溢出更新中断 */
  82  0018 ae0001        	ldw	x,#1
  83  001b a601          	ld	a,#1
  84  001d 95            	ld	xh,a
  85  001e cd0000        	call	_TIM1_ITConfig
  87                     ; 47 	TIM1_Cmd(ENABLE);			/* 使能TIM1 */
  89  0021 a601          	ld	a,#1
  91                     ; 48 }
  94  0023 cc0000        	jp	_TIM1_Cmd
 119                     ; 57 void TimingDelay_Decrement(void)
 119                     ; 58 {
 120                     .text:	section	.text,new
 121  0000               _TimingDelay_Decrement:
 125                     ; 59 	TimingDelay--;
 127  0000 be00          	ldw	x,_TimingDelay
 128  0002 5a            	decw	x
 129  0003 bf00          	ldw	_TimingDelay,x
 130                     ; 60 }
 133  0005 81            	ret	
 168                     ; 68 void delay_ms(u16 nTime)
 168                     ; 69 {
 169                     .text:	section	.text,new
 170  0000               _delay_ms:
 174                     ; 70 	TimingDelay = nTime;
 176  0000 bf00          	ldw	_TimingDelay,x
 178  0002               L35:
 179                     ; 72 	while(0 != TimingDelay)
 181  0002 be00          	ldw	x,_TimingDelay
 182  0004 26fc          	jrne	L35
 183                     ; 74 }
 186  0006 81            	ret	
 210                     	xdef	_delay_ms
 211                     	xdef	_TimingDelay_Decrement
 212                     	xdef	_Tim1_Init
 213                     	switch	.ubsct
 214  0000               _TimingDelay:
 215  0000 0000          	ds.b	2
 216                     	xdef	_TimingDelay
 217                     	xref	_TIM1_SetCounter
 218                     	xref	_TIM1_ARRPreloadConfig
 219                     	xref	_TIM1_ITConfig
 220                     	xref	_TIM1_Cmd
 221                     	xref	_TIM1_TimeBaseInit
 241                     	end
