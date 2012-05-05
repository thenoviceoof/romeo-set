library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Provides registers for writing to the function modules.
entity window_gen is
  
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
  
end window_gen;

architecture wg of window_gen is 

constant HACTIVE	: integer := 640-1;
constant VACTIVE	: integer := 480-1;

signal x_max 		: unsigned(9 downto 0) := to_unsigned(HACTIVE, 10);
signal y_max 		: unsigned(9 downto 0) := to_unsigned(VACTIVE, 10);

signal a_at_max		: std_logic;
signal b_at_max		: std_logic;
signal both_max		: std_logic;

signal a_ready		: std_logic;
signal b_ready		: std_logic;

signal b_next		: std_logic;
signal a_reset		: std_logic;

signal y_out_mirror	: std_logic_vector(9 downto 0);

begin

	b_next <= next_val and a_at_max;
	
	both_max <= a_at_max and b_at_max;
	
	a_reset <= reset or (b_next and not both_max); 
	at_max <= both_max;
	y_out <= std_logic_vector(y_max - unsigned(y_out_mirror));
	
	ready <= a_ready and b_ready;
	
	a_counter:	entity work.diff_counter port map (
		clk 		=> clk,
		next_val 	=> next_val,
		reset 		=> a_reset,		
		
		v_min 		=> a_min,
		v_diff		=> a_diff,
		v_leap		=> a_leap,
		max_itr		=> x_max,
		
		v_out		=> a_out,
		c_out		=> x_out,
		at_max		=> a_at_max,
		ready		=> a_ready
	);
	
	
	b_counter:	entity work.diff_counter port map (
		clk 		=> clk,
		next_val 	=> b_next,
		reset 		=> reset,		
		
		v_min 		=> b_min,
		v_diff		=> b_diff,
		v_leap		=> b_leap,
		max_itr		=> y_max,
		
		v_out		=> b_out,
		c_out		=> y_out_mirror,
		at_max		=> b_at_max,
		ready		=> b_ready
	);	

end wg;
