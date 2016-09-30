   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  57                     ; 12 void Pwm_Init()
  57                     ; 13 {
  59                     	switch	.text
  60  0000               _Pwm_Init:
  64                     ; 15   TIM2_DeInit();
  66  0000 cd0000        	call	_TIM2_DeInit
  68                     ; 18   TIM2_TimeBaseInit(TIM2_PRESCALER_1, 999);
  70  0003 ae03e7        	ldw	x,#999
  71  0006 89            	pushw	x
  72  0007 4f            	clr	a
  73  0008 cd0000        	call	_TIM2_TimeBaseInit
  75  000b 85            	popw	x
  76                     ; 22   TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR1_Val, TIM2_OCPOLARITY_LOW ); 
  78  000c 4b22          	push	#34
  79  000e 5f            	clrw	x
  80  000f 89            	pushw	x
  81  0010 ad34          	call	LC001
  82  0012 cd0000        	call	_TIM2_OC1Init
  84  0015 5b03          	addw	sp,#3
  85                     ; 23   TIM2_OC1PreloadConfig(ENABLE);
  87  0017 a601          	ld	a,#1
  88  0019 cd0000        	call	_TIM2_OC1PreloadConfig
  90                     ; 26   TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR2_Val, TIM2_OCPOLARITY_LOW );
  92  001c 4b22          	push	#34
  93  001e 5f            	clrw	x
  94  001f 89            	pushw	x
  95  0020 ad24          	call	LC001
  96  0022 cd0000        	call	_TIM2_OC2Init
  98  0025 5b03          	addw	sp,#3
  99                     ; 27   TIM2_OC2PreloadConfig(ENABLE);
 101  0027 a601          	ld	a,#1
 102  0029 cd0000        	call	_TIM2_OC2PreloadConfig
 104                     ; 30 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR3_Val, TIM2_OCPOLARITY_LOW );
 106  002c 4b22          	push	#34
 107  002e 5f            	clrw	x
 108  002f 89            	pushw	x
 109  0030 ad14          	call	LC001
 110  0032 cd0000        	call	_TIM2_OC3Init
 112  0035 5b03          	addw	sp,#3
 113                     ; 31   TIM2_OC3PreloadConfig(ENABLE);
 115  0037 a601          	ld	a,#1
 116  0039 cd0000        	call	_TIM2_OC3PreloadConfig
 118                     ; 34 	TIM2_ARRPreloadConfig(ENABLE);
 120  003c a601          	ld	a,#1
 121  003e cd0000        	call	_TIM2_ARRPreloadConfig
 123                     ; 37   TIM2_Cmd(ENABLE);
 125  0041 a601          	ld	a,#1
 127                     ; 38 }
 130  0043 cc0000        	jp	_TIM2_Cmd
 131  0046               LC001:
 132  0046 ae0011        	ldw	x,#17
 133  0049 a670          	ld	a,#112
 134  004b 95            	ld	xh,a
 135  004c 81            	ret	
 171                     ; 42 void Set_Pwm_Channel1(unsigned char pwm)
 171                     ; 43 {
 172                     	switch	.text
 173  004d               _Set_Pwm_Channel1:
 177                     ; 45   TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW ); 
 179  004d 4b22          	push	#34
 180  004f 97            	ld	xl,a
 181  0050 a60a          	ld	a,#10
 182  0052 42            	mul	x,a
 183  0053 89            	pushw	x
 184  0054 ae0011        	ldw	x,#17
 185  0057 a670          	ld	a,#112
 186  0059 95            	ld	xh,a
 187  005a cd0000        	call	_TIM2_OC1Init
 189  005d 5b03          	addw	sp,#3
 190                     ; 46   TIM2_OC1PreloadConfig(ENABLE);
 192  005f a601          	ld	a,#1
 194                     ; 47 }
 197  0061 cc0000        	jp	_TIM2_OC1PreloadConfig
 233                     ; 53 void Set_Pwm_Channel2(unsigned char pwm)
 233                     ; 54 {
 234                     	switch	.text
 235  0064               _Set_Pwm_Channel2:
 239                     ; 56   TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW );
 241  0064 4b22          	push	#34
 242  0066 97            	ld	xl,a
 243  0067 a60a          	ld	a,#10
 244  0069 42            	mul	x,a
 245  006a 89            	pushw	x
 246  006b ae0011        	ldw	x,#17
 247  006e a670          	ld	a,#112
 248  0070 95            	ld	xh,a
 249  0071 cd0000        	call	_TIM2_OC2Init
 251  0074 5b03          	addw	sp,#3
 252                     ; 57   TIM2_OC2PreloadConfig(ENABLE);
 254  0076 a601          	ld	a,#1
 256                     ; 58 }
 259  0078 cc0000        	jp	_TIM2_OC2PreloadConfig
 295                     ; 64 void Set_Pwm_Channel3(unsigned char pwm)
 295                     ; 65 {
 296                     	switch	.text
 297  007b               _Set_Pwm_Channel3:
 301                     ; 67 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW );
 303  007b 4b22          	push	#34
 304  007d 97            	ld	xl,a
 305  007e a60a          	ld	a,#10
 306  0080 42            	mul	x,a
 307  0081 89            	pushw	x
 308  0082 ae0011        	ldw	x,#17
 309  0085 a670          	ld	a,#112
 310  0087 95            	ld	xh,a
 311  0088 cd0000        	call	_TIM2_OC3Init
 313  008b 5b03          	addw	sp,#3
 314                     ; 68   TIM2_OC3PreloadConfig(ENABLE);
 316  008d a601          	ld	a,#1
 318                     ; 69 }
 321  008f cc0000        	jp	_TIM2_OC3PreloadConfig
 334                     	xdef	_Set_Pwm_Channel3
 335                     	xdef	_Set_Pwm_Channel2
 336                     	xdef	_Set_Pwm_Channel1
 337                     	xdef	_Pwm_Init
 338                     	xref	_TIM2_OC3PreloadConfig
 339                     	xref	_TIM2_OC2PreloadConfig
 340                     	xref	_TIM2_OC1PreloadConfig
 341                     	xref	_TIM2_ARRPreloadConfig
 342                     	xref	_TIM2_Cmd
 343                     	xref	_TIM2_OC3Init
 344                     	xref	_TIM2_OC2Init
 345                     	xref	_TIM2_OC1Init
 346                     	xref	_TIM2_TimeBaseInit
 347                     	xref	_TIM2_DeInit
 366                     	end
