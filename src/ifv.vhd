--
-- DE2 top-level module that includes the simple VGA raster generator
--
-- Stephen A. Edwards, Columbia University, sedwards@cs.columbia.edu
--
-- From an original by Terasic Technology, Inc.
-- (DE2_TOP.v, part of the DE2 system board CD supplied by Altera)
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifv is

	port (
	-- Clocks

	CLOCK_27,                                      -- 27 MHz
	CLOCK_50,                                      -- 50 MHz
	EXT_CLOCK : in std_logic;                      -- External Clock

	-- Buttons and switches

	KEY : in std_logic_vector(3 downto 0);         -- Push buttons
	SW : in std_logic_vector(17 downto 0);         -- DPDT switches

	-- LED displays

	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 -- 7-segment displays
	: out std_logic_vector(6 downto 0);
	LEDG : out std_logic_vector(8 downto 0);       -- Green LEDs
	LEDR : out std_logic_vector(17 downto 0);      -- Red LEDs

	-- RS-232 interface

	UART_TXD : out std_logic;                      -- UART transmitter   
	UART_RXD : in std_logic;                       -- UART receiver

	-- IRDA interface

--    IRDA_TXD : out std_logic;                      -- IRDA Transmitter
	IRDA_RXD : in std_logic;                       -- IRDA Receiver

	-- SDRAM
 
	DRAM_DQ : inout std_logic_vector(15 downto 0); -- Data Bus
	DRAM_ADDR : out std_logic_vector(11 downto 0); -- Address Bus    
	DRAM_LDQM,                                     -- Low-byte Data Mask 
	DRAM_UDQM,                                     -- High-byte Data Mask
	DRAM_WE_N,                                     -- Write Enable
	DRAM_CAS_N,                                    -- Column Address Strobe
	DRAM_RAS_N,                                    -- Row Address Strobe
	DRAM_CS_N,                                     -- Chip Select
	DRAM_BA_0,                                     -- Bank Address 0
	DRAM_BA_1,                                     -- Bank Address 0
	DRAM_CLK,                                      -- Clock
	DRAM_CKE : out std_logic;                      -- Clock Enable

	-- FLASH
    
	FL_DQ : inout std_logic_vector(7 downto 0);      -- Data bus
	FL_ADDR : out std_logic_vector(21 downto 0);  -- Address bus
	FL_WE_N,                                         -- Write Enable
	FL_RST_N,                                        -- Reset
	FL_OE_N,                                         -- Output Enable
	FL_CE_N : out std_logic;                         -- Chip Enable

	-- SRAM
    
	SRAM_DQ : inout std_logic_vector(15 downto 0); -- Data bus 16 Bits
	SRAM_ADDR : out std_logic_vector(17 downto 0); -- Address bus 18 Bits
	SRAM_UB_N,                                     -- High-byte Data Mask 
	SRAM_LB_N,                                     -- Low-byte Data Mask 
	SRAM_WE_N,                                     -- Write Enable
	SRAM_CE_N,                                     -- Chip Enable
	SRAM_OE_N : out std_logic;                     -- Output Enable	

	-- USB controller
    
	OTG_DATA : inout std_logic_vector(15 downto 0); -- Data bus
	OTG_ADDR : out std_logic_vector(1 downto 0);    -- Address
	OTG_CS_N,                                       -- Chip Select
	OTG_RD_N,                                       -- Write
	OTG_WR_N,                                       -- Read
	OTG_RST_N,                                      -- Reset
	OTG_FSPEED,                     -- USB Full Speed, 0 = Enable, Z = Disable
	OTG_LSPEED : out std_logic;     -- USB Low Speed, 0 = Enable, Z = Disable
	OTG_INT0,                                       -- Interrupt 0
	OTG_INT1,                                       -- Interrupt 1
	OTG_DREQ0,                                      -- DMA Request 0
	OTG_DREQ1 : in std_logic;                       -- DMA Request 1   
	OTG_DACK0_N,                                    -- DMA Acknowledge 0
	OTG_DACK1_N : out std_logic;                    -- DMA Acknowledge 1

	-- 16 X 2 LCD Module
    
	LCD_ON,                     -- Power ON/OFF
	LCD_BLON,                   -- Back Light ON/OFF
	LCD_RW,                     -- Read/Write Select, 0 = Write, 1 = Read
	LCD_EN,                     -- Enable
	LCD_RS : out std_logic;     -- Command/Data Select, 0 = Command, 1 = Data
	LCD_DATA : inout std_logic_vector(7 downto 0); -- Data bus 8 bits

	-- SD card interface
    
	SD_DAT,                     -- SD Card Data
	SD_DAT3,                    -- SD Card Data 3
	SD_CMD : inout std_logic;   -- SD Card Command Signal
	SD_CLK : out std_logic;     -- SD Card Clock

	-- USB JTAG link
    
	TDI,                        -- CPLD -> FPGA (data in)
	TCK,                        -- CPLD -> FPGA (clk)
	TCS : in std_logic;         -- CPLD -> FPGA (CS)
	TDO : out std_logic;        -- FPGA -> CPLD (data out)

	-- I2C bus
    
	I2C_SDAT : inout std_logic; -- I2C Data
	I2C_SCLK : out std_logic;   -- I2C Clock

	-- PS/2 port

	PS2_DAT,                    -- Data
	PS2_CLK : in std_logic;     -- Clock

	-- VGA output
    
	VGA_CLK,                                            -- Clock
	VGA_HS,                                             -- H_SYNC
	VGA_VS,                                             -- V_SYNC
	VGA_BLANK,                                          -- BLANK
	VGA_SYNC : out std_logic;                           -- SYNC
	VGA_R,                                              -- Red[9:0]
	VGA_G,                                              -- Green[9:0]
	VGA_B : out unsigned(9 downto 0);                   -- Blue[9:0]

	--  Ethernet Interface
    
	ENET_DATA : inout std_logic_vector(15 downto 0);    -- DATA bus 16Bits
	ENET_CMD,           -- Command/Data Select, 0 = Command, 1 = Data
	ENET_CS_N,                                          -- Chip Select
	ENET_WR_N,                                          -- Write
	ENET_RD_N,                                          -- Read
	ENET_RST_N,                                         -- Reset
	ENET_CLK : out std_logic;                           -- Clock 25 MHz
	ENET_INT : in std_logic;                            -- Interrupt
    
	-- Audio CODEC
    
	AUD_ADCLRCK : inout std_logic;                      -- ADC LR Clock
	AUD_ADCDAT : in std_logic;                          -- ADC Data
	AUD_DACLRCK : inout std_logic;                      -- DAC LR Clock
	AUD_DACDAT : out std_logic;                         -- DAC Data
	AUD_BCLK : inout std_logic;                         -- Bit-Stream Clock
	AUD_XCK : out std_logic;                            -- Chip Clock
    
	-- Video Decoder
    
	TD_DATA : in std_logic_vector(7 downto 0);  -- Data bus 8 bits
	TD_HS,                                      -- H_SYNC
	TD_VS : in std_logic;                       -- V_SYNC
	TD_RESET : out std_logic;                   -- Reset
    
	-- General-purpose I/O
    
	GPIO_0,                                      -- GPIO Connection 0
	GPIO_1 : inout std_logic_vector(35 downto 0) -- GPIO Connection 1   
);
  
end ifv;

architecture datapath of ifv is

	signal clk_25		: std_logic;
	signal clk_50		: std_logic;
	signal clk_vga		: std_logic;
	signal clk_sdram	: std_logic;

	signal cread		: unsigned(7 downto 0);
	signal xread		: unsigned(9 downto 0);
	signal yread		: unsigned(8 downto 0);
	signal re			: std_logic;
	signal we			: std_logic;
	signal cwrite		: unsigned(7 downto 0);
	signal xwrite		: unsigned(9 downto 0);
	signal ywrite		: unsigned(8 downto 0);

	signal a_min		: std_logic_vector(35 downto 0)		:= X"F80000000";
	signal b_min		: std_logic_vector(35 downto 0)		:= X"FA0000000";
	signal a_diff		: std_logic_vector(35 downto 0)		:= X"000666666";
	signal b_diff		: std_logic_vector(35 downto 0)		:= X"000666666";
	signal cr   		: std_logic_vector(35 downto 0)		:= X"FCA8F5C29";
	signal ci   		: std_logic_vector(35 downto 0)		:= X"FF125460B";
	signal a_leap		: std_logic_vector(9 downto 0)		:= "0000000010";
	signal b_leap		: std_logic_vector(9 downto 0)		:= "0000000010";
	signal reset_n		: std_logic							:='1';

	signal reset			: std_logic;
	signal reset_from_nios 	: std_logic;
	signal DRAM_BA	: std_logic_vector(1 downto 0);
	signal DRAM_DQM	: std_logic_vector(1 downto 0);

begin

	process (CLOCK_50)
	begin
		if rising_edge(CLOCK_50) then
			clk_vga <= not clk_vga;
		end if;
	end process;
	
--	DRAM_BA_1 <= DRAM_BA(1);
--	DRAM_BA_0 <= DRAM_BA(0);
--	DRAM_UDQM <= DRAM_DQM(1);
--	DRAM_LDQM <= DRAM_DQM(0);
--	reset <= reset_from_nios or SW(0);
	reset <= SW(0);

CLK5025: entity work.pll5025 port map(
	inclk0	=> CLOCK_50,
	c0		=> clk_50,
	c1		=> clk_25,
	c2		=> clk_sdram
	);

IFM: entity work.hook port map(
	clk50		=> clk_50,
	clk25		=> clk_25,
	reset		=> reset,
	a_min		=> signed(a_min),
	a_diff		=> signed(a_diff),
	a_leap		=> unsigned(a_leap),
	b_min		=> signed(b_min),
	b_diff		=> signed(b_diff),
	b_leap		=> unsigned(b_leap),
	cr			=> signed(cr),
	ci			=> signed(ci),
	std_logic_vector(xout)		=> xwrite,
	std_logic_vector(yout)		=> ywrite,
	count		=> cwrite,
	we			=> we
	);

VGA: entity work.vga_mod port map (
	clk => clk_vga,
	reset => '0',
	switch => SW(3),
	count		=> cread,--EXTERNAL SIGNALS
	VGA_CLK		=> VGA_CLK,
	VGA_HS		=> VGA_HS,
	VGA_VS		=> VGA_VS,
	VGA_BLANK	=> VGA_BLANK,
	VGA_SYNC	=> VGA_SYNC,
	VGA_R		=> VGA_R,
	VGA_G		=> VGA_G,
	VGA_B		=> VGA_B,
	xout		=> xread,--EXTERNAL SIGNALS
	yout		=> yread,--EXTERNAL SIGNALS
	re  		=> re,--EXTERNAL SIGNALS
	ce  		=> SW(2)
	);

SRAM: entity work.sram port map(
	clk_50		=> clk_50,
	clk_25		=> clk_25,
	sram_data	=> SRAM_DQ,
	sram_addr	=> SRAM_ADDR,
	sram_ub_n	=> SRAM_UB_N,
	sram_lb_n	=> SRAM_LB_N,
	sram_we_n	=> SRAM_WE_N,
	sram_ce_n	=> SRAM_CE_N,
	sram_oe_n	=> SRAM_OE_N,
	rx			=> std_logic_vector(xread),
	ry			=> std_logic_vector(yread),
	wx			=> std_logic_vector(xwrite),
	wy			=> std_logic_vector(ywrite),
	std_logic_vector(rv)	=> cread,
	wv			=> std_logic_vector(cwrite),
	re			=> re,
	we			=> we
	);
  
	HEX7     <= "1100001"; -- J
	HEX6     <= "1000001"; -- U
	HEX5     <= "1000111"; -- L
	HEX4     <= "1111001"; -- I
	HEX3     <= "0001000"; -- A
	HEX2     <= "0010010"; -- S
	HEX1     <= "0000110"; -- E
	HEX0     <= "0000111"; -- t
	LEDG     <= (others => '0');
	LEDR     <= (others => '0');

	LCD_ON   <= '1';
	LCD_BLON <= '1';
	LCD_RW <= '1';
	LCD_EN <= '0';
	LCD_RS <= '0';

	SD_DAT3 <= '1';  
	SD_CMD <= '1';
	SD_CLK <= '1';

	UART_TXD <= '0';
	DRAM_ADDR <= (others => '0');
	DRAM_LDQM <= '0';
	DRAM_UDQM <= '0';
	DRAM_WE_N <= '1';
	DRAM_CAS_N <= '1';
	DRAM_RAS_N <= '1';
	DRAM_CS_N <= '1';
	DRAM_BA_0 <= '0';
	DRAM_BA_1 <= '0';
	DRAM_CLK <= '0';
	DRAM_CKE <= '0';

	FL_ADDR <= (others => '0');
	FL_WE_N <= '1';
	FL_RST_N <= '0';
	FL_OE_N <= '1';
	FL_CE_N <= '1';
	OTG_ADDR <= (others => '0');
	OTG_CS_N <= '1';
	OTG_RD_N <= '1';
	OTG_RD_N <= '1';
	OTG_WR_N <= '1';
	OTG_RST_N <= '1';
	OTG_FSPEED <= '1';
	OTG_LSPEED <= '1';
	OTG_DACK0_N <= '1';
	OTG_DACK1_N <= '1';

	TDO <= '0';

	ENET_CMD <= '0';
	ENET_CS_N <= '1';
	ENET_WR_N <= '1';
	ENET_RD_N <= '1';
	ENET_RST_N <= '1';
	ENET_CLK <= '0';

	TD_RESET <= '0';

	I2C_SCLK <= '1';

	AUD_DACDAT <= '1';
	AUD_XCK <= '1';

	-- Set all bidirectional ports to tri-state
	DRAM_DQ     <= (others => 'Z');
	FL_DQ       <= (others => 'Z');
--	SRAM_DQ     <= (others => 'Z');
	OTG_DATA    <= (others => 'Z');
	LCD_DATA    <= (others => 'Z');
	SD_DAT      <= 'Z';
	I2C_SDAT    <= 'Z';
	ENET_DATA   <= (others => 'Z');
	AUD_ADCLRCK <= 'Z';
	AUD_DACLRCK <= 'Z';
	AUD_BCLK    <= 'Z';
	GPIO_0      <= (others => 'Z');
	GPIO_1      <= (others => 'Z');

end datapath;
