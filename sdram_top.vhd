library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sdram_top is  
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
       : out std_logic_vector(6 downto 0);         -- (active low)
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
    VGA_B : out unsigned(9 downto 0);           -- Blue[9:0]

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
  
end sdram_top;
	
architecture rtl of sdram_top is
		signal reset_n : std_logic := '1';
		signal pll_c1 : std_logic;
		
		signal DRAM_BA 	: std_logic_vector(1 downto 0);
		signal DRAM_DQM	: std_logic_vector(1 downto 0);
		
		
		--signals for communication between the ifm controller and the ifm bus
		signal a_to_box : std_logic_vector(17 downto 0);
		signal b_to_box : std_logic_vector(17 downto 0);
		signal x_to_box : std_logic_vector(9 downto 0);
		signal y_to_box : std_logic_vector(8 downto 0);		
		signal data_flag: std_logic;
		signal box_full : std_logic;
		
		signal x_from_box : std_logic_vector(9 downto 0);
		signal y_from_box : std_logic_vector(8 downto 0);
		signal c_from_box : unsigned(6 downto 0);
		signal we_from_box: std_logic;
		
	component sram is
	port(
		rhold_out : out std_logic_vector(15 downto 0);
		re_count_out : out std_logic_vector(1 downto 0);
	
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
	end component;
		
begin
	DRAM_BA_1 <= DRAM_BA(1);
	DRAM_BA_0 <= DRAM_BA(0);
	DRAM_UDQM <= DRAM_DQM(1);
	DRAM_LDQM <= DRAM_DQM(0);
	
	
	nios	: entity work.nios_system port map (
		clk								=> CLOCK_50,
		reset_n							=> reset_n,
		
		-- the_sdram
		zs_addr_from_the_sdram => DRAM_ADDR,
		zs_ba_from_the_sdram => DRAM_BA,
		zs_cas_n_from_the_sdram => DRAM_CAS_N,
		zs_cke_from_the_sdram => DRAM_CKE,
		zs_cs_n_from_the_sdram => DRAM_CS_N,
		zs_dq_to_and_from_the_sdram => DRAM_DQ,
		zs_dqm_from_the_sdram => DRAM_DQM,
		zs_ras_n_from_the_sdram => DRAM_RAS_N,
		zs_we_n_from_the_sdram => DRAM_WE_N,
		
		--the ifm bus
		a_out_from_the_julia_calc => a_to_box,
        b_out_from_the_julia_calc => b_to_box,
        x_out_from_the_julia_calc => x_to_box,
        y_out_from_the_julia_calc => y_to_box,
        buffer_full_to_the_julia_calc => box_full,
        exp_data_from_the_julia_calc => data_flag

	
	
	);
		
	sdram_pll : entity work.sdram_pll port map (
		inclk0	=> CLOCK_50,
		c0		=> DRAM_CLK
	);
	
	ifm_controller: entity work.box port map (
		clk 	=> CLOCK_50,
		clr 	=> reset_n,
		data	=> data_flag,
		xin		=> x_to_box,
		yin		=> y_to_box,
		ain		=> a_to_box,
		bin		=> b_to_box,
		xout	=> x_from_box,
		yout	=> y_from_box,
		count	=> c_from_box,
		full	=> box_full,
		we		=> we_from_box
	);
	
	
	
end rtl;