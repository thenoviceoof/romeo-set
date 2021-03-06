/*
 * ifv.c
 *
 * The main function for the Interactive Fractal Viewer
 * 
 * Responsible for responding to PS/2 input, computing window parameters
 * and communicating them across the Avalon bus
 *
 * Author: Richard Nwaobasi and Stephen Pratt 
 *
 */

#include <stdio.h>
#include <alt_types.h>
#include <stdlib.h>
#include <system.h>
#include <io.h>
#include "ps2_keyboard.h"

#define VGA_WIDTH   640LL
#define VGA_HEIGHT  480LL

#define RADIX_SHIFT 30

#define TOP_18_MASK 0xFFFFC0000LL
#define BOT_18_MASK 0x00003FFFFLL
#define DC 0x100000LL

#define RES_O           0
#define ITER_O          1
#define COLOR_O         2
#define REF_O           5
#define FRACT_O         6
#define RMR_REFRESH     7500
#define MAX_SPEED       5

KB_CODE_TYPE decode_mode;

//Window and Julia set parameters are kept as
//global state variables
alt_64 b_min;
alt_64 a_min;
int a_leap_interval;
int b_leap_interval;
alt_64 d_a;
alt_64 d_b;
alt_64 c_rea;
alt_64 c_img;

//Helper variables used to compute Julia set parameters
alt_64 b_max;
alt_64 a_max;
alt_64 a_delt;
alt_64 b_delt;
alt_64 a_leap_total;
alt_64 b_leap_total;

int curr_speed = 1;
int speeds[] = {60000, 70000, 80000, 90000, 100000};

//Control flags
alt_8 iterate = 0;
alt_8 color = 0;
alt_8 fract = 0;
alt_8 control = 0;

//Some funky fresh pre-sets
alt_64 cr_consts[] = {68055867794LL,    68289980007LL, 
                      68049461838LL,    395007542LL, 
                      67891644661LL,    389091824LL, 
                      67965967674LL,    67965967674LL, 
                      67860483277LL,    67914170368LL};

alt_64 ci_consts[] = {0,                644245094LL, 
                      467077693LL,      678734281LL, 
                      68627725498LL,    343597383LL, 
                      68604049490LL,    68306945128LL, 
                      167503724LL, 68504728372LL};


//Recomputes the window parameters based on the min and max values for a and b
static void recompute_window()
{
    //total change in window
    a_delt = (a_max - a_min);
    b_delt = (b_max - b_min);
    
    //amount to add each iteration    
    d_a = (a_delt/VGA_WIDTH);
    d_b = (b_delt/VGA_HEIGHT);
    
    //leap total is the number of times we'll need to increment our sum by 1
    a_leap_total = a_delt%VGA_WIDTH;
    b_leap_total = b_delt%VGA_HEIGHT;

    
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
}


//Send refresh instructions to the board
static void refresh()
{
    printf("REFRESHING\n");

  //bring 0 lo
  control = (fract << FRACT_O)|(0 << REF_O)|(color << COLOR_O)|
               (iterate << ITER_O)|(0 << RES_O);
               
  IOWR_8DIRECT(RAM_SIGNAL_BASE, 0, control);
  int i;

  //bring 5 hi
  control = (fract << FRACT_O)|(1 << REF_O)|(color << COLOR_O)|
            (iterate << ITER_O)|(0 << RES_O);
   
   IOWR_8DIRECT(RAM_SIGNAL_BASE, 0, control);
   for(i = 0; i < RMR_REFRESH; i++)
   ;
  
  //bring 5 lo
  control = (fract << FRACT_O)|(0 << REF_O)|(color << COLOR_O)|
            (iterate << ITER_O)|(0 << RES_O);
  IOWR_8DIRECT(RAM_SIGNAL_BASE, 0, control);  
  for(i = 0; i < speeds[curr_speed]; i++)
  ;
  
  //bring 0 hi
  control = (fract << FRACT_O)|(0 << REF_O)|(color << COLOR_O)|
            (iterate << ITER_O)|(1 << RES_O);
  
  IOWR_8DIRECT(RAM_SIGNAL_BASE, 0, control);
}

//Send the parameter set to the board
static void redraw()
{
    recompute_window();
    int payload[15];
    
    payload[0] = ((a_min & TOP_18_MASK) >> 18);
    payload[1] = (a_min & BOT_18_MASK);
    payload[2] = ((b_min & TOP_18_MASK) >> 18);
    payload[3] = (b_min & BOT_18_MASK);
    payload[4] = ((d_a & TOP_18_MASK) >> 18);
    payload[5] = (d_a & BOT_18_MASK);
    payload[6] = ((d_b & TOP_18_MASK) >> 18);
    payload[7] = (d_b & BOT_18_MASK);
    payload[8] = (a_leap_interval);
    payload[9] = (b_leap_interval);
    payload[10] = ((c_rea & TOP_18_MASK) >> 18);
    payload[11] = (c_rea & BOT_18_MASK);
    payload[12] = ((c_img & TOP_18_MASK) >> 18);
    payload[13] = (c_img & BOT_18_MASK);
    payload[14] = 1;
    
    int i;    
    for(i = 0; i < 14; i++){
        IOWR_32DIRECT(RAM_BASE, i*4, payload[i]);
        //printf("0x%x\n", (payload[i]<<14));
    }
    refresh();
}

int main()
{
    
    //configure our window
    b_max = 3LL;
    b_max = b_max << (RADIX_SHIFT-1);
    a_max = 2LL;
    a_max = a_max << (RADIX_SHIFT-0);
    b_min = -3LL;
    b_min = b_min << (RADIX_SHIFT-1);
    a_min = -2LL;
    a_min = a_min << (RADIX_SHIFT-0);
    
    c_rea = 0xFF91F5C29LL;
    c_img = 0xFC925460BLL;
    
    
    redraw();
    
    
    alt_u8 key = 0;   
    int status = 0;  
    
    // Initialize the keyboard
    printf("Please wait three seconds to initialize keyboard\n");
    clear_FIFO();
    switch (get_mode()) {
        case PS2_KEYBOARD:
            break;
        case PS2_MOUSE:
            printf("Error: Mouse detected on PS/2 port\n");
            goto ErrorExit;
        default:
            printf("Error: Unrecognized or no device on PS/2 port\n");
            goto ErrorExit;
    } 
    printf("Ready!\n");   
       
    for (;;) { 
        // wait for the user's input and get the make code
        status = read_make_code(&decode_mode, &key);//under  
        if (status == PS2_SUCCESS) {
            // print out the result
            switch ( decode_mode ) {
            case KB_ASCII_MAKE_CODE :
            printf("%c", key );
                switch (key) {
                    case 'W':  // w
                        c_img += DC;
                        redraw();
                        printf("W\n");
                    break;
                    
                    case 'A':  // a
                        c_rea -= DC;
                        redraw();
                        printf("A\n");
                    break;
                    
                    case 'S':  // s
                        c_img -= DC;
                        redraw();
                        printf("S\n");
                    break;
                    
                    case 'D':  // d
                        c_rea += DC;
                        redraw();
                        printf("D\n");
                    break;
                    
                    case 'U': // fractal 00
                        fract = 0;
                        redraw();
                        printf("Fractal 00\n");
                    break;
                    
                    case 'P': // fractal 11
                        fract = 3;
                        refresh();
                        printf("Fractal 11\n");
                    break;
                    
                    case 'I': // fractal 01
                        fract = 1;
                        refresh();
                        printf("Fractal 01\n");
                    break;
                    
                    case 'O': // fractal 10
                        fract = 2;
                        refresh();
                        printf("Fractal 10\n");
                    break;
                    
                    case 'Z': // fractal 10
                        color = 0;
                        refresh();
                        printf("color = 000\n");

                    break;
                    
                    case 'X': // fractal 10
                        color = 1;
                        refresh();
                        printf("color = 001\n");
                    break;
                    
                    case 'C': // fractal 10
                        color = 2;
                        refresh();
                        printf("color = 010\n");
                    break;
                    
                    case 'V': // fractal 10
                        color = 3;
                        refresh();
                        printf("color = 011\n");
                    break;
                    
                    case 'B': // fractal 10
                        color = 4;
                        refresh();
                        printf("color = 100\n");
                    break;
                    
                    case 'N': // fractal 10
                        color = 5;
                        refresh();
                        printf("color = 101\n");
                    break;
                    
                    case 'M': // fractal 10
                        color = 6;
                        refresh();
                        printf("color = 110\n");
                    break;
                    
                    case ',': // fractal 10
                        color = 7;
                        refresh();
                        printf("color = 111\n");
                    break;
                    
                    case '-':
                        if (curr_speed > 0)
                            curr_speed--;                         
                    break;
                    
                    case '=':
                        if (curr_speed < MAX_SPEED)
                            curr_speed++;
                    break;
                   
                    case '`':
                        b_max = 3LL;
                        b_max = b_max << (RADIX_SHIFT-1);
                        a_max = 2LL;
                        a_max = a_max << (RADIX_SHIFT-0);
                        b_min = -3LL;
                        b_min = b_min << (RADIX_SHIFT-1);
                        a_min = -2LL;
                        a_min = a_min << (RADIX_SHIFT-0);
                        redraw();                        
                    break;
                    
                    
                    case '0': 
                    case '1': 
                    case '2': 
                    case '3': 
                    case '4': 
                    case '5': 
                    case '6': 
                    case '7': 
                    case '8': 
                    case '9':
                        c_rea = cr_consts[atoi(&key)];
                        c_img = ci_consts[atoi(&key)];
                        redraw();
                    break;                    
                }
                    
            break ;
            case KB_LONG_BINARY_MAKE_CODE :
            printf("%s", " LONG ");
            // fall through
            case KB_BINARY_MAKE_CODE :
                switch (key) {
                case  0x5a: //enter key: send the msg
                    printf("ENTER\n");
                    if(!iterate)
                    iterate = 1;
                    else
                    iterate = 0;
                    refresh();
                break; 
                
                case 0x29: //space key
                    a_min += 0.1 * a_delt;
                    a_max -= 0.1 * a_delt;                    
                    b_min += 0.1 * b_delt;
                    b_max -= 0.1 * b_delt;
                    redraw();
                    printf("SPACE\n");
                break;
                
                case 0x66: //backspace
                    a_min -= 0.1 * a_delt;
                    a_max += 0.1 * a_delt;                    
                    b_min -= 0.1 * b_delt;
                    b_max += 0.1 * b_delt;
                    redraw();
                    printf("SPACE\n");                
                    printf("BACKSPACE\n");
                break;  
                
                case 0x75:  //up arrow
                    b_min += 0.1 * b_delt;
                    b_max += 0.1 * b_delt;                    
                    printf("UP\n");
                    redraw();
                break;
                
                case 0x72:  //down arrow
                    b_min -= 0.1 * b_delt;
                    b_max -= 0.1 * b_delt;                    
                    printf("DOWN\n");
                    redraw();
                break;
                
                case 0x74: //right arrow
                    a_min += 0.1 * a_delt;
                    a_max += 0.1 * a_delt;                    
                    printf("RIGHT\n");
                    redraw();
                break;
                
                case 0x6b: //left arrow
                    a_min -= 0.1 * a_delt;
                    a_max -= 0.1 * a_delt;                    
                    printf("RIGHT\n");
                    redraw();
                break;
                
                default:
                  printf(" MAKE CODE :\t%X\n", key ); //print other unknown breakcode
                }
            break ;
            
            case KB_BREAK_CODE :
            // do nothing
            default :
            break ;
            }
        }
        else {
            printf(" Keyboard error ....\n");
        }
    }
    
    ErrorExit:
  printf("Program terminated with an error condition\n");
    
    return 0;
}
