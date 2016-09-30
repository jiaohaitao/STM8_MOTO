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
#include "sysclock.h"
#include "led.h"
#include "tim1.h"
#include "I2c_slave_interrupt.h"
#include "adc.h"
#include "uart1.h"

extern u8 u8_My_Buffer[MAX_BUFFER];
__IO u8 Last_I2c_Buffer[MAX_BUFFER]={0};

extern __IO u8 Sys_20ms_Flag;
extern __IO u8 Sys_50ms_Flag;
extern __IO u8 Sys_100ms_Flag;
extern __IO u8 Sys_200ms_Flag;
extern __IO u8 Sys_500ms_Flag;
extern __IO u8 Sys_1000ms_Flag;

/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/ 
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
u8 Check_I2c_Data(void)
{
	u8 i=0;
	/*
	for(i=0;i<MAX_BUFFER;i++){
		if(Last_I2c_Buffer[i]!=u8_My_Buffer[i]){
		
		}
	}
	*/
	// deal iic data buf
	return 0;
}

/**
  * @brief Example firmware main entry point.
  * @par Parameters:
  * None
  * @retval 
  * None
  */
void main(void)
{
	unsigned char pwm=0;
	static uint16_t AdcValue=0;
	
	SystemClock_Init(HSI_Clock);
	LED_Init();//led3->PC3 led2->PD3 led1->PD3
	Tim1_Init();	
	Pwm_Init(); //channel1->PD4 channel2->PD3 channel3->PA3
	ADC_Init();// ADC1 Channel2 PC4
	Uart1_Init();//PD5->Uart1 Tx   PD6->Uart1 Rx
	
	SetLedOFF(); /* ÈÃËùÓÐµÆÃð */

	/* Initialise I2C for communication */
	Init_I2C();//PB4-SCL PB5->SDA
	

	
	UART1_SendString("Stm8 Pwm Test....\r\n");
		enableInterrupts(); 
		
  while (1)
	{
		if(Sys_20ms_Flag==1)
		{
			Sys_20ms_Flag=0;
		}
		
		if(Sys_50ms_Flag==1)
		{
			Sys_50ms_Flag=0;
			
			Check_I2c_Data();
		}
		
		if(Sys_100ms_Flag==1)
		{
			Sys_100ms_Flag=0;
			pwm+=10;
			if(pwm>100)
			pwm=0;
		
			Set_Pwm_Channel1(pwm);
			Set_Pwm_Channel2(pwm);
			Set_Pwm_Channel3(pwm);
		}

		if(Sys_200ms_Flag==1)
		{
			Sys_200ms_Flag=0;
			AdcValue=OneChannelGetADValue(ADC1_CHANNEL_2,ADC1_SCHMITTTRIG_CHANNEL2);
			//UART1_SendString("\r\nThe Adc Value:");
			UART1_SendByte((unsigned char)(AdcValue>>8));
			UART1_SendByte((unsigned char)AdcValue);
			UART1_SendByte(0);
		}
		
		if(Sys_500ms_Flag==1)
		{
			Sys_500ms_Flag=0;
		}
		
		if(Sys_1000ms_Flag==1)
		{
			Sys_1000ms_Flag=0;
			LED_Reverse(LED_3);
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

/**
  * @}
  */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
