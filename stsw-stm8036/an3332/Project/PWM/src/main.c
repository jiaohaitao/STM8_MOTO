/**
  ******************************************************************************
  * @file main.c
  * @brief This file contains the main function for TIM2 PWM Output example.
  * @author STMicroelectronics - MCD Application Team
  * @version V2.0.0
  * @date 15-March-2011
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "pwm.h"
//#include "sysclock.h"
#include "led.h"
#include "tim1.h"
#include "I2c_slave_interrupt.h"
#include "adc.h"
#include "uart1.h"
#include "flash_eeprom.h"

/* Public variables ---------------------------------------------------------*/ 
//for system cyc deal
extern __IO u8 Sys_10ms_Flag;
extern __IO u8 Sys_20ms_Flag;
extern __IO u8 Sys_50ms_Flag;
extern __IO u8 Sys_100ms_Flag;
extern __IO u8 Sys_200ms_Flag;
extern __IO u8 Sys_500ms_Flag;
extern __IO u8 Sys_1000ms_Flag;

//for iic slave mode
extern __IO unsigned char SLAVE_ADDRESS;
extern __IO unsigned char IIC_RECV_ONE_FRAME_OK;
extern __IO unsigned char IIC_BUF[10];

extern __IO unsigned char UartRxI2cAddr;
extern __IO unsigned char UartRxI2cAddrFlag;

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

//for adc filter
#define ADC_FILTER_LENGTH	20
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/ 

//for adc filter buf
unsigned short ADC_BUF[ADC_FILTER_LENGTH]={0};
unsigned char AdcBufCnt=0;
uint16_t AdcValue=0;
unsigned int AdcSum=0;
unsigned short AdcPosition=0;

//for slave iic cmd
unsigned short CmdPosition=0;
unsigned short CmdTime=0;
unsigned char  NewI2cCmd=0;

__IO uint16_t Systemid=0;
__IO uint16_t SystemStatus=0;//0->ok 1->system id error


//for motor
//PC4->nFAULT PC6->VISEN
//nFAULT->Low :过热 过流 过电压 需要立即停止驱动工作
//VISEN->Low  :电机过流，配合电路设置过流大小
__IO unsigned char Moto_nFAULT_Error=1;//=0异常
__IO unsigned char Moto_VISEN_Error=1;//=0异常


/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
unsigned char ReadSysId(void);
unsigned char SaveSysId(unsigned char id);
void Check_I2c_Data(void);
void CmdDeal(void);
void Moto_Init(void);
void SetMotoForward(unsigned char pwm);
void SetMotoReverse(unsigned char pwm);
void SetMotoStop(void);
void SetMotoSleep(void);
void CheckUartRxI2cAddr(void);
void MotoStatusCheck(void);
/**
  * @brief Example firmware main entry point.
  * @par Parameters:
  * None
  * @retval 
  * None
  */
	//本文选择16M内部RC震荡，分频为1 即系统时钟为16M
void CLK_Configuration(void)
{
   CLK_HSICmd(ENABLE);/* Set HSIEN bit */

 
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); /* Fmaster = 16MHz */

}


void main(void)
{
	
	unsigned char pwm=0,i=0;
	//初始化时，调用以下函数即可：
  CLK_Configuration();

	//init the value
	Systemid=0;
	SystemStatus=0;//system init ok
	Moto_nFAULT_Error=1;//=0异常
  Moto_VISEN_Error=1;//=0异常	
	
	NewI2cCmd=1;//开机执行一次命令，回到中间位置
	CmdPosition=180;//中间位置(0-360)
	CmdTime=1000;//默认1000ms，暂时没有使用

	Moto_Init();//PC5->M_PHA PC3->M_nSLEEP PC4->nFAULT PC6->VISEN
	LED_Init();//led3->PC3
	Tim1_Init();	
	Pwm_Init(); //channel3->PA3
	ADC_Init();// ADC1 Channel4 PD3
	Uart1_Init();//PD5->Uart1 Tx   PD6->Uart1 Rx
	SetLedOFF(); /* 让所有灯灭 */
	

	
	//SaveSysId(0x51);
	//Systemid=ReadSysId();
	
//	Systemid=0x51;//lefthand
	Systemid=0x52;//righthand
//	Systemid=0x53;//left-right-head
//	Systemid=0x54;//up-down-head	
	
	UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf

  switch (Systemid)
	{
		case 0x51:
		UART1_printf("The System is for Lefthand\r\n");
		SLAVE_ADDRESS=0x51;
		break;
		case 0x52:
		UART1_printf("The System is for Righthand\r\n");
		SLAVE_ADDRESS=0x52;
		break;
		case 0x53:
		UART1_printf("The System is for Left-Right-head\r\n");
		SLAVE_ADDRESS=0x53;
		break;
		case 0x54:
		UART1_printf("The System is for up-down-head\r\n");
		SLAVE_ADDRESS=0x54;
		break;		
		default :
		UART1_printf("The Systemid is error....\r\n");
		SystemStatus=1;//system is error
		SLAVE_ADDRESS=0x50;//default addr
		break;
	}
	Init_I2C();//PB4-SCL PB5->SDA
	
	UART1_printf("System is on....!!!\r\n");
	enableInterrupts(); 

/*
	IIC_RECV_ONE_FRAME_OK=1;
	IIC_BUF[0]=0x01;
	IIC_BUF[1]=2;
	IIC_BUF[2]=0x00;
	*/
		
  while (1)
	{
		if(Sys_10ms_Flag==1)
		{
			Sys_10ms_Flag=0;
			
			if(SystemStatus==0)
			{
				Check_I2c_Data();
				MotoStatusCheck();
				if(Moto_nFAULT_Error==1&&Moto_VISEN_Error==1)//=1 ok
				{
					CmdDeal();
				}			
				else
				{
					NewI2cCmd=0;
					SetMotoStop();
				}
			}
		}
		if(Sys_20ms_Flag==1)
		{
			Sys_20ms_Flag=0;
			if(SystemStatus==0)
			{
				AdcBufCnt++;
				if(AdcBufCnt>=ADC_FILTER_LENGTH)
				AdcBufCnt=0;
				
				ADC_BUF[AdcBufCnt]=GetMotoADValue();
				
				AdcSum=0;
				for(i=0;i<ADC_FILTER_LENGTH;i++)
				AdcSum+=ADC_BUF[i];
				
				AdcValue=AdcSum/ADC_FILTER_LENGTH;
				
				//暂时不用平均值，平均值在0切换的时候会出现误判断
				AdcValue=ADC_BUF[AdcBufCnt];
			}
			else
			{
		
			}
		}
		
		if(Sys_50ms_Flag==1)
		{
			Sys_50ms_Flag=0;

			if(SystemStatus==0)
			{
				Check_I2c_Data();
			}
			else
			{
		
			}
		}
		
		if(Sys_100ms_Flag==1)
		{
			Sys_100ms_Flag=0;
			
			if(SystemStatus==0)
			{
			
			}
			else
			{
		
			}			
		}

		if(Sys_200ms_Flag==1)
		{
			Sys_200ms_Flag=0;
			
			if(SystemStatus==0)
			{
				
				//UART1_SendString("\r\nThe Adc Value:");
			
			}
			else
			{
				LED_Reverse(LED_3);
			}			
		}
		
		if(Sys_500ms_Flag==1)
		{
			Sys_500ms_Flag=0;
			
			if(SystemStatus==0)
			{
				if(Moto_nFAULT_Error==0||Moto_VISEN_Error==0)//=1 ok
				{
					LED_Reverse(LED_3);
					UART1_SendString("Motor Driver error....\r\n");
				}
			}
			else
			{
		
			}			
		}
		
		if(Sys_1000ms_Flag==1)
		{
			Sys_1000ms_Flag=0;
			
			if(SystemStatus==0)
			{
				LED_Reverse(LED_3);
				UART1_printf("The Adc Is:%d\r\n",AdcValue);
				AdcPosition=(float)AdcValue/2.844;
				UART1_printf("The Position Is:%d\r\n",AdcPosition);
			}
			else
			{
		
			}			
		}		
	}
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  * where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval 
  * None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

void CheckUartRxI2cAddr(void)
{
	if(UartRxI2cAddrFlag==1)
	{
		UartRxI2cAddrFlag=0;
		SLAVE_ADDRESS=UartRxI2cAddr;
		SaveSysId(SLAVE_ADDRESS);
		Systemid=ReadSysId();
		UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
	
		switch (Systemid)
		{
			case 0x51:
			UART1_printf("The System is for Lefthand\r\n");
			SLAVE_ADDRESS=0x51;
			break;
			case 0x52:
			UART1_printf("The System is for Righthand\r\n");
			SLAVE_ADDRESS=0x52;
			break;
			case 0x53:
			UART1_printf("The System is for Left-Right-head\r\n");
			SLAVE_ADDRESS=0x53;
			break;
			case 0x54:
			UART1_printf("The System is for up-down-head\r\n");
			SLAVE_ADDRESS=0x54;
			break;		
			default :
			UART1_printf("The Systemid is error....\r\n");
			SystemStatus=1;//system is error
			SLAVE_ADDRESS=0x50;//default addr
			break;
		}
		Init_I2C();//PB4-SCL PB5->SDA		
	}
}

u8 ReadBuffer[FLASH_BLOCK_SIZE]={0};
unsigned char ReadSysId(void)
{
         
	ReadMultiBlockByte(Block_0,1,ReadBuffer);
	return ReadBuffer[0];
}
unsigned char SaveSysId(unsigned char id)
{
	ReadMultiBlockByte(Block_0,1,ReadBuffer);
	ReadBuffer[0]=id;
	
	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
        
	FLASH_EraseBlock(Block_0, FLASH_MEMTYPE_DATA);/*往FLASH写数据前，要擦除对应的区域*/
	FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
        
	WriteMultiBlockByte(Block_0,FLASH_MEMTYPE_DATA,FLASH_PROGRAMMODE_STANDARD,ReadBuffer,1);
	
#ifdef DEBUG_PRINTF	
	UART1_printf("Save Sysid ok,the id is:0x%02h",ReadBuffer[0]);
#endif	
}
void Check_I2c_Data(void)
{
	u8 i=0;
	
	if(IIC_RECV_ONE_FRAME_OK==1)
	{
		
		IIC_RECV_ONE_FRAME_OK=0;
		NewI2cCmd=IIC_BUF[0];
		switch (NewI2cCmd){
			case 0x00:
			UART1_printf("Receive a null cmd (0)\r\n");
			break;
			case 0x01:
		
			
			if(IIC_BUF[1]==0x00)//shunshizhen
			{
				if(IIC_BUF[2]<=180)
				CmdPosition=IIC_BUF[2]+180;
			}
			else if(IIC_BUF[1]==0x01)//nishizhen
			{
				if(IIC_BUF[2]<=180)
				CmdPosition=180-IIC_BUF[2];
			}
			else{
		
			}
			
			if(CmdPosition>360)
			CmdPosition=360;
			CmdTime=IIC_BUF[3]*256+IIC_BUF[4];
			UART1_printf("Receive a Position Change Cmd\r\n");
			UART1_printf("The CmdPosition is:%d,The CmdTime is:%d\r\n",CmdPosition,CmdTime);				
			
			//adc 
			//nishizhen 512->1024
			//shunshizhen 512->0
			
			//shoubi qian->120 hou:60
			//touzuoyou->zuo:90 you:90
			//toushangxia->shang:20 xia:15
			
			//left hand
			//nishizhen->hou->60->50
			//shunshizhen-> qian-120->110
			if(Systemid==0x51){
				if(CmdPosition<(180-50)||CmdPosition>(180+110))
				{
					UART1_printf("Left Hand Cmd erro out of(70-230)\r\n");
					CmdPosition=180;
					NewI2cCmd=0;
				}				
			}
			//right hand
			//nishizhen->qian-120->110
			//shunshizhen->hou->60->50 
			else if(Systemid==0x52){
				if(CmdPosition<(180-110)||CmdPosition>(180+50))
				{
					UART1_printf("Right Hand Cmd erro out of(130-290)\r\n");
					CmdPosition=180;NewI2cCmd=0;
				}				
			}
			//left-right-head
			//nishizhen->left->90->80 
			//shunshizhen->right-90->80
			else if(Systemid==0x53){
				if(CmdPosition<(180-80)||CmdPosition>(180+80))
				{
					UART1_printf("left-right-head Cmd erro out of(100-260)\r\n");
					CmdPosition=180;NewI2cCmd=0;
				}						
			}
			//up-down-head
			//nishizhen->down->15->15
			//shunshizhen->up-20->25			
			else if(Systemid==0x54){
				if(CmdPosition<(180-15)||CmdPosition>(180+25))
				{
					UART1_printf("up-down-head Cmd erro out of(165-190)\r\n");
					CmdPosition=180;NewI2cCmd=0;
				}						
			}
			else
			{
				CmdPosition=180;NewI2cCmd=0;
			}

			break;
			case 0x02:
			UART1_printf("Receive stop Cmd\r\n");
			break;
			default:
			UART1_printf("Receive a error cmd:%d\r\n",(unsigned int)(NewI2cCmd));
			break;
		}
	}
}

void Moto_Init(void)
{
	//output pin
	//PC3->M_nSLEEP PC5->M_PHA 
	GPIO_Init(GPIOC,GPIO_PIN_3|GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST );
	
	//input pin
	//PC4->nFAULT PC6->VISEN
  GPIO_Init(GPIOC,GPIO_PIN_4|GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT );	
	
	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);//init to high
	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);//low->sleep, init to high not sleep
	
}
//10ms cyc
//PC4->nFAULT PC6->VISEN
//nFAULT->Low :过热 过流 过电压 需要立即停止驱动工作
//VISEN->Low  :电机过流，配合电路设置过流大小
//__IO unsigned char Moto_nFAULT_Error=1;//=0异常
//__IO unsigned char Moto_VISEN_Error=1;//=0异常
void MotoStatusCheck(void)
{
	static unsigned char nFAULT_Cnt=0;
	static unsigned char Old_nFAULT=1;
	static unsigned char VISEN_Cnt=0;
	static unsigned char Old_VISEN=1;
	unsigned char New_nFAULT=0,New_VISEN=0;
	
	if(RESET==GPIO_ReadInputPin(GPIOC, GPIO_PIN_4))
	New_nFAULT=0;//PC4->nFAULT 
	else
	New_nFAULT=1;//PC4->nFAULT 
	
	if(RESET==GPIO_ReadInputPin(GPIOC, GPIO_PIN_6))
	New_VISEN=0;//PC6->VISEN 
	else
	New_VISEN=1;//PC6->VISEN 
	
	if(New_nFAULT!=Old_nFAULT)
	{
		Old_nFAULT=New_nFAULT;
		nFAULT_Cnt=0;
	}
	else{
		if(nFAULT_Cnt<10)//10*20=200ms 
		{
			nFAULT_Cnt++;
		}
		else{
			if(Moto_nFAULT_Error!=Old_nFAULT){
				Moto_nFAULT_Error=Old_nFAULT;
				UART1_printf("Motor Driver nFAULT Change,nFAULT:%d",Moto_nFAULT_Error);
			}
		}
	}
	
	if(New_VISEN!=Old_VISEN)
	{
		Old_VISEN=New_VISEN;
		VISEN_Cnt=0;
	}
	else{
		if(VISEN_Cnt<=10)//10*20=200ms 
		{
			VISEN_Cnt++;
		}
		else{
			if(Moto_VISEN_Error!=Old_VISEN){
				Moto_VISEN_Error=Old_VISEN;
				UART1_printf("Motor Driver VISEN Change,VISEN:%d",Moto_VISEN_Error);
			}
		}
	}	
}

void CmdDeal(void)
{
	static float p=1.0,d=1.0;
	float temp=0;
	unsigned char pwm=0;
	unsigned short CmdAdc=0;//nishizhen->shunshizhen:1024->0
	if(NewI2cCmd!=0){
		if(NewI2cCmd==0x01)//position change
		{
			if(CmdPosition>330)
			return;
			
			//temp=CmdPosition*1024/330;
			temp=CmdPosition*2.844;
			CmdAdc=temp;
			
			if(CmdAdc>(AdcValue+10))
			{
				temp=(CmdAdc-AdcValue);
				if(temp>50)
				{
					pwm=75;
				}
				else{
					//pwm=temp*0.09765*p+d;
					pwm=65;
				}				
				SetMotoReverse(pwm);
				
			}
			else if((CmdAdc+10)<AdcValue)
			{
				temp=(AdcValue-CmdAdc);
				if(temp>50)
				{
					pwm=75;
				}
				else{
					//pwm=temp*0.09765*p+d;
					pwm=65;
				}				
				SetMotoForward(pwm);
			}
			else
			{
				NewI2cCmd=0;
				SetMotoStop();
			}
		}
		else if(NewI2cCmd==0x02)//stop
		{	
			NewI2cCmd=0;
			SetMotoStop();
		}
		else
		{
			NewI2cCmd=0;
   			SetMotoStop();
		}
	}
}
void SetMotoForward(unsigned char pwm)
{
	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
	Set_Pwm_Channel3(pwm);
}
void SetMotoReverse(unsigned char pwm)
{
	GPIO_WriteLow(GPIOC, GPIO_PIN_5);
	Set_Pwm_Channel3(pwm);
}
void SetMotoStop(void)
{
	Set_Pwm_Channel3(0);
}
void SetMotoSleep(void)
{
	Set_Pwm_Channel3(0);
}
/**
  * @}
  */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
