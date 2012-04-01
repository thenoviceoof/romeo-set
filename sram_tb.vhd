library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram_tb is
end sram_tb;

architecture tb of sram_tb is
  signal clk : std_logic := '0';

  signal sram_data : std_logic_vector(15 downto 0);
  signal sram_addr : std_logic_vector(17 downto 0);
  signal sram_ub_n : std_logic;
  signal sram_lb_n : std_logic;
  signal sram_we_n : std_logic;
  signal sram_ce_n : std_logic;
  signal sram_oe_n : std_logic;

  signal r_e : std_logic := '0';
  signal r_x : std_logic_vector(9 downto 0) := "XXXXXXXXXX";
  signal r_y : std_logic_vector(8 downto 0) :=  "XXXXXXXXX";
  signal read_sram : std_logic_vector(7 downto 0) := "XXXXXXXX";

  signal w_e : std_logic := '0';
  signal w_x : std_logic_vector(9 downto 0) := "XXXXXXXXXX";
  signal w_y : std_logic_vector(8 downto 0) :=  "XXXXXXXXX";
  signal write_sram : std_logic_vector(7 downto 0) := "XXXXXXXX";
begin
  -- instantiate unit
  sram_u : entity work.sram
  port map ( 
    sram_data => sram_data,
    sram_addr => sram_addr,
    sram_ub_n => sram_ub_n,
    sram_lb_n => sram_ub_n,
    sram_we_n => sram_we_n,
    sram_ce_n => sram_ce_n,
    sram_oe_n => sram_oe_n,

    rx => r_x,
    ry => r_y,
    rv => read_sram,
    wx => w_x,
    wy => w_y,
    wv => write_sram,
    re => r_e,
    we => w_e
  );

  --clk <= not clk after 10 ns; -- 50MHz
  clk <= not clk after 20 ns; -- 25MHz

  process
  begin
--    wait for 10 ns;

    -- try writing
--    wait for 0 ns;
--    w_e <= '1';
--    w_x <= "0000000100";
--    w_y <= "000000010";
--    write_sram <= "10101010";
--    wait for 20 ns;
--    w_e <= '0';
--    w_x <= "XXXXXXXXXX";
--    w_y <= "XXXXXXXXX";
--    write_sram <= "XXXXXXXX";
--    wait for 20 ns;

    -- try reading
--    r_e <= '1';
--    r_x <= "0000000100";
--    r_y <= "000000010";
--    wait for 12 ns;
--    sram_data <= "0000000010101010";
--    wait for 8 ns;
--    r_e <= '0';
--    r_x <= "XXXXXXXXXX";
--    r_y <= "XXXXXXXXX";
--    wait for 2 ns;
--    sram_data <= "0000000000000000";

    -- reading with 25MHz clock
    wait for 20 ns;
    r_e <= '1';
    r_x <= "0000000100";
    r_y <= "000000010";
    wait for 12 ns;
    sram_data <= "0000000010101010";
    wait for 28 ns;
    r_e <= '0';
    r_x <= "XXXXXXXXXX";
    r_y <= "XXXXXXXXX";
    wait for 2 ns;
    sram_data <= "0000000000000000";

    -- end
    wait;
  end process;
end tb;