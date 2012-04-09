library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tlc_tb2 is
end tlc_tb2;

architecture tb of tlc_tb2 is
signal clk:			std_logic := '0';
signal next_val:	std_logic;
signal reset:		std_logic;

signal v_min:		signed(35 downto 0) := X"000000000";
signal v_diff:		signed(35 downto 0) := X"000000001";
signal v_leap:		unsigned(9 downto 0) := "0000000100"; 
signal max_itr:		unsigned(9 downto 0) := "0001000000";

signal v_out:		std_logic_vector(35 downto 0);
signal c_out:		std_logic_vector(9 downto 0);
signal at_max:		std_logic;
signal ready:		std_logic;

component diff_counter is
  
  port (
    clk        	: in std_logic;
	next_val	: in std_logic;
	reset		: in std_logic;
    
	v_min		: in signed(35 downto 0);
	v_diff		: in signed(35 downto 0);
	v_leap		: in unsigned(9 downto 0);
	max_itr		: in unsigned(9 downto 0);
	
	v_out		: out std_logic_vector(35 downto 0);
	c_out		: out std_logic_vector(9 downto 0);
	at_max		: out std_logic;
	ready		: out std_logic
    );
  

end component;


begin


clk <= not clk after 20 ns;
process	
begin
wait for 40 ns;
reset <= '1';
wait for 40 ns;
reset <= '0';
wait for 40 ns;		
next_val <= '1';
wait for 400 ns;
next_val <= '0';
wait for 100 ns;
next_val <= '1';
wait;
end process;


uut : diff_counter port map(
clk => clk,
next_val => next_val,
reset => reset,

v_min => v_min,
v_diff => v_diff,
v_leap => v_leap,
max_itr => max_itr,

v_out => v_out,
c_out => c_out,
at_max => at_max,
ready => ready
);
end tb;