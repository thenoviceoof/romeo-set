library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifmtb is
end ifmtb;

architecture test of ifmtb is
	signal	clock		: std_logic				:= '1';
	signal	clr			: std_logic				:= '0';
	signal	comp		: std_logic				:= '0';
	signal	da,db		: std_logic_vector(17 downto 0);
	signal xi			: std_logic_vector(9 downto 0);
	signal yi			: std_logic_vector(8 downto 0);
	signal xo			: std_logic_vector(9 downto 0);
	signal yo			: std_logic_vector(8 downto 0);

	signal ct			: unsigned(7 downto 0);
	signal done, rd		: std_logic;

component ifm
	port(
	clock		: in std_logic;								-- Global clock
	clr			: in std_logic;								-- Clear
	compute		: in std_logic;								-- Compute command
	xin			: in std_logic_vector(9 downto 0);			-- The x coordinate input
	yin			: in std_logic_vector(8 downto 0);			-- The y coordinate input
	a			: in std_logic_vector(17 downto 0);			-- Real part of input
	b			: in std_logic_vector(17 downto 0);			-- Imaginary part of input
	xout		: out std_logic_vector(9 downto 0);			-- The x coordinate output
	yout		: out std_logic_vector(8 downto 0);
	count		: out unsigned(7 downto 0);
	don			: out std_logic;
	ready		: out std_logic
		);
end component;

begin

	clock <= not clock after 10 ns;			-- 50 MHz


	process
	begin
		clr 	<= '1';
		comp	<= '0';
		da	<= "000000101101010001";
		db	<= "000000101101010000";
		xi	<= "1111111111";
		yi	<= "111111111";

		wait for 20 ns;
		clr		<= '0';
		comp	<= '1';

		wait for 5000 ns;
		clr 	<= '1';
		comp	<= '0';
		da	<= "000000101101010001";
		db	<= "000000101101010001";
		xi	<= "0111111111";
		yi	<= "011111111";

		wait for 20 ns;
		clr		<= '0';
		wait for 20 ns;
		comp	<= '1';
		

		wait for 5000 ns;
		clr 	<= '1';
		comp	<= '0';
		da	<= "000000101101010000";
		db	<= "000000101101010000";
		xi	<= "1011111111";
		yi	<= "101111111";

		wait for 20 ns;
		clr		<= '0';
		wait for 100 ns;
		comp	<= '1';

		wait;
	end process;

uut:	ifm
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
		don			=> done,
		ready		=> rd
	);

end test;