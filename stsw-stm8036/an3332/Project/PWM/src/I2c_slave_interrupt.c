#include "I2c_slave_interrupt.h"
#include "uart1.h"

unsigned char SLAVE_ADDRESS=0x50;// init  0x50

__IO unsigned char IIC_RECV_ONE_FRAME_OK=0;
__IO unsigned char IIC_BUF[10]={0};


   u8 u8_My_Buffer[MAX_BUFFER];
   u8 *u8_MyBuffp;
   u8 MessageBegin;

// ********************** Data link function ****************************
// * These functions must be modified according to your application neeeds *
// * See AN document for more precision
// **********************************************************************
unsigned char Rev_Cnt=0;
	void I2C_transaction_begin(void)
	{
		MessageBegin = TRUE;
		Rev_Cnt=0;
	//	UART1_printf("i2c begin\r\n");
	}
	void I2C_transaction_end(void)
	{
		//Not used in this example
	//	UART1_printf("i2c end\r\n");
	}
	void I2C_byte_received(u8 u8_RxData)
	{
		unsigned char i=0;
		unsigned int temp=0;
		unsigned char SumCheck=0;
	//	UART1_printf("i2c rev one byte\r\n");
		if (MessageBegin == TRUE  &&  u8_RxData < MAX_BUFFER) {
			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
			MessageBegin = FALSE;
		}
    else if(u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
      *(u8_MyBuffp++) = u8_RxData;
			
		Rev_Cnt++;
		if(	Rev_Cnt>10){
			Rev_Cnt=0;
			
#ifdef DEBUG_PRINTF			
			UART1_printf("Receive 10 Bytes\r\n:");
			for(i=0;i<10;i++){
				temp=u8_My_Buffer[i];
				UART1_printf("%d-",temp);
			}
			UART1_printf("\r\n");
#endif

			SumCheck=0;
			for(i=0;i<5;i++)
			{
				SumCheck+=u8_My_Buffer[i];
			}
			if(SumCheck==u8_My_Buffer[5])//ok
			{
				UART1_printf("Check Sum ok\r\n");
				if(IIC_RECV_ONE_FRAME_OK==0){
					IIC_RECV_ONE_FRAME_OK=1;
					for(i=0;i<10;i++)
					IIC_BUF[i]=u8_My_Buffer[i];
					UART1_printf("New Cmd come\r\n");
				}
				else{
					UART1_printf("Old Cmd not deal\r\n");
				}
				
			}
			else
			{
				UART1_printf("Check Sum error\r\n");
			}
			
		}
	}
	u8 I2C_byte_write(void)
	{
		if (u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
			return *(u8_MyBuffp++);
		else
			return 0x00;
	}


// ********************** Data link interrupt handler *******************

#ifdef _RAISONANCE_
void I2C_Slave_check_event(void) interrupt 19 {
#endif
#ifdef _COSMIC_
@far @interrupt void I2C_Slave_check_event(void) {
#endif
	static u8 sr1;					
	static u8 sr2;
	static u8 sr3;
	
// save the I2C registers configuration
sr1 = I2C->SR1;
sr2 = I2C->SR2;
sr3 = I2C->SR3;

/* Communication error? */
  if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
  {		
    I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
    I2C->SR2= 0;					    // clear all error flags
	}
/* More bytes received ? */
  if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
  {
    I2C_byte_received(I2C->DR);
  }
/* Byte received ? */
  if (sr1 & I2C_SR1_RXNE)
  {
    I2C_byte_received(I2C->DR);
  }
/* NAK? (=end of slave transmit comm) */
  if (sr2 & I2C_SR2_AF)
  {	
    I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
		I2C_transaction_end();
	}
/* Stop bit from Master  (= end of slave receive comm) */
  if (sr1 & I2C_SR1_STOPF) 
  {
    I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
		I2C_transaction_end();
	}
/* Slave address matched (= Start Comm) */
  if (sr1 & I2C_SR1_ADDR)
  {	 
		I2C_transaction_begin();
	}
/* More bytes to transmit ? */
  if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
  {
		I2C->DR = I2C_byte_write();
  }
/* Byte to transmit ? */
  if (sr1 & I2C_SR1_TXE)
  {
		I2C->DR = I2C_byte_write();
  }	
	GPIOD->ODR^=1;
}


// ************************* I2C init Function  *************************

void Init_I2C (void)
{
		/* Init GPIO for I2C use */
	/*
	GPIOE->CR1 |= 0x06;
	GPIOE->DDR &= ~0x06;
	GPIOE->CR2 &= ~0x06;
	*/
	//PB4->SCL PB5->SDA
	GPIOB->DDR&= 0xcf;
	GPIOB->CR1&= 0xcf;
	GPIOB->CR2&= 0xcf;
	
	#ifdef I2C_slave_7Bits_Address
		/* Set I2C registers for 7Bits Address */
		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
		I2C->OARH = 0x40;					      	// Set 7bit address mode

	#endif
	#ifdef I2C_slave_10Bits_Address
	  /* Set I2C registers for 10Bits Address */
	  I2C->CR1 |= 0x01;				  // Enable I2C peripheral
	  I2C->CR2 = 0x04;					// Enable I2C acknowledgement
	  I2C->FREQR = 16; 					// Set I2C Freq value (16MHz)
	  I2C->OARL = (SLAVE_ADDRESS & 0xFF) ;							// set slave address LSB 
	  I2C->OARH = 0xC0 | ((SLAVE_ADDRESS & 0x300) >> 7);	// Set 10bits address mode and address MSB
	#endif
	
	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
}

