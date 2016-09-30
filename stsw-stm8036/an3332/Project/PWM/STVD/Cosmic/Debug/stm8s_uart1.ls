   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  48                     ; 46 void UART1_DeInit(void)
  48                     ; 47 {
  50                     .text:	section	.text,new
  51  0000               _UART1_DeInit:
  55                     ; 50     (void)UART1->SR;
  57  0000 c65230        	ld	a,21040
  58                     ; 51     (void)UART1->DR;
  60  0003 c65231        	ld	a,21041
  61                     ; 53     UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /* Set UART1_BRR2 to reset value 0x00 */
  63  0006 725f5233      	clr	21043
  64                     ; 54     UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /* Set UART1_BRR1 to reset value 0x00 */
  66  000a 725f5232      	clr	21042
  67                     ; 56     UART1->CR1 = UART1_CR1_RESET_VALUE;  /* Set UART1_CR1 to reset value 0x00 */
  69  000e 725f5234      	clr	21044
  70                     ; 57     UART1->CR2 = UART1_CR2_RESET_VALUE;  /* Set UART1_CR2 to reset value 0x00 */
  72  0012 725f5235      	clr	21045
  73                     ; 58     UART1->CR3 = UART1_CR3_RESET_VALUE;  /* Set UART1_CR3 to reset value 0x00 */
  75  0016 725f5236      	clr	21046
  76                     ; 59     UART1->CR4 = UART1_CR4_RESET_VALUE;  /* Set UART1_CR4 to reset value 0x00 */
  78  001a 725f5237      	clr	21047
  79                     ; 60     UART1->CR5 = UART1_CR5_RESET_VALUE;  /* Set UART1_CR5 to reset value 0x00 */
  81  001e 725f5238      	clr	21048
  82                     ; 62     UART1->GTR = UART1_GTR_RESET_VALUE;
  84  0022 725f5239      	clr	21049
  85                     ; 63     UART1->PSCR = UART1_PSCR_RESET_VALUE;
  87  0026 725f523a      	clr	21050
  88                     ; 64 }
  91  002a 81            	ret	
 394                     .const:	section	.text
 395  0000               L41:
 396  0000 00000064      	dc.l	100
 397                     ; 83 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 397                     ; 84                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 397                     ; 85                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 397                     ; 86 {
 398                     .text:	section	.text,new
 399  0000               _UART1_Init:
 401       0000000c      OFST:	set	12
 404                     ; 87     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 408                     ; 90     assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 410                     ; 91     assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 412                     ; 92     assert_param(IS_UART1_STOPBITS_OK(StopBits));
 414                     ; 93     assert_param(IS_UART1_PARITY_OK(Parity));
 416                     ; 94     assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 418                     ; 95     assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 420                     ; 98     UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 422  0000 72195234      	bres	21044,#4
 423  0004 520c          	subw	sp,#12
 424                     ; 101     UART1->CR1 |= (uint8_t)WordLength;
 426  0006 c65234        	ld	a,21044
 427  0009 1a13          	or	a,(OFST+7,sp)
 428  000b c75234        	ld	21044,a
 429                     ; 104     UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 431  000e c65236        	ld	a,21046
 432  0011 a4cf          	and	a,#207
 433  0013 c75236        	ld	21046,a
 434                     ; 106     UART1->CR3 |= (uint8_t)StopBits;  
 436  0016 c65236        	ld	a,21046
 437  0019 1a14          	or	a,(OFST+8,sp)
 438  001b c75236        	ld	21046,a
 439                     ; 109     UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 441  001e c65234        	ld	a,21044
 442  0021 a4f9          	and	a,#249
 443  0023 c75234        	ld	21044,a
 444                     ; 111     UART1->CR1 |= (uint8_t)Parity;  
 446  0026 c65234        	ld	a,21044
 447  0029 1a15          	or	a,(OFST+9,sp)
 448  002b c75234        	ld	21044,a
 449                     ; 114     UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 451  002e 725f5232      	clr	21042
 452                     ; 116     UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 454  0032 c65233        	ld	a,21043
 455  0035 a40f          	and	a,#15
 456  0037 c75233        	ld	21043,a
 457                     ; 118     UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 459  003a c65233        	ld	a,21043
 460  003d a4f0          	and	a,#240
 461  003f c75233        	ld	21043,a
 462                     ; 121     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 464  0042 96            	ldw	x,sp
 465  0043 cd011c        	call	LC001
 467  0046 96            	ldw	x,sp
 468  0047 5c            	incw	x
 469  0048 cd0000        	call	c_rtol
 471  004b cd0000        	call	_CLK_GetClockFreq
 473  004e 96            	ldw	x,sp
 474  004f 5c            	incw	x
 475  0050 cd0000        	call	c_ludv
 477  0053 96            	ldw	x,sp
 478  0054 1c0009        	addw	x,#OFST-3
 479  0057 cd0000        	call	c_rtol
 481                     ; 122     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 483  005a 96            	ldw	x,sp
 484  005b cd011c        	call	LC001
 486  005e 96            	ldw	x,sp
 487  005f 5c            	incw	x
 488  0060 cd0000        	call	c_rtol
 490  0063 cd0000        	call	_CLK_GetClockFreq
 492  0066 a664          	ld	a,#100
 493  0068 cd0000        	call	c_smul
 495  006b 96            	ldw	x,sp
 496  006c 5c            	incw	x
 497  006d cd0000        	call	c_ludv
 499  0070 96            	ldw	x,sp
 500  0071 1c0005        	addw	x,#OFST-7
 501  0074 cd0000        	call	c_rtol
 503                     ; 124     UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 505  0077 96            	ldw	x,sp
 506  0078 1c0009        	addw	x,#OFST-3
 507  007b cd0000        	call	c_ltor
 509  007e a664          	ld	a,#100
 510  0080 cd0000        	call	c_smul
 512  0083 96            	ldw	x,sp
 513  0084 5c            	incw	x
 514  0085 cd0000        	call	c_rtol
 516  0088 96            	ldw	x,sp
 517  0089 1c0005        	addw	x,#OFST-7
 518  008c cd0000        	call	c_ltor
 520  008f 96            	ldw	x,sp
 521  0090 5c            	incw	x
 522  0091 cd0000        	call	c_lsub
 524  0094 a604          	ld	a,#4
 525  0096 cd0000        	call	c_llsh
 527  0099 ae0000        	ldw	x,#L41
 528  009c cd0000        	call	c_ludv
 530  009f b603          	ld	a,c_lreg+3
 531  00a1 a40f          	and	a,#15
 532  00a3 ca5233        	or	a,21043
 533  00a6 c75233        	ld	21043,a
 534                     ; 126     UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 536  00a9 96            	ldw	x,sp
 537  00aa 1c0009        	addw	x,#OFST-3
 538  00ad cd0000        	call	c_ltor
 540  00b0 a604          	ld	a,#4
 541  00b2 cd0000        	call	c_lursh
 543  00b5 b603          	ld	a,c_lreg+3
 544  00b7 a4f0          	and	a,#240
 545  00b9 b703          	ld	c_lreg+3,a
 546  00bb 3f02          	clr	c_lreg+2
 547  00bd 3f01          	clr	c_lreg+1
 548  00bf 3f00          	clr	c_lreg
 549  00c1 ca5233        	or	a,21043
 550  00c4 c75233        	ld	21043,a
 551                     ; 128     UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 553  00c7 c65232        	ld	a,21042
 554  00ca 1a0c          	or	a,(OFST+0,sp)
 555  00cc c75232        	ld	21042,a
 556                     ; 131     UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 558  00cf c65235        	ld	a,21045
 559  00d2 a4f3          	and	a,#243
 560  00d4 c75235        	ld	21045,a
 561                     ; 133     UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 563  00d7 c65236        	ld	a,21046
 564  00da a4f8          	and	a,#248
 565  00dc c75236        	ld	21046,a
 566                     ; 135     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 566                     ; 136                                               UART1_CR3_CPHA | UART1_CR3_LBCL));  
 568  00df 7b16          	ld	a,(OFST+10,sp)
 569  00e1 a407          	and	a,#7
 570  00e3 ca5236        	or	a,21046
 571  00e6 c75236        	ld	21046,a
 572                     ; 138     if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 574  00e9 7b17          	ld	a,(OFST+11,sp)
 575  00eb a504          	bcp	a,#4
 576  00ed 2706          	jreq	L371
 577                     ; 141         UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 579  00ef 72165235      	bset	21045,#3
 581  00f3 2004          	jra	L571
 582  00f5               L371:
 583                     ; 146         UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 585  00f5 72175235      	bres	21045,#3
 586  00f9               L571:
 587                     ; 148     if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 589  00f9 a508          	bcp	a,#8
 590  00fb 2706          	jreq	L771
 591                     ; 151         UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 593  00fd 72145235      	bset	21045,#2
 595  0101 2004          	jra	L102
 596  0103               L771:
 597                     ; 156         UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 599  0103 72155235      	bres	21045,#2
 600  0107               L102:
 601                     ; 160     if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 603  0107 7b16          	ld	a,(OFST+10,sp)
 604  0109 2a06          	jrpl	L302
 605                     ; 163         UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 607  010b 72175236      	bres	21046,#3
 609  010f 2008          	jra	L502
 610  0111               L302:
 611                     ; 167         UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 613  0111 a408          	and	a,#8
 614  0113 ca5236        	or	a,21046
 615  0116 c75236        	ld	21046,a
 616  0119               L502:
 617                     ; 169 }
 620  0119 5b0c          	addw	sp,#12
 621  011b 81            	ret	
 622  011c               LC001:
 623  011c 1c000f        	addw	x,#OFST+3
 624  011f cd0000        	call	c_ltor
 626  0122 a604          	ld	a,#4
 627  0124 cc0000        	jp	c_llsh
 682                     ; 177 void UART1_Cmd(FunctionalState NewState)
 682                     ; 178 {
 683                     .text:	section	.text,new
 684  0000               _UART1_Cmd:
 688                     ; 179     if (NewState != DISABLE)
 690  0000 4d            	tnz	a
 691  0001 2705          	jreq	L532
 692                     ; 182         UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 694  0003 721b5234      	bres	21044,#5
 697  0007 81            	ret	
 698  0008               L532:
 699                     ; 187         UART1->CR1 |= UART1_CR1_UARTD;  
 701  0008 721a5234      	bset	21044,#5
 702                     ; 189 }
 705  000c 81            	ret	
 830                     ; 205 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 830                     ; 206 {
 831                     .text:	section	.text,new
 832  0000               _UART1_ITConfig:
 834  0000 89            	pushw	x
 835  0001 89            	pushw	x
 836       00000002      OFST:	set	2
 839                     ; 207     uint8_t uartreg = 0, itpos = 0x00;
 843                     ; 210     assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 845                     ; 211     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 847                     ; 214     uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
 849  0002 9e            	ld	a,xh
 850  0003 6b01          	ld	(OFST-1,sp),a
 851                     ; 216     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
 853  0005 9f            	ld	a,xl
 854  0006 a40f          	and	a,#15
 855  0008 5f            	clrw	x
 856  0009 97            	ld	xl,a
 857  000a a601          	ld	a,#1
 858  000c 5d            	tnzw	x
 859  000d 2704          	jreq	L22
 860  000f               L42:
 861  000f 48            	sll	a
 862  0010 5a            	decw	x
 863  0011 26fc          	jrne	L42
 864  0013               L22:
 865  0013 6b02          	ld	(OFST+0,sp),a
 866                     ; 218     if (NewState != DISABLE)
 868  0015 7b07          	ld	a,(OFST+5,sp)
 869  0017 271f          	jreq	L713
 870                     ; 221         if (uartreg == 0x01)
 872  0019 7b01          	ld	a,(OFST-1,sp)
 873  001b a101          	cp	a,#1
 874  001d 2607          	jrne	L123
 875                     ; 223             UART1->CR1 |= itpos;
 877  001f c65234        	ld	a,21044
 878  0022 1a02          	or	a,(OFST+0,sp)
 880  0024 201e          	jp	LC003
 881  0026               L123:
 882                     ; 225         else if (uartreg == 0x02)
 884  0026 a102          	cp	a,#2
 885  0028 2607          	jrne	L523
 886                     ; 227             UART1->CR2 |= itpos;
 888  002a c65235        	ld	a,21045
 889  002d 1a02          	or	a,(OFST+0,sp)
 891  002f 2022          	jp	LC004
 892  0031               L523:
 893                     ; 231             UART1->CR4 |= itpos;
 895  0031 c65237        	ld	a,21047
 896  0034 1a02          	or	a,(OFST+0,sp)
 897  0036 2026          	jp	LC002
 898  0038               L713:
 899                     ; 237         if (uartreg == 0x01)
 901  0038 7b01          	ld	a,(OFST-1,sp)
 902  003a a101          	cp	a,#1
 903  003c 260b          	jrne	L333
 904                     ; 239             UART1->CR1 &= (uint8_t)(~itpos);
 906  003e 7b02          	ld	a,(OFST+0,sp)
 907  0040 43            	cpl	a
 908  0041 c45234        	and	a,21044
 909  0044               LC003:
 910  0044 c75234        	ld	21044,a
 912  0047 2018          	jra	L133
 913  0049               L333:
 914                     ; 241         else if (uartreg == 0x02)
 916  0049 a102          	cp	a,#2
 917  004b 260b          	jrne	L733
 918                     ; 243             UART1->CR2 &= (uint8_t)(~itpos);
 920  004d 7b02          	ld	a,(OFST+0,sp)
 921  004f 43            	cpl	a
 922  0050 c45235        	and	a,21045
 923  0053               LC004:
 924  0053 c75235        	ld	21045,a
 926  0056 2009          	jra	L133
 927  0058               L733:
 928                     ; 247             UART1->CR4 &= (uint8_t)(~itpos);
 930  0058 7b02          	ld	a,(OFST+0,sp)
 931  005a 43            	cpl	a
 932  005b c45237        	and	a,21047
 933  005e               LC002:
 934  005e c75237        	ld	21047,a
 935  0061               L133:
 936                     ; 251 }
 939  0061 5b04          	addw	sp,#4
 940  0063 81            	ret	
 976                     ; 258 void UART1_HalfDuplexCmd(FunctionalState NewState)
 976                     ; 259 {
 977                     .text:	section	.text,new
 978  0000               _UART1_HalfDuplexCmd:
 982                     ; 260     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 984                     ; 262     if (NewState != DISABLE)
 986  0000 4d            	tnz	a
 987  0001 2705          	jreq	L163
 988                     ; 264         UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 990  0003 72165238      	bset	21048,#3
 993  0007 81            	ret	
 994  0008               L163:
 995                     ; 268         UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 997  0008 72175238      	bres	21048,#3
 998                     ; 270 }
1001  000c 81            	ret	
1058                     ; 278 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1058                     ; 279 {
1059                     .text:	section	.text,new
1060  0000               _UART1_IrDAConfig:
1064                     ; 280     assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1066                     ; 282     if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1068  0000 4d            	tnz	a
1069  0001 2705          	jreq	L314
1070                     ; 284         UART1->CR5 |= UART1_CR5_IRLP;
1072  0003 72145238      	bset	21048,#2
1075  0007 81            	ret	
1076  0008               L314:
1077                     ; 288         UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1079  0008 72155238      	bres	21048,#2
1080                     ; 290 }
1083  000c 81            	ret	
1118                     ; 298 void UART1_IrDACmd(FunctionalState NewState)
1118                     ; 299 {
1119                     .text:	section	.text,new
1120  0000               _UART1_IrDACmd:
1124                     ; 302     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1126                     ; 304     if (NewState != DISABLE)
1128  0000 4d            	tnz	a
1129  0001 2705          	jreq	L534
1130                     ; 307         UART1->CR5 |= UART1_CR5_IREN;
1132  0003 72125238      	bset	21048,#1
1135  0007 81            	ret	
1136  0008               L534:
1137                     ; 312         UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1139  0008 72135238      	bres	21048,#1
1140                     ; 314 }
1143  000c 81            	ret	
1202                     ; 323 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1202                     ; 324 {
1203                     .text:	section	.text,new
1204  0000               _UART1_LINBreakDetectionConfig:
1208                     ; 325     assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1210                     ; 327     if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1212  0000 4d            	tnz	a
1213  0001 2705          	jreq	L764
1214                     ; 329         UART1->CR4 |= UART1_CR4_LBDL;
1216  0003 721a5237      	bset	21047,#5
1219  0007 81            	ret	
1220  0008               L764:
1221                     ; 333         UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1223  0008 721b5237      	bres	21047,#5
1224                     ; 335 }
1227  000c 81            	ret	
1262                     ; 343 void UART1_LINCmd(FunctionalState NewState)
1262                     ; 344 {
1263                     .text:	section	.text,new
1264  0000               _UART1_LINCmd:
1268                     ; 345     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1270                     ; 347     if (NewState != DISABLE)
1272  0000 4d            	tnz	a
1273  0001 2705          	jreq	L115
1274                     ; 350         UART1->CR3 |= UART1_CR3_LINEN;
1276  0003 721c5236      	bset	21046,#6
1279  0007 81            	ret	
1280  0008               L115:
1281                     ; 355         UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1283  0008 721d5236      	bres	21046,#6
1284                     ; 357 }
1287  000c 81            	ret	
1322                     ; 364 void UART1_SmartCardCmd(FunctionalState NewState)
1322                     ; 365 {
1323                     .text:	section	.text,new
1324  0000               _UART1_SmartCardCmd:
1328                     ; 366     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1330                     ; 368     if (NewState != DISABLE)
1332  0000 4d            	tnz	a
1333  0001 2705          	jreq	L335
1334                     ; 371         UART1->CR5 |= UART1_CR5_SCEN;
1336  0003 721a5238      	bset	21048,#5
1339  0007 81            	ret	
1340  0008               L335:
1341                     ; 376         UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1343  0008 721b5238      	bres	21048,#5
1344                     ; 378 }
1347  000c 81            	ret	
1383                     ; 387 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1383                     ; 388 {
1384                     .text:	section	.text,new
1385  0000               _UART1_SmartCardNACKCmd:
1389                     ; 389     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1391                     ; 391     if (NewState != DISABLE)
1393  0000 4d            	tnz	a
1394  0001 2705          	jreq	L555
1395                     ; 394         UART1->CR5 |= UART1_CR5_NACK;
1397  0003 72185238      	bset	21048,#4
1400  0007 81            	ret	
1401  0008               L555:
1402                     ; 399         UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1404  0008 72195238      	bres	21048,#4
1405                     ; 401 }
1408  000c 81            	ret	
1465                     ; 409 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1465                     ; 410 {
1466                     .text:	section	.text,new
1467  0000               _UART1_WakeUpConfig:
1471                     ; 411     assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1473                     ; 413     UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1475  0000 72175234      	bres	21044,#3
1476                     ; 414     UART1->CR1 |= (uint8_t)UART1_WakeUp;
1478  0004 ca5234        	or	a,21044
1479  0007 c75234        	ld	21044,a
1480                     ; 415 }
1483  000a 81            	ret	
1519                     ; 422 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1519                     ; 423 {
1520                     .text:	section	.text,new
1521  0000               _UART1_ReceiverWakeUpCmd:
1525                     ; 424     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1527                     ; 426     if (NewState != DISABLE)
1529  0000 4d            	tnz	a
1530  0001 2705          	jreq	L526
1531                     ; 429         UART1->CR2 |= UART1_CR2_RWU;
1533  0003 72125235      	bset	21045,#1
1536  0007 81            	ret	
1537  0008               L526:
1538                     ; 434         UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1540  0008 72135235      	bres	21045,#1
1541                     ; 436 }
1544  000c 81            	ret	
1567                     ; 443 uint8_t UART1_ReceiveData8(void)
1567                     ; 444 {
1568                     .text:	section	.text,new
1569  0000               _UART1_ReceiveData8:
1573                     ; 445     return ((uint8_t)UART1->DR);
1575  0000 c65231        	ld	a,21041
1578  0003 81            	ret	
1612                     ; 453 uint16_t UART1_ReceiveData9(void)
1612                     ; 454 {
1613                     .text:	section	.text,new
1614  0000               _UART1_ReceiveData9:
1616  0000 89            	pushw	x
1617       00000002      OFST:	set	2
1620                     ; 455   uint16_t temp = 0;
1622                     ; 457   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
1624  0001 c65234        	ld	a,21044
1625  0004 a480          	and	a,#128
1626  0006 5f            	clrw	x
1627  0007 02            	rlwa	x,a
1628  0008 58            	sllw	x
1629  0009 1f01          	ldw	(OFST-1,sp),x
1630                     ; 458   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
1632  000b 5f            	clrw	x
1633  000c c65231        	ld	a,21041
1634  000f 97            	ld	xl,a
1635  0010 01            	rrwa	x,a
1636  0011 1a02          	or	a,(OFST+0,sp)
1637  0013 01            	rrwa	x,a
1638  0014 1a01          	or	a,(OFST-1,sp)
1639  0016 a401          	and	a,#1
1640  0018 01            	rrwa	x,a
1643  0019 5b02          	addw	sp,#2
1644  001b 81            	ret	
1678                     ; 466 void UART1_SendData8(uint8_t Data)
1678                     ; 467 {
1679                     .text:	section	.text,new
1680  0000               _UART1_SendData8:
1684                     ; 469     UART1->DR = Data;
1686  0000 c75231        	ld	21041,a
1687                     ; 470 }
1690  0003 81            	ret	
1724                     ; 478 void UART1_SendData9(uint16_t Data)
1724                     ; 479 {
1725                     .text:	section	.text,new
1726  0000               _UART1_SendData9:
1728  0000 89            	pushw	x
1729       00000000      OFST:	set	0
1732                     ; 481     UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
1734  0001 721d5234      	bres	21044,#6
1735                     ; 483     UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
1737  0005 54            	srlw	x
1738  0006 54            	srlw	x
1739  0007 9f            	ld	a,xl
1740  0008 a440          	and	a,#64
1741  000a ca5234        	or	a,21044
1742  000d c75234        	ld	21044,a
1743                     ; 485     UART1->DR   = (uint8_t)(Data);
1745  0010 7b02          	ld	a,(OFST+2,sp)
1746  0012 c75231        	ld	21041,a
1747                     ; 486 }
1750  0015 85            	popw	x
1751  0016 81            	ret	
1774                     ; 493 void UART1_SendBreak(void)
1774                     ; 494 {
1775                     .text:	section	.text,new
1776  0000               _UART1_SendBreak:
1780                     ; 495     UART1->CR2 |= UART1_CR2_SBK;
1782  0000 72105235      	bset	21045,#0
1783                     ; 496 }
1786  0004 81            	ret	
1820                     ; 503 void UART1_SetAddress(uint8_t UART1_Address)
1820                     ; 504 {
1821                     .text:	section	.text,new
1822  0000               _UART1_SetAddress:
1824  0000 88            	push	a
1825       00000000      OFST:	set	0
1828                     ; 506     assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1830                     ; 509     UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
1832  0001 c65237        	ld	a,21047
1833  0004 a4f0          	and	a,#240
1834  0006 c75237        	ld	21047,a
1835                     ; 511     UART1->CR4 |= UART1_Address;
1837  0009 c65237        	ld	a,21047
1838  000c 1a01          	or	a,(OFST+1,sp)
1839  000e c75237        	ld	21047,a
1840                     ; 512 }
1843  0011 84            	pop	a
1844  0012 81            	ret	
1878                     ; 520 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
1878                     ; 521 {
1879                     .text:	section	.text,new
1880  0000               _UART1_SetGuardTime:
1884                     ; 523     UART1->GTR = UART1_GuardTime;
1886  0000 c75239        	ld	21049,a
1887                     ; 524 }
1890  0003 81            	ret	
1924                     ; 548 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
1924                     ; 549 {
1925                     .text:	section	.text,new
1926  0000               _UART1_SetPrescaler:
1930                     ; 551     UART1->PSCR = UART1_Prescaler;
1932  0000 c7523a        	ld	21050,a
1933                     ; 552 }
1936  0003 81            	ret	
2079                     ; 560 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2079                     ; 561 {
2080                     .text:	section	.text,new
2081  0000               _UART1_GetFlagStatus:
2083  0000 89            	pushw	x
2084  0001 88            	push	a
2085       00000001      OFST:	set	1
2088                     ; 562     FlagStatus status = RESET;
2090                     ; 565     assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2092                     ; 569     if (UART1_FLAG == UART1_FLAG_LBDF)
2094  0002 a30210        	cpw	x,#528
2095  0005 2608          	jrne	L7501
2096                     ; 571         if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2098  0007 9f            	ld	a,xl
2099  0008 c45237        	and	a,21047
2100  000b 271e          	jreq	L5601
2101                     ; 574             status = SET;
2103  000d 2017          	jp	LC007
2104                     ; 579             status = RESET;
2105  000f               L7501:
2106                     ; 582     else if (UART1_FLAG == UART1_FLAG_SBK)
2108  000f 1e02          	ldw	x,(OFST+1,sp)
2109  0011 a30101        	cpw	x,#257
2110  0014 2609          	jrne	L7601
2111                     ; 584         if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2113  0016 c65235        	ld	a,21045
2114  0019 1503          	bcp	a,(OFST+2,sp)
2115  001b 270d          	jreq	L7701
2116                     ; 587             status = SET;
2118  001d 2007          	jp	LC007
2119                     ; 592             status = RESET;
2120  001f               L7601:
2121                     ; 597         if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2123  001f c65230        	ld	a,21040
2124  0022 1503          	bcp	a,(OFST+2,sp)
2125  0024 2704          	jreq	L7701
2126                     ; 600             status = SET;
2128  0026               LC007:
2131  0026 a601          	ld	a,#1
2134  0028 2001          	jra	L5601
2135  002a               L7701:
2136                     ; 605             status = RESET;
2139  002a 4f            	clr	a
2140  002b               L5601:
2141                     ; 609     return status;
2145  002b 5b03          	addw	sp,#3
2146  002d 81            	ret	
2181                     ; 639 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2181                     ; 640 {
2182                     .text:	section	.text,new
2183  0000               _UART1_ClearFlag:
2187                     ; 641     assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2189                     ; 644     if (UART1_FLAG == UART1_FLAG_RXNE)
2191  0000 a30020        	cpw	x,#32
2192  0003 2605          	jrne	L1211
2193                     ; 646         UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2195  0005 35df5230      	mov	21040,#223
2198  0009 81            	ret	
2199  000a               L1211:
2200                     ; 651         UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2202  000a 72195237      	bres	21047,#4
2203                     ; 653 }
2206  000e 81            	ret	
2288                     ; 668 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2288                     ; 669 {
2289                     .text:	section	.text,new
2290  0000               _UART1_GetITStatus:
2292  0000 89            	pushw	x
2293  0001 89            	pushw	x
2294       00000002      OFST:	set	2
2297                     ; 670     ITStatus pendingbitstatus = RESET;
2299                     ; 671     uint8_t itpos = 0;
2301                     ; 672     uint8_t itmask1 = 0;
2303                     ; 673     uint8_t itmask2 = 0;
2305                     ; 674     uint8_t enablestatus = 0;
2307                     ; 677     assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2309                     ; 680     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2311  0002 9f            	ld	a,xl
2312  0003 a40f          	and	a,#15
2313  0005 5f            	clrw	x
2314  0006 97            	ld	xl,a
2315  0007 a601          	ld	a,#1
2316  0009 5d            	tnzw	x
2317  000a 2704          	jreq	L67
2318  000c               L001:
2319  000c 48            	sll	a
2320  000d 5a            	decw	x
2321  000e 26fc          	jrne	L001
2322  0010               L67:
2323  0010 6b01          	ld	(OFST-1,sp),a
2324                     ; 682     itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2326  0012 7b04          	ld	a,(OFST+2,sp)
2327  0014 4e            	swap	a
2328  0015 a40f          	and	a,#15
2329  0017 6b02          	ld	(OFST+0,sp),a
2330                     ; 684     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2332  0019 5f            	clrw	x
2333  001a 97            	ld	xl,a
2334  001b a601          	ld	a,#1
2335  001d 5d            	tnzw	x
2336  001e 2704          	jreq	L201
2337  0020               L401:
2338  0020 48            	sll	a
2339  0021 5a            	decw	x
2340  0022 26fc          	jrne	L401
2341  0024               L201:
2342  0024 6b02          	ld	(OFST+0,sp),a
2343                     ; 688     if (UART1_IT == UART1_IT_PE)
2345  0026 1e03          	ldw	x,(OFST+1,sp)
2346  0028 a30100        	cpw	x,#256
2347  002b 260c          	jrne	L7611
2348                     ; 691         enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2350  002d c65234        	ld	a,21044
2351  0030 1402          	and	a,(OFST+0,sp)
2352  0032 6b02          	ld	(OFST+0,sp),a
2353                     ; 694         if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2355  0034 c65230        	ld	a,21040
2357                     ; 697             pendingbitstatus = SET;
2359  0037 200f          	jp	LC010
2360                     ; 702             pendingbitstatus = RESET;
2361  0039               L7611:
2362                     ; 706     else if (UART1_IT == UART1_IT_LBDF)
2364  0039 a30346        	cpw	x,#838
2365  003c 2616          	jrne	L7711
2366                     ; 709         enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2368  003e c65237        	ld	a,21047
2369  0041 1402          	and	a,(OFST+0,sp)
2370  0043 6b02          	ld	(OFST+0,sp),a
2371                     ; 711         if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2373  0045 c65237        	ld	a,21047
2375  0048               LC010:
2376  0048 1501          	bcp	a,(OFST-1,sp)
2377  004a 271a          	jreq	L7021
2378  004c 7b02          	ld	a,(OFST+0,sp)
2379  004e 2716          	jreq	L7021
2380                     ; 714             pendingbitstatus = SET;
2382  0050               LC009:
2385  0050 a601          	ld	a,#1
2387  0052 2013          	jra	L5711
2388                     ; 719             pendingbitstatus = RESET;
2389  0054               L7711:
2390                     ; 725         enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2392  0054 c65235        	ld	a,21045
2393  0057 1402          	and	a,(OFST+0,sp)
2394  0059 6b02          	ld	(OFST+0,sp),a
2395                     ; 727         if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2397  005b c65230        	ld	a,21040
2398  005e 1501          	bcp	a,(OFST-1,sp)
2399  0060 2704          	jreq	L7021
2401  0062 7b02          	ld	a,(OFST+0,sp)
2402                     ; 730             pendingbitstatus = SET;
2404  0064 26ea          	jrne	LC009
2405  0066               L7021:
2406                     ; 735             pendingbitstatus = RESET;
2410  0066 4f            	clr	a
2411  0067               L5711:
2412                     ; 740     return  pendingbitstatus;
2416  0067 5b04          	addw	sp,#4
2417  0069 81            	ret	
2453                     ; 768 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2453                     ; 769 {
2454                     .text:	section	.text,new
2455  0000               _UART1_ClearITPendingBit:
2459                     ; 770     assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
2461                     ; 773     if (UART1_IT == UART1_IT_RXNE)
2463  0000 a30255        	cpw	x,#597
2464  0003 2605          	jrne	L1321
2465                     ; 775         UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2467  0005 35df5230      	mov	21040,#223
2470  0009 81            	ret	
2471  000a               L1321:
2472                     ; 780         UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2474  000a 72195237      	bres	21047,#4
2475                     ; 782 }
2478  000e 81            	ret	
2491                     	xdef	_UART1_ClearITPendingBit
2492                     	xdef	_UART1_GetITStatus
2493                     	xdef	_UART1_ClearFlag
2494                     	xdef	_UART1_GetFlagStatus
2495                     	xdef	_UART1_SetPrescaler
2496                     	xdef	_UART1_SetGuardTime
2497                     	xdef	_UART1_SetAddress
2498                     	xdef	_UART1_SendBreak
2499                     	xdef	_UART1_SendData9
2500                     	xdef	_UART1_SendData8
2501                     	xdef	_UART1_ReceiveData9
2502                     	xdef	_UART1_ReceiveData8
2503                     	xdef	_UART1_ReceiverWakeUpCmd
2504                     	xdef	_UART1_WakeUpConfig
2505                     	xdef	_UART1_SmartCardNACKCmd
2506                     	xdef	_UART1_SmartCardCmd
2507                     	xdef	_UART1_LINCmd
2508                     	xdef	_UART1_LINBreakDetectionConfig
2509                     	xdef	_UART1_IrDACmd
2510                     	xdef	_UART1_IrDAConfig
2511                     	xdef	_UART1_HalfDuplexCmd
2512                     	xdef	_UART1_ITConfig
2513                     	xdef	_UART1_Cmd
2514                     	xdef	_UART1_Init
2515                     	xdef	_UART1_DeInit
2516                     	xref	_CLK_GetClockFreq
2517                     	xref.b	c_lreg
2518                     	xref.b	c_x
2537                     	xref	c_lursh
2538                     	xref	c_lsub
2539                     	xref	c_smul
2540                     	xref	c_ludv
2541                     	xref	c_rtol
2542                     	xref	c_llsh
2543                     	xref	c_ltor
2544                     	end
