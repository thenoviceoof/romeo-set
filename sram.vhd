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

entity sram is 
        port (
              -- inputs:
                 signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal chipselect : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;
                 signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

              -- outputs:
                 signal SRAM_ADDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal SRAM_CE_N : OUT STD_LOGIC;
                 signal SRAM_DQ : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal SRAM_LB_N : OUT STD_LOGIC;
                 signal SRAM_OE_N : OUT STD_LOGIC;
                 signal SRAM_UB_N : OUT STD_LOGIC;
                 signal SRAM_WE_N : OUT STD_LOGIC;
                 signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
end entity sram;


architecture europa of sram is
component de2_sram_controller is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

                 -- outputs:
                    signal SRAM_ADDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal SRAM_CE_N : OUT STD_LOGIC;
                    signal SRAM_DQ : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal SRAM_LB_N : OUT STD_LOGIC;
                    signal SRAM_OE_N : OUT STD_LOGIC;
                    signal SRAM_UB_N : OUT STD_LOGIC;
                    signal SRAM_WE_N : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component de2_sram_controller;

                signal internal_SRAM_ADDR :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_SRAM_CE_N :  STD_LOGIC;
                signal internal_SRAM_LB_N :  STD_LOGIC;
                signal internal_SRAM_OE_N :  STD_LOGIC;
                signal internal_SRAM_UB_N :  STD_LOGIC;
                signal internal_SRAM_WE_N :  STD_LOGIC;
                signal internal_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);

begin

  --the_de2_sram_controller, which is an e_instance
  the_de2_sram_controller : de2_sram_controller
    port map(
      SRAM_ADDR => internal_SRAM_ADDR,
      SRAM_CE_N => internal_SRAM_CE_N,
      SRAM_DQ => SRAM_DQ,
      SRAM_LB_N => internal_SRAM_LB_N,
      SRAM_OE_N => internal_SRAM_OE_N,
      SRAM_UB_N => internal_SRAM_UB_N,
      SRAM_WE_N => internal_SRAM_WE_N,
      readdata => internal_readdata,
      address => address,
      byteenable => byteenable,
      chipselect => chipselect,
      read => read,
      write => write,
      writedata => writedata
    );


  --vhdl renameroo for output signals
  SRAM_ADDR <= internal_SRAM_ADDR;
  --vhdl renameroo for output signals
  SRAM_CE_N <= internal_SRAM_CE_N;
  --vhdl renameroo for output signals
  SRAM_LB_N <= internal_SRAM_LB_N;
  --vhdl renameroo for output signals
  SRAM_OE_N <= internal_SRAM_OE_N;
  --vhdl renameroo for output signals
  SRAM_UB_N <= internal_SRAM_UB_N;
  --vhdl renameroo for output signals
  SRAM_WE_N <= internal_SRAM_WE_N;
  --vhdl renameroo for output signals
  readdata <= internal_readdata;

end europa;

