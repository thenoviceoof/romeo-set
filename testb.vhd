library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testb is
end testb;

architecture test of testb is
	signal	clock		: std_logic				:= '0';
	signal	clr			: std_logic				:= '0';
	signal	comp		: std_logic				:= '0';
	signal	da,db		: std_logic_vector(17 downto 0);
	signal xi,xo		: std_logic_vector(9 downto 0);
	signal yi,yo		: std_logic_vector(8 downto 0);

	signal ct			: unsigned(6 downto 0);
	signal done			: std_logic;

component ifmunit
	port(
	clock		: in std_logic;		-- Global clock
	clr			: in std_logic;		-- Asynchronous clear
	compute		: in std_logic;		-- Compute command
	xin			: in std_logic_vector(9 downto 0);			-- The x coordinate input
	yin			: in std_logic_vector(8 downto 0);			-- The y coordinate input
	a			: in std_logic_vector(17 downto 0);			-- Real part of input
	b			: in std_logic_vector(17 downto 0);			-- Imaginary part of input
	xout		: out std_logic_vector(9 downto 0);			-- The x coordinate output
	yout		: out std_logic_vector(8 downto 0);
	count		: out unsigned(6 downto 0);
	don			: out std_logic
		);
end component;

begin

	clock <= not clock after 20 ns;			-- 50 MHz

	process
	begin
		clr		<= '1';
		da	<= "000000101101010001";
		db	<= "000000101101010000";
		xi	<= "0101001010";
		yi	<= "010100101";

		wait for 80 ns;
		clr		<= '0';

		wait for 80 ns;
		comp	<= '1';

		wait for 2000 ns;
		clr 	<= '1';
		comp	<= '0';
		da	<= "000000101101010001";
		db	<= "000000101101010000";

		wait for 80 ns;
		clr		<= '0';

		wait for 80 ns;
		comp	<= '1';

		wait;
	end process;

uut:	ifmunit
	port map(
		clock		=> clock,
		clr			=> clr,
		compute		=> comp,
		xin			=> xi,
		yin			=> yi,
		a			=> da,
		b			=> db,
		xout		=> xo,
		yout		=> yo,
		count		=> ct,
		don			=> done
	);

end test;