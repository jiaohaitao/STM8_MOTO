   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  54                     ; 12 void Pwm_Init()
  54                     ; 13 {
  56                     .text:	section	.text,new
  57  0000               _Pwm_Init:
  61                     ; 15   TIM2_DeInit();
  63  0000 cd0000        	call	_TIM2_DeInit
  65                     ; 18   TIM2_TimeBaseInit(TIM2_PRESCALER_8, 99);//999->2K 99->20K  
  67  0003 ae0063        	ldw	x,#99
  68  0006 89            	pushw	x
  69  0007 a603          	ld	a,#3
  70  0009 cd0000        	call	_TIM2_TimeBaseInit
  72  000c 85            	popw	x
  73                     ; 30 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR3_Val, TIM2_OCPOLARITY_LOW );
  75  000d 4b22          	push	#34
  76  000f 5f            	clrw	x
  77  0010 89            	pushw	x
  78  0011 ae0011        	ldw	x,#17
  79  0014 a670          	ld	a,#112
  80  0016 95            	ld	xh,a
  81  0017 cd0000        	call	_TIM2_OC3Init
  83  001a 5b03          	addw	sp,#3
  84                     ; 31   TIM2_OC3PreloadConfig(ENABLE);
  86  001c a601          	ld	a,#1
  87  001e cd0000        	call	_TIM2_OC3PreloadConfig
  89                     ; 34 	TIM2_ARRPreloadConfig(ENABLE);
  91  0021 a601          	ld	a,#1
  92  0023 cd0000        	call	_TIM2_ARRPreloadConfig
  94                     ; 37   TIM2_Cmd(ENABLE);
  96  0026 a601          	ld	a,#1
  98                     ; 38 }
 101  0028 cc0000        	jp	_TIM2_Cmd
 135                     ; 42 void Set_Pwm_Channel1(unsigned char pwm)
 135                     ; 43 {
 136                     .text:	section	.text,new
 137  0000               _Set_Pwm_Channel1:
 141                     ; 47 }
 144  0000 81            	ret	
 178                     ; 53 void Set_Pwm_Channel2(unsigned char pwm)
 178                     ; 54 {
 179                     .text:	section	.text,new
 180  0000               _Set_Pwm_Channel2:
 184                     ; 58 }
 187  0000 81            	ret	
 223                     ; 64 void Set_Pwm_Channel3(unsigned char pwm)
 223                     ; 65 {
 224                     .text:	section	.text,new
 225  0000               _Set_Pwm_Channel3:
 229                     ; 67 	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm, TIM2_OCPOLARITY_LOW );
 231  0000 4b22          	push	#34
 232  0002 5f            	clrw	x
 233  0003 97            	ld	xl,a
 234  0004 89            	pushw	x
 235  0005 ae0011        	ldw	x,#17
 236  0008 a670          	ld	a,#112
 237  000a 95            	ld	xh,a
 238  000b cd0000        	call	_TIM2_OC3Init
 240  000e 5b03          	addw	sp,#3
 241                     ; 68   TIM2_OC3PreloadConfig(ENABLE);
 243  0010 a601          	ld	a,#1
 245                     ; 69 }
 248  0012 cc0000        	jp	_TIM2_OC3PreloadConfig
 261                     	xdef	_Set_Pwm_Channel3
 262                     	xdef	_Set_Pwm_Channel2
 263                     	xdef	_Set_Pwm_Channel1
 264                     	xdef	_Pwm_Init
 265                     	xref	_TIM2_OC3PreloadConfig
 266                     	xref	_TIM2_ARRPreloadConfig
 267                     	xref	_TIM2_Cmd
 268                     	xref	_TIM2_OC3Init
 269                     	xref	_TIM2_TimeBaseInit
 270                     	xref	_TIM2_DeInit
 289                     	end
