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

entity fbus is 
        port (
              -- inputs:
                 signal chipselect : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal adiff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal aleap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal amin : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal bdiff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal bleap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                 signal bmin : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal cio : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal cro : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal expdata : OUT STD_LOGIC
              );
end entity fbus;


architecture europa of fbus is
component de2_ifm_bus is 
           port (
                 -- inputs:
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal adiff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal aleap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal amin : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal bdiff : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal bleap : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
                    signal bmin : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal cio : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal cro : OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal expdata : OUT STD_LOGIC
                 );
end component de2_ifm_bus;

                signal internal_adiff :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_aleap :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_amin :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_bdiff :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_bleap :  STD_LOGIC_VECTOR (9 DOWNTO 0);
                signal internal_bmin :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_cio :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_cro :  STD_LOGIC_VECTOR (35 DOWNTO 0);
                signal internal_expdata :  STD_LOGIC;

begin

  --the_de2_ifm_bus, which is an e_instance
  the_de2_ifm_bus : de2_ifm_bus
    port map(
      adiff => internal_adiff,
      aleap => internal_aleap,
      amin => internal_amin,
      bdiff => internal_bdiff,
      bleap => internal_bleap,
      bmin => internal_bmin,
      cio => internal_cio,
      cro => internal_cro,
      expdata => internal_expdata,
      chipselect => chipselect,
      clk => clk,
      data => data,
      reset_n => reset_n,
      write => write
    );


  --vhdl renameroo for output signals
  adiff <= internal_adiff;
  --vhdl renameroo for output signals
  aleap <= internal_aleap;
  --vhdl renameroo for output signals
  amin <= internal_amin;
  --vhdl renameroo for output signals
  bdiff <= internal_bdiff;
  --vhdl renameroo for output signals
  bleap <= internal_bleap;
  --vhdl renameroo for output signals
  bmin <= internal_bmin;
  --vhdl renameroo for output signals
  cio <= internal_cio;
  --vhdl renameroo for output signals
  cro <= internal_cro;
  --vhdl renameroo for output signals
  expdata <= internal_expdata;

end europa;

