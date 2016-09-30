#include "stm8s.h"
#include "pwm.h"

//#define CCR1_Val  ((u16)500) // Configure channel 1 Pulse Width
//#define CCR2_Val  ((u16)250) // Configure channel 2 Pulse Width
//#define CCR3_Val  ((u16)750) // Configure channel 3 Pulse Width

#define CCR1_Val  ((u16)0) // Configure channel 1 Pulse Width
#define CCR2_Val  ((u16)0) // Configure channel 2 Pulse Width
#define CCR3_Val  ((u16)0) // Configure channel 3 Pulse Width

void Pwm_Init()
{
  /* TIM2 Peripheral Configuration */ 
  TIM2_DeInit();

  /* Set TIM2 Frequency to 2Mhz */ 
  TIM2_TimeBaseInit(TIM2_PRESCALER_1, 999);

 
	/* Channel 1 PWM configuration */ 
  TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR1_Val, TIM2_OCPOLARITY_LOW ); 
  TIM2_OC1PreloadConfig(ENABLE);
  
	/* Channel 2 PWM configuration */
  TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR2_Val, TIM2_OCPOLARITY_LOW );
  TIM2_OC2PreloadConfig(ENABLE);
	
	/* Channel 3 PWM configuration */
	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,CCR3_Val, TIM2_OCPOLARITY_LOW );
  TIM2_OC3PreloadConfig(ENABLE);
  
	/* Enables TIM2 peripheral Preload register on ARR */
	TIM2_ARRPreloadConfig(ENABLE);
	
  /* Enable TIM2 */
  TIM2_Cmd(ENABLE);
}
//----------------------------------------------------------------
//pwm(0-100)
//pwm channel1->PD4
void Set_Pwm_Channel1(unsigned char pwm)
{
		/* Channel 1 PWM configuration */ 
  TIM2_OC1Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW ); 
  TIM2_OC1PreloadConfig(ENABLE);
}
//----------------------------------------------------------------

//----------------------------------------------------------------
//pwm(0-100)
//pwm channel2->PD3
void Set_Pwm_Channel2(unsigned char pwm)
{
	/* Channel 2 PWM configuration */
  TIM2_OC2Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW );
  TIM2_OC2PreloadConfig(ENABLE);
}
//----------------------------------------------------------------

//----------------------------------------------------------------
//pwm(0-100)
//pwm channel3->PA3
void Set_Pwm_Channel3(unsigned char pwm)
{
	/* Channel 3 PWM configuration */
	TIM2_OC3Init(TIM2_OCMODE_PWM2, TIM2_OUTPUTSTATE_ENABLE,pwm*10, TIM2_OCPOLARITY_LOW );
  TIM2_OC3PreloadConfig(ENABLE);
}
//----------------------------------------------------------------