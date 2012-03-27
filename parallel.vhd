library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parallel is

	port(

	clk			: in std_logic;
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
end parallel;

architecture qq of parallel is
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

--OUTPUT BUFFER:
signal w0		: std_logic				:= '0';
signal count0	: unsigned(6 downto 0);
signal xo0		: std_logic_vector(9 downto 0);
signal yo0		: std_logic_vector(8 downto 0);
signal w1		: std_logic				:= '0';
signal count1	: unsigned(6 downto 0);
signal xo1		: std_logic_vector(9 downto 0);
signal yo1		: std_logic_vector(8 downto 0);
signal w2		: std_logic				:= '0';
signal count2	: unsigned(6 downto 0);
signal xo2		: std_logic_vector(9 downto 0);
signal yo2		: std_logic_vector(8 downto 0);

signal ct0		: unsigned(6 downto 0);
signal xif0		: std_logic_vector(9 downto 0);
signal yif0		: std_logic_vector(8 downto 0);
signal ct1		: unsigned(6 downto 0);
signal xif1		: std_logic_vector(9 downto 0);
signal yif1		: std_logic_vector(8 downto 0);
signal ct2		: unsigned(6 downto 0);
signal xif2		: std_logic_vector(9 downto 0);
signal yif2		: std_logic_vector(8 downto 0);
signal ct3		: unsigned(6 downto 0);
signal xif3		: std_logic_vector(9 downto 0);
signal yif3		: std_logic_vector(8 downto 0);

signal clear0	: std_logic							:= '0';
signal comp0	: std_logic							:= '0';
signal done0	: std_logic;
signal standby0	: unsigned(1 downto 0)		:= "00";	-- Used to set and reset the IFM
signal clear1	: std_logic							:= '0';
signal comp1	: std_logic							:= '0';
signal done1	: std_logic;
signal standby1	: unsigned(1 downto 0)		:= "00";	-- Used to set and reset the IFM
signal clear2	: std_logic							:= '0';
signal comp2	: std_logic							:= '0';
signal done2	: std_logic;
signal standby2	: unsigned(1 downto 0)		:= "00";	-- Used to set and reset the IFM
signal clear3	: std_logic							:= '0';
signal comp3	: std_logic							:= '0';
signal done3	: std_logic;
signal standby3	: unsigned(1 downto 0)		:= "00";	-- Used to set and reset the IFM


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

-- IFM ZERO
		if done0 = '1' or standby0 /= "11" then
		if done0 = '1' then
			standby0	<= "00";
			count0		<= ct0;
			xo0			<= xif0;
			yo0			<= yif0;
			w0			<= '1';
		end if;

		if 		standby0 = "00" then
			comp0	<= '0';
			clear0	<= '1';
			w0		<= '0';
		elsif	standby0 = "01" then
			clear0	<= '0';
			w0		<= '0';
		elsif	standby0 = "10" then
			if d0 = '1' then
				comp0	<= '1';
				d0		<= '0';
			end if;
			w0		<= '0';
		end if;

		if standby0 /= "11" then
			standby0		<= standby0 + 1;
		end if;
-- END OF IFM ZERO

-- IFM ONE
		elsif done1 = '1' or standby1 /= "11" then
		if done1 = '1' then
			standby1	<= "00";
			count0		<= ct1;
			xo0			<= xif1;
			yo0			<= yif1;
			w0			<= '1';
		end if;

		if 		standby1 = "00" then
			comp1	<= '0';
			clear1	<= '1';
			w0		<= '0';
		elsif	standby1 = "01" then
			clear1	<= '0';
			w0		<= '0';
		elsif	standby1 = "10" then
			if d0 = '1' then
				comp1	<= '1';
				d0		<= '0';
			end if;
			w0		<= '0';
		end if;

		if standby1 /= "11" then
			standby1		<= standby1 + 1;
		end if;
-- END OF IFM ONE

-- IFM TWO
		elsif done2 = '1' or standby2 /= "11" then
		if done2 = '1' then
			standby2	<= "00";
			count0		<= ct2;
			xo0			<= xif2;
			yo0			<= yif2;
			w0			<= '1';
		end if;

		if 		standby2 = "00" then
			comp2	<= '0';
			clear2	<= '1';
			w0		<= '0';
		elsif	standby2 = "01" then
			clear2	<= '0';
			w0		<= '0';
		elsif	standby2 = "10" then
			if d0 = '1' then
				comp2	<= '1';
				d0		<= '0';
			end if;
			w0		<= '0';
		end if;

		if standby2 /= "11" then
			standby2		<= standby2 + 1;
		end if;
--END OF IFM TWO

--IFM THREE
		elsif done3 = '1' or standby3 /= "11" then
		if done3 = '1' then
			standby3	<= "00";
			count0		<= ct3;
			xo0			<= xif3;
			yo0			<= yif3;
			w0			<= '1';
		end if;

		if 		standby3 = "00" then
			comp3	<= '0';
			clear3	<= '1';
			w0		<= '0';
		elsif	standby3 = "01" then
			clear3	<= '0';
			w0		<= '0';
		elsif	standby3 = "10" then
			if d0 = '1' then
				comp3	<= '1';
				d0		<= '0';
			end if;
			w0		<= '0';
		end if;

		if standby3 /= "11" then
			standby3		<= standby3 + 1;
		end if;
		end if;
-- END OF IFM THREE

	end if;
	end process;

	ifm0:	entity work.ifmunit port map(

	clock		=> clk,
	clr			=> clear0,
	compute		=> comp0,
	xin			=> x0,
	yin			=> y0,
	a			=> a0,
	b			=> b0,
	xout		=> xif0,
	yout		=> yif0,
	count		=> ct0,
	don			=> done0
	);

	ifm1:	entity work.ifmunit port map(

	clock		=> clk,
	clr			=> clear1,
	compute		=> comp1,
	xin			=> x0,
	yin			=> y0,
	a			=> a0,
	b			=> b0,
	xout		=> xif1,
	yout		=> yif1,
	count		=> ct1,
	don			=> done1
	);

	ifm2:	entity work.ifmunit port map(

	clock		=> clk,
	clr			=> clear2,
	compute		=> comp2,
	xin			=> x0,
	yin			=> y0,
	a			=> a0,
	b			=> b0,
	xout		=> xif2,
	yout		=> yif2,
	count		=> ct2,
	don			=> done2
	);

	ifm3:	entity work.ifmunit port map(

	clock		=> clk,
	clr			=> clear3,
	compute		=> comp3,
	xin			=> x0,
	yin			=> y0,
	a			=> a0,
	b			=> b0,
	xout		=> xif3,
	yout		=> yif3,
	count		=> ct3,
	don			=> done3
	);
end qq;