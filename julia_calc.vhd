--Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity julia_calc is 
        port (
              -- inputs:
                 signal buffer_full : IN STD_LOGIC;
                 signal chipselect : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal a_out : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal b_out : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal exp_data : OUT STD_LOGIC;
                 signal ifm_wait : OUT STD_LOGIC;
                 signal x_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal y_out : OUT STD_LOGIC_VECTOR (8 DOWNTO 0)
              );
end entity julia_calc;


architecture europa of julia_calc is
component de2_ifm_bus is 
           port (
                 -- inputs:
                    signal buffer_full : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal a_out : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal b_out : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal exp_data : OUT STD_LOGIC;
                    signal ifm_wait : OUT STD_LOGIC;
                    signal x_out : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal y_out : OUT STD_LOGIC_VECTOR (8 DOWNTO 0)
                 );
end component de2_ifm_bus;

                signal internal_a_out :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_b_out :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_exp_data :  STD_LOGIC;
                signal internal_ifm_wait :  STD_LOGIC;
                signal internal_x_out :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_y_out :  STD_LOGIC_VECTOR (8 DOWNTO 0);

begin

  --the_de2_ifm_bus, which is an e_instance
  the_de2_ifm_bus : de2_ifm_bus
    port map(
      a_out => internal_a_out,
      b_out => internal_b_out,
      exp_data => internal_exp_data,
      ifm_wait => internal_ifm_wait,
      x_out => internal_x_out,
      y_out => internal_y_out,
      buffer_full => buffer_full,
      chipselect => chipselect,
      clk => clk,
      data => data,
      reset_n => reset_n,
      write => write
    );


  --vhdl renameroo for output signals
  a_out <= internal_a_out;
  --vhdl renameroo for output signals
  b_out <= internal_b_out;
  --vhdl renameroo for output signals
  exp_data <= internal_exp_data;
  --vhdl renameroo for output signals
  ifm_wait <= internal_ifm_wait;
  --vhdl renameroo for output signals
  x_out <= internal_x_out;
  --vhdl renameroo for output signals
  y_out <= internal_y_out;

end europa;

