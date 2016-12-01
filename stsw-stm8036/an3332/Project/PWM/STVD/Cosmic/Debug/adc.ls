   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  50                     ; 39 void ADC_Init(void)
  50                     ; 40 {
  52                     .text:	section	.text,new
  53  0000               _ADC_Init:
  57                     ; 49     ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS , ADC1_CHANNEL_4, ADC1_PRESSEL_FCPU_D18,\
  57                     ; 50 		ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SCHMITTTRIG_CHANNEL4,DISABLE);
  59  0000 4b00          	push	#0
  60  0002 4b04          	push	#4
  61  0004 4b08          	push	#8
  62  0006 4b00          	push	#0
  63  0008 4b00          	push	#0
  64  000a 4b70          	push	#112
  65  000c ae0004        	ldw	x,#4
  66  000f a601          	ld	a,#1
  67  0011 95            	ld	xh,a
  68  0012 cd0000        	call	_ADC1_Init
  70  0015 5b06          	addw	sp,#6
  71                     ; 51     ADC1_Cmd(ENABLE);
  73  0017 a601          	ld	a,#1
  75                     ; 53 }
  78  0019 cc0000        	jp	_ADC1_Cmd
 113                     ; 61 uint16_t GetMotoADValue(void)
 113                     ; 62 {
 114                     .text:	section	.text,new
 115  0000               _GetMotoADValue:
 117  0000 89            	pushw	x
 118       00000002      OFST:	set	2
 121                     ; 72     ADConversion_Value = ADC1_GetConversionValue();
 123  0001 cd0000        	call	_ADC1_GetConversionValue
 125                     ; 73     return ADConversion_Value;
 129  0004 5b02          	addw	sp,#2
 130  0006 81            	ret	
 164                     ; 84 void Send_ADC_Value(u16 AD_Value)
 164                     ; 85 {
 165                     .text:	section	.text,new
 166  0000               _Send_ADC_Value:
 170                     ; 92 }
 173  0000 81            	ret	
 197                     ; 102 void MultipleChannelGetADValue(void)
 197                     ; 103 {
 198                     .text:	section	.text,new
 199  0000               _MultipleChannelGetADValue:
 203                     ; 114 }
 206  0000 81            	ret	
 451                     ; 122 uint16_t OneChannelGetADValue(ADC1_Channel_TypeDef ADC1_Channel,\
 451                     ; 123                                      ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel)
 451                     ; 124 {
 452                     .text:	section	.text,new
 453  0000               _OneChannelGetADValue:
 455  0000 89            	pushw	x
 456       00000002      OFST:	set	2
 459                     ; 134     ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS , ADC1_Channel, ADC1_PRESSEL_FCPU_D18,\
 459                     ; 135 		ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SchmittTriggerChannel,DISABLE);
 461  0001 4b00          	push	#0
 462  0003 9f            	ld	a,xl
 463  0004 88            	push	a
 464  0005 4b08          	push	#8
 465  0007 4b00          	push	#0
 466  0009 4b00          	push	#0
 467  000b 4b70          	push	#112
 468  000d 9e            	ld	a,xh
 469  000e 97            	ld	xl,a
 470  000f a601          	ld	a,#1
 471  0011 95            	ld	xh,a
 472  0012 cd0000        	call	_ADC1_Init
 474  0015 5b06          	addw	sp,#6
 475                     ; 136     ADC1_Cmd(ENABLE);
 477  0017 a601          	ld	a,#1
 478  0019 cd0000        	call	_ADC1_Cmd
 480                     ; 137     ADC1_StartConversion();
 482  001c cd0000        	call	_ADC1_StartConversion
 484                     ; 138     ADConversion_Value = ADC1_GetConversionValue();
 486  001f cd0000        	call	_ADC1_GetConversionValue
 488                     ; 139     return ADConversion_Value;
 492  0022 5b02          	addw	sp,#2
 493  0024 81            	ret	
 527                     ; 143 static void Delay(u16 nCount)
 527                     ; 144 {
 528                     .text:	section	.text,new
 529  0000               L3_Delay:
 531  0000 89            	pushw	x
 532       00000000      OFST:	set	0
 535  0001 2003          	jra	L322
 536  0003               L122:
 537                     ; 148     nCount--;
 539  0003 5a            	decw	x
 540  0004 1f01          	ldw	(OFST+1,sp),x
 541  0006               L322:
 542                     ; 146   while (nCount != 0)
 544  0006 1e01          	ldw	x,(OFST+1,sp)
 545  0008 26f9          	jrne	L122
 546                     ; 150 }
 549  000a 85            	popw	x
 550  000b 81            	ret	
 563                     	xdef	_GetMotoADValue
 564                     	xdef	_OneChannelGetADValue
 565                     	xdef	_MultipleChannelGetADValue
 566                     	xdef	_Send_ADC_Value
 567                     	xdef	_ADC_Init
 568                     	xref	_ADC1_GetConversionValue
 569                     	xref	_ADC1_StartConversion
 570                     	xref	_ADC1_Cmd
 571                     	xref	_ADC1_Init
 590                     	end
