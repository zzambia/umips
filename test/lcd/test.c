#define LCD_CLEAR       (1<<0)
#define CURSOR_HOME     (1<<1)
#define ENTRY_MODE      (1<<2)
#define DISPLAY_STAT    (1<<3)
#define DISPLAY_MODE    (1<<4)
#define FUNCTION        (1<<5)
#define CGRAM_ADDRESS   (1<<6)
#define DDRAM_ADDRESS   (1<<7)
#define LCD_BUSY        (1<<8)
#define READ_RAM        (3<<8)

#define BLINK_ON        (0x1)
#define CURSOR_ON       (0x2)
#define DISPLAY_ON      (0x4)
#define SHIFT_ON        (0x1)
#define INCREMENT       (0x2)
#define FORMAT_5X10     (0x4)
#define TWO_LINES       (0x8)
#define BUS_8BIT        (0x10)
#define SHIFT_RIGHT     (0x4)
#define DISPLAY_SHIFT   (0x8)

#define LCD_RS          (1<<9)
#define LCD_EN          (1<<10)

#define LED_CTRL ((volatile unsigned*)(0x8000))
#define LCD_CTRL ((volatile unsigned*)(0x8004))

void delay_ms(unsigned x)
{  
    unsigned y;
    for (; x>0; x--) {
        for (y=0; y<12500; y++) {   /* takes about 4 cycles */
            asm volatile ("nop");
        }  
    }
}

void lcd_cmd(unsigned c)
{   
    *LCD_CTRL = LCD_EN|c;
    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");
    *LCD_CTRL = 0;
}

void lcd_putc(unsigned char c)
{   
    *LCD_CTRL = LCD_EN|LCD_RS|c;
    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");
    asm volatile ("nop");
    *LCD_CTRL = 0;
    delay_ms(1);
}

void main()
{
    /* power on delay*/
    delay_ms(15);

    /* initialization */
    lcd_cmd(0x30);
    delay_ms(5);
   
    lcd_cmd(0x30);
    delay_ms(1);

    lcd_cmd(0x30);
    delay_ms(1);

    /* two lines/8-bit interface/5x10 */
    lcd_cmd(0x38); 
    delay_ms(1);

    /* display on/cursor on/blink on */
    lcd_cmd(0x0F); 
    delay_ms(1);

    /* entry mode increment cursor */
    lcd_cmd(0x06); 
    delay_ms(1);

    /* clear display */
    lcd_cmd(0x01); 
    delay_ms(2);

    const char *msg = "Heka Meka!";

    int i;
    for (i=0; i<10; i++) {        
        lcd_putc(msg[i]);
    }

    while (1) {
        *LED_CTRL = 1;
        delay_ms(500);
        *LED_CTRL = 0;
        delay_ms(500);
    }
}
