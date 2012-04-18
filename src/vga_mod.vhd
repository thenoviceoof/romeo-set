--
-- lab1.vhd
--
-- Richard Nwaobasi
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_mod is
  port(
    clk, reset  : in std_logic;
	count		: in unsigned(7 downto 0);
    VGA_CLK,                             -- Clock
    VGA_HS,                              -- H_SYNC
    VGA_VS,                              -- V_SYNC
    VGA_BLANK,                           -- BLANK
    VGA_SYNC : out std_logic;            -- SYNC
    VGA_R,                               -- Red[9:0]
    VGA_G,                               -- Green[9:0]
    VGA_B : out unsigned(9 downto 0);   -- Blue[9:0]
	xout		: out unsigned(9 downto 0);
	yout		: out unsigned(8 downto 0);
	re			: out std_logic);
end vga_mod;

architecture imp of vga_mod is

  component vga
    port (
    reset   : in std_logic;
    clk     : in std_logic;                    -- Should be 25.125 MHz
    VGA_RGB : in unsigned(29 downto 0);
    
    VGA_CLK,                          -- Clock
    VGA_HS,                           -- H_SYNC
    VGA_VS,                           -- V_SYNC
    VGA_BLANK,                        -- BLANK
    VGA_SYNC : out std_logic;         -- SYNC
    VGA_R,                            -- Red[9:0]
    VGA_G,                            -- Green[9:0]
    VGA_B : out unsigned(9 downto 0); -- Blue[9:0]
    x_pos : out unsigned(9 downto 0);
    y_pos : out unsigned(8 downto 0);
    re    : out std_logic             -- Read Enable
		);
  end component;
	
  component Color_LUT
    port(
      count   : in unsigned(7 downto 0);
      VGA_RGB : out unsigned(29 downto 0));
  end component;

	signal VGA_RGB    : unsigned(29 downto 0);

begin
  
  G : vga port map (reset => reset,
					clk => clk,                -- Should be 25.125 MHz
					VGA_RGB => VGA_RGB,
					VGA_CLK  => VGA_CLK,
					VGA_HS     => VGA_HS,
					VGA_VS     => VGA_VS,
					VGA_BLANK  => VGA_BLANK,
					VGA_SYNC   => VGA_SYNC,
					VGA_R      => VGA_R,
					VGA_G      => VGA_G,
					VGA_B      => VGA_B,
					x_pos	  => xout,
					y_pos	  => yout,
					re		  => re);

   A : Color_LUT port map 
		(count		=> count,
		VGA_RGB		=> VGA_RGB);

end imp;