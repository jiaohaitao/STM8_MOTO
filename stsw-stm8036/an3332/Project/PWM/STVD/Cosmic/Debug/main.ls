   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  57                     ; 45 void main(void)
  57                     ; 46 {
  59                     	switch	.text
  60  0000               _main:
  64                     ; 49   TIM2_DeInit();
  66  0000 cd0000        	call	_TIM2_DeInit
  68                     ; 52   TIM2_TimeBaseInit(TIM2_PRESCALER_1, 999);
  70  0003 ae03e7        	ldw	x,#999
  71  0006 89            	pushw	x
  72  0007 4f            	clr	a
  73  0008 cd0000        	call	_TIM2_TimeBaseInit
  75  000b 85            	popw	x
  76                     ; 56   TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR1_Val, TIM2_OCPOLARITY_LOW ); 
  78  000c 4b22          	push	#34
  79  000e ae01f4        	ldw	x,#500
  80  0011 89            	pushw	x
  81  0012 ad3a          	call	LC001
  82  0014 cd0000        	call	_TIM2_OC1Init
  84  0017 5b03          	addw	sp,#3
  85                     ; 57   TIM2_OC1PreloadConfig(ENABLE);
  87  0019 a601          	ld	a,#1
  88  001b cd0000        	call	_TIM2_OC1PreloadConfig
  90                     ; 60   TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR2_Val, TIM2_OCPOLARITY_LOW );
  92  001e 4b22          	push	#34
  93  0020 ae00fa        	ldw	x,#250
  94  0023 89            	pushw	x
  95  0024 ad28          	call	LC001
  96  0026 cd0000        	call	_TIM2_OC2Init
  98  0029 5b03          	addw	sp,#3
  99                     ; 61   TIM2_OC2PreloadConfig(ENABLE);
 101  002b a601          	ld	a,#1
 102  002d cd0000        	call	_TIM2_OC2PreloadConfig
 104                     ; 64 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR3_Val, TIM2_OCPOLARITY_LOW );
 106  0030 4b22          	push	#34
 107  0032 ae02ee        	ldw	x,#750
 108  0035 89            	pushw	x
 109  0036 ad16          	call	LC001
 110  0038 cd0000        	call	_TIM2_OC3Init
 112  003b 5b03          	addw	sp,#3
 113                     ; 65   TIM2_OC3PreloadConfig(ENABLE);
 115  003d a601          	ld	a,#1
 116  003f cd0000        	call	_TIM2_OC3PreloadConfig
 118                     ; 68 	TIM2_ARRPreloadConfig(ENABLE);
 120  0042 a601          	ld	a,#1
 121  0044 cd0000        	call	_TIM2_ARRPreloadConfig
 123                     ; 71   TIM2_Cmd(ENABLE);
 125  0047 a601          	ld	a,#1
 126  0049 cd0000        	call	_TIM2_Cmd
 128  004c               L12:
 129                     ; 74   while (1); 
 131  004c 20fe          	jra	L12
 132  004e               LC001:
 133  004e ae0011        	ldw	x,#17
 134  0051 a670          	ld	a,#112
 135  0053 95            	ld	xh,a
 136  0054 81            	ret	
 149                     	xdef	_main
 150                     	xref	_TIM2_OC3PreloadConfig
 151                     	xref	_TIM2_OC2PreloadConfig
 152                     	xref	_TIM2_OC1PreloadConfig
 153                     	xref	_TIM2_ARRPreloadConfig
 154                     	xref	_TIM2_Cmd
 155                     	xref	_TIM2_OC3Init
 156                     	xref	_TIM2_OC2Init
 157                     	xref	_TIM2_OC1Init
 158                     	xref	_TIM2_TimeBaseInit
 159                     	xref	_TIM2_DeInit
 178                     	end
