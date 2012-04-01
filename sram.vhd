library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram is
  port(
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
    x : in std_logic_vector(9 downto 0);
    -- 480<512  (9 bits)
    y : in std_logic_vector(8 downto 0);
    -- read/write values (8 bits)
    rv : out std_logic_vector(7 downto 0);
    wv : in std_logic_vector(7 downto 0);
    -- read/write controls
    -- reading takes precedence
    re : in std_logic
    we : in std_logic
    );
end sram;

architecture sram_arch of sram is
  signal addr : std_logic_vector(17 downto 0);
  signal upper : std_logic;
  signal lower : std_logic;
begin
  -- generate the address
  addr <= y(8 downto 0) & x(9 downto 1);
  upper <= x(0);
  
  -- sram outputs
  sram_addr <= addr;
  -- !!! going to have to redo this part, migth have to use both bytes
  sram_ub_n <= NOT upper;
  sram_lb_n <= upper;
  -- only enable write enable when, well, writing
  sram_we_n <= NOT we;
  -- only enable the output when reading
  sram_oe_n <= NOT re;
  -- always power up the chip
  sram_ce_n <= '0';
  -- try to generate the right data
  -- !!! overhaul this
  sram_data <= wv & "00000000" when (upper='1' AND we='1') else
               "00000000" & wv when (upper='0' AND we='1') else
               (others => 'Z'); -- we='0', reading
  -- module outputs
  rv <= sram_data(15 downto 8) when (upper='1' AND we='0') else
        sram_data(7 downto 0) when (upper='0' AND we='0') else
        "00000000";
end sram_arch;
