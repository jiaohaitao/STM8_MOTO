   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  80                     ; 81 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  80                     ; 82 {
  82                     .text:	section	.text,new
  83  0000               _FLASH_Unlock:
  87                     ; 84     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  89                     ; 87     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
  91  0000 a1fd          	cp	a,#253
  92  0002 2609          	jrne	L73
  93                     ; 89         FLASH->PUKR = FLASH_RASS_KEY1;
  95  0004 35565062      	mov	20578,#86
  96                     ; 90         FLASH->PUKR = FLASH_RASS_KEY2;
  98  0008 35ae5062      	mov	20578,#174
 101  000c 81            	ret	
 102  000d               L73:
 103                     ; 95         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
 105  000d 35ae5064      	mov	20580,#174
 106                     ; 96         FLASH->DUKR = FLASH_RASS_KEY1;
 108  0011 35565064      	mov	20580,#86
 109                     ; 98 }
 112  0015 81            	ret	
 147                     ; 106 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 147                     ; 107 {
 148                     .text:	section	.text,new
 149  0000               _FLASH_Lock:
 153                     ; 109     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 155                     ; 112   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 157  0000 c4505f        	and	a,20575
 158  0003 c7505f        	ld	20575,a
 159                     ; 113 }
 162  0006 81            	ret	
 185                     ; 120 void FLASH_DeInit(void)
 185                     ; 121 {
 186                     .text:	section	.text,new
 187  0000               _FLASH_DeInit:
 191                     ; 122     FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 193  0000 725f505a      	clr	20570
 194                     ; 123     FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 196  0004 725f505b      	clr	20571
 197                     ; 124     FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 199  0008 35ff505c      	mov	20572,#255
 200                     ; 125     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 202  000c 7217505f      	bres	20575,#3
 203                     ; 126     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 205  0010 7213505f      	bres	20575,#1
 206                     ; 127     (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 208  0014 c6505f        	ld	a,20575
 209                     ; 128 }
 212  0017 81            	ret	
 267                     ; 136 void FLASH_ITConfig(FunctionalState NewState)
 267                     ; 137 {
 268                     .text:	section	.text,new
 269  0000               _FLASH_ITConfig:
 273                     ; 139   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 275                     ; 141     if (NewState != DISABLE)
 277  0000 4d            	tnz	a
 278  0001 2705          	jreq	L711
 279                     ; 143         FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 281  0003 7212505a      	bset	20570,#1
 284  0007 81            	ret	
 285  0008               L711:
 286                     ; 147         FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 288  0008 7213505a      	bres	20570,#1
 289                     ; 149 }
 292  000c 81            	ret	
 326                     ; 158 void FLASH_EraseByte(uint32_t Address)
 326                     ; 159 {
 327                     .text:	section	.text,new
 328  0000               _FLASH_EraseByte:
 330       00000000      OFST:	set	0
 333                     ; 161     assert_param(IS_FLASH_ADDRESS_OK(Address));
 335                     ; 164    *(PointerAttr uint8_t*) (uint16_t)Address = FLASH_CLEAR_BYTE; 
 337  0000 1e05          	ldw	x,(OFST+5,sp)
 338  0002 7f            	clr	(x)
 339                     ; 166 }
 342  0003 81            	ret	
 385                     ; 176 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 385                     ; 177 {
 386                     .text:	section	.text,new
 387  0000               _FLASH_ProgramByte:
 389       00000000      OFST:	set	0
 392                     ; 179     assert_param(IS_FLASH_ADDRESS_OK(Address));
 394                     ; 180     *(PointerAttr uint8_t*) (uint16_t)Address = Data;
 396  0000 1e05          	ldw	x,(OFST+5,sp)
 397  0002 7b07          	ld	a,(OFST+7,sp)
 398  0004 f7            	ld	(x),a
 399                     ; 181 }
 402  0005 81            	ret	
 436                     ; 190 uint8_t FLASH_ReadByte(uint32_t Address)
 436                     ; 191 {
 437                     .text:	section	.text,new
 438  0000               _FLASH_ReadByte:
 440       00000000      OFST:	set	0
 443                     ; 193     assert_param(IS_FLASH_ADDRESS_OK(Address));
 445                     ; 196     return(*(PointerAttr uint8_t *) (uint16_t)Address); 
 447  0000 1e05          	ldw	x,(OFST+5,sp)
 448  0002 f6            	ld	a,(x)
 451  0003 81            	ret	
 494                     ; 207 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 494                     ; 208 {
 495                     .text:	section	.text,new
 496  0000               _FLASH_ProgramWord:
 498       00000000      OFST:	set	0
 501                     ; 210     assert_param(IS_FLASH_ADDRESS_OK(Address));
 503                     ; 213     FLASH->CR2 |= FLASH_CR2_WPRG;
 505  0000 721c505b      	bset	20571,#6
 506                     ; 214     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 508  0004 721d505c      	bres	20572,#6
 509                     ; 217     *((PointerAttr uint8_t*)(uint16_t)Address)       = *((uint8_t*)(&Data));
 511  0008 1e05          	ldw	x,(OFST+5,sp)
 512  000a 7b07          	ld	a,(OFST+7,sp)
 513  000c f7            	ld	(x),a
 514                     ; 219     *(((PointerAttr uint8_t*)(uint16_t)Address) + 1) = *((uint8_t*)(&Data)+1); 
 516  000d 7b08          	ld	a,(OFST+8,sp)
 517  000f e701          	ld	(1,x),a
 518                     ; 221     *(((PointerAttr uint8_t*)(uint16_t)Address) + 2) = *((uint8_t*)(&Data)+2); 
 520  0011 7b09          	ld	a,(OFST+9,sp)
 521  0013 e702          	ld	(2,x),a
 522                     ; 223     *(((PointerAttr uint8_t*)(uint16_t)Address) + 3) = *((uint8_t*)(&Data)+3); 
 524  0015 7b0a          	ld	a,(OFST+10,sp)
 525  0017 e703          	ld	(3,x),a
 526                     ; 224 }
 529  0019 81            	ret	
 574                     ; 232 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 574                     ; 233 {
 575                     .text:	section	.text,new
 576  0000               _FLASH_ProgramOptionByte:
 578       00000000      OFST:	set	0
 581                     ; 235     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 583                     ; 238     FLASH->CR2 |= FLASH_CR2_OPT;
 585  0000 721e505b      	bset	20571,#7
 586  0004 89            	pushw	x
 587                     ; 239     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 589  0005 721f505c      	bres	20572,#7
 590                     ; 242     if (Address == 0x4800)
 592  0009 a34800        	cpw	x,#18432
 593  000c 2607          	jrne	L542
 594                     ; 245        *((NEAR uint8_t*)Address) = Data;
 596  000e 1e01          	ldw	x,(OFST+1,sp)
 597  0010 7b05          	ld	a,(OFST+5,sp)
 598  0012 f7            	ld	(x),a
 600  0013 2008          	jra	L742
 601  0015               L542:
 602                     ; 250        *((NEAR uint8_t*)Address) = Data;
 604  0015 1e01          	ldw	x,(OFST+1,sp)
 605  0017 7b05          	ld	a,(OFST+5,sp)
 606  0019 f7            	ld	(x),a
 607                     ; 251        *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 609  001a 43            	cpl	a
 610  001b e701          	ld	(1,x),a
 611  001d               L742:
 612                     ; 253     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 614  001d a6fd          	ld	a,#253
 615  001f cd0000        	call	_FLASH_WaitForLastOperation
 617                     ; 256     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 619  0022 721f505b      	bres	20571,#7
 620                     ; 257     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 622                     ; 258 }
 625  0026 85            	popw	x
 626  0027 721e505c      	bset	20572,#7
 627  002b 81            	ret	
 663                     ; 265 void FLASH_EraseOptionByte(uint16_t Address)
 663                     ; 266 {
 664                     .text:	section	.text,new
 665  0000               _FLASH_EraseOptionByte:
 667       00000000      OFST:	set	0
 670                     ; 268     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 672                     ; 271     FLASH->CR2 |= FLASH_CR2_OPT;
 674  0000 721e505b      	bset	20571,#7
 675  0004 89            	pushw	x
 676                     ; 272     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 678  0005 721f505c      	bres	20572,#7
 679                     ; 275      if (Address == 0x4800)
 681  0009 a34800        	cpw	x,#18432
 682  000c 2603          	jrne	L762
 683                     ; 278        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 685  000e 7f            	clr	(x)
 687  000f 2007          	jra	L172
 688  0011               L762:
 689                     ; 283        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 691  0011 1e01          	ldw	x,(OFST+1,sp)
 692                     ; 284        *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 694  0013 a6ff          	ld	a,#255
 695  0015 7f            	clr	(x)
 696  0016 e701          	ld	(1,x),a
 697  0018               L172:
 698                     ; 286     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 700  0018 a6fd          	ld	a,#253
 701  001a cd0000        	call	_FLASH_WaitForLastOperation
 703                     ; 289     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 705  001d 721f505b      	bres	20571,#7
 706                     ; 290     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 708                     ; 291 }
 711  0021 85            	popw	x
 712  0022 721e505c      	bset	20572,#7
 713  0026 81            	ret	
 776                     ; 297 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 776                     ; 298 {
 777                     .text:	section	.text,new
 778  0000               _FLASH_ReadOptionByte:
 780  0000 5204          	subw	sp,#4
 781       00000004      OFST:	set	4
 784                     ; 299     uint8_t value_optbyte, value_optbyte_complement = 0;
 786                     ; 300     uint16_t res_value = 0;
 788                     ; 303     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 790                     ; 306     value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 792  0002 f6            	ld	a,(x)
 793  0003 6b02          	ld	(OFST-2,sp),a
 794                     ; 307     value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 796  0005 e601          	ld	a,(1,x)
 797  0007 6b01          	ld	(OFST-3,sp),a
 798                     ; 310     if (Address == 0x4800)	 
 800  0009 a34800        	cpw	x,#18432
 801  000c 2606          	jrne	L523
 802                     ; 312         res_value =	 value_optbyte;
 804  000e 7b02          	ld	a,(OFST-2,sp)
 805  0010 5f            	clrw	x
 806  0011 97            	ld	xl,a
 808  0012 201c          	jra	L723
 809  0014               L523:
 810                     ; 316         if (value_optbyte == (uint8_t)(~value_optbyte_complement))
 812  0014 43            	cpl	a
 813  0015 1102          	cp	a,(OFST-2,sp)
 814  0017 2614          	jrne	L133
 815                     ; 318             res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 817  0019 7b02          	ld	a,(OFST-2,sp)
 818  001b 97            	ld	xl,a
 819  001c 4f            	clr	a
 820  001d 02            	rlwa	x,a
 821  001e 1f03          	ldw	(OFST-1,sp),x
 822                     ; 319             res_value = res_value | (uint16_t)value_optbyte_complement;
 824  0020 5f            	clrw	x
 825  0021 7b01          	ld	a,(OFST-3,sp)
 826  0023 97            	ld	xl,a
 827  0024 01            	rrwa	x,a
 828  0025 1a04          	or	a,(OFST+0,sp)
 829  0027 01            	rrwa	x,a
 830  0028 1a03          	or	a,(OFST-1,sp)
 831  002a 01            	rrwa	x,a
 833  002b 2003          	jra	L723
 834  002d               L133:
 835                     ; 323             res_value = FLASH_OPTIONBYTE_ERROR;
 837  002d ae5555        	ldw	x,#21845
 838  0030               L723:
 839                     ; 326     return(res_value);
 843  0030 5b04          	addw	sp,#4
 844  0032 81            	ret	
 918                     ; 335 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 918                     ; 336 {
 919                     .text:	section	.text,new
 920  0000               _FLASH_SetLowPowerMode:
 922  0000 88            	push	a
 923       00000000      OFST:	set	0
 926                     ; 338     assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 928                     ; 341     FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 930  0001 c6505a        	ld	a,20570
 931  0004 a4f3          	and	a,#243
 932  0006 c7505a        	ld	20570,a
 933                     ; 344     FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 935  0009 c6505a        	ld	a,20570
 936  000c 1a01          	or	a,(OFST+1,sp)
 937  000e c7505a        	ld	20570,a
 938                     ; 345 }
 941  0011 84            	pop	a
 942  0012 81            	ret	
1000                     ; 353 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1000                     ; 354 {
1001                     .text:	section	.text,new
1002  0000               _FLASH_SetProgrammingTime:
1006                     ; 356     assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1008                     ; 358     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1010  0000 7211505a      	bres	20570,#0
1011                     ; 359     FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1013  0004 ca505a        	or	a,20570
1014  0007 c7505a        	ld	20570,a
1015                     ; 360 }
1018  000a 81            	ret	
1043                     ; 367 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1043                     ; 368 {
1044                     .text:	section	.text,new
1045  0000               _FLASH_GetLowPowerMode:
1049                     ; 369     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1051  0000 c6505a        	ld	a,20570
1052  0003 a40c          	and	a,#12
1055  0005 81            	ret	
1080                     ; 377 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1080                     ; 378 {
1081                     .text:	section	.text,new
1082  0000               _FLASH_GetProgrammingTime:
1086                     ; 379     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1088  0000 c6505a        	ld	a,20570
1089  0003 a401          	and	a,#1
1092  0005 81            	ret	
1126                     ; 387 uint32_t FLASH_GetBootSize(void)
1126                     ; 388 {
1127                     .text:	section	.text,new
1128  0000               _FLASH_GetBootSize:
1130  0000 5204          	subw	sp,#4
1131       00000004      OFST:	set	4
1134                     ; 389     uint32_t temp = 0;
1136                     ; 392     temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1138  0002 c6505d        	ld	a,20573
1139  0005 5f            	clrw	x
1140  0006 97            	ld	xl,a
1141  0007 90ae0200      	ldw	y,#512
1142  000b cd0000        	call	c_umul
1144  000e 96            	ldw	x,sp
1145  000f 5c            	incw	x
1146  0010 cd0000        	call	c_rtol
1148                     ; 395     if (FLASH->FPR == 0xFF)
1150  0013 c6505d        	ld	a,20573
1151  0016 4c            	inc	a
1152  0017 260d          	jrne	L354
1153                     ; 397         temp += 512;
1155  0019 ae0200        	ldw	x,#512
1156  001c bf02          	ldw	c_lreg+2,x
1157  001e 5f            	clrw	x
1158  001f bf00          	ldw	c_lreg,x
1159  0021 96            	ldw	x,sp
1160  0022 5c            	incw	x
1161  0023 cd0000        	call	c_lgadd
1163  0026               L354:
1164                     ; 401     return(temp);
1166  0026 96            	ldw	x,sp
1167  0027 5c            	incw	x
1168  0028 cd0000        	call	c_ltor
1172  002b 5b04          	addw	sp,#4
1173  002d 81            	ret	
1275                     ; 412 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1275                     ; 413 {
1276                     .text:	section	.text,new
1277  0000               _FLASH_GetFlagStatus:
1279  0000 88            	push	a
1280       00000001      OFST:	set	1
1283                     ; 414     FlagStatus status = RESET;
1285                     ; 416     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1287                     ; 419     if ((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1289  0001 c4505f        	and	a,20575
1290  0004 2702          	jreq	L325
1291                     ; 421         status = SET; /* FLASH_FLAG is set */
1293  0006 a601          	ld	a,#1
1295  0008               L325:
1296                     ; 425         status = RESET; /* FLASH_FLAG is reset*/
1298                     ; 429     return status;
1302  0008 5b01          	addw	sp,#1
1303  000a 81            	ret	
1388                     ; 531 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1388                     ; 532 {
1389                     .FLASH_CODE:	section	.text,new
1390  0000               _FLASH_WaitForLastOperation:
1392  0000 5205          	subw	sp,#5
1393       00000005      OFST:	set	5
1396                     ; 533     uint8_t flagstatus = 0x00;
1398  0002 0f05          	clr	(OFST+0,sp)
1399                     ; 534     uint32_t timeout = OPERATION_TIMEOUT;
1401  0004 aeffff        	ldw	x,#65535
1402  0007 1f03          	ldw	(OFST-2,sp),x
1403  0009 ae000f        	ldw	x,#15
1404  000c 1f01          	ldw	(OFST-4,sp),x
1406  000e 200e          	jra	L375
1407  0010               L765:
1408                     ; 560         flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
1410  0010 c6505f        	ld	a,20575
1411  0013 a405          	and	a,#5
1412  0015 6b05          	ld	(OFST+0,sp),a
1413                     ; 561         timeout--;
1415  0017 96            	ldw	x,sp
1416  0018 5c            	incw	x
1417  0019 a601          	ld	a,#1
1418  001b cd0000        	call	c_lgsbc
1420  001e               L375:
1421                     ; 558     while ((flagstatus == 0x00) && (timeout != 0x00))
1423  001e 7b05          	ld	a,(OFST+0,sp)
1424  0020 2607          	jrne	L775
1426  0022 96            	ldw	x,sp
1427  0023 5c            	incw	x
1428  0024 cd0000        	call	c_lzmp
1430  0027 26e7          	jrne	L765
1431  0029               L775:
1432                     ; 566     if (timeout == 0x00 )
1434  0029 96            	ldw	x,sp
1435  002a 5c            	incw	x
1436  002b cd0000        	call	c_lzmp
1438  002e 2604          	jrne	L106
1439                     ; 568         flagstatus = FLASH_STATUS_TIMEOUT;
1441  0030 a602          	ld	a,#2
1442  0032 6b05          	ld	(OFST+0,sp),a
1443  0034               L106:
1444                     ; 571     return((FLASH_Status_TypeDef)flagstatus);
1446  0034 7b05          	ld	a,(OFST+0,sp)
1449  0036 5b05          	addw	sp,#5
1450  0038 81            	ret	
1513                     ; 581 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1513                     ; 582 {
1514                     .FLASH_CODE:	section	.text,new
1515  0000               _FLASH_EraseBlock:
1517  0000 89            	pushw	x
1518  0001 5206          	subw	sp,#6
1519       00000006      OFST:	set	6
1522                     ; 583   uint32_t startaddress = 0;
1524                     ; 592   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1526                     ; 593   if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1528  0003 7b0b          	ld	a,(OFST+5,sp)
1529  0005 a1fd          	cp	a,#253
1530  0007 2605          	jrne	L536
1531                     ; 595       assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1533                     ; 596       startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1535  0009 ae8000        	ldw	x,#32768
1537  000c 2003          	jra	L736
1538  000e               L536:
1539                     ; 600       assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1541                     ; 601       startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1543  000e ae4000        	ldw	x,#16384
1544  0011               L736:
1545  0011 1f05          	ldw	(OFST-1,sp),x
1546  0013 5f            	clrw	x
1547  0014 1f03          	ldw	(OFST-3,sp),x
1548                     ; 608     pwFlash = (PointerAttr uint32_t *)(uint16_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1550  0016 a640          	ld	a,#64
1551  0018 1e07          	ldw	x,(OFST+1,sp)
1552  001a cd0000        	call	c_cmulx
1554  001d 96            	ldw	x,sp
1555  001e 1c0003        	addw	x,#OFST-3
1556  0021 cd0000        	call	c_ladd
1558  0024 be02          	ldw	x,c_lreg+2
1559  0026 1f01          	ldw	(OFST-5,sp),x
1560                     ; 612     FLASH->CR2 |= FLASH_CR2_ERASE;
1562  0028 721a505b      	bset	20571,#5
1563                     ; 613     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1565                     ; 616     *pwFlash = (uint32_t)0;
1567  002c 4f            	clr	a
1568  002d 721b505c      	bres	20572,#5
1569  0031 e703          	ld	(3,x),a
1570  0033 e702          	ld	(2,x),a
1571  0035 e701          	ld	(1,x),a
1572  0037 f7            	ld	(x),a
1573                     ; 623 }
1576  0038 5b08          	addw	sp,#8
1577  003a 81            	ret	
1681                     ; 634 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1681                     ; 635                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1681                     ; 636 {
1682                     .FLASH_CODE:	section	.text,new
1683  0000               _FLASH_ProgramBlock:
1685  0000 89            	pushw	x
1686  0001 5206          	subw	sp,#6
1687       00000006      OFST:	set	6
1690                     ; 637     uint16_t Count = 0;
1692                     ; 638     uint32_t startaddress = 0;
1694                     ; 641     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1696                     ; 642     assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1698                     ; 643     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1700  0003 7b0b          	ld	a,(OFST+5,sp)
1701  0005 a1fd          	cp	a,#253
1702  0007 2605          	jrne	L317
1703                     ; 645         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1705                     ; 646         startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1707  0009 ae8000        	ldw	x,#32768
1709  000c 2003          	jra	L517
1710  000e               L317:
1711                     ; 650         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1713                     ; 651         startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1715  000e ae4000        	ldw	x,#16384
1716  0011               L517:
1717  0011 1f03          	ldw	(OFST-3,sp),x
1718  0013 5f            	clrw	x
1719  0014 1f01          	ldw	(OFST-5,sp),x
1720                     ; 655     startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1722  0016 a640          	ld	a,#64
1723  0018 1e07          	ldw	x,(OFST+1,sp)
1724  001a cd0000        	call	c_cmulx
1726  001d 96            	ldw	x,sp
1727  001e 5c            	incw	x
1728  001f cd0000        	call	c_lgadd
1730                     ; 658     if (FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1732  0022 7b0c          	ld	a,(OFST+6,sp)
1733  0024 260a          	jrne	L717
1734                     ; 661         FLASH->CR2 |= FLASH_CR2_PRG;
1736  0026 7210505b      	bset	20571,#0
1737                     ; 662         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1739  002a 7211505c      	bres	20572,#0
1741  002e 2008          	jra	L127
1742  0030               L717:
1743                     ; 667         FLASH->CR2 |= FLASH_CR2_FPRG;
1745  0030 7218505b      	bset	20571,#4
1746                     ; 668         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1748  0034 7219505c      	bres	20572,#4
1749  0038               L127:
1750                     ; 672     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1752  0038 5f            	clrw	x
1753  0039 1f05          	ldw	(OFST-1,sp),x
1754  003b               L327:
1755                     ; 678   *((PointerAttr uint8_t*) (uint16_t)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1757  003b 1e0d          	ldw	x,(OFST+7,sp)
1758  003d 72fb05        	addw	x,(OFST-1,sp)
1759  0040 f6            	ld	a,(x)
1760  0041 1e03          	ldw	x,(OFST-3,sp)
1761  0043 72fb05        	addw	x,(OFST-1,sp)
1762  0046 f7            	ld	(x),a
1763                     ; 672     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1765  0047 1e05          	ldw	x,(OFST-1,sp)
1766  0049 5c            	incw	x
1767  004a 1f05          	ldw	(OFST-1,sp),x
1770  004c a30040        	cpw	x,#64
1771  004f 25ea          	jrult	L327
1772                     ; 681 }
1775  0051 5b08          	addw	sp,#8
1776  0053 81            	ret	
1789                     	xdef	_FLASH_WaitForLastOperation
1790                     	xdef	_FLASH_ProgramBlock
1791                     	xdef	_FLASH_EraseBlock
1792                     	xdef	_FLASH_GetFlagStatus
1793                     	xdef	_FLASH_GetBootSize
1794                     	xdef	_FLASH_GetProgrammingTime
1795                     	xdef	_FLASH_GetLowPowerMode
1796                     	xdef	_FLASH_SetProgrammingTime
1797                     	xdef	_FLASH_SetLowPowerMode
1798                     	xdef	_FLASH_EraseOptionByte
1799                     	xdef	_FLASH_ProgramOptionByte
1800                     	xdef	_FLASH_ReadOptionByte
1801                     	xdef	_FLASH_ProgramWord
1802                     	xdef	_FLASH_ReadByte
1803                     	xdef	_FLASH_ProgramByte
1804                     	xdef	_FLASH_EraseByte
1805                     	xdef	_FLASH_ITConfig
1806                     	xdef	_FLASH_DeInit
1807                     	xdef	_FLASH_Lock
1808                     	xdef	_FLASH_Unlock
1809                     	xref.b	c_lreg
1810                     	xref.b	c_x
1811                     	xref.b	c_y
1830                     	xref	c_ladd
1831                     	xref	c_cmulx
1832                     	xref	c_lzmp
1833                     	xref	c_lgsbc
1834                     	xref	c_ltor
1835                     	xref	c_lgadd
1836                     	xref	c_rtol
1837                     	xref	c_umul
1838                     	end
