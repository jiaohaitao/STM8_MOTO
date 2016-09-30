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

/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/ 
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
void Delay_Ms(unsigned int x)
{
	unsigned int i,j;
	for(i=0;i<x;i++)
	for(j=0;j<1000;j++);
}
/* Public functions ----------------------------------------------------------*/

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
	Pwm_Init(); 
	
	
  while (1)
	{
		pwm+=10;
		if(pwm>100)
		pwm=0;
		
		Set_Pwm_Channel1(pwm);
		Set_Pwm_Channel2(pwm);
		Set_Pwm_Channel3(pwm);
		Delay_Ms(100);
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
