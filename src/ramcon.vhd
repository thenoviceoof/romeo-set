library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ramcon is
	port(
	clk						: in std_logic;
	reset_n					: in std_logic;
	read					: in std_logic;
	write					: in std_logic;
	chipselect				: in std_logic;
	address					: in unsigned(3 downto 0);
	addressout				: in unsigned(3 downto 0);
	
	readaddr				: out unsigned(3 downto 0);
	readdata				: out unsigned(17 downto 0);
	writedata				: in unsigned(31 downto 0)
	);
end ramcon;

architecture ramarch of ramcon is

	type ram_type is array(15 downto 0) of unsigned(17 downto 0);
	signal RAM				: ram_type;
	begin

	process(clk)
	begin
		if rising_edge(clk) then
			readaddr	<= addressout;
			readdata	<= RAM(to_integer(addressout));
			if chipselect = '1' then
				if write = '1' then
					RAM(to_integer(address))	<= writedata(17 downto 0);
				end if;
			end if;
		end if;
	end process;
	
	
end ramarch;
