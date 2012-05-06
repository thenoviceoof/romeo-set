library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Provides registers for writing to the function modules.
entity de2_ifm_bus is
  
  port (
	clk			: in  std_logic;
	reset_n		: in  std_logic;
	write		: in  std_logic;
	chipselect	: in  std_logic;

	data		: in unsigned(31 downto 0);

	expdata		: out std_logic;

	amin		: out unsigned(35 downto 0); 
	bmin		: out unsigned(35 downto 0);
	adiff		: out unsigned(35 downto 0); 
	bdiff		: out unsigned(35 downto 0);
	aleap		: out unsigned(9 downto 0); 
	bleap		: out unsigned(9 downto 0);

	cro			: out unsigned(35 downto 0);
	cio			: out unsigned(35 downto 0)

    );
  
end de2_ifm_bus;

architecture rtl of de2_ifm_bus is
	signal new_data		: std_logic;
	signal write_type 	: unsigned(3 downto 0);
	
	signal exp_data		: std_logic;
	
	signal a_min		: unsigned(35 downto 0); 
	signal b_min		: unsigned(35 downto 0);
	signal a_diff		: unsigned(35 downto 0); 
	signal b_diff		: unsigned(35 downto 0);
	signal a_leap		: unsigned(9 downto 0); 
	signal b_leap		: unsigned(9 downto 0);

	signal cr			: unsigned(35 downto 0);
	signal ci			: unsigned(35 downto 0);

	begin

	write_type <= data(3 downto 0);
	exp_data <= new_data;
	
	expdata		<= exp_data;
	amin		<= a_min;
	bmin		<= b_min;
	adiff		<= a_diff;
	bdiff		<= b_diff;
	aleap		<= a_leap;
	bleap		<= b_leap;
	cro			<= cr;
	cio			<= ci;
	
	process (clk)
	begin
	if rising_edge(clk) then
		--only write data to the IFM controller if it's ready			
		new_data <= '0';
		-- handle resets and writes
		if reset_n = '0' then
			a_min 		<= (others => '0');
			b_min 		<= (others => '0');
			a_diff 		<= (others => '0');
			b_diff 		<= (others => '0');
			a_leap 		<= (others => '0');
			b_leap 		<= (others => '0');
			cr			<= (others => '0');
			ci			<= (others => '0');
		else
			--read data in from nios and place in appropriate registers
			if chipselect = '1' and write = '1' then
				if write_type = "0000" then
					a_min(35 downto 18) <= data(21 downto 4);
				elsif write_type = "0001" then
					a_min(17 downto 0) <= data(21 downto 4);
				elsif write_type = "0010" then
					b_min(35 downto 18) <= data(21 downto 4);
				elsif write_type = "0011" then
					b_min(17 downto 0) <= data(21 downto 4);
				elsif write_type = "0100" then
					a_diff(35 downto 18) <= data(21 downto 4);
				elsif write_type = "0101" then
					a_diff(17 downto 0) <= data(21 downto 4);
				elsif write_type = "0110" then
					b_diff(35 downto 18) <= data(21 downto 4);
				elsif write_type = "0111" then
					b_diff(17 downto 0) <= data(21 downto 4);
				elsif write_type = "1000" then
					a_leap <= data(23 downto 14);
					b_leap <= data(13 downto 4);
				elsif write_type = "1001" then
					cr(35 downto 18) <= data(21 downto 4);
				elsif write_type = "1010" then
					cr(17 downto 0) <= data(21 downto 4);
				elsif write_type = "1011" then
					ci(35 downto 18) <= data(21 downto 4);
				elsif write_type = "1100" then
					ci(17 downto 0) <= data(21 downto 4);
				elsif write_type = "1111" then
					new_data <= '1';
				end if;
			end if;
		end if; -- end reset_n
	end if;
end process;

end rtl;
