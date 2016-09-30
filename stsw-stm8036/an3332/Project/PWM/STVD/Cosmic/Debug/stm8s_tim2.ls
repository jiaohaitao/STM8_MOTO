   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  47                     ; 46 void TIM2_DeInit(void)
  47                     ; 47 {
  49                     	switch	.text
  50  0000               _TIM2_DeInit:
  54                     ; 49     TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  56  0000 725f5300      	clr	21248
  57                     ; 50     TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  59  0004 725f5303      	clr	21251
  60                     ; 51     TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  62  0008 725f5305      	clr	21253
  63                     ; 54     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  65  000c 725f530a      	clr	21258
  66                     ; 55     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  68  0010 725f530b      	clr	21259
  69                     ; 59     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  71  0014 725f530a      	clr	21258
  72                     ; 60     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  74  0018 725f530b      	clr	21259
  75                     ; 61     TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  77  001c 725f5307      	clr	21255
  78                     ; 62     TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  80  0020 725f5308      	clr	21256
  81                     ; 63     TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  83  0024 725f5309      	clr	21257
  84                     ; 64     TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  86  0028 725f530c      	clr	21260
  87                     ; 65     TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  89  002c 725f530d      	clr	21261
  90                     ; 66     TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  92  0030 725f530e      	clr	21262
  93                     ; 67     TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  95  0034 35ff530f      	mov	21263,#255
  96                     ; 68     TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  98  0038 35ff5310      	mov	21264,#255
  99                     ; 69     TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
 101  003c 725f5311      	clr	21265
 102                     ; 70     TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 104  0040 725f5312      	clr	21266
 105                     ; 71     TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 107  0044 725f5313      	clr	21267
 108                     ; 72     TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 110  0048 725f5314      	clr	21268
 111                     ; 73     TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 113  004c 725f5315      	clr	21269
 114                     ; 74     TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 116  0050 725f5316      	clr	21270
 117                     ; 75     TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 119  0054 725f5304      	clr	21252
 120                     ; 76 }
 123  0058 81            	ret	
 291                     ; 85 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 291                     ; 86                         uint16_t TIM2_Period)
 291                     ; 87 {
 292                     	switch	.text
 293  0059               _TIM2_TimeBaseInit:
 295       00000000      OFST:	set	0
 298                     ; 89     TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 300  0059 c7530e        	ld	21262,a
 301  005c 88            	push	a
 302                     ; 91     TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 304  005d 7b04          	ld	a,(OFST+4,sp)
 305  005f c7530f        	ld	21263,a
 306                     ; 92     TIM2->ARRL = (uint8_t)(TIM2_Period);
 308  0062 7b05          	ld	a,(OFST+5,sp)
 309  0064 c75310        	ld	21264,a
 310                     ; 93 }
 313  0067 84            	pop	a
 314  0068 81            	ret	
 471                     ; 104 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 471                     ; 105                   TIM2_OutputState_TypeDef TIM2_OutputState,
 471                     ; 106                   uint16_t TIM2_Pulse,
 471                     ; 107                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 471                     ; 108 {
 472                     	switch	.text
 473  0069               _TIM2_OC1Init:
 475  0069 89            	pushw	x
 476  006a 88            	push	a
 477       00000001      OFST:	set	1
 480                     ; 110     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 482                     ; 111     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 484                     ; 112     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 486                     ; 115     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 488  006b c6530a        	ld	a,21258
 489  006e a4fc          	and	a,#252
 490  0070 c7530a        	ld	21258,a
 491                     ; 117     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 491                     ; 118                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 493  0073 7b08          	ld	a,(OFST+7,sp)
 494  0075 a402          	and	a,#2
 495  0077 6b01          	ld	(OFST+0,sp),a
 496  0079 9f            	ld	a,xl
 497  007a a401          	and	a,#1
 498  007c 1a01          	or	a,(OFST+0,sp)
 499  007e ca530a        	or	a,21258
 500  0081 c7530a        	ld	21258,a
 501                     ; 121     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 501                     ; 122                             (uint8_t)TIM2_OCMode);
 503  0084 c65307        	ld	a,21255
 504  0087 a48f          	and	a,#143
 505  0089 1a02          	or	a,(OFST+1,sp)
 506  008b c75307        	ld	21255,a
 507                     ; 125     TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 509  008e 7b06          	ld	a,(OFST+5,sp)
 510  0090 c75311        	ld	21265,a
 511                     ; 126     TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 513  0093 7b07          	ld	a,(OFST+6,sp)
 514  0095 c75312        	ld	21266,a
 515                     ; 127 }
 518  0098 5b03          	addw	sp,#3
 519  009a 81            	ret	
 583                     ; 138 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 583                     ; 139                   TIM2_OutputState_TypeDef TIM2_OutputState,
 583                     ; 140                   uint16_t TIM2_Pulse,
 583                     ; 141                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 583                     ; 142 {
 584                     	switch	.text
 585  009b               _TIM2_OC2Init:
 587  009b 89            	pushw	x
 588  009c 88            	push	a
 589       00000001      OFST:	set	1
 592                     ; 144     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 594                     ; 145     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 596                     ; 146     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 598                     ; 150     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 600  009d c6530a        	ld	a,21258
 601  00a0 a4cf          	and	a,#207
 602  00a2 c7530a        	ld	21258,a
 603                     ; 152     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 603                     ; 153                         (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 605  00a5 7b08          	ld	a,(OFST+7,sp)
 606  00a7 a420          	and	a,#32
 607  00a9 6b01          	ld	(OFST+0,sp),a
 608  00ab 9f            	ld	a,xl
 609  00ac a410          	and	a,#16
 610  00ae 1a01          	or	a,(OFST+0,sp)
 611  00b0 ca530a        	or	a,21258
 612  00b3 c7530a        	ld	21258,a
 613                     ; 157     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 613                     ; 158                             (uint8_t)TIM2_OCMode);
 615  00b6 c65308        	ld	a,21256
 616  00b9 a48f          	and	a,#143
 617  00bb 1a02          	or	a,(OFST+1,sp)
 618  00bd c75308        	ld	21256,a
 619                     ; 162     TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 621  00c0 7b06          	ld	a,(OFST+5,sp)
 622  00c2 c75313        	ld	21267,a
 623                     ; 163     TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 625  00c5 7b07          	ld	a,(OFST+6,sp)
 626  00c7 c75314        	ld	21268,a
 627                     ; 164 }
 630  00ca 5b03          	addw	sp,#3
 631  00cc 81            	ret	
 695                     ; 175 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 695                     ; 176                   TIM2_OutputState_TypeDef TIM2_OutputState,
 695                     ; 177                   uint16_t TIM2_Pulse,
 695                     ; 178                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 695                     ; 179 {
 696                     	switch	.text
 697  00cd               _TIM2_OC3Init:
 699  00cd 89            	pushw	x
 700  00ce 88            	push	a
 701       00000001      OFST:	set	1
 704                     ; 181     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 706                     ; 182     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 708                     ; 183     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 710                     ; 185     TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 712  00cf c6530b        	ld	a,21259
 713  00d2 a4fc          	and	a,#252
 714  00d4 c7530b        	ld	21259,a
 715                     ; 187     TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 715                     ; 188                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 717  00d7 7b08          	ld	a,(OFST+7,sp)
 718  00d9 a402          	and	a,#2
 719  00db 6b01          	ld	(OFST+0,sp),a
 720  00dd 9f            	ld	a,xl
 721  00de a401          	and	a,#1
 722  00e0 1a01          	or	a,(OFST+0,sp)
 723  00e2 ca530b        	or	a,21259
 724  00e5 c7530b        	ld	21259,a
 725                     ; 191     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 725                     ; 192                             (uint8_t)TIM2_OCMode);
 727  00e8 c65309        	ld	a,21257
 728  00eb a48f          	and	a,#143
 729  00ed 1a02          	or	a,(OFST+1,sp)
 730  00ef c75309        	ld	21257,a
 731                     ; 195     TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 733  00f2 7b06          	ld	a,(OFST+5,sp)
 734  00f4 c75315        	ld	21269,a
 735                     ; 196     TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 737  00f7 7b07          	ld	a,(OFST+6,sp)
 738  00f9 c75316        	ld	21270,a
 739                     ; 198 }
 742  00fc 5b03          	addw	sp,#3
 743  00fe 81            	ret	
 936                     ; 210 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
 936                     ; 211                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
 936                     ; 212                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
 936                     ; 213                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
 936                     ; 214                  uint8_t TIM2_ICFilter)
 936                     ; 215 {
 937                     	switch	.text
 938  00ff               _TIM2_ICInit:
 940  00ff 89            	pushw	x
 941       00000000      OFST:	set	0
 944                     ; 217     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
 946                     ; 218     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
 948                     ; 219     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
 950                     ; 220     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
 952                     ; 221     assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
 954                     ; 223     if (TIM2_Channel == TIM2_CHANNEL_1)
 956  0100 9e            	ld	a,xh
 957  0101 4d            	tnz	a
 958  0102 2614          	jrne	L104
 959                     ; 226         TI1_Config((uint8_t)TIM2_ICPolarity,
 959                     ; 227                    (uint8_t)TIM2_ICSelection,
 959                     ; 228                    (uint8_t)TIM2_ICFilter);
 961  0104 7b07          	ld	a,(OFST+7,sp)
 962  0106 88            	push	a
 963  0107 7b06          	ld	a,(OFST+6,sp)
 964  0109 97            	ld	xl,a
 965  010a 7b03          	ld	a,(OFST+3,sp)
 966  010c 95            	ld	xh,a
 967  010d cd040b        	call	L3_TI1_Config
 969  0110 84            	pop	a
 970                     ; 231         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
 972  0111 7b06          	ld	a,(OFST+6,sp)
 973  0113 cd032c        	call	_TIM2_SetIC1Prescaler
 976  0116 202b          	jra	L304
 977  0118               L104:
 978                     ; 233     else if (TIM2_Channel == TIM2_CHANNEL_2)
 980  0118 7b01          	ld	a,(OFST+1,sp)
 981  011a 4a            	dec	a
 982  011b 2614          	jrne	L504
 983                     ; 236         TI2_Config((uint8_t)TIM2_ICPolarity,
 983                     ; 237                    (uint8_t)TIM2_ICSelection,
 983                     ; 238                    (uint8_t)TIM2_ICFilter);
 985  011d 7b07          	ld	a,(OFST+7,sp)
 986  011f 88            	push	a
 987  0120 7b06          	ld	a,(OFST+6,sp)
 988  0122 97            	ld	xl,a
 989  0123 7b03          	ld	a,(OFST+3,sp)
 990  0125 95            	ld	xh,a
 991  0126 cd043b        	call	L5_TI2_Config
 993  0129 84            	pop	a
 994                     ; 241         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
 996  012a 7b06          	ld	a,(OFST+6,sp)
 997  012c cd0339        	call	_TIM2_SetIC2Prescaler
1000  012f 2012          	jra	L304
1001  0131               L504:
1002                     ; 246         TI3_Config((uint8_t)TIM2_ICPolarity,
1002                     ; 247                    (uint8_t)TIM2_ICSelection,
1002                     ; 248                    (uint8_t)TIM2_ICFilter);
1004  0131 7b07          	ld	a,(OFST+7,sp)
1005  0133 88            	push	a
1006  0134 7b06          	ld	a,(OFST+6,sp)
1007  0136 97            	ld	xl,a
1008  0137 7b03          	ld	a,(OFST+3,sp)
1009  0139 95            	ld	xh,a
1010  013a cd046b        	call	L7_TI3_Config
1012  013d 84            	pop	a
1013                     ; 251         TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1015  013e 7b06          	ld	a,(OFST+6,sp)
1016  0140 cd0346        	call	_TIM2_SetIC3Prescaler
1018  0143               L304:
1019                     ; 253 }
1022  0143 85            	popw	x
1023  0144 81            	ret	
1119                     ; 265 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1119                     ; 266                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1119                     ; 267                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1119                     ; 268                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1119                     ; 269                      uint8_t TIM2_ICFilter)
1119                     ; 270 {
1120                     	switch	.text
1121  0145               _TIM2_PWMIConfig:
1123  0145 89            	pushw	x
1124  0146 89            	pushw	x
1125       00000002      OFST:	set	2
1128                     ; 271     uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1130                     ; 272     uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1132                     ; 275     assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1134                     ; 276     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1136                     ; 277     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1138                     ; 278     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1140                     ; 281     if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1142  0147 9f            	ld	a,xl
1143  0148 a144          	cp	a,#68
1144  014a 2706          	jreq	L754
1145                     ; 283         icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1147  014c a644          	ld	a,#68
1148  014e 6b01          	ld	(OFST-1,sp),a
1150  0150 2002          	jra	L164
1151  0152               L754:
1152                     ; 287         icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1154  0152 0f01          	clr	(OFST-1,sp)
1155  0154               L164:
1156                     ; 291     if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1158  0154 7b07          	ld	a,(OFST+5,sp)
1159  0156 4a            	dec	a
1160  0157 2604          	jrne	L364
1161                     ; 293         icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1163  0159 a602          	ld	a,#2
1165  015b 2002          	jra	L564
1166  015d               L364:
1167                     ; 297         icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1169  015d a601          	ld	a,#1
1170  015f               L564:
1171  015f 6b02          	ld	(OFST+0,sp),a
1172                     ; 300     if (TIM2_Channel == TIM2_CHANNEL_1)
1174  0161 7b03          	ld	a,(OFST+1,sp)
1175  0163 2626          	jrne	L764
1176                     ; 303         TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1176                     ; 304                    (uint8_t)TIM2_ICFilter);
1178  0165 7b09          	ld	a,(OFST+7,sp)
1179  0167 88            	push	a
1180  0168 7b08          	ld	a,(OFST+6,sp)
1181  016a 97            	ld	xl,a
1182  016b 7b05          	ld	a,(OFST+3,sp)
1183  016d 95            	ld	xh,a
1184  016e cd040b        	call	L3_TI1_Config
1186  0171 84            	pop	a
1187                     ; 307         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1189  0172 7b08          	ld	a,(OFST+6,sp)
1190  0174 cd032c        	call	_TIM2_SetIC1Prescaler
1192                     ; 310         TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1194  0177 7b09          	ld	a,(OFST+7,sp)
1195  0179 88            	push	a
1196  017a 7b03          	ld	a,(OFST+1,sp)
1197  017c 97            	ld	xl,a
1198  017d 7b02          	ld	a,(OFST+0,sp)
1199  017f 95            	ld	xh,a
1200  0180 cd043b        	call	L5_TI2_Config
1202  0183 84            	pop	a
1203                     ; 313         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1205  0184 7b08          	ld	a,(OFST+6,sp)
1206  0186 cd0339        	call	_TIM2_SetIC2Prescaler
1209  0189 2024          	jra	L174
1210  018b               L764:
1211                     ; 318         TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1211                     ; 319                    (uint8_t)TIM2_ICFilter);
1213  018b 7b09          	ld	a,(OFST+7,sp)
1214  018d 88            	push	a
1215  018e 7b08          	ld	a,(OFST+6,sp)
1216  0190 97            	ld	xl,a
1217  0191 7b05          	ld	a,(OFST+3,sp)
1218  0193 95            	ld	xh,a
1219  0194 cd043b        	call	L5_TI2_Config
1221  0197 84            	pop	a
1222                     ; 322         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1224  0198 7b08          	ld	a,(OFST+6,sp)
1225  019a cd0339        	call	_TIM2_SetIC2Prescaler
1227                     ; 325         TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1229  019d 7b09          	ld	a,(OFST+7,sp)
1230  019f 88            	push	a
1231  01a0 7b03          	ld	a,(OFST+1,sp)
1232  01a2 97            	ld	xl,a
1233  01a3 7b02          	ld	a,(OFST+0,sp)
1234  01a5 95            	ld	xh,a
1235  01a6 cd040b        	call	L3_TI1_Config
1237  01a9 84            	pop	a
1238                     ; 328         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1240  01aa 7b08          	ld	a,(OFST+6,sp)
1241  01ac cd032c        	call	_TIM2_SetIC1Prescaler
1243  01af               L174:
1244                     ; 330 }
1247  01af 5b04          	addw	sp,#4
1248  01b1 81            	ret	
1303                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1303                     ; 340 {
1304                     	switch	.text
1305  01b2               _TIM2_Cmd:
1309                     ; 342     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1311                     ; 345     if (NewState != DISABLE)
1313  01b2 4d            	tnz	a
1314  01b3 2705          	jreq	L125
1315                     ; 347         TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1317  01b5 72105300      	bset	21248,#0
1320  01b9 81            	ret	
1321  01ba               L125:
1322                     ; 351         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1324  01ba 72115300      	bres	21248,#0
1325                     ; 353 }
1328  01be 81            	ret	
1407                     ; 369 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1407                     ; 370 {
1408                     	switch	.text
1409  01bf               _TIM2_ITConfig:
1411  01bf 89            	pushw	x
1412       00000000      OFST:	set	0
1415                     ; 372     assert_param(IS_TIM2_IT_OK(TIM2_IT));
1417                     ; 373     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1419                     ; 375     if (NewState != DISABLE)
1421  01c0 9f            	ld	a,xl
1422  01c1 4d            	tnz	a
1423  01c2 2706          	jreq	L365
1424                     ; 378         TIM2->IER |= (uint8_t)TIM2_IT;
1426  01c4 9e            	ld	a,xh
1427  01c5 ca5303        	or	a,21251
1429  01c8 2006          	jra	L565
1430  01ca               L365:
1431                     ; 383         TIM2->IER &= (uint8_t)(~TIM2_IT);
1433  01ca 7b01          	ld	a,(OFST+1,sp)
1434  01cc 43            	cpl	a
1435  01cd c45303        	and	a,21251
1436  01d0               L565:
1437  01d0 c75303        	ld	21251,a
1438                     ; 385 }
1441  01d3 85            	popw	x
1442  01d4 81            	ret	
1478                     ; 394 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1478                     ; 395 {
1479                     	switch	.text
1480  01d5               _TIM2_UpdateDisableConfig:
1484                     ; 397     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1486                     ; 400     if (NewState != DISABLE)
1488  01d5 4d            	tnz	a
1489  01d6 2705          	jreq	L506
1490                     ; 402         TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1492  01d8 72125300      	bset	21248,#1
1495  01dc 81            	ret	
1496  01dd               L506:
1497                     ; 406         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1499  01dd 72135300      	bres	21248,#1
1500                     ; 408 }
1503  01e1 81            	ret	
1561                     ; 418 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1561                     ; 419 {
1562                     	switch	.text
1563  01e2               _TIM2_UpdateRequestConfig:
1567                     ; 421     assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1569                     ; 424     if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1571  01e2 4d            	tnz	a
1572  01e3 2705          	jreq	L736
1573                     ; 426         TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
1575  01e5 72145300      	bset	21248,#2
1578  01e9 81            	ret	
1579  01ea               L736:
1580                     ; 430         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
1582  01ea 72155300      	bres	21248,#2
1583                     ; 432 }
1586  01ee 81            	ret	
1643                     ; 443 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1643                     ; 444 {
1644                     	switch	.text
1645  01ef               _TIM2_SelectOnePulseMode:
1649                     ; 446     assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1651                     ; 449     if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1653  01ef 4d            	tnz	a
1654  01f0 2705          	jreq	L176
1655                     ; 451         TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
1657  01f2 72165300      	bset	21248,#3
1660  01f6 81            	ret	
1661  01f7               L176:
1662                     ; 455         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
1664  01f7 72175300      	bres	21248,#3
1665                     ; 458 }
1668  01fb 81            	ret	
1736                     ; 489 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
1736                     ; 490                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
1736                     ; 491 {
1737                     	switch	.text
1738  01fc               _TIM2_PrescalerConfig:
1742                     ; 493     assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
1744                     ; 494     assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
1746                     ; 497     TIM2->PSCR = (uint8_t)Prescaler;
1748  01fc 9e            	ld	a,xh
1749  01fd c7530e        	ld	21262,a
1750                     ; 500     TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
1752  0200 9f            	ld	a,xl
1753  0201 c75306        	ld	21254,a
1754                     ; 501 }
1757  0204 81            	ret	
1815                     ; 512 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1815                     ; 513 {
1816                     	switch	.text
1817  0205               _TIM2_ForcedOC1Config:
1819  0205 88            	push	a
1820       00000000      OFST:	set	0
1823                     ; 515     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1825                     ; 518     TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
1825                     ; 519                               | (uint8_t)TIM2_ForcedAction);
1827  0206 c65307        	ld	a,21255
1828  0209 a48f          	and	a,#143
1829  020b 1a01          	or	a,(OFST+1,sp)
1830  020d c75307        	ld	21255,a
1831                     ; 520 }
1834  0210 84            	pop	a
1835  0211 81            	ret	
1871                     ; 531 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1871                     ; 532 {
1872                     	switch	.text
1873  0212               _TIM2_ForcedOC2Config:
1875  0212 88            	push	a
1876       00000000      OFST:	set	0
1879                     ; 534     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1881                     ; 537     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
1881                     ; 538                             | (uint8_t)TIM2_ForcedAction);
1883  0213 c65308        	ld	a,21256
1884  0216 a48f          	and	a,#143
1885  0218 1a01          	or	a,(OFST+1,sp)
1886  021a c75308        	ld	21256,a
1887                     ; 539 }
1890  021d 84            	pop	a
1891  021e 81            	ret	
1927                     ; 550 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1927                     ; 551 {
1928                     	switch	.text
1929  021f               _TIM2_ForcedOC3Config:
1931  021f 88            	push	a
1932       00000000      OFST:	set	0
1935                     ; 553     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1937                     ; 556     TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
1937                     ; 557                               | (uint8_t)TIM2_ForcedAction);
1939  0220 c65309        	ld	a,21257
1940  0223 a48f          	and	a,#143
1941  0225 1a01          	or	a,(OFST+1,sp)
1942  0227 c75309        	ld	21257,a
1943                     ; 558 }
1946  022a 84            	pop	a
1947  022b 81            	ret	
1983                     ; 567 void TIM2_ARRPreloadConfig(FunctionalState NewState)
1983                     ; 568 {
1984                     	switch	.text
1985  022c               _TIM2_ARRPreloadConfig:
1989                     ; 570     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1991                     ; 573     if (NewState != DISABLE)
1993  022c 4d            	tnz	a
1994  022d 2705          	jreq	L7201
1995                     ; 575         TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
1997  022f 721e5300      	bset	21248,#7
2000  0233 81            	ret	
2001  0234               L7201:
2002                     ; 579         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
2004  0234 721f5300      	bres	21248,#7
2005                     ; 581 }
2008  0238 81            	ret	
2044                     ; 590 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2044                     ; 591 {
2045                     	switch	.text
2046  0239               _TIM2_OC1PreloadConfig:
2050                     ; 593     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2052                     ; 596     if (NewState != DISABLE)
2054  0239 4d            	tnz	a
2055  023a 2705          	jreq	L1501
2056                     ; 598         TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2058  023c 72165307      	bset	21255,#3
2061  0240 81            	ret	
2062  0241               L1501:
2063                     ; 602         TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2065  0241 72175307      	bres	21255,#3
2066                     ; 604 }
2069  0245 81            	ret	
2105                     ; 613 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2105                     ; 614 {
2106                     	switch	.text
2107  0246               _TIM2_OC2PreloadConfig:
2111                     ; 616     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2113                     ; 619     if (NewState != DISABLE)
2115  0246 4d            	tnz	a
2116  0247 2705          	jreq	L3701
2117                     ; 621         TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2119  0249 72165308      	bset	21256,#3
2122  024d 81            	ret	
2123  024e               L3701:
2124                     ; 625         TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2126  024e 72175308      	bres	21256,#3
2127                     ; 627 }
2130  0252 81            	ret	
2166                     ; 636 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2166                     ; 637 {
2167                     	switch	.text
2168  0253               _TIM2_OC3PreloadConfig:
2172                     ; 639     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2174                     ; 642     if (NewState != DISABLE)
2176  0253 4d            	tnz	a
2177  0254 2705          	jreq	L5111
2178                     ; 644         TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2180  0256 72165309      	bset	21257,#3
2183  025a 81            	ret	
2184  025b               L5111:
2185                     ; 648         TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2187  025b 72175309      	bres	21257,#3
2188                     ; 650 }
2191  025f 81            	ret	
2264                     ; 663 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2264                     ; 664 {
2265                     	switch	.text
2266  0260               _TIM2_GenerateEvent:
2270                     ; 666     assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2272                     ; 669     TIM2->EGR = (uint8_t)TIM2_EventSource;
2274  0260 c75306        	ld	21254,a
2275                     ; 670 }
2278  0263 81            	ret	
2314                     ; 681 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2314                     ; 682 {
2315                     	switch	.text
2316  0264               _TIM2_OC1PolarityConfig:
2320                     ; 684     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2322                     ; 687     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2324  0264 4d            	tnz	a
2325  0265 2705          	jreq	L1711
2326                     ; 689         TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
2328  0267 7212530a      	bset	21258,#1
2331  026b 81            	ret	
2332  026c               L1711:
2333                     ; 693         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
2335  026c 7213530a      	bres	21258,#1
2336                     ; 695 }
2339  0270 81            	ret	
2375                     ; 706 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2375                     ; 707 {
2376                     	switch	.text
2377  0271               _TIM2_OC2PolarityConfig:
2381                     ; 709     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2383                     ; 712     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2385  0271 4d            	tnz	a
2386  0272 2705          	jreq	L3121
2387                     ; 714         TIM2->CCER1 |= TIM2_CCER1_CC2P;
2389  0274 721a530a      	bset	21258,#5
2392  0278 81            	ret	
2393  0279               L3121:
2394                     ; 718         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
2396  0279 721b530a      	bres	21258,#5
2397                     ; 720 }
2400  027d 81            	ret	
2436                     ; 731 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2436                     ; 732 {
2437                     	switch	.text
2438  027e               _TIM2_OC3PolarityConfig:
2442                     ; 734     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2444                     ; 737     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2446  027e 4d            	tnz	a
2447  027f 2705          	jreq	L5321
2448                     ; 739         TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
2450  0281 7212530b      	bset	21259,#1
2453  0285 81            	ret	
2454  0286               L5321:
2455                     ; 743         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
2457  0286 7213530b      	bres	21259,#1
2458                     ; 745 }
2461  028a 81            	ret	
2506                     ; 759 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
2506                     ; 760 {
2507                     	switch	.text
2508  028b               _TIM2_CCxCmd:
2510  028b 89            	pushw	x
2511       00000000      OFST:	set	0
2514                     ; 762     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2516                     ; 763     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2518                     ; 765     if (TIM2_Channel == TIM2_CHANNEL_1)
2520  028c 9e            	ld	a,xh
2521  028d 4d            	tnz	a
2522  028e 2610          	jrne	L3621
2523                     ; 768         if (NewState != DISABLE)
2525  0290 9f            	ld	a,xl
2526  0291 4d            	tnz	a
2527  0292 2706          	jreq	L5621
2528                     ; 770             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
2530  0294 7210530a      	bset	21258,#0
2532  0298 2029          	jra	L1721
2533  029a               L5621:
2534                     ; 774             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2536  029a 7211530a      	bres	21258,#0
2537  029e 2023          	jra	L1721
2538  02a0               L3621:
2539                     ; 778     else if (TIM2_Channel == TIM2_CHANNEL_2)
2541  02a0 7b01          	ld	a,(OFST+1,sp)
2542  02a2 4a            	dec	a
2543  02a3 2610          	jrne	L3721
2544                     ; 781         if (NewState != DISABLE)
2546  02a5 7b02          	ld	a,(OFST+2,sp)
2547  02a7 2706          	jreq	L5721
2548                     ; 783             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
2550  02a9 7218530a      	bset	21258,#4
2552  02ad 2014          	jra	L1721
2553  02af               L5721:
2554                     ; 787             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2556  02af 7219530a      	bres	21258,#4
2557  02b3 200e          	jra	L1721
2558  02b5               L3721:
2559                     ; 793         if (NewState != DISABLE)
2561  02b5 7b02          	ld	a,(OFST+2,sp)
2562  02b7 2706          	jreq	L3031
2563                     ; 795             TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
2565  02b9 7210530b      	bset	21259,#0
2567  02bd 2004          	jra	L1721
2568  02bf               L3031:
2569                     ; 799             TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2571  02bf 7211530b      	bres	21259,#0
2572  02c3               L1721:
2573                     ; 802 }
2576  02c3 85            	popw	x
2577  02c4 81            	ret	
2622                     ; 824 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
2622                     ; 825 {
2623                     	switch	.text
2624  02c5               _TIM2_SelectOCxM:
2626  02c5 89            	pushw	x
2627       00000000      OFST:	set	0
2630                     ; 827     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2632                     ; 828     assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
2634                     ; 830     if (TIM2_Channel == TIM2_CHANNEL_1)
2636  02c6 9e            	ld	a,xh
2637  02c7 4d            	tnz	a
2638  02c8 2610          	jrne	L1331
2639                     ; 833         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
2641  02ca 7211530a      	bres	21258,#0
2642                     ; 836         TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
2642                     ; 837                                | (uint8_t)TIM2_OCMode);
2644  02ce c65307        	ld	a,21255
2645  02d1 a48f          	and	a,#143
2646  02d3 1a02          	or	a,(OFST+2,sp)
2647  02d5 c75307        	ld	21255,a
2649  02d8 2023          	jra	L3331
2650  02da               L1331:
2651                     ; 839     else if (TIM2_Channel == TIM2_CHANNEL_2)
2653  02da 7b01          	ld	a,(OFST+1,sp)
2654  02dc 4a            	dec	a
2655  02dd 2610          	jrne	L5331
2656                     ; 842         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
2658  02df 7219530a      	bres	21258,#4
2659                     ; 845         TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
2659                     ; 846                                 | (uint8_t)TIM2_OCMode);
2661  02e3 c65308        	ld	a,21256
2662  02e6 a48f          	and	a,#143
2663  02e8 1a02          	or	a,(OFST+2,sp)
2664  02ea c75308        	ld	21256,a
2666  02ed 200e          	jra	L3331
2667  02ef               L5331:
2668                     ; 851         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
2670  02ef 7211530b      	bres	21259,#0
2671                     ; 854         TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2671                     ; 855                                 | (uint8_t)TIM2_OCMode);
2673  02f3 c65309        	ld	a,21257
2674  02f6 a48f          	and	a,#143
2675  02f8 1a02          	or	a,(OFST+2,sp)
2676  02fa c75309        	ld	21257,a
2677  02fd               L3331:
2678                     ; 857 }
2681  02fd 85            	popw	x
2682  02fe 81            	ret	
2716                     ; 866 void TIM2_SetCounter(uint16_t Counter)
2716                     ; 867 {
2717                     	switch	.text
2718  02ff               _TIM2_SetCounter:
2722                     ; 869     TIM2->CNTRH = (uint8_t)(Counter >> 8);
2724  02ff 9e            	ld	a,xh
2725  0300 c7530c        	ld	21260,a
2726                     ; 870     TIM2->CNTRL = (uint8_t)(Counter);
2728  0303 9f            	ld	a,xl
2729  0304 c7530d        	ld	21261,a
2730                     ; 872 }
2733  0307 81            	ret	
2767                     ; 881 void TIM2_SetAutoreload(uint16_t Autoreload)
2767                     ; 882 {
2768                     	switch	.text
2769  0308               _TIM2_SetAutoreload:
2773                     ; 885     TIM2->ARRH = (uint8_t)(Autoreload >> 8);
2775  0308 9e            	ld	a,xh
2776  0309 c7530f        	ld	21263,a
2777                     ; 886     TIM2->ARRL = (uint8_t)(Autoreload);
2779  030c 9f            	ld	a,xl
2780  030d c75310        	ld	21264,a
2781                     ; 888 }
2784  0310 81            	ret	
2818                     ; 897 void TIM2_SetCompare1(uint16_t Compare1)
2818                     ; 898 {
2819                     	switch	.text
2820  0311               _TIM2_SetCompare1:
2824                     ; 900     TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
2826  0311 9e            	ld	a,xh
2827  0312 c75311        	ld	21265,a
2828                     ; 901     TIM2->CCR1L = (uint8_t)(Compare1);
2830  0315 9f            	ld	a,xl
2831  0316 c75312        	ld	21266,a
2832                     ; 903 }
2835  0319 81            	ret	
2869                     ; 912 void TIM2_SetCompare2(uint16_t Compare2)
2869                     ; 913 {
2870                     	switch	.text
2871  031a               _TIM2_SetCompare2:
2875                     ; 915     TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
2877  031a 9e            	ld	a,xh
2878  031b c75313        	ld	21267,a
2879                     ; 916     TIM2->CCR2L = (uint8_t)(Compare2);
2881  031e 9f            	ld	a,xl
2882  031f c75314        	ld	21268,a
2883                     ; 918 }
2886  0322 81            	ret	
2920                     ; 927 void TIM2_SetCompare3(uint16_t Compare3)
2920                     ; 928 {
2921                     	switch	.text
2922  0323               _TIM2_SetCompare3:
2926                     ; 930     TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
2928  0323 9e            	ld	a,xh
2929  0324 c75315        	ld	21269,a
2930                     ; 931     TIM2->CCR3L = (uint8_t)(Compare3);
2932  0327 9f            	ld	a,xl
2933  0328 c75316        	ld	21270,a
2934                     ; 933 }
2937  032b 81            	ret	
2973                     ; 946 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
2973                     ; 947 {
2974                     	switch	.text
2975  032c               _TIM2_SetIC1Prescaler:
2977  032c 88            	push	a
2978       00000000      OFST:	set	0
2981                     ; 949     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
2983                     ; 952     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
2983                     ; 953                             | (uint8_t)TIM2_IC1Prescaler);
2985  032d c65307        	ld	a,21255
2986  0330 a4f3          	and	a,#243
2987  0332 1a01          	or	a,(OFST+1,sp)
2988  0334 c75307        	ld	21255,a
2989                     ; 954 }
2992  0337 84            	pop	a
2993  0338 81            	ret	
3029                     ; 966 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3029                     ; 967 {
3030                     	switch	.text
3031  0339               _TIM2_SetIC2Prescaler:
3033  0339 88            	push	a
3034       00000000      OFST:	set	0
3037                     ; 969     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3039                     ; 972     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3039                     ; 973                             | (uint8_t)TIM2_IC2Prescaler);
3041  033a c65308        	ld	a,21256
3042  033d a4f3          	and	a,#243
3043  033f 1a01          	or	a,(OFST+1,sp)
3044  0341 c75308        	ld	21256,a
3045                     ; 974 }
3048  0344 84            	pop	a
3049  0345 81            	ret	
3085                     ; 986 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3085                     ; 987 {
3086                     	switch	.text
3087  0346               _TIM2_SetIC3Prescaler:
3089  0346 88            	push	a
3090       00000000      OFST:	set	0
3093                     ; 990     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3095                     ; 992     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3095                     ; 993                             | (uint8_t)TIM2_IC3Prescaler);
3097  0347 c65309        	ld	a,21257
3098  034a a4f3          	and	a,#243
3099  034c 1a01          	or	a,(OFST+1,sp)
3100  034e c75309        	ld	21257,a
3101                     ; 994 }
3104  0351 84            	pop	a
3105  0352 81            	ret	
3157                     ; 1001 uint16_t TIM2_GetCapture1(void)
3157                     ; 1002 {
3158                     	switch	.text
3159  0353               _TIM2_GetCapture1:
3161  0353 5204          	subw	sp,#4
3162       00000004      OFST:	set	4
3165                     ; 1004     uint16_t tmpccr1 = 0;
3167                     ; 1005     uint8_t tmpccr1l=0, tmpccr1h=0;
3171                     ; 1007     tmpccr1h = TIM2->CCR1H;
3173  0355 c65311        	ld	a,21265
3174  0358 6b02          	ld	(OFST-2,sp),a
3175                     ; 1008     tmpccr1l = TIM2->CCR1L;
3177  035a c65312        	ld	a,21266
3178  035d 6b01          	ld	(OFST-3,sp),a
3179                     ; 1010     tmpccr1 = (uint16_t)(tmpccr1l);
3181  035f 5f            	clrw	x
3182  0360 97            	ld	xl,a
3183  0361 1f03          	ldw	(OFST-1,sp),x
3184                     ; 1011     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3186  0363 5f            	clrw	x
3187  0364 7b02          	ld	a,(OFST-2,sp)
3188  0366 97            	ld	xl,a
3189  0367 7b04          	ld	a,(OFST+0,sp)
3190  0369 01            	rrwa	x,a
3191  036a 1a03          	or	a,(OFST-1,sp)
3192  036c 01            	rrwa	x,a
3193                     ; 1013     return (uint16_t)tmpccr1;
3197  036d 5b04          	addw	sp,#4
3198  036f 81            	ret	
3250                     ; 1021 uint16_t TIM2_GetCapture2(void)
3250                     ; 1022 {
3251                     	switch	.text
3252  0370               _TIM2_GetCapture2:
3254  0370 5204          	subw	sp,#4
3255       00000004      OFST:	set	4
3258                     ; 1024     uint16_t tmpccr2 = 0;
3260                     ; 1025     uint8_t tmpccr2l=0, tmpccr2h=0;
3264                     ; 1027     tmpccr2h = TIM2->CCR2H;
3266  0372 c65313        	ld	a,21267
3267  0375 6b02          	ld	(OFST-2,sp),a
3268                     ; 1028     tmpccr2l = TIM2->CCR2L;
3270  0377 c65314        	ld	a,21268
3271  037a 6b01          	ld	(OFST-3,sp),a
3272                     ; 1030     tmpccr2 = (uint16_t)(tmpccr2l);
3274  037c 5f            	clrw	x
3275  037d 97            	ld	xl,a
3276  037e 1f03          	ldw	(OFST-1,sp),x
3277                     ; 1031     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3279  0380 5f            	clrw	x
3280  0381 7b02          	ld	a,(OFST-2,sp)
3281  0383 97            	ld	xl,a
3282  0384 7b04          	ld	a,(OFST+0,sp)
3283  0386 01            	rrwa	x,a
3284  0387 1a03          	or	a,(OFST-1,sp)
3285  0389 01            	rrwa	x,a
3286                     ; 1033     return (uint16_t)tmpccr2;
3290  038a 5b04          	addw	sp,#4
3291  038c 81            	ret	
3343                     ; 1041 uint16_t TIM2_GetCapture3(void)
3343                     ; 1042 {
3344                     	switch	.text
3345  038d               _TIM2_GetCapture3:
3347  038d 5204          	subw	sp,#4
3348       00000004      OFST:	set	4
3351                     ; 1044     uint16_t tmpccr3 = 0;
3353                     ; 1045     uint8_t tmpccr3l=0, tmpccr3h=0;
3357                     ; 1047     tmpccr3h = TIM2->CCR3H;
3359  038f c65315        	ld	a,21269
3360  0392 6b02          	ld	(OFST-2,sp),a
3361                     ; 1048     tmpccr3l = TIM2->CCR3L;
3363  0394 c65316        	ld	a,21270
3364  0397 6b01          	ld	(OFST-3,sp),a
3365                     ; 1050     tmpccr3 = (uint16_t)(tmpccr3l);
3367  0399 5f            	clrw	x
3368  039a 97            	ld	xl,a
3369  039b 1f03          	ldw	(OFST-1,sp),x
3370                     ; 1051     tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
3372  039d 5f            	clrw	x
3373  039e 7b02          	ld	a,(OFST-2,sp)
3374  03a0 97            	ld	xl,a
3375  03a1 7b04          	ld	a,(OFST+0,sp)
3376  03a3 01            	rrwa	x,a
3377  03a4 1a03          	or	a,(OFST-1,sp)
3378  03a6 01            	rrwa	x,a
3379                     ; 1053     return (uint16_t)tmpccr3;
3383  03a7 5b04          	addw	sp,#4
3384  03a9 81            	ret	
3418                     ; 1061 uint16_t TIM2_GetCounter(void)
3418                     ; 1062 {
3419                     	switch	.text
3420  03aa               _TIM2_GetCounter:
3422  03aa 89            	pushw	x
3423       00000002      OFST:	set	2
3426                     ; 1063      uint16_t tmpcntr = 0;
3428                     ; 1065     tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
3430  03ab c6530c        	ld	a,21260
3431  03ae 97            	ld	xl,a
3432  03af 4f            	clr	a
3433  03b0 02            	rlwa	x,a
3434  03b1 1f01          	ldw	(OFST-1,sp),x
3435                     ; 1067     return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
3437  03b3 5f            	clrw	x
3438  03b4 c6530d        	ld	a,21261
3439  03b7 97            	ld	xl,a
3440  03b8 01            	rrwa	x,a
3441  03b9 1a02          	or	a,(OFST+0,sp)
3442  03bb 01            	rrwa	x,a
3443  03bc 1a01          	or	a,(OFST-1,sp)
3444  03be 01            	rrwa	x,a
3447  03bf 5b02          	addw	sp,#2
3448  03c1 81            	ret	
3472                     ; 1076 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
3472                     ; 1077 {
3473                     	switch	.text
3474  03c2               _TIM2_GetPrescaler:
3478                     ; 1079     return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
3480  03c2 c6530e        	ld	a,21262
3483  03c5 81            	ret	
3622                     ; 1096 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3622                     ; 1097 {
3623                     	switch	.text
3624  03c6               _TIM2_GetFlagStatus:
3626  03c6 89            	pushw	x
3627  03c7 89            	pushw	x
3628       00000002      OFST:	set	2
3631                     ; 1098     FlagStatus bitstatus = RESET;
3633                     ; 1099     uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
3637                     ; 1102     assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
3639                     ; 1104     tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
3641  03c8 9f            	ld	a,xl
3642  03c9 c45304        	and	a,21252
3643  03cc 6b01          	ld	(OFST-1,sp),a
3644                     ; 1105     tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
3646  03ce 7b03          	ld	a,(OFST+1,sp)
3647  03d0 6b02          	ld	(OFST+0,sp),a
3648                     ; 1107     if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
3650  03d2 c45305        	and	a,21253
3651  03d5 1a01          	or	a,(OFST-1,sp)
3652  03d7 2702          	jreq	L5371
3653                     ; 1109         bitstatus = SET;
3655  03d9 a601          	ld	a,#1
3657  03db               L5371:
3658                     ; 1113         bitstatus = RESET;
3660                     ; 1115     return (FlagStatus)bitstatus;
3664  03db 5b04          	addw	sp,#4
3665  03dd 81            	ret	
3700                     ; 1132 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3700                     ; 1133 {
3701                     	switch	.text
3702  03de               _TIM2_ClearFlag:
3706                     ; 1135     assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
3708                     ; 1138     TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
3710  03de 9f            	ld	a,xl
3711  03df 43            	cpl	a
3712  03e0 c75304        	ld	21252,a
3713                     ; 1139     TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
3715  03e3 35ff5305      	mov	21253,#255
3716                     ; 1140 }
3719  03e7 81            	ret	
3783                     ; 1154 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
3783                     ; 1155 {
3784                     	switch	.text
3785  03e8               _TIM2_GetITStatus:
3787  03e8 88            	push	a
3788  03e9 89            	pushw	x
3789       00000002      OFST:	set	2
3792                     ; 1156     ITStatus bitstatus = RESET;
3794                     ; 1157     uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
3798                     ; 1160     assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
3800                     ; 1162     TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
3802  03ea c45304        	and	a,21252
3803  03ed 6b01          	ld	(OFST-1,sp),a
3804                     ; 1164     TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
3806  03ef c65303        	ld	a,21251
3807  03f2 1403          	and	a,(OFST+1,sp)
3808  03f4 6b02          	ld	(OFST+0,sp),a
3809                     ; 1166     if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
3811  03f6 7b01          	ld	a,(OFST-1,sp)
3812  03f8 2708          	jreq	L1102
3814  03fa 7b02          	ld	a,(OFST+0,sp)
3815  03fc 2704          	jreq	L1102
3816                     ; 1168         bitstatus = SET;
3818  03fe a601          	ld	a,#1
3820  0400 2001          	jra	L3102
3821  0402               L1102:
3822                     ; 1172         bitstatus = RESET;
3824  0402 4f            	clr	a
3825  0403               L3102:
3826                     ; 1174     return (ITStatus)(bitstatus);
3830  0403 5b03          	addw	sp,#3
3831  0405 81            	ret	
3867                     ; 1188 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
3867                     ; 1189 {
3868                     	switch	.text
3869  0406               _TIM2_ClearITPendingBit:
3873                     ; 1191     assert_param(IS_TIM2_IT_OK(TIM2_IT));
3875                     ; 1194     TIM2->SR1 = (uint8_t)(~TIM2_IT);
3877  0406 43            	cpl	a
3878  0407 c75304        	ld	21252,a
3879                     ; 1195 }
3882  040a 81            	ret	
3934                     ; 1214 static void TI1_Config(uint8_t TIM2_ICPolarity,
3934                     ; 1215                        uint8_t TIM2_ICSelection,
3934                     ; 1216                        uint8_t TIM2_ICFilter)
3934                     ; 1217 {
3935                     	switch	.text
3936  040b               L3_TI1_Config:
3938  040b 89            	pushw	x
3939       00000001      OFST:	set	1
3942                     ; 1219     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3944  040c 7211530a      	bres	21258,#0
3945  0410 88            	push	a
3946                     ; 1222     TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
3946                     ; 1223                              | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
3948  0411 7b06          	ld	a,(OFST+5,sp)
3949  0413 97            	ld	xl,a
3950  0414 a610          	ld	a,#16
3951  0416 42            	mul	x,a
3952  0417 9f            	ld	a,xl
3953  0418 1a03          	or	a,(OFST+2,sp)
3954  041a 6b01          	ld	(OFST+0,sp),a
3955  041c c65307        	ld	a,21255
3956  041f a40c          	and	a,#12
3957  0421 1a01          	or	a,(OFST+0,sp)
3958  0423 c75307        	ld	21255,a
3959                     ; 1226     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
3961  0426 7b02          	ld	a,(OFST+1,sp)
3962  0428 2706          	jreq	L1602
3963                     ; 1228         TIM2->CCER1 |= TIM2_CCER1_CC1P;
3965  042a 7212530a      	bset	21258,#1
3967  042e 2004          	jra	L3602
3968  0430               L1602:
3969                     ; 1232         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
3971  0430 7213530a      	bres	21258,#1
3972  0434               L3602:
3973                     ; 1235     TIM2->CCER1 |= TIM2_CCER1_CC1E;
3975  0434 7210530a      	bset	21258,#0
3976                     ; 1236 }
3979  0438 5b03          	addw	sp,#3
3980  043a 81            	ret	
4032                     ; 1255 static void TI2_Config(uint8_t TIM2_ICPolarity,
4032                     ; 1256                        uint8_t TIM2_ICSelection,
4032                     ; 1257                        uint8_t TIM2_ICFilter)
4032                     ; 1258 {
4033                     	switch	.text
4034  043b               L5_TI2_Config:
4036  043b 89            	pushw	x
4037       00000001      OFST:	set	1
4040                     ; 1260     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
4042  043c 7219530a      	bres	21258,#4
4043  0440 88            	push	a
4044                     ; 1263     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
4044                     ; 1264                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4046  0441 7b06          	ld	a,(OFST+5,sp)
4047  0443 97            	ld	xl,a
4048  0444 a610          	ld	a,#16
4049  0446 42            	mul	x,a
4050  0447 9f            	ld	a,xl
4051  0448 1a03          	or	a,(OFST+2,sp)
4052  044a 6b01          	ld	(OFST+0,sp),a
4053  044c c65308        	ld	a,21256
4054  044f a40c          	and	a,#12
4055  0451 1a01          	or	a,(OFST+0,sp)
4056  0453 c75308        	ld	21256,a
4057                     ; 1268     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4059  0456 7b02          	ld	a,(OFST+1,sp)
4060  0458 2706          	jreq	L3112
4061                     ; 1270         TIM2->CCER1 |= TIM2_CCER1_CC2P;
4063  045a 721a530a      	bset	21258,#5
4065  045e 2004          	jra	L5112
4066  0460               L3112:
4067                     ; 1274         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
4069  0460 721b530a      	bres	21258,#5
4070  0464               L5112:
4071                     ; 1278     TIM2->CCER1 |= TIM2_CCER1_CC2E;
4073  0464 7218530a      	bset	21258,#4
4074                     ; 1280 }
4077  0468 5b03          	addw	sp,#3
4078  046a 81            	ret	
4130                     ; 1296 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
4130                     ; 1297                        uint8_t TIM2_ICFilter)
4130                     ; 1298 {
4131                     	switch	.text
4132  046b               L7_TI3_Config:
4134  046b 89            	pushw	x
4135       00000001      OFST:	set	1
4138                     ; 1300     TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
4140  046c 7211530b      	bres	21259,#0
4141  0470 88            	push	a
4142                     ; 1303     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
4142                     ; 1304                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4144  0471 7b06          	ld	a,(OFST+5,sp)
4145  0473 97            	ld	xl,a
4146  0474 a610          	ld	a,#16
4147  0476 42            	mul	x,a
4148  0477 9f            	ld	a,xl
4149  0478 1a03          	or	a,(OFST+2,sp)
4150  047a 6b01          	ld	(OFST+0,sp),a
4151  047c c65309        	ld	a,21257
4152  047f a40c          	and	a,#12
4153  0481 1a01          	or	a,(OFST+0,sp)
4154  0483 c75309        	ld	21257,a
4155                     ; 1308     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4157  0486 7b02          	ld	a,(OFST+1,sp)
4158  0488 2706          	jreq	L5412
4159                     ; 1310         TIM2->CCER2 |= TIM2_CCER2_CC3P;
4161  048a 7212530b      	bset	21259,#1
4163  048e 2004          	jra	L7412
4164  0490               L5412:
4165                     ; 1314         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
4167  0490 7213530b      	bres	21259,#1
4168  0494               L7412:
4169                     ; 1317     TIM2->CCER2 |= TIM2_CCER2_CC3E;
4171  0494 7210530b      	bset	21259,#0
4172                     ; 1318 }
4175  0498 5b03          	addw	sp,#3
4176  049a 81            	ret	
4189                     	xdef	_TIM2_ClearITPendingBit
4190                     	xdef	_TIM2_GetITStatus
4191                     	xdef	_TIM2_ClearFlag
4192                     	xdef	_TIM2_GetFlagStatus
4193                     	xdef	_TIM2_GetPrescaler
4194                     	xdef	_TIM2_GetCounter
4195                     	xdef	_TIM2_GetCapture3
4196                     	xdef	_TIM2_GetCapture2
4197                     	xdef	_TIM2_GetCapture1
4198                     	xdef	_TIM2_SetIC3Prescaler
4199                     	xdef	_TIM2_SetIC2Prescaler
4200                     	xdef	_TIM2_SetIC1Prescaler
4201                     	xdef	_TIM2_SetCompare3
4202                     	xdef	_TIM2_SetCompare2
4203                     	xdef	_TIM2_SetCompare1
4204                     	xdef	_TIM2_SetAutoreload
4205                     	xdef	_TIM2_SetCounter
4206                     	xdef	_TIM2_SelectOCxM
4207                     	xdef	_TIM2_CCxCmd
4208                     	xdef	_TIM2_OC3PolarityConfig
4209                     	xdef	_TIM2_OC2PolarityConfig
4210                     	xdef	_TIM2_OC1PolarityConfig
4211                     	xdef	_TIM2_GenerateEvent
4212                     	xdef	_TIM2_OC3PreloadConfig
4213                     	xdef	_TIM2_OC2PreloadConfig
4214                     	xdef	_TIM2_OC1PreloadConfig
4215                     	xdef	_TIM2_ARRPreloadConfig
4216                     	xdef	_TIM2_ForcedOC3Config
4217                     	xdef	_TIM2_ForcedOC2Config
4218                     	xdef	_TIM2_ForcedOC1Config
4219                     	xdef	_TIM2_PrescalerConfig
4220                     	xdef	_TIM2_SelectOnePulseMode
4221                     	xdef	_TIM2_UpdateRequestConfig
4222                     	xdef	_TIM2_UpdateDisableConfig
4223                     	xdef	_TIM2_ITConfig
4224                     	xdef	_TIM2_Cmd
4225                     	xdef	_TIM2_PWMIConfig
4226                     	xdef	_TIM2_ICInit
4227                     	xdef	_TIM2_OC3Init
4228                     	xdef	_TIM2_OC2Init
4229                     	xdef	_TIM2_OC1Init
4230                     	xdef	_TIM2_TimeBaseInit
4231                     	xdef	_TIM2_DeInit
4250                     	end
