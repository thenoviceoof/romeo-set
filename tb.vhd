library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture test of tb is
	signal	clock		: std_logic				:= '0';
	signal	da,db		: std_logic_vector(17 downto 0);
	signal xi,xo		: std_logic_vector(9 downto 0);
	signal yi,yo		: std_logic_vector(8 downto 0);
	signal ct			: unsigned(6 downto 0);
	signal full,data	: std_logic;
	signal we			: std_logic;

component parallel
	port(
	clk			: in std_logic;
	data		: in std_logic;							--Asserted high when data is ready to be read
	xin			: in std_logic_vector(9 downto 0);
	yin			: in std_logic_vector(8 downto 0);
	ain			: in std_logic_vector(17 downto 0);
	bin			: in std_logic_vector(17 downto 0);
	xout		: out std_logic_vector(9 downto 0);
	yout		: out std_logic_vector(8 downto 0);
	count		: out unsigned(6 downto 0);
	full		: out std_logic;
	we			: out std_logic
		);
end component;

begin

	clock <= not clock after 20 ns;			-- 50 MHz

	process
	begin
		da		<= "000000101101010001";
		db		<= "000000101101010000";
		xi		<= "1111110000";
		yi		<= "111110000";
		data	<= '1';

		wait for 200 ns;
		da		<= "000000101101010001";
		db		<= "000000101101010001";
		xi		<= "1111111111";
		yi		<= "111111111";
		
		wait for 20 ns;
		da		<= "000000101101010000";
		db		<= "000000101101010000";
		xi		<= "0000000000";
		yi		<= "000000000";
		
		wait for 140 ns;
		
		da		<= "000000101101010001";
		db		<= "000000101101010001";
		xi		<= "1111111111";
		yi		<= "111111111";
		
		wait for 100 ns;
		
		da		<= "000100101101010001";
		db		<= "000000101101010001";
		xi		<= "0000011111";
		yi		<= "000011111";

	end process;

uut:	parallel
	port map(
	clk			=> clock,
	data		=> data,
	xin			=> xi,
	yin			=> yi,
	ain			=> da,
	bin			=> db,
	xout		=> xo,
	yout		=> yo,
	count		=> ct,
	full		=> full,
	we			=> we
	);

end test;