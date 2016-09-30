   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  58                     ; 12 void Pwm_Init()
  58                     ; 13 {
  60                     .text:	section	.text,new
  61  0000               _Pwm_Init:
  65                     ; 15   TIM2_DeInit();
  67  0000 cd0000        	call	_TIM2_DeInit
  69                     ; 18   TIM2_TimeBaseInit(TIM2_PRESCALER_8, 999);
  71  0003 ae03e7        	ldw	x,#999
  72  0006 89            	pushw	x
  73  0007 a603          	ld	a,#3
  74  0009 cd0000        	call	_TIM2_TimeBaseInit
  76  000c 85            	popw	x
  77                     ; 22   TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR1_Val, TIM2_OCPOLARITY_LOW ); 
  79  000d 4b22          	push	#34
  80  000f 5f            	clrw	x
  81  0010 89            	pushw	x
  82  0011 ad34          	call	LC001
  83  0013 cd0000        	call	_TIM2_OC1Init
  85  0016 5b03          	addw	sp,#3
  86                     ; 23   TIM2_OC1PreloadConfig(ENABLE);
  88  0018 a601          	ld	a,#1
  89  001a cd0000        	call	_TIM2_OC1PreloadConfig
  91                     ; 26   TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR2_Val, TIM2_OCPOLARITY_LOW );
  93  001d 4b22          	push	#34
  94  001f 5f            	clrw	x
  95  0020 89            	pushw	x
  96  0021 ad24          	call	LC001
  97  0023 cd0000        	call	_TIM2_OC2Init
  99  0026 5b03          	addw	sp,#3
 100                     ; 27   TIM2_OC2PreloadConfig(ENABLE);
 102  0028 a601          	ld	a,#1
 103  002a cd0000        	call	_TIM2_OC2PreloadConfig
 105                     ; 30 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR3_Val, TIM2_OCPOLARITY_LOW );
 107  002d 4b22          	push	#34
 108  002f 5f            	clrw	x
 109  0030 89            	pushw	x
 110  0031 ad14          	call	LC001
 111  0033 cd0000        	call	_TIM2_OC3Init
 113  0036 5b03          	addw	sp,#3
 114                     ; 31   TIM2_OC3PreloadConfig(ENABLE);
 116  0038 a601          	ld	a,#1
 117  003a cd0000        	call	_TIM2_OC3PreloadConfig
 119                     ; 34 	TIM2_ARRPreloadConfig(ENABLE);
 121  003d a601          	ld	a,#1
 122  003f cd0000        	call	_TIM2_ARRPreloadConfig
 124                     ; 37   TIM2_Cmd(ENABLE);
 126  0042 a601          	ld	a,#1
 128                     ; 38 }
 131  0044 cc0000        	jp	_TIM2_Cmd
 132  0047               LC001:
 133  0047 ae0011        	ldw	x,#17
 134  004a a670          	ld	a,#112
 135  004c 95            	ld	xh,a
 136  004d 81            	ret	
 172                     ; 42 void Set_Pwm_Channel1(unsigned char pwm)
 172                     ; 43 {
 173                     .text:	section	.text,new
 174  0000               _Set_Pwm_Channel1:
 178                     ; 45   TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW ); 
 180  0000 4b22          	push	#34
 181  0002 97            	ld	xl,a
 182  0003 a60a          	ld	a,#10
 183  0005 42            	mul	x,a
 184  0006 89            	pushw	x
 185  0007 ae0011        	ldw	x,#17
 186  000a a670          	ld	a,#112
 187  000c 95            	ld	xh,a
 188  000d cd0000        	call	_TIM2_OC1Init
 190  0010 5b03          	addw	sp,#3
 191                     ; 46   TIM2_OC1PreloadConfig(ENABLE);
 193  0012 a601          	ld	a,#1
 195                     ; 47 }
 198  0014 cc0000        	jp	_TIM2_OC1PreloadConfig
 234                     ; 53 void Set_Pwm_Channel2(unsigned char pwm)
 234                     ; 54 {
 235                     .text:	section	.text,new
 236  0000               _Set_Pwm_Channel2:
 240                     ; 56   TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW );
 242  0000 4b22          	push	#34
 243  0002 97            	ld	xl,a
 244  0003 a60a          	ld	a,#10
 245  0005 42            	mul	x,a
 246  0006 89            	pushw	x
 247  0007 ae0011        	ldw	x,#17
 248  000a a670          	ld	a,#112
 249  000c 95            	ld	xh,a
 250  000d cd0000        	call	_TIM2_OC2Init
 252  0010 5b03          	addw	sp,#3
 253                     ; 57   TIM2_OC2PreloadConfig(ENABLE);
 255  0012 a601          	ld	a,#1
 257                     ; 58 }
 260  0014 cc0000        	jp	_TIM2_OC2PreloadConfig
 296                     ; 64 void Set_Pwm_Channel3(unsigned char pwm)
 296                     ; 65 {
 297                     .text:	section	.text,new
 298  0000               _Set_Pwm_Channel3:
 302                     ; 67 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW );
 304  0000 4b22          	push	#34
 305  0002 97            	ld	xl,a
 306  0003 a60a          	ld	a,#10
 307  0005 42            	mul	x,a
 308  0006 89            	pushw	x
 309  0007 ae0011        	ldw	x,#17
 310  000a a670          	ld	a,#112
 311  000c 95            	ld	xh,a
 312  000d cd0000        	call	_TIM2_OC3Init
 314  0010 5b03          	addw	sp,#3
 315                     ; 68   TIM2_OC3PreloadConfig(ENABLE);
 317  0012 a601          	ld	a,#1
 319                     ; 69 }
 322  0014 cc0000        	jp	_TIM2_OC3PreloadConfig
 335                     	xdef	_Set_Pwm_Channel3
 336                     	xdef	_Set_Pwm_Channel2
 337                     	xdef	_Set_Pwm_Channel1
 338                     	xdef	_Pwm_Init
 339                     	xref	_TIM2_OC3PreloadConfig
 340                     	xref	_TIM2_OC2PreloadConfig
 341                     	xref	_TIM2_OC1PreloadConfig
 342                     	xref	_TIM2_ARRPreloadConfig
 343                     	xref	_TIM2_Cmd
 344                     	xref	_TIM2_OC3Init
 345                     	xref	_TIM2_OC2Init
 346                     	xref	_TIM2_OC1Init
 347                     	xref	_TIM2_TimeBaseInit
 348                     	xref	_TIM2_DeInit
 367                     	end
