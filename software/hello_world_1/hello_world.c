#include <stdio.h>

#define VGA_WIDTH   640
#define VGA_HEIGHT  480

int main()
{
    int row, col;
    
    //configure our window
    int y_max = 1 << 6;
    int x_max = 1 << 6;
    int y_min = 0;
    int x_min = 0;
    
    //set our iteration params
    
    //to compute a and b, we will iterate through each pixel of the screen
    //adding win_dim/screen_dim to a sum that starts at win_dim_min
    
    //we will also have "leap" iterations, which are iterations in which
    //the sum must be incremented by 1 to keep it on track towards screen_dim
    
    //amount to add each iteration    
    int x_delt = (x_max - x_min)/VGA_WIDTH;
    int y_delt = (y_max - y_min)/VGA_HEIGHT;
    
    //leap total is the number of times we'll need to increment our sum by 1
    int x_leap_total = (x_max - x_min)%VGA_WIDTH;
    int y_leap_total = (y_max - y_min)%VGA_HEIGHT;
    
    //leap count will keep track of how many times we incremented our count by this value
    int x_leap_count = 0;
    int y_leap_count = 0;
 
    //leap interval is the number of cycles between leaps
    int x_leap_interval = VGA_WIDTH/x_leap_total;
    int y_leap_interval = VGA_HEIGHT/y_leap_total;
    
    //time since last leap
    int x_last_leap = 0;
    int y_last_leap = 0;
    
    int a = y_min;
    int b = x_min;
    
    for(row = VGA_HEIGHT; row > 0; row--)    //bottom to top so our min is in the bottom left corner
    {
        
        
        for(col = 0; col < VGA_WIDTH; col++)
        {
            b+= x_delt;
            
            if(x_last_leap >= x_leap_interval && x_leap_count < x_leap_total)
            {
                b++;
                x_last_leap = 0;
                x_leap_count++;
            }
            else
                x_last_leap++;
            
            //write to board
            
        }
        
        a += y_delt;
        if(y_last_leap >= y_leap_interval && y_leap_count < y_leap_total)
        {
            a++;
            y_last_leap = 0;
            y_leap_count++;
        }
        else
            y_last_leap++;
        
    }
    
    printf("Final coordinate is (%d, %d).\n", b >> 6, a >> 6);
    
    printf("Hello from Nios II!\n");
    return 0;
}
