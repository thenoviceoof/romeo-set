---------------------------------------------------------------------
--hook.vhd
--
--This is the place where the IFMs and their controller connect with
--the window generator that feeds the IFMs.
--
--Author: Luis E. P.
---------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hook is
	port(
	clk25		: in std_logic;
	reset		: in std_logic;								-- Clear
	a_min		: in signed(35 downto 0);
	a_diff		: in signed(35 downto 0);
	a_leap		: in unsigned(9 downto 0);
	b_min		: in signed(35 downto 0);
	b_diff		: in signed(35 downto 0);
	b_leap		: in unsigned(9 downto 0);
	cr  		: in signed(35 downto 0);
	ci  		: in signed(35 downto 0);
	xout		: out std_logic_vector(9 downto 0);
	yout		: out std_logic_vector(8 downto 0);
	count		: out unsigned (7 downto 0);
	we  		: out std_logic
	);

end hook;

architecture first of hook is
	signal nxt		: std_logic;
	signal ai		: std_logic_vector(35 downto 0);
	signal bi		: std_logic_vector(35 downto 0);
	signal x		: std_logic_vector(9 downto 0);
	signal yi		: std_logic_vector(8 downto 0);
	signal yo		: std_logic_vector(9 downto 0);
	signal data		: std_logic;
	
	begin
	yi <= yo(8 downto 0);

	gen: entity work.window_gen port map(
		clk 		=> clk25,
		next_val	=> nxt,
		reset		=> reset,
		a_min		=> a_min,
		a_diff		=> a_diff,
		a_leap		=> a_leap,
		b_min		=> b_min,
		b_diff		=> b_diff,
		b_leap		=> b_leap,
		a_out		=> ai,
		b_out		=> bi,
		x_out		=> x,
		y_out		=> yo,
		ready		=> data
	);

	ifm: entity work.ifmunitd port map(
		clk25		=> clk25,
		reset		=> reset,
		data		=> data,
		xin 		=> x,
		yin 		=> yi,
		ain 		=> ai,
		bin 		=> bi,
		cr  		=> cr,
		ci  		=> ci,
		xout		=> xout,
		yout		=> yout,
		count		=> count,
		full		=> nxt,
		we  		=> we
	);

end first;
