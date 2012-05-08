library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ramctrl is
	port(
	clk						: in std_logic;
	reset_n					: in std_logic;
	read					: in std_logic;
	write					: in std_logic;
	chipselect				: in std_logic;
	address					: in unsigned(1 downto 0);
	readdata				: out unsigned(1 downto 0);
	writedata				: out unsigned(1 downto 0);

	addressout				: in unsigned(1 downto 0);
	readaddr				: out unsigned(1 downto 0);
	);
end ramcon;

architecture ramarch of ramctrl is

	type ram_type is array(1 downto 0) of unsigned(0 downto 0);
	
	signal RAM				: ram_type;
	signal read_addr		: integer;
	begin

	process(clk)
	begin
		if rising_edge(clk) then
			read_addr	<= to_integer(addressout);
			readaddr	<= addressout;
			readdata	<= RAM(to_integer(addressout));
			if reset_n = '0' then
				read_addr	<= 0;
			else
				if chipselect = '1' and write = '1' then
					RAM(to_integer(address)) <= writedata(17 downto 0);
				end if;
			end if;
		end if;
	end process;
end ramarch;
