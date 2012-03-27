library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity box is

	port(

	clk			: in std_logic;
	clr			: in std_logic;
	data		: in std_logic;								--Asserted high when data is ready to be read
	xin			: in std_logic_vector(9 downto 0);
	yin			: in std_logic_vector(8 downto 0);
	ain			: in std_logic_vector(17 downto 0);
	bin			: in std_logic_vector(17 downto 0);
	xout		: out std_logic_vector(9 downto 0);
	yout		: out std_logic_vector(8 downto 0);
	count		: out unsigned(6 downto 0);					--Data to be written in memory
	full		: out std_logic;
	we			: out std_logic								-- Write enable

	);
end box;

architecture qq of box is
--INPUT BUFFER:
signal d0		: std_logic							:= '0';		-- Valid data at this stage
signal a0		: std_logic_vector(17 downto 0);
signal b0		: std_logic_vector(17 downto 0);
signal x0		: std_logic_vector(9 downto 0);
signal y0		: std_logic_vector(8 downto 0);
signal d1		: std_logic							:= '0';		-- Valid data at this stage
signal a1		: std_logic_vector(17 downto 0);
signal b1		: std_logic_vector(17 downto 0);
signal x1		: std_logic_vector(9 downto 0);
signal y1		: std_logic_vector(8 downto 0);
signal d2		: std_logic							:= '0';		-- Valid data at this stage
signal a2		: std_logic_vector(17 downto 0);
signal b2		: std_logic_vector(17 downto 0);
signal x2		: std_logic_vector(9 downto 0);
signal y2		: std_logic_vector(8 downto 0);
--OUTPUT BUFFER:
signal w0		: std_logic;
signal count0	: unsigned(6 downto 0);
signal xo0		: std_logic_vector(9 downto 0);
signal yo0		: std_logic_vector(8 downto 0);
signal w1		: std_logic;
signal count1	: unsigned(6 downto 0);
signal xo1		: std_logic_vector(9 downto 0);
signal yo1		: std_logic_vector(8 downto 0);
signal w2		: std_logic;
signal count2	: unsigned(6 downto 0);
signal xo2		: std_logic_vector(9 downto 0);
signal yo2		: std_logic_vector(8 downto 0);

signal wenable	: std_logic							:= '0';
signal clear	: std_logic							:= '0';
signal comp		: std_logic							:= '0';
signal done		: std_logic;
signal standby	: unsigned(1 downto 0)		:= "00";	-- Used to set and reset the IFM

	begin

	full <= d1;

	process(clk)
	begin
	if rising_edge(clk) then

-- OUTPUT BUFFER:
	xout		<= xo2;
	yout		<= yo2;
	we			<= w2;
	count		<= count2;

	xo2			<= xo1;
	yo2			<= yo1;
	w2			<= w1;
	count2		<= count1;

	xo1			<= xo0;
	yo1			<= yo0;
	w1			<= w0;
	count1		<= count0;

-- INPUT BUFFER:
		if d1 = '0' then
			if data = '1' then
				a1			<= ain;
				b1			<= bin;
				x1			<= xin;
				y1			<= yin;
				d1			<= '1';
			else
				d1			<= '0';
			end if;
		end if;

--		if d1 = '0' then
--			if d2 = '1' then
--				a1			<= a2;
--				b1			<= b2;
--				x1			<= x2;
--				y1			<= y2;
--				d1			<= d2;
--				d2			<= '0';
--			else
--				d1			<= '0';
--			end if;
--		end if;

		if d0 = '0' then
			if d1 = '1' then
				a0			<= a1;
				b0			<= b1;
				x0			<= x1;
				y0			<= y1;
				d0			<= d1;
				d1			<= '0';
			else
				d0			<= '0';
			end if;
		end if;

		if done = '1' then
			standby		<= "00";
			w0			<= '1';
		end if;

		if 		standby = "00" then
			comp	<= '0';
			clear	<= '1';
			w0		<= '0';
		elsif	standby = "01" then
			clear	<= '0';
			w0		<= '0';
		elsif	standby = "10" then
			if d0 = '1' then
				comp	<= '1';
				d0		<= '0';
			end if;
			w0		<= '0';
		end if;

		if standby /= "11" then
			standby		<= standby + 1;
		end if;

	end if;
	end process;

	ifm:	entity work.two port map(

	clock		=> clk,
	aclr		=> clear,
	compute		=> comp,
	xin			=> x0,
	yin			=> y0,
	a			=> a0,
	b			=> b0,
	xout		=> xo0,
	yout		=> yo0,
	count		=> count0,
	don			=> done
	);

end qq;