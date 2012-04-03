library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tlc_tb3 is
end tlc_tb3;

architecture tb of tlc_tb3 is
signal clk:			std_logic := '0';
signal next_val:	std_logic;
signal reset:		std_logic;

signal a_min:		signed(35 downto 0) := X"000000000";
signal a_diff:		signed(35 downto 0) := X"000000010";
signal a_leap:		unsigned(9 downto 0) := "0000010000"; 

signal b_min:		signed(35 downto 0) := X"000000000";
signal b_diff:		signed(35 downto 0) := X"000000001";
signal b_leap:		unsigned(9 downto 0) := "0000000100"; 


signal a_out:		std_logic_vector(35 downto 0);
signal b_out:		std_logic_vector(35 downto 0);
signal x_out:		std_logic_vector(9 downto 0);
signal y_out:		std_logic_vector(9 downto 0);
signal at_max:		std_logic;
signal ready:		std_logic;

component window_gen is
  
  port (
    clk        	: in std_logic;
	next_val	: in std_logic;
	reset		: in std_logic;
    
	a_min		: in signed(35 downto 0);
	a_diff		: in signed(35 downto 0);
	a_leap		: in unsigned(9 downto 0);
	b_min		: in signed(35 downto 0);
	b_diff		: in signed(35 downto 0);
	b_leap		: in unsigned(9 downto 0);
	
	a_out		: out std_logic_vector(35 downto 0);
	b_out		: out std_logic_vector(35 downto 0);
	x_out		: out std_logic_vector(9 downto 0);
	y_out		: out std_logic_vector(9 downto 0);
	
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
		wait for 20 ns;		
		next_val <= '1';
		wait for 400 ns;
		next_val <= '0';
		wait for 120 ns;
		next_val <= '1';
		wait;
	end process;


	uut : window_gen port map(
		clk => clk,
		next_val => next_val,
		reset => reset,

		a_min => a_min,
		a_diff => a_diff,
		a_leap => a_leap,
		b_min => b_min,
		b_diff => b_diff,
		b_leap => b_leap,
		
		a_out => a_out,
		b_out => b_out,
		x_out => x_out,
		y_out => y_out,
		
		at_max => at_max,
		ready => ready
	);
end tb;