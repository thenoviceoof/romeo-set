library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifmdtb is
end ifmdtb;

architecture test of ifmdtb is
	signal	clock		: std_logic				:= '1';
	signal	clr			: std_logic				:= '0';
	signal	comp		: std_logic				:= '0';
	signal ain,bin		: std_logic_vector(35 downto 0);
	signal aout,bout	: std_logic_vector(35 downto 0);
	signal xi			: std_logic_vector(9 downto 0);
	signal yi			: std_logic_vector(8 downto 0);
	signal xo			: std_logic_vector(9 downto 0);
	signal yo			: std_logic_vector(8 downto 0);

	signal ct			: unsigned(7 downto 0);
	signal done, rd		: std_logic;

component ifmd
	port(
	clock		: in std_logic;								-- Global clock
	clr			: in std_logic;								-- Clear
	compute		: in std_logic;								-- Controls when IFM starts iterating. Set high to start iterations
	xin			: in std_logic_vector(9 downto 0);			-- The x coordinate input
	yin			: in std_logic_vector(8 downto 0);			-- The y coordinate input
	ain			: in std_logic_vector(35 downto 0);			-- Real part of input
	bin			: in std_logic_vector(35 downto 0);			-- Imaginary part of input
	aout		: out std_logic_vector(35 downto 0);			-- Real part of input
	bout		: out std_logic_vector(35 downto 0);			-- Imaginary part of input
	xout		: out std_logic_vector(9 downto 0);			-- The x coordinate output
	yout		: out std_logic_vector(8 downto 0);			-- The y coordinate output
	count		: out unsigned(7 downto 0);					-- Iteration count
	don			: out std_logic;							-- Becomes high when the iterator is done iterating
	ready		: out std_logic								-- Becomes high when the IFM is ready for new data
		);
end component;

begin

	clock <= not clock after 10 ns;			-- 50 MHz


	process
	begin
		clr 	<= '1';
		comp	<= '0';
		
		wait for 20 ns;
		clr		<= '0';
		ain	<= "111111111111111111111111111111111111";
		bin	<= "000000000000000000000000000000000000";
		xi	<= "1111111111";
		yi	<= "000000000";

		wait for 20 ns;
		clr		<= '0';
		comp	<= '1';

		wait for 5000 ns;
		clr 	<= '1';
		comp	<= '0';
		ain	<= "000000101101010001000000101101010001";
		bin	<= "000000101101010001000000101101010001";
		xi	<= "0100111010";
		yi	<= "100111010";
		wait for 20 ns;
		clr		<= '0';
		wait for 20 ns;
		comp	<= '1';
		

		wait for 5000 ns;
		clr 	<= '1';
		comp	<= '0';
		ain	<= "000000000000000000000000000000000000";
		bin	<= "111111111111111111111111111111111111";
		xi	<= "0000000000";
		yi	<= "111111111";

		wait for 20 ns;
		clr		<= '0';
		wait for 100 ns;
		comp	<= '1';

		wait;
	end process;

uut:	ifmd
	port map(
		clock		=> clock,
		clr			=> clr,
		compute		=> comp,
		xin			=> xi,
		yin			=> yi,
		ain			=> ain,
		bin			=> bin,
		aout		=> aout,
		bout		=> bout,
		xout		=> xo,
		yout		=> yo,
		count		=> ct,
		don			=> done,
		ready		=> rd
	);

end test;