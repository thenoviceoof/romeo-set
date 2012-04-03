library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- this module expects to bridge from 50Mhz writes to 25MHz reads
entity sram is
  port(
    -- clocks
    clk_50 : std_logic;
    clk_25 : std_logic;

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
  signal raddr : std_logic_vector(17 downto 0);
  signal waddr : std_logic_vector(17 downto 0);

  -- byte mask, due to 16bit words in SRAM
  signal mask : std_logic_vector(1 downto 0);

  -- handle reading from the SRAM
  signal re_count : unsigned(1 downto 0);
  signal rre : std_logic;
  -- a register for the stored bits
  signal rhold : std_logic_vector(15 downto 0);

  -- buffer for writes, length 2
  signal we_buffer : std_logic_vector(1 downto 0);
  signal wv_buffer : std_logic_vector(15 downto 0);
  signal waddr_buffer : std_logic_vector(37 downto 0); -- 19 each
  -- outputs from the buffer, r for really
  signal rwe : std_logic;
  signal rwv : std_logic_vector(7 downto 0);
  signal rwaddr : std_logic_vector(18 downto 0);
begin
  -- determine whether we really need to read from the SRAM
  rre <= re when re_count="00" else '0';
  -- and fetch the rest of the results from the write buffer
  rwe <= we_buffer(0) and (not rre); -- + check rre
  rwv <= wv_buffer(7 downto 0);
  rwaddr <= waddr_buffer(18 downto 0);

  -- generate the address
  raddr <= ry(8 downto 0) & rx(9 downto 1);
  -- for the waddr
  waddr <= wy(8 downto 0) & wx(9 downto 0)
  rwaddr <= waddr_buffer(18 downto 1);
  addr <= raddr when rre='1' else rwaddr;
  -- get the last bit
  last <= rx(0) when rre='1' else rwaddr(0);

  -- find out if we need to mask either byte
  mask <= "11" when rre else -- always read both bytes
          "01" when last='0' else 
          "10"; -- last='1'
  
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
  sram_data <= rwv & "00000000" when (last='1' and rwe='1') else
               "00000000" & rwv when (last='0' and rwe='1') else
               (others => 'Z'); -- rwe='0', reading
  -- module outputs
  rv <= sram_data(7 downto 0) when rre='1' else
        rhold(7 downto 0) when (re='1' and last='0') else
        rhold(15 downto 8) when (re='1' and last='1') else
        "00000000";

  -- handle synchronous things
  process(clk_50)
  begin
    -- increment the re_count, keeps track of when to really read
    re_count <= re_count+1 when re='1' else '0';

    -- save the results of the read
    rhold <= sram_data when rre='1' else (others => '0');

    -- buffer for writes
    we_buffer(1) <= we; -- always write the current we
    we_buffer(0) <= we_buffer(1) when (rre='0') else we_buffer(0);
    wv_buffer(15 downto 8) <= wv;
    wv_buffer(7 downto 0) <= wv_buffer(1) when (rre='0') else wv_buffer(0);
    waddr_buffer(37 downto 19) <= waddr_b; -- always write the current we
    waddr_buffer(18 downto 0) <= waddr_buffer(37 downto 19) when (rre='0') else waddr_buffer(18 downto 0);
  end process;
end sram_arch;
