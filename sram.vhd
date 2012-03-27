library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram is
	port(
		sram_data : inout std_logic_vector(15 downto 0);
		sram_addr : out std_logic_vector(17 downto 0);
		sram_ub_n,
		sram_lb_n,
		sram_we_n,
		sram_ce_n,
		sram_oe_n : out std_logic;
		
		x : in std_logic_vector(9 downto 0); -- 640<1024 (10b)
		y : in std_logic_vector(8 downto 0); -- 480<512  (9b)
		rv : out std_logic_vector(7 downto 0);
		wv : in std_logic_vector(7 downto 0);
		-- !!! we need two ports, but we have one. how do we overcome this?
		-- !!! some sort of time-multiplexing? (ie. shift register)
		-- !!! concievably, the input queue could never let up
		-- !!! so how could we draw without dropping?
		-- !!! maybe we have something like 8 write-waits, and drop after that?
		re : in std_logic -- control whether to read data
		we : in std_logic -- control whether to write data
	);
end sram;

architecture sram_arch of sram is
	signal addr : std_logic_vector(17 downto 0);
	signal upper : std_logic;
	signal lower : std_logic;
begin
	-- generate the address
	addr <= x(9 downto 0) & y(8 downto 1);
	upper <= y(0);
	
	-- sram outputs
	sram_addr <= addr;
	sram_ub_n <= NOT upper;
	sram_lb_n <= upper;
	sram_we_n <= NOT we;
	sram_ce_n <= '0'; -- always enable the chip
	sram_oe_n <= we;
	sram_data <= wv & "00000000" when (upper='1' AND we='1') else
				 "00000000" & wv when (upper='0' AND we='1') else
				 (others => 'Z'); -- we='0', reading
	-- module outputs
	rv <= sram_data(15 downto 8) when (upper='1' AND we='0') else
	      sram_data(7 downto 0) when (upper='0' AND we='0') else
		  "00000000";
end sram_arch;