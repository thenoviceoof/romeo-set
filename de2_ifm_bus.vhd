library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Provides registers for writing to the function modules.
entity de2_ifm_bus is
  
  port (
    clk        : in  std_logic;
    reset_n      : in  std_logic;
    write      : in  std_logic;
    chipselect : in  std_logic;
    
	ifm_wait  : out std_logic;
	data	   : in unsigned(63 downto 0);
	
	buffer_full : in std_logic;
	exp_data : out std_logic;
	
	a_out	: out unsigned(17 downto 0); 
	b_out	: out unsigned(17 downto 0);
	x_out	: out unsigned(9 downto 0); 
	y_out	: out unsigned(8 downto 0)
	 

    );
  
end de2_ifm_bus;

architecture rtl of de2_ifm_bus is

signal new_data : std_logic;

begin
	ifm_wait <= new_data;			--if we're still hanging on to new data, we need to tell the processor to wait

	process (clk)
	begin
		if rising_edge(clk) then
			exp_data <= '0';		--only write data to the IFM controller if it's ready
			if reset_n = '0' then
				new_data 	<= '0';
				a_out 		<= (others => '0');
				b_out 		<= (others => '0');
				x_out 		<= (others => '0');
				y_out 		<= (others => '0');
			else
				if chipselect = '1' and write = '1' then --read data in from nios and place in appropriate registers
						a_out <= data(63 downto 46);
						b_out <= data(45 downto 28);
						x_out <= data(27 downto 18);
						y_out <= data(17 downto 9);
						new_data <= '1';					
				elsif buffer_full = '0' and new_data = '1' then	--write to a buffer that's not full if we have new data			
					exp_data <= '1';
					new_data <= '0';
				end if;				
			end if;
		end if;
end process;

end rtl;
