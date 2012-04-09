library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifmunittb is
end ifmunittb;

architecture test of ifmunittb is
	signal	clock,reset	: std_logic				:= '1';
	signal	da,db		: std_logic_vector(17 downto 0);
	signal xi			: std_logic_vector(9 downto 0);
	signal yi			: std_logic_vector(8 downto 0);
	signal xo			: std_logic_vector(9 downto 0);
	signal yo			: std_logic_vector(8 downto 0);
	signal ct			: unsigned(7 downto 0);
	signal full,data	: std_logic;
	signal done,compute	: unsigned(7 downto 0);
	signal we			: std_logic;

component unit
	port(
	clk			: in std_logic;
	reset		: in std_logic		:= '1';
	data		: in std_logic;							--Asserted high when data is ready to be read
	xin			: in std_logic_vector(9 downto 0);
	yin			: in std_logic_vector(8 downto 0);
	ain			: in std_logic_vector(17 downto 0);
	bin			: in std_logic_vector(17 downto 0);
	xout		: out std_logic_vector(9 downto 0);
	yout		: out std_logic_vector(8 downto 0);
	count		: out unsigned(7 downto 0);
	full		: out std_logic;
	done		: out unsigned(7 downto 0);
	compute		: out unsigned(7 downto 0);
	we			: out std_logic
		);
end component;

begin

	clock <= not clock after 10 ns;			-- 50 MHz

	process
	begin
	
		wait for 40ns;
		reset	<= '0';


		wait for 40ns;
		da		<= "000000101101010000";
		db		<= "000000101101010001";
		xi		<= "1111111111";
		yi		<= "111111111";
		data	<= '1';

		wait for 40 ns;
		da		<= "000000101101010001";
		db		<= "000000101101010001";
		xi		<= "0111111111";
		yi		<= "011111111";
		
		wait for 40 ns;
		da		<= "000000101101010000";
		db		<= "000000101101010000";
		xi		<= "1011111111";
		yi		<= "101111111";
		
		wait for 40 ns;
		
		da		<= "000000101101010001";
		db		<= "000111111101010001";
		xi		<= "1101111111";
		yi		<= "110111111";
		
		wait for 20 ns;
		
		da		<= "000100000001010000";
		db		<= "000000101101010001";
		xi		<= "1110111111";
		yi		<= "111011111";

		wait for 40 ns;
		da		<= "000110101101010001";
		db		<= "000011111101010001";
		xi		<= "1111011111";
		yi		<= "111101111";
		
		wait for 20 ns;
		da		<= "000000101101010000";
		db		<= "000000101101010000";
		xi		<= "1111101111";
		yi		<= "111110111";
		wait for 20 ns;
	end process;

uut:	unit
	port map(
	clk			=> clock,
	reset		=> reset,
	data		=> data,
	xin			=> xi,
	yin			=> yi,
	ain			=> da,
	bin			=> db,
	xout		=> xo,
	yout		=> yo,
	count		=> ct,
	full		=> full,
	done		=> done,
	compute		=> compute,
	we			=> we
	);

end test;