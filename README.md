README
================================================================================
Embedded Systems, W4840, Columbia University

AUTHORS
================================================================================
 - Luis E. P.              lep2141
 - Nathan Hwang            nyh2105
 - Stephen Pratt           sdp2128
 - Richard Nwaobasi        rcn2105


ABOUT
--------------------------------------------------------------------------------
A little class project to generate interactive fractals.

In more detail, the project is built on a Altera DE2 FPGA (Cyclone II)
development board, dispatching the calculation of pixel colors from a
"soft" Nios II processor to hardware fractal calculators working in
parallel, which are then stored in a frame buffer and displayed
through VGA. The parameters used to generate the fractal are dynamic,
mutable by buttons or some other input.


COMPILING
--------------------------------------------------------------------------------
This project was developed with Quartus II (v7.2) along with SOPC
Builder (v7.2, tied to Quartus) and Nios-IDE (v7.2, tied to Quartus),
on Red Hat 5.

From source, one need only:
 - Generate the SOPC system using SPOC Builder
 - Compile the project using Quartus
 - Compile the C-code using nios2-ide
   - To do this, you need to set your workspace to src/software
   - then, you have to import all the folders as projects, then
     compile with IFV

For the class notes, see
<http://www.cs.columbia.edu/~sedwards/classes/2012/4840/index.html>


RUNNING
--------------------------------------------------------------------------------
To run, program the board with Quartus, then nios2-ide.

Controls:
 - Space and backspace are zoom in/out
 - Arrow keys are pan
 - WASD moves the constant around in the complex plane
 - The number row changes the preset constant
 - The z to m keys change the color scheme
 - The enter key cycles the colors


TODO
--------------------------------------------------------------------------------
You should see either 1) github issues, or 2) our heads. Or the docs/
directory, we've likely put our latest and greatest out there.
