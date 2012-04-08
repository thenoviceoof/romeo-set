library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram_tb is
end sram_tb;

architecture tb of sram_tb is
	signal clk_50 : std_logic := '1';
	signal clk_25 : std_logic := '1';
	
	signal sram_data : std_logic_vector(15 downto 0) := "ZZZZZZZZZZZZZZZZ";
	signal sram_addr : std_logic_vector(17 downto 0) := "ZZZZZZZZZZZZZZZZZZ";
	signal sram_ub_n : std_logic := 'Z';
	signal sram_lb_n : std_logic := 'Z';
	signal sram_we_n : std_logic := 'Z';
	signal sram_ce_n : std_logic := 'Z';
	signal sram_oe_n : std_logic := 'Z';
	
	signal r_e : std_logic := '0';
	signal r_x : std_logic_vector(9 downto 0) := "XXXXXXXXXX";
	signal r_y : std_logic_vector(8 downto 0) :=  "XXXXXXXXX";
	signal read_sram : std_logic_vector(7 downto 0) := "XXXXXXXX";
	
	signal w_e : std_logic := '0';
	signal w_x : std_logic_vector(9 downto 0) := "XXXXXXXXXX";
	signal w_y : std_logic_vector(8 downto 0) :=  "XXXXXXXXX";
	signal write_sram : std_logic_vector(7 downto 0) := "XXXXXXXX";

begin

	clk_50 <= not clk_50 after 10 ns; -- 50MHz
	clk_25 <= not clk_25 after 20 ns; -- 25MHz

	process
	begin
		-- wait a 25mhz cycle
		wait for 39 ns;

		-- 1 --------------------
		-- do a write
		w_e <= '1';
		w_x <= "0000000100";
		w_y <= "000000010";
		write_sram <= "10101010";
		-- clean up after the write
		wait for 20 ns;
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";

		-- wait a cycle
		wait for 20 ns;

		-- 2 --------------------
		-- do a read
		r_e <= '1';
		r_x <= "0000000100";
		r_y <= "000000010";
		wait for 12 ns;
		sram_data <= "1010000010101010";
		wait for 8 ns;
		-- and interleave a write
		w_e <= '1';
		w_x <= "0000110100";
		w_y <= "011100010";
		write_sram <= "11100010";
		wait for 2 ns;
		-- clean up the read from sram
		sram_data <= "ZZZZZZZZZZZZZZZZ";
		wait for 18 ns;
		-- and clean up both
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";
		-- clean write
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";

		-- 3 --------------------
		-- keep reading, and do a write at the same time
		r_e <= '1';
		r_x <= "0000000101";
		r_y <= "000000010";
		-- write somewhere completely random
		w_e <= '1';
		w_x <= "0001000000";
		w_y <= "000001010";
		write_sram <= "11101111";
		wait for 20 ns;
		-- clean write
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";
		wait for 20 ns;
		-- clean read
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";	


		-- 4 --------------------
		-- keep reading, try writing once simultaneously
		r_e <= '1';
		r_x <= "0011000110";
		r_y <= "000000010";
		w_e <= '1';
		w_x <= "1001010110";
		w_y <= "011111010";
		write_sram <= "10111111";
		-- write
		wait for 12 ns;
		sram_data <= "1111000000001010";
		wait for 8 ns;
		-- clean up
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";
		-- clean up the sram output
		wait for 2 ns;
		sram_data <= "ZZZZZZZZZZZZZZZZ";
		-- clean up again
		wait for 18 ns;
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";

		-- 5 --------------------
		-- keep reading
		r_e <= '1';
		r_x <= "0011000111";
		r_y <= "000000010";
		w_e <= '1';
		w_x <= "1101011110";
		w_y <= "111111110";
		write_sram <= "11001111";
		wait for 40 ns;
		-- clean up
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";
		
		-- 6 --------------------
		-- keep reading, do writes to both
		r_e <= '1';
		r_x <= "0000001000";
		r_y <= "000000010";
		-- write
		w_e <= '1';
		w_x <= "1001000110";
		w_y <= "001011010";
		write_sram <= "10101011";
		wait for 12 ns;
		sram_data <= "1010011011101110";
		wait for 8 ns;
		-- and now do another write
		w_e <= '1';
		w_x <= "1001001111";
		w_y <= "001011110";
		write_sram <= "11111111";
		-- clear the read
		wait for 2 ns;
		sram_data <= "ZZZZZZZZZZZZZZZZ";
		wait for 18 ns;
		-- clean up both
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";
		-- clean write
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";
		
		-- 7 --------------------
		-- keep reading for kicks
		r_e <= '1';
		r_x <= "0000001001";
		r_y <= "000000010";
		wait for 20 ns;
		w_e <= '1';
		w_x <= "1001111111";
		w_y <= "001011110";
		write_sram <= "10001111";
		wait for 20 ns;
		-- keep writing
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";
		
		-- 8 --------------------
		r_e <= '1';
		r_x <= "0000001010";
		r_y <= "000000010";
		-- write
		wait for 12 ns;
		sram_data <= "1111000110001010";
		wait for 8 ns;
		-- clean up
		w_x <= "1101111111";
		w_y <= "001011110";
		write_sram <= "11111111";
		-- clean up the sram output
		wait for 2 ns;
		sram_data <= "ZZZZZZZZZZZZZZZZ";
		-- clean up again
		wait for 18 ns;
		r_e <= '0';
		r_x <= "XXXXXXXXXX";
		r_y <= "XXXXXXXXX";
		w_e <= '0';
		w_x <= "XXXXXXXXXX";
		w_y <= "XXXXXXXXX";
		write_sram <= "XXXXXXXX";

		-- end
		wait;
	end process;

	-- instantiate unit
	uut : entity work.sram
	port map (
		clk_50 => clk_50,
		clk_25 => clk_25,
    
		sram_data => sram_data,
		sram_addr => sram_addr,
		sram_ub_n => sram_ub_n,
		sram_lb_n => sram_lb_n,
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
end tb;
