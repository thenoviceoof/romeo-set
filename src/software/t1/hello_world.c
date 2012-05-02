/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <alt_types.h>
#include <stdlib.h>
#include <system.h>
#include <io.h>

#define VGA_WIDTH   640
#define VGA_HEIGHT  480

#define RADIX_SHIFT 30
#define FLAG_SHIFT 4
#define A_LEAP_SHIFT 10

#define TOP_18_MASK 0xFFFFC0000
#define BOT_18_MASK 0x00003FFFF

#define A_MIN_TOP_FLAG 0x0
#define A_MIN_BOT_FLAG 0x1
#define B_MIN_TOP_FLAG 0x2
#define B_MIN_BOT_FLAG 0x3
#define A_DIF_TOP_FLAG 0x4
#define A_DIF_BOT_FLAG 0x5
#define B_DIF_TOP_FLAG 0x6
#define B_DIF_BOT_FLAG 0x7
#define A_B_LEAPI_FLAG 0x8
#define C_REA_TOP_FLAG 0x9
#define C_REA_BOT_FLAG 0xA
#define C_IMG_TOP_FLAG 0xB
#define C_IMG_BOT_FLAG 0xC
#define GOOD_DATA_FLAG 0xF

int main()
{
    
    //configure our window
    alt_64 b_max = 3;
    b_max = b_max << (RADIX_SHIFT-1);
    alt_64 a_max = 2;
    a_max = a_max << RADIX_SHIFT;
    alt_64 b_min = -3;
    b_min = b_min << (RADIX_SHIFT-1);
    alt_64 a_min = -2;
    a_min = a_min << RADIX_SHIFT;
    
    alt_64 c_rea = 3;
    c_rea = c_rea << (RADIX_SHIFT-1);
    alt_64 c_img = -1;
    c_img = c_img << (RADIX_SHIFT-2);

    //set the constant

    
    //set our iteration params
    
    //to compute a and b, we will iterate through each pixel of the screen
    //adding win_dim/screen_dim to a sum that starts at win_dim_min
    
    //we will also have "leap" iterations, which are iterations in which
    //the sum must be incremented by 1 to keep it on track towards screen_dim
    
    alt_64 a_delt = (a_max - a_min);
    alt_64 b_delt = (b_max - b_min);    

    printf("Adelt   = %lld\n",a_delt);
    printf("Bdelt   = %lld\n",b_delt);

    //amount to add each iteration    
    alt_64 d_a = a_delt/VGA_WIDTH;
    alt_64 d_b = b_delt/VGA_HEIGHT;
    
    //leap total is the number of times we'll need to increment our sum by 1
    alt_64 a_leap_total = a_delt%VGA_WIDTH;
    alt_64 b_leap_total = b_delt%VGA_HEIGHT;

    
    //leap interval is the number of cycles between leaps
    int a_leap_interval;
    if(a_leap_total != 0) 
        a_leap_interval = VGA_WIDTH/a_leap_total;
    else
        a_leap_interval = VGA_WIDTH;        
    int b_leap_interval;
    if(b_leap_total != 0)
        b_leap_interval = VGA_HEIGHT/b_leap_total;
    else
        b_leap_interval = VGA_HEIGHT;

    static int payload[14];
    payload[0] = (((a_min & TOP_18_MASK) >> 18) << FLAG_SHIFT)                          |A_MIN_TOP_FLAG;
    payload[1] = ((a_min & BOT_18_MASK) << FLAG_SHIFT)                                  |A_MIN_BOT_FLAG;
    payload[2] = (((b_min & TOP_18_MASK) >> 18) << FLAG_SHIFT)                          |B_MIN_TOP_FLAG;
    payload[3] = ((b_min & BOT_18_MASK) << FLAG_SHIFT)                                  |B_MIN_BOT_FLAG;
    payload[4] = (((d_a & TOP_18_MASK) >> 18) << FLAG_SHIFT)                            |A_DIF_TOP_FLAG;
    payload[5] = ((d_a & TOP_18_MASK) << FLAG_SHIFT)                                    |A_DIF_BOT_FLAG;
    payload[6] = (((d_b & TOP_18_MASK) >> 18) << FLAG_SHIFT)                            |B_DIF_TOP_FLAG;
    payload[7] = ((d_b & TOP_18_MASK) << FLAG_SHIFT)                                    |B_DIF_BOT_FLAG;
    payload[8] = (((a_leap_interval << A_LEAP_SHIFT) | b_leap_interval) << FLAG_SHIFT)  |A_B_LEAPI_FLAG;
    payload[9] = (((c_rea & TOP_18_MASK) >> 18) << FLAG_SHIFT)                          |C_REA_TOP_FLAG;
    payload[10] = ((c_rea & BOT_18_MASK) << FLAG_SHIFT)                                  |C_REA_BOT_FLAG;
    payload[11] = (((c_img & TOP_18_MASK) >> 18) << FLAG_SHIFT)                          |C_IMG_TOP_FLAG;
    payload[12] = ((c_img & BOT_18_MASK) << FLAG_SHIFT)                                  |C_IMG_BOT_FLAG;
    payload[13] = 0                                                                      |GOOD_DATA_FLAG;

    printf("A_MIN = %llx\n",a_min);
    printf("B_MIN = %llx\n",b_min);
    printf("D_A   = %llx\n",d_a);
    printf("D_B   = %llx\n",d_b);
    printf("A_LEAP= %x\n",a_leap_interval);
    printf("B_LEAP= %x\n",b_leap_interval);

    int i;    
   
    for(i = 0; i < 14; i++){
        IOWR_32DIRECT(JULIA_GEN_BASE, 0, payload[i]);
        printf("0x%x\n", payload[i]);
        printf("0x%d\n", payload[i]);
    }
     
    while(1)
       IOWR_32DIRECT(JULIA_GEN_BASE, 0, payload[13]);  
    
    return 0;
}