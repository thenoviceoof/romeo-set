library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ramctrl is
	port(
	clk						: in std_logic;
	reset_n					: in std_logic;
	write					: in std_logic;
	chipselect				: in std_logic;
	address					: in unsigned(0 downto 0);
	writedata				: in unsigned(7 downto 0);

	read_data				: out unsigned(1 downto 0)
	);
end ramctrl;

architecture ramarch of ramctrl is

	-- do we need to write to the bits seperately?
	signal reg : unsigned(1 downto 0);

	begin

	process(clk)
	begin
		if rising_edge(clk) then
			read_data	<= reg;
			
			if chipselect = '1' and write = '1' then
				reg <= writedata(1 downto 0);
			end if;
		end if;
	end process;
end ramarch;
