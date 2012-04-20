library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- this module expects to bridge from 50Mhz writes to 25MHz reads
entity sram is
	port(
		-- clocks
		clk_50 : in std_logic;
		clk_25 : in std_logic;
	
		-- SRAM_DQ, 16 bit data
		sram_data : inout std_logic_vector(15 downto 0);
		-- SRAM_ADDR, 18 bit address space (256k)
		sram_addr : out std_logic_vector(17 downto 0);
		-- SRAM_UB_N, *LB_N, upper and lower byte masks
		sram_ub_n,
		sram_lb_n,
		-- SRAM_WE_N, write enable
		sram_we_n,
		-- SRAM_CE_N, chip enable (power up chip)
		sram_ce_n,
		-- SRAM_OE_N, output enable (when reading)
		sram_oe_n : out std_logic;
	
		-- 640<1024 (10 bits)
		rx : in std_logic_vector(9 downto 0);
		-- 480<512  (9 bits)
		ry : in std_logic_vector(8 downto 0);
		-- same, but for writing
		wx : in std_logic_vector(9 downto 0);
		wy : in std_logic_vector(8 downto 0);
		-- read/write values (8 bits)
		rv : out std_logic_vector(7 downto 0);
		wv : in std_logic_vector(7 downto 0);
		-- read/write controls
		-- reading takes precedence
		re : in std_logic;
		we : in std_logic
	);
end sram;

architecture sram_arch of sram is
	signal addr : std_logic_vector(17 downto 0);
	-- temp addr signals
	signal raddr : std_logic_vector(18 downto 0);
	signal waddr : std_logic_vector(18 downto 0);

	-- byte mask, due to 16bit words in SRAM
	signal mask : std_logic_vector(1 downto 0);

	-- handle reading from the SRAM
	signal re_count : unsigned(1 downto 0) := "11";
	signal rre : std_logic; -- really read-enable
	-- a register for the stored read bits
	signal hold : std_logic;
	signal rhold : std_logic_vector(15 downto 0);

	-- buffer for writes, length 2
	signal we_buffer : std_logic;
	signal wv_buffer : std_logic_vector(7 downto 0);
	signal waddr_buffer : std_logic_vector(18 downto 0);
--	signal wdup : std_logic := '0';

	signal rwe : std_logic; -- really write-enable

begin
	-- determine whether we really need to read from the SRAM
	rre <= re when (re_count="00" and (not rwe='1')) else '0';
	-- determine if we should really write to the SRAM
	-- rwe <= (we and (not wdup)); -- don't know why, but this is not better
	rwe <= we;

	-- generate the address
	raddr <= ry(8 downto 0) & rx(9 downto 0);
	-- for the waddr
	waddr <= wy(8 downto 0) & wx(9 downto 0);
	addr <= waddr(18 downto 1) when rwe='1' else raddr(18 downto 1);

	-- find out if we need to mask either byte
	mask <= "01" when rwe='1' and waddr(0)='0' else
			"10" when rwe='1' and waddr(0)='1' else
			"11" when rre='1' else -- always read both bytes
			"00"; -- don't read anything by default

	-- sram outputs
	sram_addr <= addr;
	-- going to have to redo this part, migth have to use both bytes
	sram_ub_n <= not mask(1);
	sram_lb_n <= not mask(0);
	-- only enable write enable when, well, writing
	sram_we_n <= not rwe;
	-- only enable the output when reading
	sram_oe_n <= not rre;
	-- always power up the chip
	sram_ce_n <= '0';

	-- try to generate the right data
	sram_data <= wv & "00000000" when (waddr(0)='1' and rwe='1') else
				"00000000" & wv when (waddr(0)='0' and rwe='1') else
				(others => 'Z');
	-- module outputs
	rv <= sram_data(7 downto 0) when rre='1' else
			rhold(7 downto 0) when (hold='1' and re='1' and raddr(0)='0') else
			rhold(15 downto 8) when (hold='1' and re='1' and raddr(0)='1') else
			"00000000";

	-- handle synchronous things
	process(clk_50)
	begin
		if rising_edge(clk_50) then

			-- increment the re_count, keeps track of when to really read
			if re='1' then
				re_count <= re_count + "01";
			else
				re_count <= re_count;
			end if;

			-- save the results of the read
			hold <= hold;
			rhold <= rhold;
			if rre='1' then
				hold <= '1';
				rhold <= sram_data;
			elsif (re_count="11" and rwe='1') then
				-- we're supposed to get updated, but won't
				hold <= '0';
				rhold <= (others => '0');
			end if;

			-- buffer for writes, mostly to check for dupes
			we_buffer <= we;
			wv_buffer <= wv;
			waddr_buffer <= waddr;
--			if waddr=waddr_buffer then
--				wdup <= '1';
--			else
--				wdup <= '0';
--			end if;

		end if;
	end process;
end sram_arch;
