library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (clk, reset : in std_logic;
        cout : out unsigned(7 downto 0));
end counter;

architecture imp of counter is
signal count : unsigned(7 downto 0);

begin
  process (clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        count <= (others => '0');
      else
        count <= count + 1;
      end if;
      
      cout <= count;
    end if;
  end process;
end imp;