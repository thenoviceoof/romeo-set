library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifmunitdtb is
end ifmunitdtb;

architecture test of ifmunitdtb is
	signal clk50,clk25	: std_logic				:= '1';
	signal reset		: std_logic				:= '1';
	signal ain,bin		: std_logic_vector(35 downto 0);
	signal aout,bout	: std_logic_vector(35 downto 0);
	signal xi			: std_logic_vector(9 downto 0);
	signal yi			: std_logic_vector(8 downto 0);
	signal xo			: std_logic_vector(9 downto 0);
	signal yo			: std_logic_vector(8 downto 0);
	signal ct			: unsigned(7 downto 0);
	signal full,data	: std_logic;
	signal done,compute	: unsigned(3 downto 0);
	signal we			: std_logic;

component ifmunitd
	port(
	clk25		: in std_logic;
	clk50		: in std_logic;
	reset		: in std_logic;
	data		: in std_logic;								--Asserted high when data is ready to be read
	xin			: in std_logic_vector(9 downto 0);
	yin			: in std_logic_vector(8 downto 0);
	ain			: in std_logic_vector(35 downto 0);
	bin			: in std_logic_vector(35 downto 0);
	xout		: out std_logic_vector(9 downto 0);
	yout		: out std_logic_vector(8 downto 0);
	aout		: out std_logic_vector(35 downto 0);
	bout		: out std_logic_vector(35 downto 0);
	count		: out unsigned(7 downto 0);					--Data to be written in memory
	full		: out std_logic;
	done		: out unsigned(3 downto 0);
	compute		: out unsigned(3 downto 0);
	we			: out std_logic								-- Write enable
		);
end component;

begin

	clk50 <= not clk50 after 10 ns;			-- 50 MHz
	clk25 <= not clk25 after 20 ns;			-- 25 MHz

	process
	begin
	
		wait for 40 ns;
		reset	<= '0';


		wait for 40 ns;
		ain		<= "000000101101010000000000101101010000";
		bin		<= "000000101101010001000000101101010001";
		xi		<= "1111111111";
		yi		<= "111111111";
		data	<= '1';

		wait for 40 ns;
		ain		<= "000000000000000000000000101101010001";
		bin		<= "000000000000000000000000101101010001";
		xi		<= "0111111111";
		yi		<= "011111111";
		
		wait for 40 ns;
		ain		<= "000000101101010000000000000000000000";
		bin		<= "000000101101010000000000000000000000";
		xi		<= "1011111111";
		yi		<= "101111111";
		
		wait for 40 ns;
		
		ain		<= "000000000000000000000111111101010001";
		bin		<= "000111111101010001000111111101010001";
		xi		<= "1101111111";
		yi		<= "110111111";
		
		wait for 20 ns;
		
		ain		<= "000100000001010000000111111101010001";
		bin		<= "000000101101010001000000101101010001";
		xi		<= "1110111111";
		yi		<= "111011111";

		wait for 40 ns;
		ain		<= "000110101101010001000110101101010001";
		bin		<= "000011111101010001000110101101010001";
		xi		<= "1111011111";
		yi		<= "111101111";
		
		wait for 20 ns;
		ain		<= "000000101101010000111111111111111111";
		bin		<= "000000101101010000000000101101010000";
		xi		<= "1111101111";
		yi		<= "111110111";
		wait for 20 ns;
	end process;

uut:	ifmunitd
	port map(
	clk25		=> clk25,
	clk50		=> clk50,
	reset		=> reset,
	data		=> data,
	xin			=> xi,
	yin			=> yi,
	ain			=> ain,
	bin			=> bin,
	xout		=> xo,
	yout		=> yo,
	aout		=> aout,
	bout		=> bout,
	count		=> ct,
	full		=> full,
	done		=> done,
	compute		=> compute,
	we			=> we
	);

end test;