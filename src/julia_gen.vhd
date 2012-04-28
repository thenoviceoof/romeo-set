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

entity julia_gen is 
        port (
              -- inputs:
                 signal chipselect : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal a_diff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal a_leap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal a_min : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal b_diff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal b_leap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal b_min : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal ci : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal cr : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal exp_data : OUT STD_LOGIC
              );
end entity julia_gen;


architecture europa of julia_gen is
component de2_ifm_bus is 
           port (
                 -- inputs:
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal a_diff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal a_leap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal a_min : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal b_diff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal b_leap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal b_min : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal ci : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal cr : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal exp_data : OUT STD_LOGIC
                 );
end component de2_ifm_bus;

                signal internal_a_diff :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_a_leap :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_a_min :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_b_diff :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_b_leap :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_b_min :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_ci :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_cr :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_exp_data :  STD_LOGIC;

begin

  --the_de2_ifm_bus, which is an e_instance
  the_de2_ifm_bus : de2_ifm_bus
    port map(
      a_diff => internal_a_diff,
      a_leap => internal_a_leap,
      a_min => internal_a_min,
      b_diff => internal_b_diff,
      b_leap => internal_b_leap,
      b_min => internal_b_min,
      ci => internal_ci,
      cr => internal_cr,
      exp_data => internal_exp_data,
      chipselect => chipselect,
      clk => clk,
      data => data,
      reset_n => reset_n,
      write => write
    );


  --vhdl renameroo for output signals
  a_diff <= internal_a_diff;
  --vhdl renameroo for output signals
  a_leap <= internal_a_leap;
  --vhdl renameroo for output signals
  a_min <= internal_a_min;
  --vhdl renameroo for output signals
  b_diff <= internal_b_diff;
  --vhdl renameroo for output signals
  b_leap <= internal_b_leap;
  --vhdl renameroo for output signals
  b_min <= internal_b_min;
  --vhdl renameroo for output signals
  ci <= internal_ci;
  --vhdl renameroo for output signals
  cr <= internal_cr;
  --vhdl renameroo for output signals
  exp_data <= internal_exp_data;

end europa;

