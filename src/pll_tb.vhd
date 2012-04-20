library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pll_tb is
end pll_tb;

architecture tb of pll_tb is
signal CLOCK_50				: std_logic := '0';
signal clk_50				: std_logic;
signal clk_25				: std_logic;
signal clk_sram				: std_logic;

component pll5025 is
  
  port (
		inclk0		: IN STD_LOGIC;
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		c2		: OUT STD_LOGIC
	);
end component;

begin

	CLOCK_50 <= not CLOCK_50 after 10 ns;
	process	
		begin
		wait for 500 ns;
		wait;
	end process;

	uut : pll5025 port map(
		inclk0	=> CLOCK_50,
		c0		=> clk_50,
		c1		=> clk_25,
		c2		=> clk_sram
	);
end tb;
