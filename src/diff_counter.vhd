---------------------------------------------------------------------
--diff_counter.vhd
--
--A device that increments a value by some differential, adjusting 
--the sum as necessary to assure convergence to a maximum value.
--
--Author: Stephen Pratt
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity diff_counter is
  
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
  
end diff_counter;

architecture dc of diff_counter is 

signal itr_count 	: unsigned (9 downto 0);
signal leap			: std_logic;
signal v_next		: signed(35 downto 0);
signal c_next		: unsigned(9 downto 0);
signal itr_next		: unsigned(9 downto 0);
signal v_curr		: signed(35 downto 0);
signal c_curr		: unsigned(9 downto 0);

signal v_sum		: signed (35 downto 0);
signal ready_sig 	: std_logic := '0';

begin

c_out <= std_logic_vector(c_curr);
v_out <= std_logic_vector(v_curr);
ready <= ready_sig;

process(clk)

begin	

	if rising_edge(clk) then

		c_next <= c_curr+1;
		v_next <= v_curr + v_diff;
		
		itr_next <= itr_count+1; --itr_next is leap counter
		
		--make adjustment on leap count
		if leap = '1' then 
			v_next <= v_curr + v_diff + 1;
			itr_next <= (others=>'0'); --reset leap counter to zero
		end if;

		leap <= '0';
		
		--if we complete a leap interval, we should leap next cycle
		if itr_next = v_leap then
			leap <= '1';
		end if;	

		itr_count <= itr_count;		
		
		--Reset operation - transition to start state
		if reset = '1' then
			v_curr <= v_min;
			c_curr <= (others=>'0');
			itr_count <= (others=>'0');
			at_max <= '0';
			ready_sig <= '1';
			
		--Maximum iteration reached - ransition to max state
		elsif c_curr = max_itr then
			at_max <= '1';
			
		--Next value requested
		elsif next_val = '1' then			
			c_curr <= c_next;
			v_curr <= v_next;			
			itr_count <= itr_next;					
		end if;
		
	end if;
end process;

end dc;
