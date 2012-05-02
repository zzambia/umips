#define LED_REG ((volatile unsigned*)(0x4000))

void delay_ms(unsigned x)
{  
    unsigned y, z;
    for (; x>0; x--) {
        for (y=0; y<10000; y++) { 
            asm volatile ("nop");      
        }  
    }
}

int main()
{
    int i;
    *LED_REG = 0;
    while (1) {
        for (i=1; i<0x3FF; i++) {
            *LED_REG = i;
            delay_ms(1000);
        }
    }
    return 0;
}
