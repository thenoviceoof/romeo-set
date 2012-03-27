--Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpu_jtag_debug_module_wrapper is 
        port (
              -- inputs:
                 signal MonDReg : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal break_readreg : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal dbrk_hit0_latch : IN STD_LOGIC;
                 signal dbrk_hit1_latch : IN STD_LOGIC;
                 signal dbrk_hit2_latch : IN STD_LOGIC;
                 signal dbrk_hit3_latch : IN STD_LOGIC;
                 signal debugack : IN STD_LOGIC;
                 signal monitor_error : IN STD_LOGIC;
                 signal monitor_ready : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal resetlatch : IN STD_LOGIC;
                 signal tracemem_on : IN STD_LOGIC;
                 signal tracemem_trcdata : IN STD_LOGIC_VECTOR (35 DOWNTO 0);
                 signal tracemem_tw : IN STD_LOGIC;
                 signal trc_im_addr : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                 signal trc_on : IN STD_LOGIC;
                 signal trc_wrap : IN STD_LOGIC;
                 signal trigbrktype : IN STD_LOGIC;
                 signal trigger_state_1 : IN STD_LOGIC;

              -- outputs:
                 signal jdo : OUT STD_LOGIC_VECTOR (37 DOWNTO 0);
                 signal jrst_n : OUT STD_LOGIC;
                 signal st_ready_test_idle : OUT STD_LOGIC;
                 signal take_action_break_a : OUT STD_LOGIC;
                 signal take_action_break_b : OUT STD_LOGIC;
                 signal take_action_break_c : OUT STD_LOGIC;
                 signal take_action_ocimem_a : OUT STD_LOGIC;
                 signal take_action_ocimem_b : OUT STD_LOGIC;
                 signal take_action_tracectrl : OUT STD_LOGIC;
                 signal take_action_tracemem_a : OUT STD_LOGIC;
                 signal take_action_tracemem_b : OUT STD_LOGIC;
                 signal take_no_action_break_a : OUT STD_LOGIC;
                 signal take_no_action_break_b : OUT STD_LOGIC;
                 signal take_no_action_break_c : OUT STD_LOGIC;
                 signal take_no_action_ocimem_a : OUT STD_LOGIC;
                 signal take_no_action_tracemem_a : OUT STD_LOGIC
              );
end entity cpu_jtag_debug_module_wrapper;


architecture europa of cpu_jtag_debug_module_wrapper is
--synthesis translate_off
component cpu_jtag_debug_module is 
           generic (
                    SLD_AUTO_INSTANCE_INDEX : STRING := "YES";
                    SLD_NODE_INFO : INTEGER := 286279168
                    );
           port (
                 -- inputs:
                    signal MonDReg : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal break_readreg : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal clrn : IN STD_LOGIC;
                    signal dbrk_hit0_latch : IN STD_LOGIC;
                    signal dbrk_hit1_latch : IN STD_LOGIC;
                    signal dbrk_hit2_latch : IN STD_LOGIC;
                    signal dbrk_hit3_latch : IN STD_LOGIC;
                    signal debugack : IN STD_LOGIC;
                    signal ena : IN STD_LOGIC;
                    signal ir_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal jtag_state_sdr : IN STD_LOGIC;
                    signal jtag_state_udr : IN STD_LOGIC;
                    signal monitor_error : IN STD_LOGIC;
                    signal monitor_ready : IN STD_LOGIC;
                    signal raw_tck : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal resetlatch : IN STD_LOGIC;
                    signal rti : IN STD_LOGIC;
                    signal shift : IN STD_LOGIC;
                    signal tdi : IN STD_LOGIC;
                    signal tracemem_on : IN STD_LOGIC;
                    signal tracemem_trcdata : IN STD_LOGIC_VECTOR (35 DOWNTO 0);
                    signal tracemem_tw : IN STD_LOGIC;
                    signal trc_im_addr : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
                    signal trc_on : IN STD_LOGIC;
                    signal trc_wrap : IN STD_LOGIC;
                    signal trigbrktype : IN STD_LOGIC;
                    signal trigger_state_1 : IN STD_LOGIC;
                    signal update : IN STD_LOGIC;
                    signal usr1 : IN STD_LOGIC;

                 -- outputs:
                    signal jdo : OUT STD_LOGIC_VECTOR (37 DOWNTO 0);
                    signal jrst_n : OUT STD_LOGIC;
                    signal st_ready_test_idle : OUT STD_LOGIC;
                    signal take_action_break_a : OUT STD_LOGIC;
                    signal take_action_break_b : OUT STD_LOGIC;
                    signal take_action_break_c : OUT STD_LOGIC;
                    signal take_action_ocimem_a : OUT STD_LOGIC;
                    signal take_action_ocimem_b : OUT STD_LOGIC;
                    signal take_action_tracectrl : OUT STD_LOGIC;
                    signal take_action_tracemem_a : OUT STD_LOGIC;
                    signal take_action_tracemem_b : OUT STD_LOGIC;
                    signal take_no_action_break_a : OUT STD_LOGIC;
                    signal take_no_action_break_b : OUT STD_LOGIC;
                    signal take_no_action_break_c : OUT STD_LOGIC;
                    signal take_no_action_ocimem_a : OUT STD_LOGIC;
                    signal take_no_action_tracemem_a : OUT STD_LOGIC
                 );
end component cpu_jtag_debug_module;

--synthesis translate_on
--synthesis read_comments_as_HDL on
--component cpu_jtag_debug_module is 
--           generic (
--                    SLD_AUTO_INSTANCE_INDEX : STRING := "YES";
--                    SLD_NODE_INFO : INTEGER := 286279168
--                    );
--           port (
--                 
--                    signal MonDReg : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
--                    signal break_readreg : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
--                    signal clk : IN STD_LOGIC;
--                    signal dbrk_hit0_latch : IN STD_LOGIC;
--                    signal dbrk_hit1_latch : IN STD_LOGIC;
--                    signal dbrk_hit2_latch : IN STD_LOGIC;
--                    signal dbrk_hit3_latch : IN STD_LOGIC;
--                    signal debugack : IN STD_LOGIC;
--                    signal monitor_error : IN STD_LOGIC;
--                    signal monitor_ready : IN STD_LOGIC;
--                    signal reset_n : IN STD_LOGIC;
--                    signal resetlatch : IN STD_LOGIC;
--                    signal tracemem_on : IN STD_LOGIC;
--                    signal tracemem_trcdata : IN STD_LOGIC_VECTOR (35 DOWNTO 0);
--                    signal tracemem_tw : IN STD_LOGIC;
--                    signal trc_im_addr : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
--                    signal trc_on : IN STD_LOGIC;
--                    signal trc_wrap : IN STD_LOGIC;
--                    signal trigbrktype : IN STD_LOGIC;
--                    signal trigger_state_1 : IN STD_LOGIC;
--
--                 
--                    signal jdo : OUT STD_LOGIC_VECTOR (37 DOWNTO 0);
--                    signal jrst_n : OUT STD_LOGIC;
--                    signal st_ready_test_idle : OUT STD_LOGIC;
--                    signal take_action_break_a : OUT STD_LOGIC;
--                    signal take_action_break_b : OUT STD_LOGIC;
--                    signal take_action_break_c : OUT STD_LOGIC;
--                    signal take_action_ocimem_a : OUT STD_LOGIC;
--                    signal take_action_ocimem_b : OUT STD_LOGIC;
--                    signal take_action_tracectrl : OUT STD_LOGIC;
--                    signal take_action_tracemem_a : OUT STD_LOGIC;
--                    signal take_action_tracemem_b : OUT STD_LOGIC;
--                    signal take_no_action_break_a : OUT STD_LOGIC;
--                    signal take_no_action_break_b : OUT STD_LOGIC;
--                    signal take_no_action_break_c : OUT STD_LOGIC;
--                    signal take_no_action_ocimem_a : OUT STD_LOGIC;
--                    signal take_no_action_tracemem_a : OUT STD_LOGIC
--                 );
--end component cpu_jtag_debug_module;
--
--synthesis read_comments_as_HDL off
                signal internal_jdo :  STD_LOGIC_VECTOR (37 DOWNTO 0);
                signal internal_jrst_n :  STD_LOGIC;
                signal internal_st_ready_test_idle :  STD_LOGIC;
                signal internal_take_action_break_a :  STD_LOGIC;
                signal internal_take_action_break_b :  STD_LOGIC;
                signal internal_take_action_break_c :  STD_LOGIC;
                signal internal_take_action_ocimem_a :  STD_LOGIC;
                signal internal_take_action_ocimem_b :  STD_LOGIC;
                signal internal_take_action_tracectrl :  STD_LOGIC;
                signal internal_take_action_tracemem_a :  STD_LOGIC;
                signal internal_take_action_tracemem_b :  STD_LOGIC;
                signal internal_take_no_action_break_a :  STD_LOGIC;
                signal internal_take_no_action_break_b :  STD_LOGIC;
                signal internal_take_no_action_break_c :  STD_LOGIC;
                signal internal_take_no_action_ocimem_a :  STD_LOGIC;
                signal internal_take_no_action_tracemem_a :  STD_LOGIC;
                signal module_input15 :  STD_LOGIC;
                signal module_input16 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal module_input17 :  STD_LOGIC;
                signal module_input18 :  STD_LOGIC;
                signal module_input19 :  STD_LOGIC;
                signal module_input20 :  STD_LOGIC;
                signal module_input21 :  STD_LOGIC;
                signal module_input22 :  STD_LOGIC;
                signal module_input23 :  STD_LOGIC;
                signal module_input24 :  STD_LOGIC;

begin

  --vhdl renameroo for output signals
  jdo <= internal_jdo;
  --vhdl renameroo for output signals
  jrst_n <= internal_jrst_n;
  --vhdl renameroo for output signals
  st_ready_test_idle <= internal_st_ready_test_idle;
  --vhdl renameroo for output signals
  take_action_break_a <= internal_take_action_break_a;
  --vhdl renameroo for output signals
  take_action_break_b <= internal_take_action_break_b;
  --vhdl renameroo for output signals
  take_action_break_c <= internal_take_action_break_c;
  --vhdl renameroo for output signals
  take_action_ocimem_a <= internal_take_action_ocimem_a;
  --vhdl renameroo for output signals
  take_action_ocimem_b <= internal_take_action_ocimem_b;
  --vhdl renameroo for output signals
  take_action_tracectrl <= internal_take_action_tracectrl;
  --vhdl renameroo for output signals
  take_action_tracemem_a <= internal_take_action_tracemem_a;
  --vhdl renameroo for output signals
  take_action_tracemem_b <= internal_take_action_tracemem_b;
  --vhdl renameroo for output signals
  take_no_action_break_a <= internal_take_no_action_break_a;
  --vhdl renameroo for output signals
  take_no_action_break_b <= internal_take_no_action_break_b;
  --vhdl renameroo for output signals
  take_no_action_break_c <= internal_take_no_action_break_c;
  --vhdl renameroo for output signals
  take_no_action_ocimem_a <= internal_take_no_action_ocimem_a;
  --vhdl renameroo for output signals
  take_no_action_tracemem_a <= internal_take_no_action_tracemem_a;
--synthesis translate_off
    --the_cpu_jtag_debug_module, which is an e_instance
    the_cpu_jtag_debug_module : cpu_jtag_debug_module
      port map(
        jdo => internal_jdo,
        jrst_n => internal_jrst_n,
        st_ready_test_idle => internal_st_ready_test_idle,
        take_action_break_a => internal_take_action_break_a,
        take_action_break_b => internal_take_action_break_b,
        take_action_break_c => internal_take_action_break_c,
        take_action_ocimem_a => internal_take_action_ocimem_a,
        take_action_ocimem_b => internal_take_action_ocimem_b,
        take_action_tracectrl => internal_take_action_tracectrl,
        take_action_tracemem_a => internal_take_action_tracemem_a,
        take_action_tracemem_b => internal_take_action_tracemem_b,
        take_no_action_break_a => internal_take_no_action_break_a,
        take_no_action_break_b => internal_take_no_action_break_b,
        take_no_action_break_c => internal_take_no_action_break_c,
        take_no_action_ocimem_a => internal_take_no_action_ocimem_a,
        take_no_action_tracemem_a => internal_take_no_action_tracemem_a,
        MonDReg => MonDReg,
        break_readreg => break_readreg,
        clk => clk,
        clrn => reset_n,
        dbrk_hit0_latch => dbrk_hit0_latch,
        dbrk_hit1_latch => dbrk_hit1_latch,
        dbrk_hit2_latch => dbrk_hit2_latch,
        dbrk_hit3_latch => dbrk_hit3_latch,
        debugack => debugack,
        ena => module_input15,
        ir_in => module_input16,
        jtag_state_sdr => module_input17,
        jtag_state_udr => module_input18,
        monitor_error => monitor_error,
        monitor_ready => monitor_ready,
        raw_tck => module_input19,
        reset_n => reset_n,
        resetlatch => resetlatch,
        rti => module_input20,
        shift => module_input21,
        tdi => module_input22,
        tracemem_on => tracemem_on,
        tracemem_trcdata => tracemem_trcdata,
        tracemem_tw => tracemem_tw,
        trc_im_addr => trc_im_addr,
        trc_on => trc_on,
        trc_wrap => trc_wrap,
        trigbrktype => trigbrktype,
        trigger_state_1 => trigger_state_1,
        update => module_input23,
        usr1 => module_input24
      );

    module_input15 <= std_logic'('0');
    module_input16 <= std_logic_vector'("00");
    module_input17 <= std_logic'('0');
    module_input18 <= std_logic'('0');
    module_input19 <= std_logic'('0');
    module_input20 <= std_logic'('0');
    module_input21 <= std_logic'('0');
    module_input22 <= std_logic'('0');
    module_input23 <= std_logic'('0');
    module_input24 <= std_logic'('0');

--synthesis translate_on
--synthesis read_comments_as_HDL on
--    
--    the_cpu_jtag_debug_module1 : cpu_jtag_debug_module
--      port map(
--        jdo => internal_jdo,
--        jrst_n => internal_jrst_n,
--        st_ready_test_idle => internal_st_ready_test_idle,
--        take_action_break_a => internal_take_action_break_a,
--        take_action_break_b => internal_take_action_break_b,
--        take_action_break_c => internal_take_action_break_c,
--        take_action_ocimem_a => internal_take_action_ocimem_a,
--        take_action_ocimem_b => internal_take_action_ocimem_b,
--        take_action_tracectrl => internal_take_action_tracectrl,
--        take_action_tracemem_a => internal_take_action_tracemem_a,
--        take_action_tracemem_b => internal_take_action_tracemem_b,
--        take_no_action_break_a => internal_take_no_action_break_a,
--        take_no_action_break_b => internal_take_no_action_break_b,
--        take_no_action_break_c => internal_take_no_action_break_c,
--        take_no_action_ocimem_a => internal_take_no_action_ocimem_a,
--        take_no_action_tracemem_a => internal_take_no_action_tracemem_a,
--        MonDReg => MonDReg,
--        break_readreg => break_readreg,
--        clk => clk,
--        dbrk_hit0_latch => dbrk_hit0_latch,
--        dbrk_hit1_latch => dbrk_hit1_latch,
--        dbrk_hit2_latch => dbrk_hit2_latch,
--        dbrk_hit3_latch => dbrk_hit3_latch,
--        debugack => debugack,
--        monitor_error => monitor_error,
--        monitor_ready => monitor_ready,
--        reset_n => reset_n,
--        resetlatch => resetlatch,
--        tracemem_on => tracemem_on,
--        tracemem_trcdata => tracemem_trcdata,
--        tracemem_tw => tracemem_tw,
--        trc_im_addr => trc_im_addr,
--        trc_on => trc_on,
--        trc_wrap => trc_wrap,
--        trigbrktype => trigbrktype,
--        trigger_state_1 => trigger_state_1
--      );
--
--
--synthesis read_comments_as_HDL off

end europa;

