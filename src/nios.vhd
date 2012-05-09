--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


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

entity clock_0_in_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_0_in_endofpacket : IN STD_LOGIC;
                 signal clock_0_in_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clock_0_in_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal clock_0_in_address : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
                 signal clock_0_in_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal clock_0_in_endofpacket_from_sa : OUT STD_LOGIC;
                 signal clock_0_in_nativeaddress : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal clock_0_in_read : OUT STD_LOGIC;
                 signal clock_0_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clock_0_in_reset_n : OUT STD_LOGIC;
                 signal clock_0_in_waitrequest_from_sa : OUT STD_LOGIC;
                 signal clock_0_in_write : OUT STD_LOGIC;
                 signal clock_0_in_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_granted_clock_0_in : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_clock_0_in : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_clock_0_in : OUT STD_LOGIC;
                 signal cpu_data_master_requests_clock_0_in : OUT STD_LOGIC;
                 signal d1_clock_0_in_end_xfer : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of clock_0_in_arbitrator : entity is FALSE;
end entity clock_0_in_arbitrator;


architecture europa of clock_0_in_arbitrator is
                signal clock_0_in_allgrants :  STD_LOGIC;
                signal clock_0_in_allow_new_arb_cycle :  STD_LOGIC;
                signal clock_0_in_any_bursting_master_saved_grant :  STD_LOGIC;
                signal clock_0_in_any_continuerequest :  STD_LOGIC;
                signal clock_0_in_arb_counter_enable :  STD_LOGIC;
                signal clock_0_in_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal clock_0_in_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal clock_0_in_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal clock_0_in_beginbursttransfer_internal :  STD_LOGIC;
                signal clock_0_in_begins_xfer :  STD_LOGIC;
                signal clock_0_in_end_xfer :  STD_LOGIC;
                signal clock_0_in_firsttransfer :  STD_LOGIC;
                signal clock_0_in_grant_vector :  STD_LOGIC;
                signal clock_0_in_in_a_read_cycle :  STD_LOGIC;
                signal clock_0_in_in_a_write_cycle :  STD_LOGIC;
                signal clock_0_in_master_qreq_vector :  STD_LOGIC;
                signal clock_0_in_non_bursting_master_requests :  STD_LOGIC;
                signal clock_0_in_reg_firsttransfer :  STD_LOGIC;
                signal clock_0_in_slavearbiterlockenable :  STD_LOGIC;
                signal clock_0_in_slavearbiterlockenable2 :  STD_LOGIC;
                signal clock_0_in_unreg_firsttransfer :  STD_LOGIC;
                signal clock_0_in_waits_for_read :  STD_LOGIC;
                signal clock_0_in_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_clock_0_in :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_clock_0_in :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_clock_0_in_waitrequest_from_sa :  STD_LOGIC;
                signal internal_cpu_data_master_granted_clock_0_in :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_clock_0_in :  STD_LOGIC;
                signal internal_cpu_data_master_requests_clock_0_in :  STD_LOGIC;
                signal wait_for_clock_0_in_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT clock_0_in_end_xfer;
      end if;
    end if;

  end process;

  clock_0_in_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_clock_0_in);
  --assign clock_0_in_readdata_from_sa = clock_0_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  clock_0_in_readdata_from_sa <= clock_0_in_readdata;
  internal_cpu_data_master_requests_clock_0_in <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 6) & std_logic_vector'("000000")) = std_logic_vector'("1000000000001000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign clock_0_in_waitrequest_from_sa = clock_0_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_clock_0_in_waitrequest_from_sa <= clock_0_in_waitrequest;
  --clock_0_in_arb_share_counter set values, which is an e_mux
  clock_0_in_arb_share_set_values <= std_logic_vector'("001");
  --clock_0_in_non_bursting_master_requests mux, which is an e_mux
  clock_0_in_non_bursting_master_requests <= internal_cpu_data_master_requests_clock_0_in;
  --clock_0_in_any_bursting_master_saved_grant mux, which is an e_mux
  clock_0_in_any_bursting_master_saved_grant <= std_logic'('0');
  --clock_0_in_arb_share_counter_next_value assignment, which is an e_assign
  clock_0_in_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(clock_0_in_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (clock_0_in_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(clock_0_in_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (clock_0_in_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --clock_0_in_allgrants all slave grants, which is an e_mux
  clock_0_in_allgrants <= clock_0_in_grant_vector;
  --clock_0_in_end_xfer assignment, which is an e_assign
  clock_0_in_end_xfer <= NOT ((clock_0_in_waits_for_read OR clock_0_in_waits_for_write));
  --end_xfer_arb_share_counter_term_clock_0_in arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_clock_0_in <= clock_0_in_end_xfer AND (((NOT clock_0_in_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --clock_0_in_arb_share_counter arbitration counter enable, which is an e_assign
  clock_0_in_arb_counter_enable <= ((end_xfer_arb_share_counter_term_clock_0_in AND clock_0_in_allgrants)) OR ((end_xfer_arb_share_counter_term_clock_0_in AND NOT clock_0_in_non_bursting_master_requests));
  --clock_0_in_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      clock_0_in_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(clock_0_in_arb_counter_enable) = '1' then 
        clock_0_in_arb_share_counter <= clock_0_in_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --clock_0_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      clock_0_in_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clock_0_in_master_qreq_vector AND end_xfer_arb_share_counter_term_clock_0_in)) OR ((end_xfer_arb_share_counter_term_clock_0_in AND NOT clock_0_in_non_bursting_master_requests)))) = '1' then 
        clock_0_in_slavearbiterlockenable <= or_reduce(clock_0_in_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master clock_0/in arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= clock_0_in_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --clock_0_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  clock_0_in_slavearbiterlockenable2 <= or_reduce(clock_0_in_arb_share_counter_next_value);
  --cpu/data_master clock_0/in arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= clock_0_in_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --clock_0_in_any_continuerequest at least one master continues requesting, which is an e_assign
  clock_0_in_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_clock_0_in <= internal_cpu_data_master_requests_clock_0_in AND NOT ((((cpu_data_master_read AND (NOT cpu_data_master_waitrequest))) OR (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write))));
  --clock_0_in_writedata mux, which is an e_mux
  clock_0_in_writedata <= cpu_data_master_writedata;
  --assign clock_0_in_endofpacket_from_sa = clock_0_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  clock_0_in_endofpacket_from_sa <= clock_0_in_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_clock_0_in <= internal_cpu_data_master_qualified_request_clock_0_in;
  --cpu/data_master saved-grant clock_0/in, which is an e_assign
  cpu_data_master_saved_grant_clock_0_in <= internal_cpu_data_master_requests_clock_0_in;
  --allow new arb cycle for clock_0/in, which is an e_assign
  clock_0_in_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  clock_0_in_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  clock_0_in_master_qreq_vector <= std_logic'('1');
  --clock_0_in_reset_n assignment, which is an e_assign
  clock_0_in_reset_n <= reset_n;
  --clock_0_in_firsttransfer first transaction, which is an e_assign
  clock_0_in_firsttransfer <= A_WE_StdLogic((std_logic'(clock_0_in_begins_xfer) = '1'), clock_0_in_unreg_firsttransfer, clock_0_in_reg_firsttransfer);
  --clock_0_in_unreg_firsttransfer first transaction, which is an e_assign
  clock_0_in_unreg_firsttransfer <= NOT ((clock_0_in_slavearbiterlockenable AND clock_0_in_any_continuerequest));
  --clock_0_in_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      clock_0_in_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(clock_0_in_begins_xfer) = '1' then 
        clock_0_in_reg_firsttransfer <= clock_0_in_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --clock_0_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  clock_0_in_beginbursttransfer_internal <= clock_0_in_begins_xfer;
  --clock_0_in_read assignment, which is an e_mux
  clock_0_in_read <= internal_cpu_data_master_granted_clock_0_in AND cpu_data_master_read;
  --clock_0_in_write assignment, which is an e_mux
  clock_0_in_write <= internal_cpu_data_master_granted_clock_0_in AND cpu_data_master_write;
  --clock_0_in_address mux, which is an e_mux
  clock_0_in_address <= cpu_data_master_address_to_slave (5 DOWNTO 0);
  --slaveid clock_0_in_nativeaddress nativeaddress mux, which is an e_mux
  clock_0_in_nativeaddress <= A_EXT (A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")), 4);
  --d1_clock_0_in_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_clock_0_in_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_clock_0_in_end_xfer <= clock_0_in_end_xfer;
      end if;
    end if;

  end process;

  --clock_0_in_waits_for_read in a cycle, which is an e_mux
  clock_0_in_waits_for_read <= clock_0_in_in_a_read_cycle AND internal_clock_0_in_waitrequest_from_sa;
  --clock_0_in_in_a_read_cycle assignment, which is an e_assign
  clock_0_in_in_a_read_cycle <= internal_cpu_data_master_granted_clock_0_in AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= clock_0_in_in_a_read_cycle;
  --clock_0_in_waits_for_write in a cycle, which is an e_mux
  clock_0_in_waits_for_write <= clock_0_in_in_a_write_cycle AND internal_clock_0_in_waitrequest_from_sa;
  --clock_0_in_in_a_write_cycle assignment, which is an e_assign
  clock_0_in_in_a_write_cycle <= internal_cpu_data_master_granted_clock_0_in AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= clock_0_in_in_a_write_cycle;
  wait_for_clock_0_in_counter <= std_logic'('0');
  --clock_0_in_byteenable byte enable port mux, which is an e_mux
  clock_0_in_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_clock_0_in)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  clock_0_in_waitrequest_from_sa <= internal_clock_0_in_waitrequest_from_sa;
  --vhdl renameroo for output signals
  cpu_data_master_granted_clock_0_in <= internal_cpu_data_master_granted_clock_0_in;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_clock_0_in <= internal_cpu_data_master_qualified_request_clock_0_in;
  --vhdl renameroo for output signals
  cpu_data_master_requests_clock_0_in <= internal_cpu_data_master_requests_clock_0_in;
--synthesis translate_off
    --clock_0/in enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity clock_0_out_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_0_out_address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
                 signal clock_0_out_granted_ram_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_0_out_qualified_request_ram_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_0_out_read : IN STD_LOGIC;
                 signal clock_0_out_read_data_valid_ram_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_0_out_requests_ram_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_0_out_write : IN STD_LOGIC;
                 signal clock_0_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_ram_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal clock_0_out_address_to_slave : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
                 signal clock_0_out_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clock_0_out_reset_n : OUT STD_LOGIC;
                 signal clock_0_out_waitrequest : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of clock_0_out_arbitrator : entity is FALSE;
end entity clock_0_out_arbitrator;


architecture europa of clock_0_out_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal clock_0_out_address_last_time :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal clock_0_out_read_last_time :  STD_LOGIC;
                signal clock_0_out_run :  STD_LOGIC;
                signal clock_0_out_write_last_time :  STD_LOGIC;
                signal clock_0_out_writedata_last_time :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal internal_clock_0_out_address_to_slave :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal internal_clock_0_out_waitrequest :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001") AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT clock_0_out_qualified_request_ram_avalon_slave_0 OR NOT clock_0_out_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_ram_avalon_slave_0_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(clock_0_out_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT clock_0_out_qualified_request_ram_avalon_slave_0 OR NOT clock_0_out_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(clock_0_out_write)))))))));
  --cascaded wait assignment, which is an e_assign
  clock_0_out_run <= r_1;
  --optimize select-logic by passing only those address bits which matter.
  internal_clock_0_out_address_to_slave <= clock_0_out_address;
  --actual waitrequest port, which is an e_assign
  internal_clock_0_out_waitrequest <= NOT clock_0_out_run;
  --clock_0_out_reset_n assignment, which is an e_assign
  clock_0_out_reset_n <= reset_n;
  --vhdl renameroo for output signals
  clock_0_out_address_to_slave <= internal_clock_0_out_address_to_slave;
  --vhdl renameroo for output signals
  clock_0_out_waitrequest <= internal_clock_0_out_waitrequest;
--synthesis translate_off
    --clock_0_out_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_0_out_address_last_time <= std_logic_vector'("000000");
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_0_out_address_last_time <= clock_0_out_address;
        end if;
      end if;

    end process;

    --clock_0/out waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          active_and_waiting_last_time <= internal_clock_0_out_waitrequest AND ((clock_0_out_read OR clock_0_out_write));
        end if;
      end if;

    end process;

    --clock_0_out_address matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_0_out_address, clock_0_out_address_last_time)
    VARIABLE write_line : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((clock_0_out_address /= clock_0_out_address_last_time))))) = '1' then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("clock_0_out_address did not heed wait!!!"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --clock_0_out_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_0_out_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_0_out_read_last_time <= clock_0_out_read;
        end if;
      end if;

    end process;

    --clock_0_out_read matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_0_out_read, clock_0_out_read_last_time)
    VARIABLE write_line1 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(clock_0_out_read) /= std_logic'(clock_0_out_read_last_time)))))) = '1' then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("clock_0_out_read did not heed wait!!!"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --clock_0_out_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_0_out_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_0_out_write_last_time <= clock_0_out_write;
        end if;
      end if;

    end process;

    --clock_0_out_write matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_0_out_write, clock_0_out_write_last_time)
    VARIABLE write_line2 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(clock_0_out_write) /= std_logic'(clock_0_out_write_last_time)))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("clock_0_out_write did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --clock_0_out_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_0_out_writedata_last_time <= std_logic_vector'("00000000000000000000000000000000");
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_0_out_writedata_last_time <= clock_0_out_writedata;
        end if;
      end if;

    end process;

    --clock_0_out_writedata matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_0_out_write, clock_0_out_writedata, clock_0_out_writedata_last_time)
    VARIABLE write_line3 : line;
    begin
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((clock_0_out_writedata /= clock_0_out_writedata_last_time)))) AND clock_0_out_write)) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("clock_0_out_writedata did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock_1_in_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_1_in_endofpacket : IN STD_LOGIC;
                 signal clock_1_in_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal clock_1_in_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_8 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal clock_1_in_address : OUT STD_LOGIC;
                 signal clock_1_in_endofpacket_from_sa : OUT STD_LOGIC;
                 signal clock_1_in_nativeaddress : OUT STD_LOGIC;
                 signal clock_1_in_read : OUT STD_LOGIC;
                 signal clock_1_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal clock_1_in_reset_n : OUT STD_LOGIC;
                 signal clock_1_in_waitrequest_from_sa : OUT STD_LOGIC;
                 signal clock_1_in_write : OUT STD_LOGIC;
                 signal clock_1_in_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_data_master_byteenable_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_granted_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_clock_1_in : OUT STD_LOGIC;
                 signal cpu_data_master_requests_clock_1_in : OUT STD_LOGIC;
                 signal d1_clock_1_in_end_xfer : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of clock_1_in_arbitrator : entity is FALSE;
end entity clock_1_in_arbitrator;


architecture europa of clock_1_in_arbitrator is
                signal clock_1_in_allgrants :  STD_LOGIC;
                signal clock_1_in_allow_new_arb_cycle :  STD_LOGIC;
                signal clock_1_in_any_bursting_master_saved_grant :  STD_LOGIC;
                signal clock_1_in_any_continuerequest :  STD_LOGIC;
                signal clock_1_in_arb_counter_enable :  STD_LOGIC;
                signal clock_1_in_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal clock_1_in_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal clock_1_in_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal clock_1_in_beginbursttransfer_internal :  STD_LOGIC;
                signal clock_1_in_begins_xfer :  STD_LOGIC;
                signal clock_1_in_end_xfer :  STD_LOGIC;
                signal clock_1_in_firsttransfer :  STD_LOGIC;
                signal clock_1_in_grant_vector :  STD_LOGIC;
                signal clock_1_in_in_a_read_cycle :  STD_LOGIC;
                signal clock_1_in_in_a_write_cycle :  STD_LOGIC;
                signal clock_1_in_master_qreq_vector :  STD_LOGIC;
                signal clock_1_in_non_bursting_master_requests :  STD_LOGIC;
                signal clock_1_in_pretend_byte_enable :  STD_LOGIC;
                signal clock_1_in_reg_firsttransfer :  STD_LOGIC;
                signal clock_1_in_slavearbiterlockenable :  STD_LOGIC;
                signal clock_1_in_slavearbiterlockenable2 :  STD_LOGIC;
                signal clock_1_in_unreg_firsttransfer :  STD_LOGIC;
                signal clock_1_in_waits_for_read :  STD_LOGIC;
                signal clock_1_in_waits_for_write :  STD_LOGIC;
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_clock_1_in_segment_0 :  STD_LOGIC;
                signal cpu_data_master_byteenable_clock_1_in_segment_1 :  STD_LOGIC;
                signal cpu_data_master_byteenable_clock_1_in_segment_2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_clock_1_in_segment_3 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_clock_1_in :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_clock_1_in :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_clock_1_in_waitrequest_from_sa :  STD_LOGIC;
                signal internal_cpu_data_master_byteenable_clock_1_in :  STD_LOGIC;
                signal internal_cpu_data_master_granted_clock_1_in :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_clock_1_in :  STD_LOGIC;
                signal internal_cpu_data_master_requests_clock_1_in :  STD_LOGIC;
                signal wait_for_clock_1_in_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT clock_1_in_end_xfer;
      end if;
    end if;

  end process;

  clock_1_in_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_clock_1_in);
  --assign clock_1_in_readdata_from_sa = clock_1_in_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  clock_1_in_readdata_from_sa <= clock_1_in_readdata;
  internal_cpu_data_master_requests_clock_1_in <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 1) & A_ToStdLogicVector(std_logic'('0'))) = std_logic_vector'("1000000000001000001010000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign clock_1_in_waitrequest_from_sa = clock_1_in_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_clock_1_in_waitrequest_from_sa <= clock_1_in_waitrequest;
  --clock_1_in_arb_share_counter set values, which is an e_mux
  clock_1_in_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_clock_1_in)) = '1'), std_logic_vector'("00000000000000000000000000000100"), std_logic_vector'("00000000000000000000000000000001")), 3);
  --clock_1_in_non_bursting_master_requests mux, which is an e_mux
  clock_1_in_non_bursting_master_requests <= internal_cpu_data_master_requests_clock_1_in;
  --clock_1_in_any_bursting_master_saved_grant mux, which is an e_mux
  clock_1_in_any_bursting_master_saved_grant <= std_logic'('0');
  --clock_1_in_arb_share_counter_next_value assignment, which is an e_assign
  clock_1_in_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(clock_1_in_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (clock_1_in_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(clock_1_in_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (clock_1_in_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --clock_1_in_allgrants all slave grants, which is an e_mux
  clock_1_in_allgrants <= clock_1_in_grant_vector;
  --clock_1_in_end_xfer assignment, which is an e_assign
  clock_1_in_end_xfer <= NOT ((clock_1_in_waits_for_read OR clock_1_in_waits_for_write));
  --end_xfer_arb_share_counter_term_clock_1_in arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_clock_1_in <= clock_1_in_end_xfer AND (((NOT clock_1_in_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --clock_1_in_arb_share_counter arbitration counter enable, which is an e_assign
  clock_1_in_arb_counter_enable <= ((end_xfer_arb_share_counter_term_clock_1_in AND clock_1_in_allgrants)) OR ((end_xfer_arb_share_counter_term_clock_1_in AND NOT clock_1_in_non_bursting_master_requests));
  --clock_1_in_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      clock_1_in_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(clock_1_in_arb_counter_enable) = '1' then 
        clock_1_in_arb_share_counter <= clock_1_in_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --clock_1_in_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      clock_1_in_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clock_1_in_master_qreq_vector AND end_xfer_arb_share_counter_term_clock_1_in)) OR ((end_xfer_arb_share_counter_term_clock_1_in AND NOT clock_1_in_non_bursting_master_requests)))) = '1' then 
        clock_1_in_slavearbiterlockenable <= or_reduce(clock_1_in_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master clock_1/in arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= clock_1_in_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --clock_1_in_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  clock_1_in_slavearbiterlockenable2 <= or_reduce(clock_1_in_arb_share_counter_next_value);
  --cpu/data_master clock_1/in arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= clock_1_in_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --clock_1_in_any_continuerequest at least one master continues requesting, which is an e_assign
  clock_1_in_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_clock_1_in <= internal_cpu_data_master_requests_clock_1_in AND NOT ((((cpu_data_master_read AND (NOT cpu_data_master_waitrequest))) OR (((((NOT cpu_data_master_waitrequest OR cpu_data_master_no_byte_enables_and_last_term) OR NOT(internal_cpu_data_master_byteenable_clock_1_in))) AND cpu_data_master_write))));
  --clock_1_in_writedata mux, which is an e_mux
  clock_1_in_writedata <= cpu_data_master_dbs_write_8;
  --assign clock_1_in_endofpacket_from_sa = clock_1_in_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  clock_1_in_endofpacket_from_sa <= clock_1_in_endofpacket;
  --master is always granted when requested
  internal_cpu_data_master_granted_clock_1_in <= internal_cpu_data_master_qualified_request_clock_1_in;
  --cpu/data_master saved-grant clock_1/in, which is an e_assign
  cpu_data_master_saved_grant_clock_1_in <= internal_cpu_data_master_requests_clock_1_in;
  --allow new arb cycle for clock_1/in, which is an e_assign
  clock_1_in_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  clock_1_in_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  clock_1_in_master_qreq_vector <= std_logic'('1');
  --clock_1_in_reset_n assignment, which is an e_assign
  clock_1_in_reset_n <= reset_n;
  --clock_1_in_firsttransfer first transaction, which is an e_assign
  clock_1_in_firsttransfer <= A_WE_StdLogic((std_logic'(clock_1_in_begins_xfer) = '1'), clock_1_in_unreg_firsttransfer, clock_1_in_reg_firsttransfer);
  --clock_1_in_unreg_firsttransfer first transaction, which is an e_assign
  clock_1_in_unreg_firsttransfer <= NOT ((clock_1_in_slavearbiterlockenable AND clock_1_in_any_continuerequest));
  --clock_1_in_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      clock_1_in_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(clock_1_in_begins_xfer) = '1' then 
        clock_1_in_reg_firsttransfer <= clock_1_in_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --clock_1_in_beginbursttransfer_internal begin burst transfer, which is an e_assign
  clock_1_in_beginbursttransfer_internal <= clock_1_in_begins_xfer;
  --clock_1_in_read assignment, which is an e_mux
  clock_1_in_read <= internal_cpu_data_master_granted_clock_1_in AND cpu_data_master_read;
  --clock_1_in_write assignment, which is an e_mux
  clock_1_in_write <= ((internal_cpu_data_master_granted_clock_1_in AND cpu_data_master_write)) AND clock_1_in_pretend_byte_enable;
  --clock_1_in_address mux, which is an e_mux
  clock_1_in_address <= Vector_To_Std_Logic(Std_Logic_Vector'(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & cpu_data_master_dbs_address(1 DOWNTO 0)));
  --slaveid clock_1_in_nativeaddress nativeaddress mux, which is an e_mux
  clock_1_in_nativeaddress <= Vector_To_Std_Logic(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")));
  --d1_clock_1_in_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_clock_1_in_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_clock_1_in_end_xfer <= clock_1_in_end_xfer;
      end if;
    end if;

  end process;

  --clock_1_in_waits_for_read in a cycle, which is an e_mux
  clock_1_in_waits_for_read <= clock_1_in_in_a_read_cycle AND internal_clock_1_in_waitrequest_from_sa;
  --clock_1_in_in_a_read_cycle assignment, which is an e_assign
  clock_1_in_in_a_read_cycle <= internal_cpu_data_master_granted_clock_1_in AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= clock_1_in_in_a_read_cycle;
  --clock_1_in_waits_for_write in a cycle, which is an e_mux
  clock_1_in_waits_for_write <= clock_1_in_in_a_write_cycle AND internal_clock_1_in_waitrequest_from_sa;
  --clock_1_in_in_a_write_cycle assignment, which is an e_assign
  clock_1_in_in_a_write_cycle <= internal_cpu_data_master_granted_clock_1_in AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= clock_1_in_in_a_write_cycle;
  wait_for_clock_1_in_counter <= std_logic'('0');
  --clock_1_in_pretend_byte_enable byte enable port mux, which is an e_mux
  clock_1_in_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_clock_1_in)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_byteenable_clock_1_in))), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  (cpu_data_master_byteenable_clock_1_in_segment_3, cpu_data_master_byteenable_clock_1_in_segment_2, cpu_data_master_byteenable_clock_1_in_segment_1, cpu_data_master_byteenable_clock_1_in_segment_0) <= cpu_data_master_byteenable;
  internal_cpu_data_master_byteenable_clock_1_in <= A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_byteenable_clock_1_in_segment_0, A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000001"))), cpu_data_master_byteenable_clock_1_in_segment_1, A_WE_StdLogic((((std_logic_vector'("000000000000000000000000000000") & (cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000010"))), cpu_data_master_byteenable_clock_1_in_segment_2, cpu_data_master_byteenable_clock_1_in_segment_3)));
  --vhdl renameroo for output signals
  clock_1_in_waitrequest_from_sa <= internal_clock_1_in_waitrequest_from_sa;
  --vhdl renameroo for output signals
  cpu_data_master_byteenable_clock_1_in <= internal_cpu_data_master_byteenable_clock_1_in;
  --vhdl renameroo for output signals
  cpu_data_master_granted_clock_1_in <= internal_cpu_data_master_granted_clock_1_in;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_clock_1_in <= internal_cpu_data_master_qualified_request_clock_1_in;
  --vhdl renameroo for output signals
  cpu_data_master_requests_clock_1_in <= internal_cpu_data_master_requests_clock_1_in;
--synthesis translate_off
    --clock_1/in enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity clock_1_out_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_1_out_address : IN STD_LOGIC;
                 signal clock_1_out_granted_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_1_out_qualified_request_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_1_out_read : IN STD_LOGIC;
                 signal clock_1_out_read_data_valid_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_1_out_requests_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                 signal clock_1_out_write : IN STD_LOGIC;
                 signal clock_1_out_writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal d1_ram_signal_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal clock_1_out_address_to_slave : OUT STD_LOGIC;
                 signal clock_1_out_readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal clock_1_out_reset_n : OUT STD_LOGIC;
                 signal clock_1_out_waitrequest : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of clock_1_out_arbitrator : entity is FALSE;
end entity clock_1_out_arbitrator;


architecture europa of clock_1_out_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal clock_1_out_address_last_time :  STD_LOGIC;
                signal clock_1_out_read_last_time :  STD_LOGIC;
                signal clock_1_out_run :  STD_LOGIC;
                signal clock_1_out_write_last_time :  STD_LOGIC;
                signal clock_1_out_writedata_last_time :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_clock_1_out_address_to_slave :  STD_LOGIC;
                signal internal_clock_1_out_waitrequest :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((std_logic_vector'("00000000000000000000000000000001") AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT clock_1_out_qualified_request_ram_signal_avalon_slave_0 OR NOT clock_1_out_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_ram_signal_avalon_slave_0_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(clock_1_out_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT clock_1_out_qualified_request_ram_signal_avalon_slave_0 OR NOT clock_1_out_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(clock_1_out_write)))))))));
  --cascaded wait assignment, which is an e_assign
  clock_1_out_run <= r_1;
  --optimize select-logic by passing only those address bits which matter.
  internal_clock_1_out_address_to_slave <= clock_1_out_address;
  --actual waitrequest port, which is an e_assign
  internal_clock_1_out_waitrequest <= NOT clock_1_out_run;
  --clock_1_out_reset_n assignment, which is an e_assign
  clock_1_out_reset_n <= reset_n;
  --vhdl renameroo for output signals
  clock_1_out_address_to_slave <= internal_clock_1_out_address_to_slave;
  --vhdl renameroo for output signals
  clock_1_out_waitrequest <= internal_clock_1_out_waitrequest;
--synthesis translate_off
    --clock_1_out_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_1_out_address_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_1_out_address_last_time <= clock_1_out_address;
        end if;
      end if;

    end process;

    --clock_1/out waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          active_and_waiting_last_time <= internal_clock_1_out_waitrequest AND ((clock_1_out_read OR clock_1_out_write));
        end if;
      end if;

    end process;

    --clock_1_out_address matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_1_out_address, clock_1_out_address_last_time)
    VARIABLE write_line4 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(clock_1_out_address) /= std_logic'(clock_1_out_address_last_time)))))) = '1' then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("clock_1_out_address did not heed wait!!!"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --clock_1_out_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_1_out_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_1_out_read_last_time <= clock_1_out_read;
        end if;
      end if;

    end process;

    --clock_1_out_read matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_1_out_read, clock_1_out_read_last_time)
    VARIABLE write_line5 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(clock_1_out_read) /= std_logic'(clock_1_out_read_last_time)))))) = '1' then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("clock_1_out_read did not heed wait!!!"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --clock_1_out_write check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_1_out_write_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_1_out_write_last_time <= clock_1_out_write;
        end if;
      end if;

    end process;

    --clock_1_out_write matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_1_out_write, clock_1_out_write_last_time)
    VARIABLE write_line6 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(clock_1_out_write) /= std_logic'(clock_1_out_write_last_time)))))) = '1' then 
          write(write_line6, now);
          write(write_line6, string'(": "));
          write(write_line6, string'("clock_1_out_write did not heed wait!!!"));
          write(output, write_line6.all);
          deallocate (write_line6);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --clock_1_out_writedata check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        clock_1_out_writedata_last_time <= std_logic_vector'("00000000");
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          clock_1_out_writedata_last_time <= clock_1_out_writedata;
        end if;
      end if;

    end process;

    --clock_1_out_writedata matches last port_name, which is an e_process
    process (active_and_waiting_last_time, clock_1_out_write, clock_1_out_writedata, clock_1_out_writedata_last_time)
    VARIABLE write_line7 : line;
    begin
        if std_logic'(((active_and_waiting_last_time AND to_std_logic(((clock_1_out_writedata /= clock_1_out_writedata_last_time)))) AND clock_1_out_write)) = '1' then 
          write(write_line7, now);
          write(write_line7, string'(": "));
          write(write_line7, string'("clock_1_out_writedata did not heed wait!!!"));
          write(output, write_line7.all);
          deallocate (write_line7);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_reset : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_reset_n : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                 signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of cpu_jtag_debug_module_arbitrator : entity is FALSE;
end entity cpu_jtag_debug_module_arbitrator;


architecture europa of cpu_jtag_debug_module_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_jtag_debug_module_allgrants :  STD_LOGIC;
                signal cpu_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal cpu_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal cpu_jtag_debug_module_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal cpu_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal cpu_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal cpu_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal cpu_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal cpu_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal cpu_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal cpu_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_cpu_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal internal_cpu_jtag_debug_module_reset_n :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_cpu_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT cpu_jtag_debug_module_end_xfer;
      end if;
    end if;

  end process;

  cpu_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_cpu_jtag_debug_module OR internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  --assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_readdata_from_sa <= cpu_jtag_debug_module_readdata;
  internal_cpu_data_master_requests_cpu_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1000000000000100000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  cpu_jtag_debug_module_arb_share_set_values <= std_logic_vector'("001");
  --cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  cpu_jtag_debug_module_non_bursting_master_requests <= ((internal_cpu_data_master_requests_cpu_jtag_debug_module OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module) OR internal_cpu_data_master_requests_cpu_jtag_debug_module) OR internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  cpu_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  cpu_jtag_debug_module_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_jtag_debug_module_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (cpu_jtag_debug_module_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  cpu_jtag_debug_module_allgrants <= ((or_reduce(cpu_jtag_debug_module_grant_vector) OR or_reduce(cpu_jtag_debug_module_grant_vector)) OR or_reduce(cpu_jtag_debug_module_grant_vector)) OR or_reduce(cpu_jtag_debug_module_grant_vector);
  --cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  cpu_jtag_debug_module_end_xfer <= NOT ((cpu_jtag_debug_module_waits_for_read OR cpu_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_cpu_jtag_debug_module <= cpu_jtag_debug_module_end_xfer AND (((NOT cpu_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  cpu_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND cpu_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests));
  --cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_arb_counter_enable) = '1' then 
        cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(cpu_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_cpu_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_cpu_jtag_debug_module AND NOT cpu_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        cpu_jtag_debug_module_slavearbiterlockenable <= or_reduce(cpu_jtag_debug_module_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  cpu_jtag_debug_module_slavearbiterlockenable2 <= or_reduce(cpu_jtag_debug_module_arb_share_counter_next_value);
  --cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= cpu_jtag_debug_module_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= cpu_jtag_debug_module_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module))))));
      end if;
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  cpu_jtag_debug_module_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module AND NOT (((((NOT cpu_data_master_waitrequest) AND cpu_data_master_write)) OR cpu_instruction_master_arbiterlock));
  --cpu_jtag_debug_module_writedata mux, which is an e_mux
  cpu_jtag_debug_module_writedata <= cpu_data_master_writedata;
  --mux cpu_jtag_debug_module_debugaccess, which is an e_mux
  cpu_jtag_debug_module_debugaccess <= cpu_data_master_debugaccess;
  internal_cpu_instruction_master_requests_cpu_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(24 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("1000000000000100000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_cpu_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_cpu_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module))))));
      end if;
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module AND NOT (cpu_data_master_arbiterlock);
  --allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_instruction_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(0);
  --cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_instruction_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(0) AND internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  cpu_jtag_debug_module_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  internal_cpu_data_master_granted_cpu_jtag_debug_module <= cpu_jtag_debug_module_grant_vector(1);
  --cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  cpu_data_master_saved_grant_cpu_jtag_debug_module <= cpu_jtag_debug_module_arb_winner(1) AND internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  cpu_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((cpu_jtag_debug_module_master_qreq_vector & cpu_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT cpu_jtag_debug_module_master_qreq_vector & NOT cpu_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (cpu_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  cpu_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((cpu_jtag_debug_module_allow_new_arb_cycle AND or_reduce(cpu_jtag_debug_module_grant_vector)))) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
  --saved cpu_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        cpu_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1'), cpu_jtag_debug_module_grant_vector, cpu_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  cpu_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(1) OR cpu_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((cpu_jtag_debug_module_chosen_master_double_vector(0) OR cpu_jtag_debug_module_chosen_master_double_vector(2)))));
  --cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  cpu_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(cpu_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --cpu/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(cpu_jtag_debug_module_grant_vector)) = '1' then 
        cpu_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(cpu_jtag_debug_module_end_xfer) = '1'), cpu_jtag_debug_module_chosen_master_rot_left, cpu_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  cpu_jtag_debug_module_begintransfer <= cpu_jtag_debug_module_begins_xfer;
  --assign lhs ~cpu_jtag_debug_module_reset of type reset_n to cpu_jtag_debug_module_reset_n, which is an e_assign
  cpu_jtag_debug_module_reset <= NOT internal_cpu_jtag_debug_module_reset_n;
  --cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  internal_cpu_jtag_debug_module_reset_n <= reset_n;
  --assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  cpu_jtag_debug_module_resetrequest_from_sa <= cpu_jtag_debug_module_resetrequest;
  cpu_jtag_debug_module_chipselect <= internal_cpu_data_master_granted_cpu_jtag_debug_module OR internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(cpu_jtag_debug_module_begins_xfer) = '1'), cpu_jtag_debug_module_unreg_firsttransfer, cpu_jtag_debug_module_reg_firsttransfer);
  --cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  cpu_jtag_debug_module_unreg_firsttransfer <= NOT ((cpu_jtag_debug_module_slavearbiterlockenable AND cpu_jtag_debug_module_any_continuerequest));
  --cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      cpu_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(cpu_jtag_debug_module_begins_xfer) = '1' then 
        cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  cpu_jtag_debug_module_beginbursttransfer_internal <= cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  cpu_jtag_debug_module_arbitration_holdoff_internal <= cpu_jtag_debug_module_begins_xfer AND cpu_jtag_debug_module_firsttransfer;
  --cpu_jtag_debug_module_write assignment, which is an e_mux
  cpu_jtag_debug_module_write <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --cpu_jtag_debug_module_address mux, which is an e_mux
  cpu_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master <= cpu_instruction_master_address_to_slave;
  --d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_cpu_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
      end if;
    end if;

  end process;

  --cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_read <= cpu_jtag_debug_module_in_a_read_cycle AND cpu_jtag_debug_module_begins_xfer;
  --cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_read_cycle <= ((internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_cpu_jtag_debug_module AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= cpu_jtag_debug_module_in_a_read_cycle;
  --cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  cpu_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  cpu_jtag_debug_module_in_a_write_cycle <= internal_cpu_data_master_granted_cpu_jtag_debug_module AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= cpu_jtag_debug_module_in_a_write_cycle;
  wait_for_cpu_jtag_debug_module_counter <= std_logic'('0');
  --cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  cpu_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_cpu_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  cpu_data_master_granted_cpu_jtag_debug_module <= internal_cpu_data_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_data_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_data_master_requests_cpu_jtag_debug_module <= internal_cpu_data_master_requests_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_cpu_jtag_debug_module <= internal_cpu_instruction_master_granted_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_cpu_jtag_debug_module <= internal_cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_cpu_jtag_debug_module <= internal_cpu_instruction_master_requests_cpu_jtag_debug_module;
  --vhdl renameroo for output signals
  cpu_jtag_debug_module_reset_n <= internal_cpu_jtag_debug_module_reset_n;
--synthesis translate_off
    --cpu/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line8 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line8, now);
          write(write_line8, string'(": "));
          write(write_line8, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line8.all);
          deallocate (write_line8);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line9 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_cpu_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_cpu_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line9, now);
          write(write_line9, string'(": "));
          write(write_line9, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line9.all);
          deallocate (write_line9);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpu_data_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_0_in_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clock_0_in_waitrequest_from_sa : IN STD_LOGIC;
                 signal clock_1_in_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal clock_1_in_waitrequest_from_sa : IN STD_LOGIC;
                 signal cpu_data_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_byteenable_sdram_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_debugaccess : IN STD_LOGIC;
                 signal cpu_data_master_granted_clock_0_in : IN STD_LOGIC;
                 signal cpu_data_master_granted_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_granted_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_data_master_granted_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_clock_0_in : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_data_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_clock_0_in : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal cpu_data_master_requests_clock_0_in : IN STD_LOGIC;
                 signal cpu_data_master_requests_clock_1_in : IN STD_LOGIC;
                 signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                 signal cpu_data_master_requests_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                 signal cpu_data_master_requests_sdram_s1 : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_clock_0_in_end_xfer : IN STD_LOGIC;
                 signal d1_clock_1_in_end_xfer : IN STD_LOGIC;
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_jtag_uart_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_ps2_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal ps2_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal ps2_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_dbs_write_8 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : OUT STD_LOGIC;
                 signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_data_master_waitrequest : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of cpu_data_master_arbitrator : entity is FALSE;
end entity cpu_data_master_arbitrator;


architecture europa of cpu_data_master_arbitrator is
                signal cpu_data_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_run :  STD_LOGIC;
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_cpu_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_no_byte_enables_and_last_term :  STD_LOGIC;
                signal internal_cpu_data_master_waitrequest :  STD_LOGIC;
                signal last_dbs_term_and_run :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal p1_dbs_8_reg_segment_0 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_8_reg_segment_1 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_dbs_8_reg_segment_2 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal p1_registered_cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;
                signal registered_cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_clock_0_in OR NOT cpu_data_master_requests_clock_0_in)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_clock_0_in OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT clock_0_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_clock_0_in OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT clock_0_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((cpu_data_master_qualified_request_clock_1_in OR ((((cpu_data_master_write AND NOT(cpu_data_master_byteenable_clock_1_in)) AND internal_cpu_data_master_dbs_address(1)) AND internal_cpu_data_master_dbs_address(0)))) OR NOT cpu_data_master_requests_clock_1_in)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_clock_1_in OR NOT cpu_data_master_read)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT clock_1_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_data_master_dbs_address(1) AND internal_cpu_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_clock_1_in OR NOT cpu_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT clock_1_in_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((internal_cpu_data_master_dbs_address(1) AND internal_cpu_data_master_dbs_address(0))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_cpu_jtag_debug_module OR NOT cpu_data_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT jtag_uart_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_qualified_request_ps2_0_avalon_slave_0 OR NOT cpu_data_master_requests_ps2_0_avalon_slave_0)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ps2_0_avalon_slave_0 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT ps2_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_data_master_run <= r_0 AND r_1;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic(((((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_ps2_0_avalon_slave_0 OR NOT ((cpu_data_master_read OR cpu_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT ps2_0_avalon_slave_0_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_read OR cpu_data_master_write))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((((cpu_data_master_qualified_request_sdram_s1 OR ((cpu_data_master_read_data_valid_sdram_s1 AND internal_cpu_data_master_dbs_address(1)))) OR (((cpu_data_master_write AND NOT(or_reduce(cpu_data_master_byteenable_sdram_s1))) AND internal_cpu_data_master_dbs_address(1)))) OR NOT cpu_data_master_requests_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_granted_sdram_s1 OR NOT cpu_data_master_qualified_request_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT cpu_data_master_qualified_request_sdram_s1 OR NOT cpu_data_master_read) OR (((cpu_data_master_read_data_valid_sdram_s1 AND (internal_cpu_data_master_dbs_address(1))) AND cpu_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_data_master_qualified_request_sdram_s1 OR NOT cpu_data_master_write)))) OR ((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_write)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_data_master_address_to_slave <= cpu_data_master_address(24 DOWNTO 0);
  --unpredictable registered wait state incoming data, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      registered_cpu_data_master_readdata <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        registered_cpu_data_master_readdata <= p1_registered_cpu_data_master_readdata;
      end if;
    end if;

  end process;

  --registered readdata mux, which is an e_mux
  p1_registered_cpu_data_master_readdata <= (((((A_REP(NOT cpu_data_master_requests_clock_0_in, 32) OR clock_0_in_readdata_from_sa)) AND ((A_REP(NOT cpu_data_master_requests_clock_1_in, 32) OR Std_Logic_Vector'(clock_1_in_readdata_from_sa(7 DOWNTO 0) & dbs_8_reg_segment_2 & dbs_8_reg_segment_1 & dbs_8_reg_segment_0)))) AND ((A_REP(NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave, 32) OR jtag_uart_avalon_jtag_slave_readdata_from_sa))) AND ((A_REP(NOT cpu_data_master_requests_ps2_0_avalon_slave_0, 32) OR ps2_0_avalon_slave_0_readdata_from_sa))) AND ((A_REP(NOT cpu_data_master_requests_sdram_s1, 32) OR Std_Logic_Vector'(sdram_s1_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)));
  --cpu/data_master readdata mux, which is an e_mux
  cpu_data_master_readdata <= ((((((A_REP(NOT cpu_data_master_requests_clock_0_in, 32) OR registered_cpu_data_master_readdata)) AND ((A_REP(NOT cpu_data_master_requests_clock_1_in, 32) OR registered_cpu_data_master_readdata))) AND ((A_REP(NOT cpu_data_master_requests_cpu_jtag_debug_module, 32) OR cpu_jtag_debug_module_readdata_from_sa))) AND ((A_REP(NOT cpu_data_master_requests_jtag_uart_avalon_jtag_slave, 32) OR registered_cpu_data_master_readdata))) AND ((A_REP(NOT cpu_data_master_requests_ps2_0_avalon_slave_0, 32) OR registered_cpu_data_master_readdata))) AND ((A_REP(NOT cpu_data_master_requests_sdram_s1, 32) OR registered_cpu_data_master_readdata));
  --actual waitrequest port, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_waitrequest <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        internal_cpu_data_master_waitrequest <= Vector_To_Std_Logic(NOT (A_WE_StdLogicVector((std_logic'((NOT ((cpu_data_master_read OR cpu_data_master_write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_data_master_run AND internal_cpu_data_master_waitrequest))))))));
      end if;
    end if;

  end process;

  --no_byte_enables_and_last_term, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_no_byte_enables_and_last_term <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        internal_cpu_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
      end if;
    end if;

  end process;

  --compute the last dbs term, which is an e_mux
  last_dbs_term_and_run <= A_WE_StdLogic((std_logic'((cpu_data_master_requests_clock_1_in)) = '1'), (((to_std_logic(((internal_cpu_data_master_dbs_address = std_logic_vector'("11")))) AND cpu_data_master_write) AND NOT(cpu_data_master_byteenable_clock_1_in))), (((to_std_logic(((internal_cpu_data_master_dbs_address = std_logic_vector'("10")))) AND cpu_data_master_write) AND NOT(or_reduce(cpu_data_master_byteenable_sdram_s1)))));
  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= Vector_To_Std_Logic(((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((((NOT internal_cpu_data_master_no_byte_enables_and_last_term) AND cpu_data_master_requests_clock_1_in) AND cpu_data_master_write) AND NOT(cpu_data_master_byteenable_clock_1_in)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_clock_1_in AND cpu_data_master_read)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT clock_1_in_waitrequest_from_sa)))))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_clock_1_in AND cpu_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT clock_1_in_waitrequest_from_sa)))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((((NOT internal_cpu_data_master_no_byte_enables_and_last_term) AND cpu_data_master_requests_sdram_s1) AND cpu_data_master_write) AND NOT(or_reduce(cpu_data_master_byteenable_sdram_s1)))))))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_read_data_valid_sdram_s1)))) OR (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((cpu_data_master_granted_sdram_s1 AND cpu_data_master_write)))) AND std_logic_vector'("00000000000000000000000000000001")) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT sdram_s1_waitrequest_from_sa)))))));
  --input to dbs-8 stored 0, which is an e_mux
  p1_dbs_8_reg_segment_0 <= clock_1_in_readdata_from_sa;
  --dbs register for dbs-8 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_0 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_8_reg_segment_0 <= p1_dbs_8_reg_segment_0;
      end if;
    end if;

  end process;

  --input to dbs-8 stored 1, which is an e_mux
  p1_dbs_8_reg_segment_1 <= clock_1_in_readdata_from_sa;
  --dbs register for dbs-8 segment 1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_1 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000001")))))) = '1' then 
        dbs_8_reg_segment_1 <= p1_dbs_8_reg_segment_1;
      end if;
    end if;

  end process;

  --input to dbs-8 stored 2, which is an e_mux
  p1_dbs_8_reg_segment_2 <= clock_1_in_readdata_from_sa;
  --dbs register for dbs-8 segment 2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_8_reg_segment_2 <= std_logic_vector'("00000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("000000000000000000000000000000") & ((internal_cpu_data_master_dbs_address(1 DOWNTO 0)))) = std_logic_vector'("00000000000000000000000000000010")))))) = '1' then 
        dbs_8_reg_segment_2 <= p1_dbs_8_reg_segment_2;
      end if;
    end if;

  end process;

  --mux write dbs 2, which is an e_mux
  cpu_data_master_dbs_write_8 <= A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_writedata(7 DOWNTO 0), A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000001"))), cpu_data_master_writedata(15 DOWNTO 8), A_WE_StdLogicVector((((std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_dbs_address(1 DOWNTO 0))) = std_logic_vector'("00000000000000000000000000000010"))), cpu_data_master_writedata(23 DOWNTO 16), cpu_data_master_writedata(31 DOWNTO 24))));
  --dbs count increment, which is an e_mux
  cpu_data_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_clock_1_in)) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'((cpu_data_master_requests_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000"))), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_data_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_data_master_dbs_address)) + (std_logic_vector'("0") & (cpu_data_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= (pre_dbs_count_enable AND (NOT ((cpu_data_master_requests_clock_1_in AND NOT internal_cpu_data_master_waitrequest)))) AND (NOT ((cpu_data_master_requests_sdram_s1 AND NOT internal_cpu_data_master_waitrequest)));
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_data_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_data_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --irq assign, which is an e_assign
  cpu_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(jtag_uart_avalon_jtag_slave_irq_from_sa));
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= sdram_s1_readdata_from_sa;
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_data_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --mux write dbs 1, which is an e_mux
  cpu_data_master_dbs_write_16 <= A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_dbs_address(1))) = '1'), cpu_data_master_writedata(31 DOWNTO 16), cpu_data_master_writedata(15 DOWNTO 0));
  --vhdl renameroo for output signals
  cpu_data_master_address_to_slave <= internal_cpu_data_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_data_master_dbs_address <= internal_cpu_data_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_data_master_no_byte_enables_and_last_term <= internal_cpu_data_master_no_byte_enables_and_last_term;
  --vhdl renameroo for output signals
  cpu_data_master_waitrequest <= internal_cpu_data_master_waitrequest;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity cpu_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_granted_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                 signal cpu_instruction_master_requests_sdram_s1 : IN STD_LOGIC;
                 signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

              -- outputs:
                 signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of cpu_instruction_master_arbitrator : entity is FALSE;
end entity cpu_instruction_master_arbitrator;


architecture europa of cpu_instruction_master_arbitrator is
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal cpu_instruction_master_address_last_time :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_instruction_master_dbs_increment :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_read_last_time :  STD_LOGIC;
                signal cpu_instruction_master_run :  STD_LOGIC;
                signal dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal dbs_count_enable :  STD_LOGIC;
                signal dbs_counter_overflow :  STD_LOGIC;
                signal internal_cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal internal_cpu_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal next_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal p1_dbs_16_reg_segment_0 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal pre_dbs_count_enable :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;
                signal r_1 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_requests_cpu_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_cpu_jtag_debug_module OR NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT cpu_instruction_master_qualified_request_cpu_jtag_debug_module OR NOT cpu_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_cpu_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  cpu_instruction_master_run <= r_0 AND r_1;
  --r_1 master_run cascaded wait assignment, which is an e_assign
  r_1 <= Vector_To_Std_Logic((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((cpu_instruction_master_qualified_request_sdram_s1 OR ((cpu_instruction_master_read_data_valid_sdram_s1 AND internal_cpu_instruction_master_dbs_address(1)))) OR NOT cpu_instruction_master_requests_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((cpu_instruction_master_granted_sdram_s1 OR NOT cpu_instruction_master_qualified_request_sdram_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT cpu_instruction_master_qualified_request_sdram_s1 OR NOT cpu_instruction_master_read) OR (((cpu_instruction_master_read_data_valid_sdram_s1 AND (internal_cpu_instruction_master_dbs_address(1))) AND cpu_instruction_master_read)))))))));
  --optimize select-logic by passing only those address bits which matter.
  internal_cpu_instruction_master_address_to_slave <= cpu_instruction_master_address(24 DOWNTO 0);
  --cpu/instruction_master readdata mux, which is an e_mux
  cpu_instruction_master_readdata <= ((A_REP(NOT cpu_instruction_master_requests_cpu_jtag_debug_module, 32) OR cpu_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT cpu_instruction_master_requests_sdram_s1, 32) OR Std_Logic_Vector'(sdram_s1_readdata_from_sa(15 DOWNTO 0) & dbs_16_reg_segment_0)));
  --actual waitrequest port, which is an e_assign
  internal_cpu_instruction_master_waitrequest <= NOT cpu_instruction_master_run;
  --input to dbs-16 stored 0, which is an e_mux
  p1_dbs_16_reg_segment_0 <= sdram_s1_readdata_from_sa;
  --dbs register for dbs-16 segment 0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      dbs_16_reg_segment_0 <= std_logic_vector'("0000000000000000");
    elsif clk'event and clk = '1' then
      if std_logic'((dbs_count_enable AND to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((internal_cpu_instruction_master_dbs_address(1))))) = std_logic_vector'("00000000000000000000000000000000")))))) = '1' then 
        dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
      end if;
    end if;

  end process;

  --dbs count increment, which is an e_mux
  cpu_instruction_master_dbs_increment <= A_EXT (A_WE_StdLogicVector((std_logic'((cpu_instruction_master_requests_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000000")), 2);
  --dbs counter overflow, which is an e_assign
  dbs_counter_overflow <= internal_cpu_instruction_master_dbs_address(1) AND NOT((next_dbs_address(1)));
  --next master address, which is an e_assign
  next_dbs_address <= A_EXT (((std_logic_vector'("0") & (internal_cpu_instruction_master_dbs_address)) + (std_logic_vector'("0") & (cpu_instruction_master_dbs_increment))), 2);
  --dbs count enable, which is an e_mux
  dbs_count_enable <= pre_dbs_count_enable;
  --dbs counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_cpu_instruction_master_dbs_address <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(dbs_count_enable) = '1' then 
        internal_cpu_instruction_master_dbs_address <= next_dbs_address;
      end if;
    end if;

  end process;

  --pre dbs count enable, which is an e_mux
  pre_dbs_count_enable <= cpu_instruction_master_read_data_valid_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_address_to_slave <= internal_cpu_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  cpu_instruction_master_dbs_address <= internal_cpu_instruction_master_dbs_address;
  --vhdl renameroo for output signals
  cpu_instruction_master_waitrequest <= internal_cpu_instruction_master_waitrequest;
--synthesis translate_off
    --cpu_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_address_last_time <= std_logic_vector'("0000000000000000000000000");
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
        end if;
      end if;

    end process;

    --cpu/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          active_and_waiting_last_time <= internal_cpu_instruction_master_waitrequest AND (cpu_instruction_master_read);
        end if;
      end if;

    end process;

    --cpu_instruction_master_address matches last port_name, which is an e_process
    process (active_and_waiting_last_time, cpu_instruction_master_address, cpu_instruction_master_address_last_time)
    VARIABLE write_line10 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((cpu_instruction_master_address /= cpu_instruction_master_address_last_time))))) = '1' then 
          write(write_line10, now);
          write(write_line10, string'(": "));
          write(write_line10, string'("cpu_instruction_master_address did not heed wait!!!"));
          write(output, write_line10.all);
          deallocate (write_line10);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

    --cpu_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        cpu_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
        end if;
      end if;

    end process;

    --cpu_instruction_master_read matches last port_name, which is an e_process
    process (active_and_waiting_last_time, cpu_instruction_master_read, cpu_instruction_master_read_last_time)
    VARIABLE write_line11 : line;
    begin
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(cpu_instruction_master_read) /= std_logic'(cpu_instruction_master_read_last_time)))))) = '1' then 
          write(write_line11, now);
          write(write_line11, string'(": "));
          write(write_line11, string'("cpu_instruction_master_read did not heed wait!!!"));
          write(output, write_line11.all);
          deallocate (write_line11);
          assert false report "VHDL STOP" severity failure;
        end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity jtag_uart_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                 signal d1_jtag_uart_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal jtag_uart_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of jtag_uart_avalon_jtag_slave_arbitrator : entity is FALSE;
end entity jtag_uart_avalon_jtag_slave_arbitrator;


architecture europa of jtag_uart_avalon_jtag_slave_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_jtag_uart_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT jtag_uart_avalon_jtag_slave_end_xfer;
      end if;
    end if;

  end process;

  jtag_uart_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave);
  --assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_readdata_from_sa <= jtag_uart_avalon_jtag_slave_readdata;
  internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("1000000000001000001000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_dataavailable_from_sa <= jtag_uart_avalon_jtag_slave_dataavailable;
  --assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_readyfordata_from_sa <= jtag_uart_avalon_jtag_slave_readyfordata;
  --assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa <= jtag_uart_avalon_jtag_slave_waitrequest;
  --jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  jtag_uart_avalon_jtag_slave_arb_share_set_values <= std_logic_vector'("001");
  --jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_non_bursting_master_requests <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(jtag_uart_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_avalon_jtag_slave_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (jtag_uart_avalon_jtag_slave_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  jtag_uart_avalon_jtag_slave_allgrants <= jtag_uart_avalon_jtag_slave_grant_vector;
  --jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_end_xfer <= NOT ((jtag_uart_avalon_jtag_slave_waits_for_read OR jtag_uart_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave <= jtag_uart_avalon_jtag_slave_end_xfer AND (((NOT jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  jtag_uart_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND jtag_uart_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND NOT jtag_uart_avalon_jtag_slave_non_bursting_master_requests));
  --jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_avalon_jtag_slave_arb_counter_enable) = '1' then 
        jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((jtag_uart_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave AND NOT jtag_uart_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= jtag_uart_avalon_jtag_slave_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 <= or_reduce(jtag_uart_avalon_jtag_slave_arb_share_counter_next_value);
  --cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  jtag_uart_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave AND NOT ((((cpu_data_master_read AND (NOT cpu_data_master_waitrequest))) OR (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write))));
  --jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  --cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  jtag_uart_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  jtag_uart_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  jtag_uart_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_reset_n <= reset_n;
  jtag_uart_avalon_jtag_slave_chipselect <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  --jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  jtag_uart_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(jtag_uart_avalon_jtag_slave_begins_xfer) = '1'), jtag_uart_avalon_jtag_slave_unreg_firsttransfer, jtag_uart_avalon_jtag_slave_reg_firsttransfer);
  --jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  jtag_uart_avalon_jtag_slave_unreg_firsttransfer <= NOT ((jtag_uart_avalon_jtag_slave_slavearbiterlockenable AND jtag_uart_avalon_jtag_slave_any_continuerequest));
  --jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      jtag_uart_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(jtag_uart_avalon_jtag_slave_begins_xfer) = '1' then 
        jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  jtag_uart_avalon_jtag_slave_beginbursttransfer_internal <= jtag_uart_avalon_jtag_slave_begins_xfer;
  --~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  jtag_uart_avalon_jtag_slave_read_n <= NOT ((internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read));
  --~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  jtag_uart_avalon_jtag_slave_write_n <= NOT ((internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_write));
  shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  jtag_uart_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_jtag_uart_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
      end if;
    end if;

  end process;

  --jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  jtag_uart_avalon_jtag_slave_waits_for_read <= jtag_uart_avalon_jtag_slave_in_a_read_cycle AND internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_in_a_read_cycle <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  --jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  jtag_uart_avalon_jtag_slave_waits_for_write <= jtag_uart_avalon_jtag_slave_in_a_write_cycle AND internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  --jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  jtag_uart_avalon_jtag_slave_in_a_write_cycle <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wait_for_jtag_uart_avalon_jtag_slave_counter <= std_logic'('0');
  --assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  jtag_uart_avalon_jtag_slave_irq_from_sa <= jtag_uart_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  cpu_data_master_granted_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  cpu_data_master_requests_jtag_uart_avalon_jtag_slave <= internal_cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  --vhdl renameroo for output signals
  jtag_uart_avalon_jtag_slave_waitrequest_from_sa <= internal_jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ps2_0_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal ps2_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal ps2_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_granted_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal cpu_data_master_requests_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_ps2_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_address : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal ps2_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_read : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal ps2_0_avalon_slave_0_reset : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_write : OUT STD_LOGIC;
                 signal ps2_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of ps2_0_avalon_slave_0_arbitrator : entity is FALSE;
end entity ps2_0_avalon_slave_0_arbitrator;


architecture europa of ps2_0_avalon_slave_0_arbitrator is
                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_saved_grant_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_granted_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_cpu_data_master_requests_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal internal_ps2_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_allgrants :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal ps2_0_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal ps2_0_avalon_slave_0_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal ps2_0_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_ps2_0_avalon_slave_0_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_ps2_0_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT ps2_0_avalon_slave_0_end_xfer;
      end if;
    end if;

  end process;

  ps2_0_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_cpu_data_master_qualified_request_ps2_0_avalon_slave_0);
  --assign ps2_0_avalon_slave_0_readdata_from_sa = ps2_0_avalon_slave_0_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  ps2_0_avalon_slave_0_readdata_from_sa <= ps2_0_avalon_slave_0_readdata;
  internal_cpu_data_master_requests_ps2_0_avalon_slave_0 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("1000000000001000001001000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign ps2_0_avalon_slave_0_waitrequest_from_sa = ps2_0_avalon_slave_0_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_ps2_0_avalon_slave_0_waitrequest_from_sa <= ps2_0_avalon_slave_0_waitrequest;
  --ps2_0_avalon_slave_0_arb_share_counter set values, which is an e_mux
  ps2_0_avalon_slave_0_arb_share_set_values <= std_logic_vector'("001");
  --ps2_0_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  ps2_0_avalon_slave_0_non_bursting_master_requests <= internal_cpu_data_master_requests_ps2_0_avalon_slave_0;
  --ps2_0_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  ps2_0_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --ps2_0_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  ps2_0_avalon_slave_0_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(ps2_0_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (ps2_0_avalon_slave_0_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(ps2_0_avalon_slave_0_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (ps2_0_avalon_slave_0_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --ps2_0_avalon_slave_0_allgrants all slave grants, which is an e_mux
  ps2_0_avalon_slave_0_allgrants <= ps2_0_avalon_slave_0_grant_vector;
  --ps2_0_avalon_slave_0_end_xfer assignment, which is an e_assign
  ps2_0_avalon_slave_0_end_xfer <= NOT ((ps2_0_avalon_slave_0_waits_for_read OR ps2_0_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0 <= ps2_0_avalon_slave_0_end_xfer AND (((NOT ps2_0_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ps2_0_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  ps2_0_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0 AND ps2_0_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0 AND NOT ps2_0_avalon_slave_0_non_bursting_master_requests));
  --ps2_0_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ps2_0_avalon_slave_0_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(ps2_0_avalon_slave_0_arb_counter_enable) = '1' then 
        ps2_0_avalon_slave_0_arb_share_counter <= ps2_0_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ps2_0_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ps2_0_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ps2_0_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_ps2_0_avalon_slave_0 AND NOT ps2_0_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        ps2_0_avalon_slave_0_slavearbiterlockenable <= or_reduce(ps2_0_avalon_slave_0_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master ps2_0/avalon_slave_0 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= ps2_0_avalon_slave_0_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --ps2_0_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ps2_0_avalon_slave_0_slavearbiterlockenable2 <= or_reduce(ps2_0_avalon_slave_0_arb_share_counter_next_value);
  --cpu/data_master ps2_0/avalon_slave_0 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= ps2_0_avalon_slave_0_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --ps2_0_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  ps2_0_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --cpu_data_master_continuerequest continued request, which is an e_assign
  cpu_data_master_continuerequest <= std_logic'('1');
  internal_cpu_data_master_qualified_request_ps2_0_avalon_slave_0 <= internal_cpu_data_master_requests_ps2_0_avalon_slave_0 AND NOT ((((cpu_data_master_read AND (NOT cpu_data_master_waitrequest))) OR (((NOT cpu_data_master_waitrequest) AND cpu_data_master_write))));
  --ps2_0_avalon_slave_0_writedata mux, which is an e_mux
  ps2_0_avalon_slave_0_writedata <= cpu_data_master_writedata;
  --master is always granted when requested
  internal_cpu_data_master_granted_ps2_0_avalon_slave_0 <= internal_cpu_data_master_qualified_request_ps2_0_avalon_slave_0;
  --cpu/data_master saved-grant ps2_0/avalon_slave_0, which is an e_assign
  cpu_data_master_saved_grant_ps2_0_avalon_slave_0 <= internal_cpu_data_master_requests_ps2_0_avalon_slave_0;
  --allow new arb cycle for ps2_0/avalon_slave_0, which is an e_assign
  ps2_0_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ps2_0_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ps2_0_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --~ps2_0_avalon_slave_0_reset assignment, which is an e_assign
  ps2_0_avalon_slave_0_reset <= NOT reset_n;
  ps2_0_avalon_slave_0_chipselect <= internal_cpu_data_master_granted_ps2_0_avalon_slave_0;
  --ps2_0_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  ps2_0_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(ps2_0_avalon_slave_0_begins_xfer) = '1'), ps2_0_avalon_slave_0_unreg_firsttransfer, ps2_0_avalon_slave_0_reg_firsttransfer);
  --ps2_0_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  ps2_0_avalon_slave_0_unreg_firsttransfer <= NOT ((ps2_0_avalon_slave_0_slavearbiterlockenable AND ps2_0_avalon_slave_0_any_continuerequest));
  --ps2_0_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ps2_0_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ps2_0_avalon_slave_0_begins_xfer) = '1' then 
        ps2_0_avalon_slave_0_reg_firsttransfer <= ps2_0_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ps2_0_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ps2_0_avalon_slave_0_beginbursttransfer_internal <= ps2_0_avalon_slave_0_begins_xfer;
  --ps2_0_avalon_slave_0_read assignment, which is an e_mux
  ps2_0_avalon_slave_0_read <= internal_cpu_data_master_granted_ps2_0_avalon_slave_0 AND cpu_data_master_read;
  --ps2_0_avalon_slave_0_write assignment, which is an e_mux
  ps2_0_avalon_slave_0_write <= internal_cpu_data_master_granted_ps2_0_avalon_slave_0 AND cpu_data_master_write;
  shifted_address_to_ps2_0_avalon_slave_0_from_cpu_data_master <= cpu_data_master_address_to_slave;
  --ps2_0_avalon_slave_0_address mux, which is an e_mux
  ps2_0_avalon_slave_0_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_ps2_0_avalon_slave_0_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_ps2_0_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ps2_0_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_ps2_0_avalon_slave_0_end_xfer <= ps2_0_avalon_slave_0_end_xfer;
      end if;
    end if;

  end process;

  --ps2_0_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  ps2_0_avalon_slave_0_waits_for_read <= ps2_0_avalon_slave_0_in_a_read_cycle AND internal_ps2_0_avalon_slave_0_waitrequest_from_sa;
  --ps2_0_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  ps2_0_avalon_slave_0_in_a_read_cycle <= internal_cpu_data_master_granted_ps2_0_avalon_slave_0 AND cpu_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ps2_0_avalon_slave_0_in_a_read_cycle;
  --ps2_0_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  ps2_0_avalon_slave_0_waits_for_write <= ps2_0_avalon_slave_0_in_a_write_cycle AND internal_ps2_0_avalon_slave_0_waitrequest_from_sa;
  --ps2_0_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  ps2_0_avalon_slave_0_in_a_write_cycle <= internal_cpu_data_master_granted_ps2_0_avalon_slave_0 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ps2_0_avalon_slave_0_in_a_write_cycle;
  wait_for_ps2_0_avalon_slave_0_counter <= std_logic'('0');
  --ps2_0_avalon_slave_0_byteenable byte enable port mux, which is an e_mux
  ps2_0_avalon_slave_0_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_ps2_0_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (cpu_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  cpu_data_master_granted_ps2_0_avalon_slave_0 <= internal_cpu_data_master_granted_ps2_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_ps2_0_avalon_slave_0 <= internal_cpu_data_master_qualified_request_ps2_0_avalon_slave_0;
  --vhdl renameroo for output signals
  cpu_data_master_requests_ps2_0_avalon_slave_0 <= internal_cpu_data_master_requests_ps2_0_avalon_slave_0;
  --vhdl renameroo for output signals
  ps2_0_avalon_slave_0_waitrequest_from_sa <= internal_ps2_0_avalon_slave_0_waitrequest_from_sa;
--synthesis translate_off
    --ps2_0/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ram_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_0_out_address_to_slave : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
                 signal clock_0_out_read : IN STD_LOGIC;
                 signal clock_0_out_write : IN STD_LOGIC;
                 signal clock_0_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal clock_0_out_granted_ram_avalon_slave_0 : OUT STD_LOGIC;
                 signal clock_0_out_qualified_request_ram_avalon_slave_0 : OUT STD_LOGIC;
                 signal clock_0_out_read_data_valid_ram_avalon_slave_0 : OUT STD_LOGIC;
                 signal clock_0_out_requests_ram_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_ram_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal ram_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal ram_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal ram_avalon_slave_0_reset_n : OUT STD_LOGIC;
                 signal ram_avalon_slave_0_write : OUT STD_LOGIC;
                 signal ram_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of ram_avalon_slave_0_arbitrator : entity is FALSE;
end entity ram_avalon_slave_0_arbitrator;


architecture europa of ram_avalon_slave_0_arbitrator is
                signal clock_0_out_arbiterlock :  STD_LOGIC;
                signal clock_0_out_arbiterlock2 :  STD_LOGIC;
                signal clock_0_out_continuerequest :  STD_LOGIC;
                signal clock_0_out_saved_grant_ram_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ram_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_clock_0_out_granted_ram_avalon_slave_0 :  STD_LOGIC;
                signal internal_clock_0_out_qualified_request_ram_avalon_slave_0 :  STD_LOGIC;
                signal internal_clock_0_out_requests_ram_avalon_slave_0 :  STD_LOGIC;
                signal ram_avalon_slave_0_allgrants :  STD_LOGIC;
                signal ram_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal ram_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ram_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal ram_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal ram_avalon_slave_0_arb_share_counter :  STD_LOGIC;
                signal ram_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC;
                signal ram_avalon_slave_0_arb_share_set_values :  STD_LOGIC;
                signal ram_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal ram_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal ram_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal ram_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal ram_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal ram_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal ram_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal ram_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal ram_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal ram_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal ram_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal ram_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal ram_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal ram_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal ram_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_ram_avalon_slave_0_from_clock_0_out :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal wait_for_ram_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT ram_avalon_slave_0_end_xfer;
      end if;
    end if;

  end process;

  ram_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_clock_0_out_qualified_request_ram_avalon_slave_0);
  internal_clock_0_out_requests_ram_avalon_slave_0 <= Vector_To_Std_Logic(((((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((clock_0_out_read OR clock_0_out_write))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(clock_0_out_write)))));
  --ram_avalon_slave_0_arb_share_counter set values, which is an e_mux
  ram_avalon_slave_0_arb_share_set_values <= std_logic'('1');
  --ram_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  ram_avalon_slave_0_non_bursting_master_requests <= internal_clock_0_out_requests_ram_avalon_slave_0;
  --ram_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  ram_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --ram_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  ram_avalon_slave_0_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(ram_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ram_avalon_slave_0_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(ram_avalon_slave_0_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ram_avalon_slave_0_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --ram_avalon_slave_0_allgrants all slave grants, which is an e_mux
  ram_avalon_slave_0_allgrants <= ram_avalon_slave_0_grant_vector;
  --ram_avalon_slave_0_end_xfer assignment, which is an e_assign
  ram_avalon_slave_0_end_xfer <= NOT ((ram_avalon_slave_0_waits_for_read OR ram_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_ram_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ram_avalon_slave_0 <= ram_avalon_slave_0_end_xfer AND (((NOT ram_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ram_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  ram_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ram_avalon_slave_0 AND ram_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_ram_avalon_slave_0 AND NOT ram_avalon_slave_0_non_bursting_master_requests));
  --ram_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ram_avalon_slave_0_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(ram_avalon_slave_0_arb_counter_enable) = '1' then 
        ram_avalon_slave_0_arb_share_counter <= ram_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ram_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ram_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ram_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_ram_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_ram_avalon_slave_0 AND NOT ram_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        ram_avalon_slave_0_slavearbiterlockenable <= ram_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --clock_0/out ram/avalon_slave_0 arbiterlock, which is an e_assign
  clock_0_out_arbiterlock <= ram_avalon_slave_0_slavearbiterlockenable AND clock_0_out_continuerequest;
  --ram_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ram_avalon_slave_0_slavearbiterlockenable2 <= ram_avalon_slave_0_arb_share_counter_next_value;
  --clock_0/out ram/avalon_slave_0 arbiterlock2, which is an e_assign
  clock_0_out_arbiterlock2 <= ram_avalon_slave_0_slavearbiterlockenable2 AND clock_0_out_continuerequest;
  --ram_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  ram_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --clock_0_out_continuerequest continued request, which is an e_assign
  clock_0_out_continuerequest <= std_logic'('1');
  internal_clock_0_out_qualified_request_ram_avalon_slave_0 <= internal_clock_0_out_requests_ram_avalon_slave_0;
  --ram_avalon_slave_0_writedata mux, which is an e_mux
  ram_avalon_slave_0_writedata <= clock_0_out_writedata;
  --master is always granted when requested
  internal_clock_0_out_granted_ram_avalon_slave_0 <= internal_clock_0_out_qualified_request_ram_avalon_slave_0;
  --clock_0/out saved-grant ram/avalon_slave_0, which is an e_assign
  clock_0_out_saved_grant_ram_avalon_slave_0 <= internal_clock_0_out_requests_ram_avalon_slave_0;
  --allow new arb cycle for ram/avalon_slave_0, which is an e_assign
  ram_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ram_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ram_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --ram_avalon_slave_0_reset_n assignment, which is an e_assign
  ram_avalon_slave_0_reset_n <= reset_n;
  ram_avalon_slave_0_chipselect <= internal_clock_0_out_granted_ram_avalon_slave_0;
  --ram_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  ram_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(ram_avalon_slave_0_begins_xfer) = '1'), ram_avalon_slave_0_unreg_firsttransfer, ram_avalon_slave_0_reg_firsttransfer);
  --ram_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  ram_avalon_slave_0_unreg_firsttransfer <= NOT ((ram_avalon_slave_0_slavearbiterlockenable AND ram_avalon_slave_0_any_continuerequest));
  --ram_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ram_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ram_avalon_slave_0_begins_xfer) = '1' then 
        ram_avalon_slave_0_reg_firsttransfer <= ram_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ram_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ram_avalon_slave_0_beginbursttransfer_internal <= ram_avalon_slave_0_begins_xfer;
  --ram_avalon_slave_0_write assignment, which is an e_mux
  ram_avalon_slave_0_write <= internal_clock_0_out_granted_ram_avalon_slave_0 AND clock_0_out_write;
  shifted_address_to_ram_avalon_slave_0_from_clock_0_out <= clock_0_out_address_to_slave;
  --ram_avalon_slave_0_address mux, which is an e_mux
  ram_avalon_slave_0_address <= A_EXT (A_SRL(shifted_address_to_ram_avalon_slave_0_from_clock_0_out,std_logic_vector'("00000000000000000000000000000010")), 4);
  --d1_ram_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ram_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_ram_avalon_slave_0_end_xfer <= ram_avalon_slave_0_end_xfer;
      end if;
    end if;

  end process;

  --ram_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  ram_avalon_slave_0_waits_for_read <= ram_avalon_slave_0_in_a_read_cycle AND ram_avalon_slave_0_begins_xfer;
  --ram_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  ram_avalon_slave_0_in_a_read_cycle <= internal_clock_0_out_granted_ram_avalon_slave_0 AND clock_0_out_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ram_avalon_slave_0_in_a_read_cycle;
  --ram_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  ram_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ram_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --ram_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  ram_avalon_slave_0_in_a_write_cycle <= internal_clock_0_out_granted_ram_avalon_slave_0 AND clock_0_out_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ram_avalon_slave_0_in_a_write_cycle;
  wait_for_ram_avalon_slave_0_counter <= std_logic'('0');
  --vhdl renameroo for output signals
  clock_0_out_granted_ram_avalon_slave_0 <= internal_clock_0_out_granted_ram_avalon_slave_0;
  --vhdl renameroo for output signals
  clock_0_out_qualified_request_ram_avalon_slave_0 <= internal_clock_0_out_qualified_request_ram_avalon_slave_0;
  --vhdl renameroo for output signals
  clock_0_out_requests_ram_avalon_slave_0 <= internal_clock_0_out_requests_ram_avalon_slave_0;
--synthesis translate_off
    --ram/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ram_signal_avalon_slave_0_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal clock_1_out_address_to_slave : IN STD_LOGIC;
                 signal clock_1_out_read : IN STD_LOGIC;
                 signal clock_1_out_write : IN STD_LOGIC;
                 signal clock_1_out_writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal clock_1_out_granted_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                 signal clock_1_out_qualified_request_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                 signal clock_1_out_read_data_valid_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                 signal clock_1_out_requests_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                 signal d1_ram_signal_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                 signal ram_signal_avalon_slave_0_address : OUT STD_LOGIC;
                 signal ram_signal_avalon_slave_0_chipselect : OUT STD_LOGIC;
                 signal ram_signal_avalon_slave_0_reset_n : OUT STD_LOGIC;
                 signal ram_signal_avalon_slave_0_write : OUT STD_LOGIC;
                 signal ram_signal_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of ram_signal_avalon_slave_0_arbitrator : entity is FALSE;
end entity ram_signal_avalon_slave_0_arbitrator;


architecture europa of ram_signal_avalon_slave_0_arbitrator is
                signal clock_1_out_arbiterlock :  STD_LOGIC;
                signal clock_1_out_arbiterlock2 :  STD_LOGIC;
                signal clock_1_out_continuerequest :  STD_LOGIC;
                signal clock_1_out_saved_grant_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_clock_1_out_granted_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal internal_clock_1_out_qualified_request_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal internal_clock_1_out_requests_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_allgrants :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_allow_new_arb_cycle :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_any_bursting_master_saved_grant :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_any_continuerequest :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_arb_counter_enable :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_arb_share_counter :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_arb_share_counter_next_value :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_arb_share_set_values :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_beginbursttransfer_internal :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_begins_xfer :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_firsttransfer :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_grant_vector :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_in_a_read_cycle :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_in_a_write_cycle :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_master_qreq_vector :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_non_bursting_master_requests :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_pretend_byte_enable :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_reg_firsttransfer :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_slavearbiterlockenable :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_slavearbiterlockenable2 :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_unreg_firsttransfer :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_waits_for_read :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_waits_for_write :  STD_LOGIC;
                signal wait_for_ram_signal_avalon_slave_0_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT ram_signal_avalon_slave_0_end_xfer;
      end if;
    end if;

  end process;

  ram_signal_avalon_slave_0_begins_xfer <= NOT d1_reasons_to_wait AND (internal_clock_1_out_qualified_request_ram_signal_avalon_slave_0);
  internal_clock_1_out_requests_ram_signal_avalon_slave_0 <= Vector_To_Std_Logic(((((std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((clock_1_out_read OR clock_1_out_write))))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(clock_1_out_write)))));
  --ram_signal_avalon_slave_0_arb_share_counter set values, which is an e_mux
  ram_signal_avalon_slave_0_arb_share_set_values <= std_logic'('1');
  --ram_signal_avalon_slave_0_non_bursting_master_requests mux, which is an e_mux
  ram_signal_avalon_slave_0_non_bursting_master_requests <= internal_clock_1_out_requests_ram_signal_avalon_slave_0;
  --ram_signal_avalon_slave_0_any_bursting_master_saved_grant mux, which is an e_mux
  ram_signal_avalon_slave_0_any_bursting_master_saved_grant <= std_logic'('0');
  --ram_signal_avalon_slave_0_arb_share_counter_next_value assignment, which is an e_assign
  ram_signal_avalon_slave_0_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(ram_signal_avalon_slave_0_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ram_signal_avalon_slave_0_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(ram_signal_avalon_slave_0_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ram_signal_avalon_slave_0_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --ram_signal_avalon_slave_0_allgrants all slave grants, which is an e_mux
  ram_signal_avalon_slave_0_allgrants <= ram_signal_avalon_slave_0_grant_vector;
  --ram_signal_avalon_slave_0_end_xfer assignment, which is an e_assign
  ram_signal_avalon_slave_0_end_xfer <= NOT ((ram_signal_avalon_slave_0_waits_for_read OR ram_signal_avalon_slave_0_waits_for_write));
  --end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0 <= ram_signal_avalon_slave_0_end_xfer AND (((NOT ram_signal_avalon_slave_0_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --ram_signal_avalon_slave_0_arb_share_counter arbitration counter enable, which is an e_assign
  ram_signal_avalon_slave_0_arb_counter_enable <= ((end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0 AND ram_signal_avalon_slave_0_allgrants)) OR ((end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0 AND NOT ram_signal_avalon_slave_0_non_bursting_master_requests));
  --ram_signal_avalon_slave_0_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ram_signal_avalon_slave_0_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(ram_signal_avalon_slave_0_arb_counter_enable) = '1' then 
        ram_signal_avalon_slave_0_arb_share_counter <= ram_signal_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --ram_signal_avalon_slave_0_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ram_signal_avalon_slave_0_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((ram_signal_avalon_slave_0_master_qreq_vector AND end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0)) OR ((end_xfer_arb_share_counter_term_ram_signal_avalon_slave_0 AND NOT ram_signal_avalon_slave_0_non_bursting_master_requests)))) = '1' then 
        ram_signal_avalon_slave_0_slavearbiterlockenable <= ram_signal_avalon_slave_0_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --clock_1/out ram_signal/avalon_slave_0 arbiterlock, which is an e_assign
  clock_1_out_arbiterlock <= ram_signal_avalon_slave_0_slavearbiterlockenable AND clock_1_out_continuerequest;
  --ram_signal_avalon_slave_0_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  ram_signal_avalon_slave_0_slavearbiterlockenable2 <= ram_signal_avalon_slave_0_arb_share_counter_next_value;
  --clock_1/out ram_signal/avalon_slave_0 arbiterlock2, which is an e_assign
  clock_1_out_arbiterlock2 <= ram_signal_avalon_slave_0_slavearbiterlockenable2 AND clock_1_out_continuerequest;
  --ram_signal_avalon_slave_0_any_continuerequest at least one master continues requesting, which is an e_assign
  ram_signal_avalon_slave_0_any_continuerequest <= std_logic'('1');
  --clock_1_out_continuerequest continued request, which is an e_assign
  clock_1_out_continuerequest <= std_logic'('1');
  internal_clock_1_out_qualified_request_ram_signal_avalon_slave_0 <= internal_clock_1_out_requests_ram_signal_avalon_slave_0;
  --ram_signal_avalon_slave_0_writedata mux, which is an e_mux
  ram_signal_avalon_slave_0_writedata <= clock_1_out_writedata;
  --master is always granted when requested
  internal_clock_1_out_granted_ram_signal_avalon_slave_0 <= internal_clock_1_out_qualified_request_ram_signal_avalon_slave_0;
  --clock_1/out saved-grant ram_signal/avalon_slave_0, which is an e_assign
  clock_1_out_saved_grant_ram_signal_avalon_slave_0 <= internal_clock_1_out_requests_ram_signal_avalon_slave_0;
  --allow new arb cycle for ram_signal/avalon_slave_0, which is an e_assign
  ram_signal_avalon_slave_0_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  ram_signal_avalon_slave_0_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  ram_signal_avalon_slave_0_master_qreq_vector <= std_logic'('1');
  --ram_signal_avalon_slave_0_reset_n assignment, which is an e_assign
  ram_signal_avalon_slave_0_reset_n <= reset_n;
  ram_signal_avalon_slave_0_chipselect <= internal_clock_1_out_granted_ram_signal_avalon_slave_0;
  --ram_signal_avalon_slave_0_firsttransfer first transaction, which is an e_assign
  ram_signal_avalon_slave_0_firsttransfer <= A_WE_StdLogic((std_logic'(ram_signal_avalon_slave_0_begins_xfer) = '1'), ram_signal_avalon_slave_0_unreg_firsttransfer, ram_signal_avalon_slave_0_reg_firsttransfer);
  --ram_signal_avalon_slave_0_unreg_firsttransfer first transaction, which is an e_assign
  ram_signal_avalon_slave_0_unreg_firsttransfer <= NOT ((ram_signal_avalon_slave_0_slavearbiterlockenable AND ram_signal_avalon_slave_0_any_continuerequest));
  --ram_signal_avalon_slave_0_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      ram_signal_avalon_slave_0_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(ram_signal_avalon_slave_0_begins_xfer) = '1' then 
        ram_signal_avalon_slave_0_reg_firsttransfer <= ram_signal_avalon_slave_0_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --ram_signal_avalon_slave_0_beginbursttransfer_internal begin burst transfer, which is an e_assign
  ram_signal_avalon_slave_0_beginbursttransfer_internal <= ram_signal_avalon_slave_0_begins_xfer;
  --ram_signal_avalon_slave_0_write assignment, which is an e_mux
  ram_signal_avalon_slave_0_write <= ((internal_clock_1_out_granted_ram_signal_avalon_slave_0 AND clock_1_out_write)) AND ram_signal_avalon_slave_0_pretend_byte_enable;
  --ram_signal_avalon_slave_0_address mux, which is an e_mux
  ram_signal_avalon_slave_0_address <= clock_1_out_address_to_slave;
  --d1_ram_signal_avalon_slave_0_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_ram_signal_avalon_slave_0_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_ram_signal_avalon_slave_0_end_xfer <= ram_signal_avalon_slave_0_end_xfer;
      end if;
    end if;

  end process;

  --ram_signal_avalon_slave_0_waits_for_read in a cycle, which is an e_mux
  ram_signal_avalon_slave_0_waits_for_read <= ram_signal_avalon_slave_0_in_a_read_cycle AND ram_signal_avalon_slave_0_begins_xfer;
  --ram_signal_avalon_slave_0_in_a_read_cycle assignment, which is an e_assign
  ram_signal_avalon_slave_0_in_a_read_cycle <= internal_clock_1_out_granted_ram_signal_avalon_slave_0 AND clock_1_out_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= ram_signal_avalon_slave_0_in_a_read_cycle;
  --ram_signal_avalon_slave_0_waits_for_write in a cycle, which is an e_mux
  ram_signal_avalon_slave_0_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(ram_signal_avalon_slave_0_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --ram_signal_avalon_slave_0_in_a_write_cycle assignment, which is an e_assign
  ram_signal_avalon_slave_0_in_a_write_cycle <= internal_clock_1_out_granted_ram_signal_avalon_slave_0 AND clock_1_out_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= ram_signal_avalon_slave_0_in_a_write_cycle;
  wait_for_ram_signal_avalon_slave_0_counter <= std_logic'('0');
  --ram_signal_avalon_slave_0_pretend_byte_enable byte enable port mux, which is an e_mux
  ram_signal_avalon_slave_0_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_clock_1_out_granted_ram_signal_avalon_slave_0)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(std_logic'('1')))), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  --vhdl renameroo for output signals
  clock_1_out_granted_ram_signal_avalon_slave_0 <= internal_clock_1_out_granted_ram_signal_avalon_slave_0;
  --vhdl renameroo for output signals
  clock_1_out_qualified_request_ram_signal_avalon_slave_0 <= internal_clock_1_out_qualified_request_ram_signal_avalon_slave_0;
  --vhdl renameroo for output signals
  clock_1_out_requests_ram_signal_avalon_slave_0 <= internal_clock_1_out_requests_ram_signal_avalon_slave_0;
--synthesis translate_off
    --ram_signal/avalon_slave_0 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_cpu_data_master_to_sdram_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_cpu_data_master_to_sdram_s1_module;


architecture europa of rdv_fifo_for_cpu_data_master_to_sdram_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module is 
        port (
              -- inputs:
                 signal clear_fifo : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sync_reset : IN STD_LOGIC;
                 signal write : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC;
                 signal empty : OUT STD_LOGIC;
                 signal fifo_contains_ones_n : OUT STD_LOGIC;
                 signal full : OUT STD_LOGIC
              );
end entity rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module;


architecture europa of rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module is
                signal full_0 :  STD_LOGIC;
                signal full_1 :  STD_LOGIC;
                signal full_2 :  STD_LOGIC;
                signal full_3 :  STD_LOGIC;
                signal full_4 :  STD_LOGIC;
                signal full_5 :  STD_LOGIC;
                signal full_6 :  STD_LOGIC;
                signal full_7 :  STD_LOGIC;
                signal how_many_ones :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_minus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal one_count_plus_one :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal p0_full_0 :  STD_LOGIC;
                signal p0_stage_0 :  STD_LOGIC;
                signal p1_full_1 :  STD_LOGIC;
                signal p1_stage_1 :  STD_LOGIC;
                signal p2_full_2 :  STD_LOGIC;
                signal p2_stage_2 :  STD_LOGIC;
                signal p3_full_3 :  STD_LOGIC;
                signal p3_stage_3 :  STD_LOGIC;
                signal p4_full_4 :  STD_LOGIC;
                signal p4_stage_4 :  STD_LOGIC;
                signal p5_full_5 :  STD_LOGIC;
                signal p5_stage_5 :  STD_LOGIC;
                signal p6_full_6 :  STD_LOGIC;
                signal p6_stage_6 :  STD_LOGIC;
                signal stage_0 :  STD_LOGIC;
                signal stage_1 :  STD_LOGIC;
                signal stage_2 :  STD_LOGIC;
                signal stage_3 :  STD_LOGIC;
                signal stage_4 :  STD_LOGIC;
                signal stage_5 :  STD_LOGIC;
                signal stage_6 :  STD_LOGIC;
                signal updated_one_count :  STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

  data_out <= stage_0;
  full <= full_6;
  empty <= NOT(full_0);
  full_7 <= std_logic'('0');
  --data_6, which is an e_mux
  p6_stage_6 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_7 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, data_in);
  --data_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_6))))) = '1' then 
        if std_logic'(((sync_reset AND full_6) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_7))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_6 <= std_logic'('0');
        else
          stage_6 <= p6_stage_6;
        end if;
      end if;
    end if;

  end process;

  --control_6, which is an e_mux
  p6_full_6 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))), std_logic_vector'("00000000000000000000000000000000")));
  --control_reg_6, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_6 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_6 <= std_logic'('0');
        else
          full_6 <= p6_full_6;
        end if;
      end if;
    end if;

  end process;

  --data_5, which is an e_mux
  p5_stage_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_6 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_6);
  --data_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_5))))) = '1' then 
        if std_logic'(((sync_reset AND full_5) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_6))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_5 <= std_logic'('0');
        else
          stage_5 <= p5_stage_5;
        end if;
      end if;
    end if;

  end process;

  --control_5, which is an e_mux
  p5_full_5 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_4, full_6);
  --control_reg_5, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_5 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_5 <= std_logic'('0');
        else
          full_5 <= p5_full_5;
        end if;
      end if;
    end if;

  end process;

  --data_4, which is an e_mux
  p4_stage_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_5 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_5);
  --data_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_4))))) = '1' then 
        if std_logic'(((sync_reset AND full_4) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_5))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_4 <= std_logic'('0');
        else
          stage_4 <= p4_stage_4;
        end if;
      end if;
    end if;

  end process;

  --control_4, which is an e_mux
  p4_full_4 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_3, full_5);
  --control_reg_4, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_4 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_4 <= std_logic'('0');
        else
          full_4 <= p4_full_4;
        end if;
      end if;
    end if;

  end process;

  --data_3, which is an e_mux
  p3_stage_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_4 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_4);
  --data_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_3))))) = '1' then 
        if std_logic'(((sync_reset AND full_3) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_4))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_3 <= std_logic'('0');
        else
          stage_3 <= p3_stage_3;
        end if;
      end if;
    end if;

  end process;

  --control_3, which is an e_mux
  p3_full_3 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_2, full_4);
  --control_reg_3, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_3 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_3 <= std_logic'('0');
        else
          full_3 <= p3_full_3;
        end if;
      end if;
    end if;

  end process;

  --data_2, which is an e_mux
  p2_stage_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_3 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_3);
  --data_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_2))))) = '1' then 
        if std_logic'(((sync_reset AND full_2) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_3))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_2 <= std_logic'('0');
        else
          stage_2 <= p2_stage_2;
        end if;
      end if;
    end if;

  end process;

  --control_2, which is an e_mux
  p2_full_2 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_1, full_3);
  --control_reg_2, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_2 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_2 <= std_logic'('0');
        else
          full_2 <= p2_full_2;
        end if;
      end if;
    end if;

  end process;

  --data_1, which is an e_mux
  p1_stage_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_2 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_2);
  --data_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_1))))) = '1' then 
        if std_logic'(((sync_reset AND full_1) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_2))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_1 <= std_logic'('0');
        else
          stage_1 <= p1_stage_1;
        end if;
      end if;
    end if;

  end process;

  --control_1, which is an e_mux
  p1_full_1 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), full_0, full_2);
  --control_reg_1, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(clear_fifo) = '1' then 
          full_1 <= std_logic'('0');
        else
          full_1 <= p1_full_1;
        end if;
      end if;
    end if;

  end process;

  --data_0, which is an e_mux
  p0_stage_0 <= A_WE_StdLogic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((full_1 AND NOT clear_fifo))))) = std_logic_vector'("00000000000000000000000000000000"))), data_in, stage_1);
  --data_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      stage_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'(((sync_reset AND full_0) AND NOT((((to_std_logic((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1))) = std_logic_vector'("00000000000000000000000000000000")))) AND read) AND write))))) = '1' then 
          stage_0 <= std_logic'('0');
        else
          stage_0 <= p0_stage_0;
        end if;
      end if;
    end if;

  end process;

  --control_0, which is an e_mux
  p0_full_0 <= Vector_To_Std_Logic(A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((read AND NOT(write)))))) = std_logic_vector'("00000000000000000000000000000000"))), std_logic_vector'("00000000000000000000000000000001"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(full_1)))));
  --control_reg_0, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      full_0 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(((clear_fifo OR ((read XOR write))) OR ((write AND NOT(full_0))))) = '1' then 
        if std_logic'((clear_fifo AND NOT write)) = '1' then 
          full_0 <= std_logic'('0');
        else
          full_0 <= p0_full_0;
        end if;
      end if;
    end if;

  end process;

  one_count_plus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) + std_logic_vector'("000000000000000000000000000000001")), 4);
  one_count_minus_one <= A_EXT (((std_logic_vector'("00000000000000000000000000000") & (how_many_ones)) - std_logic_vector'("000000000000000000000000000000001")), 4);
  --updated_one_count, which is an e_mux
  updated_one_count <= A_EXT (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND NOT(write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000") & (A_WE_StdLogicVector((std_logic'(((((clear_fifo OR sync_reset)) AND write))) = '1'), (std_logic_vector'("000") & (A_TOSTDLOGICVECTOR(data_in))), A_WE_StdLogicVector((std_logic'(((((read AND (data_in)) AND write) AND (stage_0)))) = '1'), how_many_ones, A_WE_StdLogicVector((std_logic'(((write AND (data_in)))) = '1'), one_count_plus_one, A_WE_StdLogicVector((std_logic'(((read AND (stage_0)))) = '1'), one_count_minus_one, how_many_ones))))))), 4);
  --counts how many ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      how_many_ones <= std_logic_vector'("0000");
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        how_many_ones <= updated_one_count;
      end if;
    end if;

  end process;

  --this fifo contains ones in the data pipeline, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      fifo_contains_ones_n <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'((((clear_fifo OR sync_reset) OR read) OR write)) = '1' then 
        fifo_contains_ones_n <= NOT (or_reduce(updated_one_count));
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity sdram_s1_arbitrator is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                 signal cpu_data_master_read : IN STD_LOGIC;
                 signal cpu_data_master_waitrequest : IN STD_LOGIC;
                 signal cpu_data_master_write : IN STD_LOGIC;
                 signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                 signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_instruction_master_read : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;
                 signal sdram_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_readdatavalid : IN STD_LOGIC;
                 signal sdram_s1_waitrequest : IN STD_LOGIC;

              -- outputs:
                 signal cpu_data_master_byteenable_sdram_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal cpu_data_master_granted_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_data_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_data_master_requests_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_granted_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                 signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                 signal cpu_instruction_master_requests_sdram_s1 : OUT STD_LOGIC;
                 signal d1_sdram_s1_end_xfer : OUT STD_LOGIC;
                 signal sdram_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                 signal sdram_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal sdram_s1_chipselect : OUT STD_LOGIC;
                 signal sdram_s1_read_n : OUT STD_LOGIC;
                 signal sdram_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal sdram_s1_reset_n : OUT STD_LOGIC;
                 signal sdram_s1_waitrequest_from_sa : OUT STD_LOGIC;
                 signal sdram_s1_write_n : OUT STD_LOGIC;
                 signal sdram_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
              );
attribute auto_dissolve : boolean;
attribute auto_dissolve of sdram_s1_arbitrator : entity is FALSE;
end entity sdram_s1_arbitrator;


architecture europa of sdram_s1_arbitrator is
component rdv_fifo_for_cpu_data_master_to_sdram_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_cpu_data_master_to_sdram_s1_module;

component rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module is 
           port (
                 -- inputs:
                    signal clear_fifo : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sync_reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC;
                    signal empty : OUT STD_LOGIC;
                    signal fifo_contains_ones_n : OUT STD_LOGIC;
                    signal full : OUT STD_LOGIC
                 );
end component rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module;

                signal cpu_data_master_arbiterlock :  STD_LOGIC;
                signal cpu_data_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_data_master_byteenable_sdram_s1_segment_0 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_byteenable_sdram_s1_segment_1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_continuerequest :  STD_LOGIC;
                signal cpu_data_master_rdv_fifo_empty_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_rdv_fifo_output_from_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_saved_grant_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock :  STD_LOGIC;
                signal cpu_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal cpu_instruction_master_continuerequest :  STD_LOGIC;
                signal cpu_instruction_master_rdv_fifo_empty_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_rdv_fifo_output_from_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_saved_grant_sdram_s1 :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_sdram_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_cpu_data_master_byteenable_sdram_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_cpu_data_master_granted_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_data_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal internal_cpu_data_master_requests_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_granted_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal internal_cpu_instruction_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal internal_cpu_instruction_master_requests_sdram_s1 :  STD_LOGIC;
                signal internal_sdram_s1_waitrequest_from_sa :  STD_LOGIC;
                signal last_cycle_cpu_data_master_granted_slave_sdram_s1 :  STD_LOGIC;
                signal last_cycle_cpu_instruction_master_granted_slave_sdram_s1 :  STD_LOGIC;
                signal module_input :  STD_LOGIC;
                signal module_input1 :  STD_LOGIC;
                signal module_input2 :  STD_LOGIC;
                signal module_input3 :  STD_LOGIC;
                signal module_input4 :  STD_LOGIC;
                signal module_input5 :  STD_LOGIC;
                signal sdram_s1_allgrants :  STD_LOGIC;
                signal sdram_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal sdram_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal sdram_s1_any_continuerequest :  STD_LOGIC;
                signal sdram_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_arb_counter_enable :  STD_LOGIC;
                signal sdram_s1_arb_share_counter :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_s1_arb_share_counter_next_value :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_s1_arb_share_set_values :  STD_LOGIC_VECTOR (2 DOWNTO 0);
                signal sdram_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal sdram_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal sdram_s1_begins_xfer :  STD_LOGIC;
                signal sdram_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal sdram_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_end_xfer :  STD_LOGIC;
                signal sdram_s1_firsttransfer :  STD_LOGIC;
                signal sdram_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_in_a_read_cycle :  STD_LOGIC;
                signal sdram_s1_in_a_write_cycle :  STD_LOGIC;
                signal sdram_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_move_on_to_next_transaction :  STD_LOGIC;
                signal sdram_s1_non_bursting_master_requests :  STD_LOGIC;
                signal sdram_s1_readdatavalid_from_sa :  STD_LOGIC;
                signal sdram_s1_reg_firsttransfer :  STD_LOGIC;
                signal sdram_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_slavearbiterlockenable :  STD_LOGIC;
                signal sdram_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal sdram_s1_unreg_firsttransfer :  STD_LOGIC;
                signal sdram_s1_waits_for_read :  STD_LOGIC;
                signal sdram_s1_waits_for_write :  STD_LOGIC;
                signal shifted_address_to_sdram_s1_from_cpu_data_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal shifted_address_to_sdram_s1_from_cpu_instruction_master :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal wait_for_sdram_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_reasons_to_wait <= NOT sdram_s1_end_xfer;
      end if;
    end if;

  end process;

  sdram_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_cpu_data_master_qualified_request_sdram_s1 OR internal_cpu_instruction_master_qualified_request_sdram_s1));
  --assign sdram_s1_readdata_from_sa = sdram_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_s1_readdata_from_sa <= sdram_s1_readdata;
  internal_cpu_data_master_requests_sdram_s1 <= to_std_logic(((Std_Logic_Vector'(cpu_data_master_address_to_slave(24 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0100000000000000000000000")))) AND ((cpu_data_master_read OR cpu_data_master_write));
  --assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_sdram_s1_waitrequest_from_sa <= sdram_s1_waitrequest;
  --assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  sdram_s1_readdatavalid_from_sa <= sdram_s1_readdatavalid;
  --sdram_s1_arb_share_counter set values, which is an e_mux
  sdram_s1_arb_share_set_values <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), A_WE_StdLogicVector((std_logic'((internal_cpu_instruction_master_granted_sdram_s1)) = '1'), std_logic_vector'("00000000000000000000000000000010"), std_logic_vector'("00000000000000000000000000000001"))))), 3);
  --sdram_s1_non_bursting_master_requests mux, which is an e_mux
  sdram_s1_non_bursting_master_requests <= ((internal_cpu_data_master_requests_sdram_s1 OR internal_cpu_instruction_master_requests_sdram_s1) OR internal_cpu_data_master_requests_sdram_s1) OR internal_cpu_instruction_master_requests_sdram_s1;
  --sdram_s1_any_bursting_master_saved_grant mux, which is an e_mux
  sdram_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --sdram_s1_arb_share_counter_next_value assignment, which is an e_assign
  sdram_s1_arb_share_counter_next_value <= A_EXT (A_WE_StdLogicVector((std_logic'(sdram_s1_firsttransfer) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_s1_arb_share_set_values)) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(or_reduce(sdram_s1_arb_share_counter)) = '1'), (((std_logic_vector'("000000000000000000000000000000") & (sdram_s1_arb_share_counter)) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))), 3);
  --sdram_s1_allgrants all slave grants, which is an e_mux
  sdram_s1_allgrants <= ((or_reduce(sdram_s1_grant_vector) OR or_reduce(sdram_s1_grant_vector)) OR or_reduce(sdram_s1_grant_vector)) OR or_reduce(sdram_s1_grant_vector);
  --sdram_s1_end_xfer assignment, which is an e_assign
  sdram_s1_end_xfer <= NOT ((sdram_s1_waits_for_read OR sdram_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_sdram_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_sdram_s1 <= sdram_s1_end_xfer AND (((NOT sdram_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --sdram_s1_arb_share_counter arbitration counter enable, which is an e_assign
  sdram_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_sdram_s1 AND sdram_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_sdram_s1 AND NOT sdram_s1_non_bursting_master_requests));
  --sdram_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_arb_share_counter <= std_logic_vector'("000");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_arb_counter_enable) = '1' then 
        sdram_s1_arb_share_counter <= sdram_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --sdram_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(sdram_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_sdram_s1)) OR ((end_xfer_arb_share_counter_term_sdram_s1 AND NOT sdram_s1_non_bursting_master_requests)))) = '1' then 
        sdram_s1_slavearbiterlockenable <= or_reduce(sdram_s1_arb_share_counter_next_value);
      end if;
    end if;

  end process;

  --cpu/data_master sdram/s1 arbiterlock, which is an e_assign
  cpu_data_master_arbiterlock <= sdram_s1_slavearbiterlockenable AND cpu_data_master_continuerequest;
  --sdram_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  sdram_s1_slavearbiterlockenable2 <= or_reduce(sdram_s1_arb_share_counter_next_value);
  --cpu/data_master sdram/s1 arbiterlock2, which is an e_assign
  cpu_data_master_arbiterlock2 <= sdram_s1_slavearbiterlockenable2 AND cpu_data_master_continuerequest;
  --cpu/instruction_master sdram/s1 arbiterlock, which is an e_assign
  cpu_instruction_master_arbiterlock <= sdram_s1_slavearbiterlockenable AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master sdram/s1 arbiterlock2, which is an e_assign
  cpu_instruction_master_arbiterlock2 <= sdram_s1_slavearbiterlockenable2 AND cpu_instruction_master_continuerequest;
  --cpu/instruction_master granted sdram/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_instruction_master_saved_grant_sdram_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_s1_arbitration_holdoff_internal OR NOT internal_cpu_instruction_master_requests_sdram_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_instruction_master_granted_slave_sdram_s1))))));
      end if;
    end if;

  end process;

  --cpu_instruction_master_continuerequest continued request, which is an e_mux
  cpu_instruction_master_continuerequest <= last_cycle_cpu_instruction_master_granted_slave_sdram_s1 AND internal_cpu_instruction_master_requests_sdram_s1;
  --sdram_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  sdram_s1_any_continuerequest <= cpu_instruction_master_continuerequest OR cpu_data_master_continuerequest;
  internal_cpu_data_master_qualified_request_sdram_s1 <= internal_cpu_data_master_requests_sdram_s1 AND NOT (((((cpu_data_master_read AND ((NOT cpu_data_master_waitrequest OR (internal_cpu_data_master_read_data_valid_sdram_s1_shift_register))))) OR (((((NOT cpu_data_master_waitrequest OR cpu_data_master_no_byte_enables_and_last_term) OR NOT(or_reduce(internal_cpu_data_master_byteenable_sdram_s1)))) AND cpu_data_master_write))) OR cpu_instruction_master_arbiterlock));
  --unique name for sdram_s1_move_on_to_next_transaction, which is an e_assign
  sdram_s1_move_on_to_next_transaction <= sdram_s1_readdatavalid_from_sa;
  --rdv_fifo_for_cpu_data_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_s1 : rdv_fifo_for_cpu_data_master_to_sdram_s1_module
    port map(
      data_out => cpu_data_master_rdv_fifo_output_from_sdram_s1,
      empty => open,
      fifo_contains_ones_n => cpu_data_master_rdv_fifo_empty_sdram_s1,
      full => open,
      clear_fifo => module_input,
      clk => clk,
      data_in => internal_cpu_data_master_granted_sdram_s1,
      read => sdram_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input1,
      write => module_input2
    );

  module_input <= std_logic'('0');
  module_input1 <= std_logic'('0');
  module_input2 <= in_a_read_cycle AND NOT sdram_s1_waits_for_read;

  internal_cpu_data_master_read_data_valid_sdram_s1_shift_register <= NOT cpu_data_master_rdv_fifo_empty_sdram_s1;
  --local readdatavalid cpu_data_master_read_data_valid_sdram_s1, which is an e_mux
  cpu_data_master_read_data_valid_sdram_s1 <= ((sdram_s1_readdatavalid_from_sa AND cpu_data_master_rdv_fifo_output_from_sdram_s1)) AND NOT cpu_data_master_rdv_fifo_empty_sdram_s1;
  --sdram_s1_writedata mux, which is an e_mux
  sdram_s1_writedata <= cpu_data_master_dbs_write_16;
  internal_cpu_instruction_master_requests_sdram_s1 <= ((to_std_logic(((Std_Logic_Vector'(cpu_instruction_master_address_to_slave(24 DOWNTO 23) & std_logic_vector'("00000000000000000000000")) = std_logic_vector'("0100000000000000000000000")))) AND (cpu_instruction_master_read))) AND cpu_instruction_master_read;
  --cpu/data_master granted sdram/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_cpu_data_master_granted_slave_sdram_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        last_cycle_cpu_data_master_granted_slave_sdram_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(cpu_data_master_saved_grant_sdram_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((sdram_s1_arbitration_holdoff_internal OR NOT internal_cpu_data_master_requests_sdram_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_cpu_data_master_granted_slave_sdram_s1))))));
      end if;
    end if;

  end process;

  --cpu_data_master_continuerequest continued request, which is an e_mux
  cpu_data_master_continuerequest <= last_cycle_cpu_data_master_granted_slave_sdram_s1 AND internal_cpu_data_master_requests_sdram_s1;
  internal_cpu_instruction_master_qualified_request_sdram_s1 <= internal_cpu_instruction_master_requests_sdram_s1 AND NOT ((((cpu_instruction_master_read AND (internal_cpu_instruction_master_read_data_valid_sdram_s1_shift_register))) OR cpu_data_master_arbiterlock));
  --rdv_fifo_for_cpu_instruction_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_s1 : rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module
    port map(
      data_out => cpu_instruction_master_rdv_fifo_output_from_sdram_s1,
      empty => open,
      fifo_contains_ones_n => cpu_instruction_master_rdv_fifo_empty_sdram_s1,
      full => open,
      clear_fifo => module_input3,
      clk => clk,
      data_in => internal_cpu_instruction_master_granted_sdram_s1,
      read => sdram_s1_move_on_to_next_transaction,
      reset_n => reset_n,
      sync_reset => module_input4,
      write => module_input5
    );

  module_input3 <= std_logic'('0');
  module_input4 <= std_logic'('0');
  module_input5 <= in_a_read_cycle AND NOT sdram_s1_waits_for_read;

  internal_cpu_instruction_master_read_data_valid_sdram_s1_shift_register <= NOT cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  --local readdatavalid cpu_instruction_master_read_data_valid_sdram_s1, which is an e_mux
  cpu_instruction_master_read_data_valid_sdram_s1 <= ((sdram_s1_readdatavalid_from_sa AND cpu_instruction_master_rdv_fifo_output_from_sdram_s1)) AND NOT cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  --allow new arb cycle for sdram/s1, which is an e_assign
  sdram_s1_allow_new_arb_cycle <= NOT cpu_data_master_arbiterlock AND NOT cpu_instruction_master_arbiterlock;
  --cpu/instruction_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  sdram_s1_master_qreq_vector(0) <= internal_cpu_instruction_master_qualified_request_sdram_s1;
  --cpu/instruction_master grant sdram/s1, which is an e_assign
  internal_cpu_instruction_master_granted_sdram_s1 <= sdram_s1_grant_vector(0);
  --cpu/instruction_master saved-grant sdram/s1, which is an e_assign
  cpu_instruction_master_saved_grant_sdram_s1 <= sdram_s1_arb_winner(0) AND internal_cpu_instruction_master_requests_sdram_s1;
  --cpu/data_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  sdram_s1_master_qreq_vector(1) <= internal_cpu_data_master_qualified_request_sdram_s1;
  --cpu/data_master grant sdram/s1, which is an e_assign
  internal_cpu_data_master_granted_sdram_s1 <= sdram_s1_grant_vector(1);
  --cpu/data_master saved-grant sdram/s1, which is an e_assign
  cpu_data_master_saved_grant_sdram_s1 <= sdram_s1_arb_winner(1) AND internal_cpu_data_master_requests_sdram_s1;
  --sdram/s1 chosen-master double-vector, which is an e_assign
  sdram_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((sdram_s1_master_qreq_vector & sdram_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT sdram_s1_master_qreq_vector & NOT sdram_s1_master_qreq_vector))) + (std_logic_vector'("000") & (sdram_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  sdram_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((sdram_s1_allow_new_arb_cycle AND or_reduce(sdram_s1_grant_vector)))) = '1'), sdram_s1_grant_vector, sdram_s1_saved_chosen_master_vector);
  --saved sdram_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_allow_new_arb_cycle) = '1' then 
        sdram_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(sdram_s1_grant_vector)) = '1'), sdram_s1_grant_vector, sdram_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  sdram_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((sdram_s1_chosen_master_double_vector(1) OR sdram_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((sdram_s1_chosen_master_double_vector(0) OR sdram_s1_chosen_master_double_vector(2)))));
  --sdram/s1 chosen master rotated left, which is an e_assign
  sdram_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(sdram_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(sdram_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --sdram/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(sdram_s1_grant_vector)) = '1' then 
        sdram_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(sdram_s1_end_xfer) = '1'), sdram_s1_chosen_master_rot_left, sdram_s1_grant_vector);
      end if;
    end if;

  end process;

  --sdram_s1_reset_n assignment, which is an e_assign
  sdram_s1_reset_n <= reset_n;
  sdram_s1_chipselect <= internal_cpu_data_master_granted_sdram_s1 OR internal_cpu_instruction_master_granted_sdram_s1;
  --sdram_s1_firsttransfer first transaction, which is an e_assign
  sdram_s1_firsttransfer <= A_WE_StdLogic((std_logic'(sdram_s1_begins_xfer) = '1'), sdram_s1_unreg_firsttransfer, sdram_s1_reg_firsttransfer);
  --sdram_s1_unreg_firsttransfer first transaction, which is an e_assign
  sdram_s1_unreg_firsttransfer <= NOT ((sdram_s1_slavearbiterlockenable AND sdram_s1_any_continuerequest));
  --sdram_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      sdram_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(sdram_s1_begins_xfer) = '1' then 
        sdram_s1_reg_firsttransfer <= sdram_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --sdram_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  sdram_s1_beginbursttransfer_internal <= sdram_s1_begins_xfer;
  --sdram_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  sdram_s1_arbitration_holdoff_internal <= sdram_s1_begins_xfer AND sdram_s1_firsttransfer;
  --~sdram_s1_read_n assignment, which is an e_mux
  sdram_s1_read_n <= NOT ((((internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_sdram_s1 AND cpu_instruction_master_read))));
  --~sdram_s1_write_n assignment, which is an e_mux
  sdram_s1_write_n <= NOT ((internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_write));
  shifted_address_to_sdram_s1_from_cpu_data_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_data_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_data_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --sdram_s1_address mux, which is an e_mux
  sdram_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), (A_SRL(shifted_address_to_sdram_s1_from_cpu_data_master,std_logic_vector'("00000000000000000000000000000001"))), (A_SRL(shifted_address_to_sdram_s1_from_cpu_instruction_master,std_logic_vector'("00000000000000000000000000000001")))), 22);
  shifted_address_to_sdram_s1_from_cpu_instruction_master <= A_EXT (Std_Logic_Vector'(A_SRL(cpu_instruction_master_address_to_slave,std_logic_vector'("00000000000000000000000000000010")) & A_ToStdLogicVector(cpu_instruction_master_dbs_address(1)) & A_ToStdLogicVector(std_logic'('0'))), 25);
  --d1_sdram_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_sdram_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        d1_sdram_s1_end_xfer <= sdram_s1_end_xfer;
      end if;
    end if;

  end process;

  --sdram_s1_waits_for_read in a cycle, which is an e_mux
  sdram_s1_waits_for_read <= sdram_s1_in_a_read_cycle AND internal_sdram_s1_waitrequest_from_sa;
  --sdram_s1_in_a_read_cycle assignment, which is an e_assign
  sdram_s1_in_a_read_cycle <= ((internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_read)) OR ((internal_cpu_instruction_master_granted_sdram_s1 AND cpu_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= sdram_s1_in_a_read_cycle;
  --sdram_s1_waits_for_write in a cycle, which is an e_mux
  sdram_s1_waits_for_write <= sdram_s1_in_a_write_cycle AND internal_sdram_s1_waitrequest_from_sa;
  --sdram_s1_in_a_write_cycle assignment, which is an e_assign
  sdram_s1_in_a_write_cycle <= internal_cpu_data_master_granted_sdram_s1 AND cpu_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= sdram_s1_in_a_write_cycle;
  wait_for_sdram_s1_counter <= std_logic'('0');
  --~sdram_s1_byteenable_n byte enable port mux, which is an e_mux
  sdram_s1_byteenable_n <= A_EXT (NOT (A_WE_StdLogicVector((std_logic'((internal_cpu_data_master_granted_sdram_s1)) = '1'), (std_logic_vector'("000000000000000000000000000000") & (internal_cpu_data_master_byteenable_sdram_s1)), -SIGNED(std_logic_vector'("00000000000000000000000000000001")))), 2);
  (cpu_data_master_byteenable_sdram_s1_segment_1(1), cpu_data_master_byteenable_sdram_s1_segment_1(0), cpu_data_master_byteenable_sdram_s1_segment_0(1), cpu_data_master_byteenable_sdram_s1_segment_0(0)) <= cpu_data_master_byteenable;
  internal_cpu_data_master_byteenable_sdram_s1 <= A_WE_StdLogicVector((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_data_master_dbs_address(1)))) = std_logic_vector'("00000000000000000000000000000000"))), cpu_data_master_byteenable_sdram_s1_segment_0, cpu_data_master_byteenable_sdram_s1_segment_1);
  --vhdl renameroo for output signals
  cpu_data_master_byteenable_sdram_s1 <= internal_cpu_data_master_byteenable_sdram_s1;
  --vhdl renameroo for output signals
  cpu_data_master_granted_sdram_s1 <= internal_cpu_data_master_granted_sdram_s1;
  --vhdl renameroo for output signals
  cpu_data_master_qualified_request_sdram_s1 <= internal_cpu_data_master_qualified_request_sdram_s1;
  --vhdl renameroo for output signals
  cpu_data_master_read_data_valid_sdram_s1_shift_register <= internal_cpu_data_master_read_data_valid_sdram_s1_shift_register;
  --vhdl renameroo for output signals
  cpu_data_master_requests_sdram_s1 <= internal_cpu_data_master_requests_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_granted_sdram_s1 <= internal_cpu_instruction_master_granted_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_qualified_request_sdram_s1 <= internal_cpu_instruction_master_qualified_request_sdram_s1;
  --vhdl renameroo for output signals
  cpu_instruction_master_read_data_valid_sdram_s1_shift_register <= internal_cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  --vhdl renameroo for output signals
  cpu_instruction_master_requests_sdram_s1 <= internal_cpu_instruction_master_requests_sdram_s1;
  --vhdl renameroo for output signals
  sdram_s1_waitrequest_from_sa <= internal_sdram_s1_waitrequest_from_sa;
--synthesis translate_off
    --sdram/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
          enable_nonzero_assertions <= std_logic'('1');
        end if;
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line12 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_data_master_granted_sdram_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_cpu_instruction_master_granted_sdram_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line12, now);
          write(write_line12, string'(": "));
          write(write_line12, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line12.all);
          deallocate (write_line12);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line13 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_data_master_saved_grant_sdram_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(cpu_instruction_master_saved_grant_sdram_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line13, now);
          write(write_line13, string'(": "));
          write(write_line13, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line13.all);
          deallocate (write_line13);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios_reset_clk_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity nios_reset_clk_domain_synch_module;


architecture europa of nios_reset_clk_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "MAX_DELAY=100ns ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        data_in_d1 <= data_in;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        data_out <= data_in_d1;
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios_reset_clk_25_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity nios_reset_clk_25_domain_synch_module;


architecture europa of nios_reset_clk_25_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "MAX_DELAY=100ns ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        data_in_d1 <= data_in;
      end if;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if (std_logic_vector'("00000000000000000000000000000001")) /= std_logic_vector'("00000000000000000000000000000000") then 
        data_out <= data_in_d1;
      end if;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nios is 
        port (
              -- 1) global signals:
                 signal clk : IN STD_LOGIC;
                 signal clk_25 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_ps2_0
                 signal PS2_CLK_to_and_from_the_ps2_0 : INOUT STD_LOGIC;
                 signal PS2_DAT_to_and_from_the_ps2_0 : INOUT STD_LOGIC;
                 signal irq_from_the_ps2_0 : OUT STD_LOGIC;

              -- the_ram
                 signal addressout_to_the_ram : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal read_to_the_ram : IN STD_LOGIC;
                 signal readaddr_from_the_ram : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal readdata_from_the_ram : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);

              -- the_ram_signal
                 signal read_addr_to_the_ram_signal : IN STD_LOGIC;
                 signal read_data_from_the_ram_signal : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

              -- the_sdram
                 signal zs_addr_from_the_sdram : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                 signal zs_ba_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_cas_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_cke_from_the_sdram : OUT STD_LOGIC;
                 signal zs_cs_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_dq_to_and_from_the_sdram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                 signal zs_dqm_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal zs_ras_n_from_the_sdram : OUT STD_LOGIC;
                 signal zs_we_n_from_the_sdram : OUT STD_LOGIC
              );
end entity nios;


architecture europa of nios is
component clock_0_in_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_0_in_endofpacket : IN STD_LOGIC;
                    signal clock_0_in_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clock_0_in_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal clock_0_in_address : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal clock_0_in_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clock_0_in_endofpacket_from_sa : OUT STD_LOGIC;
                    signal clock_0_in_nativeaddress : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal clock_0_in_read : OUT STD_LOGIC;
                    signal clock_0_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clock_0_in_reset_n : OUT STD_LOGIC;
                    signal clock_0_in_waitrequest_from_sa : OUT STD_LOGIC;
                    signal clock_0_in_write : OUT STD_LOGIC;
                    signal clock_0_in_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_granted_clock_0_in : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_clock_0_in : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_clock_0_in : OUT STD_LOGIC;
                    signal cpu_data_master_requests_clock_0_in : OUT STD_LOGIC;
                    signal d1_clock_0_in_end_xfer : OUT STD_LOGIC
                 );
end component clock_0_in_arbitrator;

component clock_0_out_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_0_out_address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal clock_0_out_granted_ram_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_0_out_qualified_request_ram_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_0_out_read : IN STD_LOGIC;
                    signal clock_0_out_read_data_valid_ram_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_0_out_requests_ram_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_0_out_write : IN STD_LOGIC;
                    signal clock_0_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_ram_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal clock_0_out_address_to_slave : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal clock_0_out_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clock_0_out_reset_n : OUT STD_LOGIC;
                    signal clock_0_out_waitrequest : OUT STD_LOGIC
                 );
end component clock_0_out_arbitrator;

component clock_0 is 
           port (
                 -- inputs:
                    signal master_clk : IN STD_LOGIC;
                    signal master_endofpacket : IN STD_LOGIC;
                    signal master_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal master_reset_n : IN STD_LOGIC;
                    signal master_waitrequest : IN STD_LOGIC;
                    signal slave_address : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal slave_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal slave_clk : IN STD_LOGIC;
                    signal slave_nativeaddress : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal slave_read : IN STD_LOGIC;
                    signal slave_reset_n : IN STD_LOGIC;
                    signal slave_write : IN STD_LOGIC;
                    signal slave_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal master_address : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal master_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal master_nativeaddress : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal master_read : OUT STD_LOGIC;
                    signal master_write : OUT STD_LOGIC;
                    signal master_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal slave_endofpacket : OUT STD_LOGIC;
                    signal slave_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal slave_waitrequest : OUT STD_LOGIC
                 );
end component clock_0;

component clock_1_in_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_1_in_endofpacket : IN STD_LOGIC;
                    signal clock_1_in_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clock_1_in_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_8 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal clock_1_in_address : OUT STD_LOGIC;
                    signal clock_1_in_endofpacket_from_sa : OUT STD_LOGIC;
                    signal clock_1_in_nativeaddress : OUT STD_LOGIC;
                    signal clock_1_in_read : OUT STD_LOGIC;
                    signal clock_1_in_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clock_1_in_reset_n : OUT STD_LOGIC;
                    signal clock_1_in_waitrequest_from_sa : OUT STD_LOGIC;
                    signal clock_1_in_write : OUT STD_LOGIC;
                    signal clock_1_in_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_data_master_byteenable_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_granted_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_clock_1_in : OUT STD_LOGIC;
                    signal cpu_data_master_requests_clock_1_in : OUT STD_LOGIC;
                    signal d1_clock_1_in_end_xfer : OUT STD_LOGIC
                 );
end component clock_1_in_arbitrator;

component clock_1_out_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_1_out_address : IN STD_LOGIC;
                    signal clock_1_out_granted_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_1_out_qualified_request_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_1_out_read : IN STD_LOGIC;
                    signal clock_1_out_read_data_valid_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_1_out_requests_ram_signal_avalon_slave_0 : IN STD_LOGIC;
                    signal clock_1_out_write : IN STD_LOGIC;
                    signal clock_1_out_writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal d1_ram_signal_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal clock_1_out_address_to_slave : OUT STD_LOGIC;
                    signal clock_1_out_readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clock_1_out_reset_n : OUT STD_LOGIC;
                    signal clock_1_out_waitrequest : OUT STD_LOGIC
                 );
end component clock_1_out_arbitrator;

component clock_1 is 
           port (
                 -- inputs:
                    signal master_clk : IN STD_LOGIC;
                    signal master_endofpacket : IN STD_LOGIC;
                    signal master_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal master_reset_n : IN STD_LOGIC;
                    signal master_waitrequest : IN STD_LOGIC;
                    signal slave_address : IN STD_LOGIC;
                    signal slave_clk : IN STD_LOGIC;
                    signal slave_nativeaddress : IN STD_LOGIC;
                    signal slave_read : IN STD_LOGIC;
                    signal slave_reset_n : IN STD_LOGIC;
                    signal slave_write : IN STD_LOGIC;
                    signal slave_writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- outputs:
                    signal master_address : OUT STD_LOGIC;
                    signal master_nativeaddress : OUT STD_LOGIC;
                    signal master_read : OUT STD_LOGIC;
                    signal master_write : OUT STD_LOGIC;
                    signal master_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal slave_endofpacket : OUT STD_LOGIC;
                    signal slave_readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal slave_waitrequest : OUT STD_LOGIC
                 );
end component clock_1;

component cpu_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal cpu_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_reset : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_reset_n : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_write : OUT STD_LOGIC;
                    signal cpu_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component cpu_jtag_debug_module_arbitrator;

component cpu_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_0_in_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clock_0_in_waitrequest_from_sa : IN STD_LOGIC;
                    signal clock_1_in_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clock_1_in_waitrequest_from_sa : IN STD_LOGIC;
                    signal cpu_data_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_byteenable_sdram_s1 : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_debugaccess : IN STD_LOGIC;
                    signal cpu_data_master_granted_clock_0_in : IN STD_LOGIC;
                    signal cpu_data_master_granted_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_granted_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_data_master_granted_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_clock_0_in : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_data_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_clock_0_in : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal cpu_data_master_requests_clock_0_in : IN STD_LOGIC;
                    signal cpu_data_master_requests_clock_1_in : IN STD_LOGIC;
                    signal cpu_data_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : IN STD_LOGIC;
                    signal cpu_data_master_requests_ps2_0_avalon_slave_0 : IN STD_LOGIC;
                    signal cpu_data_master_requests_sdram_s1 : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_clock_0_in_end_xfer : IN STD_LOGIC;
                    signal d1_clock_1_in_end_xfer : IN STD_LOGIC;
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_jtag_uart_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_ps2_0_avalon_slave_0_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal ps2_0_avalon_slave_0_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal ps2_0_avalon_slave_0_waitrequest_from_sa : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_dbs_write_8 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal cpu_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : OUT STD_LOGIC;
                    signal cpu_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_data_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_data_master_arbitrator;

component cpu_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_instruction_master_address : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_granted_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_granted_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1 : IN STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_cpu_jtag_debug_module : IN STD_LOGIC;
                    signal cpu_instruction_master_requests_sdram_s1 : IN STD_LOGIC;
                    signal cpu_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_cpu_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_waitrequest_from_sa : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal cpu_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component cpu_instruction_master_arbitrator;

component cpu is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_clk : IN STD_LOGIC;
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_reset : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component cpu;

component jtag_uart_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave : OUT STD_LOGIC;
                    signal d1_jtag_uart_avalon_jtag_slave_end_xfer : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal jtag_uart_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component jtag_uart_avalon_jtag_slave_arbitrator;

component jtag_uart is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component jtag_uart;

component ps2_0_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal ps2_0_avalon_slave_0_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal ps2_0_avalon_slave_0_waitrequest : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_granted_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal cpu_data_master_requests_ps2_0_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_ps2_0_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_address : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal ps2_0_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_read : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal ps2_0_avalon_slave_0_reset : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_waitrequest_from_sa : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_write : OUT STD_LOGIC;
                    signal ps2_0_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component ps2_0_avalon_slave_0_arbitrator;

component ps2_0 is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC;
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal PS2_CLK : INOUT STD_LOGIC;
                    signal PS2_DAT : INOUT STD_LOGIC;
                    signal irq : OUT STD_LOGIC;
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal waitrequest : OUT STD_LOGIC
                 );
end component ps2_0;

component ram_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_0_out_address_to_slave : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
                    signal clock_0_out_read : IN STD_LOGIC;
                    signal clock_0_out_write : IN STD_LOGIC;
                    signal clock_0_out_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal clock_0_out_granted_ram_avalon_slave_0 : OUT STD_LOGIC;
                    signal clock_0_out_qualified_request_ram_avalon_slave_0 : OUT STD_LOGIC;
                    signal clock_0_out_read_data_valid_ram_avalon_slave_0 : OUT STD_LOGIC;
                    signal clock_0_out_requests_ram_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_ram_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal ram_avalon_slave_0_address : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal ram_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal ram_avalon_slave_0_reset_n : OUT STD_LOGIC;
                    signal ram_avalon_slave_0_write : OUT STD_LOGIC;
                    signal ram_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component ram_avalon_slave_0_arbitrator;

component ram is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal addressout : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal readaddr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
                 );
end component ram;

component ram_signal_avalon_slave_0_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal clock_1_out_address_to_slave : IN STD_LOGIC;
                    signal clock_1_out_read : IN STD_LOGIC;
                    signal clock_1_out_write : IN STD_LOGIC;
                    signal clock_1_out_writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal clock_1_out_granted_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                    signal clock_1_out_qualified_request_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                    signal clock_1_out_read_data_valid_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                    signal clock_1_out_requests_ram_signal_avalon_slave_0 : OUT STD_LOGIC;
                    signal d1_ram_signal_avalon_slave_0_end_xfer : OUT STD_LOGIC;
                    signal ram_signal_avalon_slave_0_address : OUT STD_LOGIC;
                    signal ram_signal_avalon_slave_0_chipselect : OUT STD_LOGIC;
                    signal ram_signal_avalon_slave_0_reset_n : OUT STD_LOGIC;
                    signal ram_signal_avalon_slave_0_write : OUT STD_LOGIC;
                    signal ram_signal_avalon_slave_0_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component ram_signal_avalon_slave_0_arbitrator;

component ram_signal is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC;
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal read_addr : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- outputs:
                    signal read_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component ram_signal;

component sdram_s1_arbitrator is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal cpu_data_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal cpu_data_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_dbs_write_16 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal cpu_data_master_no_byte_enables_and_last_term : IN STD_LOGIC;
                    signal cpu_data_master_read : IN STD_LOGIC;
                    signal cpu_data_master_waitrequest : IN STD_LOGIC;
                    signal cpu_data_master_write : IN STD_LOGIC;
                    signal cpu_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (24 DOWNTO 0);
                    signal cpu_instruction_master_dbs_address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_instruction_master_read : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal sdram_s1_readdata : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_readdatavalid : IN STD_LOGIC;
                    signal sdram_s1_waitrequest : IN STD_LOGIC;

                 -- outputs:
                    signal cpu_data_master_byteenable_sdram_s1 : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal cpu_data_master_granted_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_data_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_data_master_requests_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_granted_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_qualified_request_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1 : OUT STD_LOGIC;
                    signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register : OUT STD_LOGIC;
                    signal cpu_instruction_master_requests_sdram_s1 : OUT STD_LOGIC;
                    signal d1_sdram_s1_end_xfer : OUT STD_LOGIC;
                    signal sdram_s1_address : OUT STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal sdram_s1_byteenable_n : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal sdram_s1_chipselect : OUT STD_LOGIC;
                    signal sdram_s1_read_n : OUT STD_LOGIC;
                    signal sdram_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal sdram_s1_reset_n : OUT STD_LOGIC;
                    signal sdram_s1_waitrequest_from_sa : OUT STD_LOGIC;
                    signal sdram_s1_write_n : OUT STD_LOGIC;
                    signal sdram_s1_writedata : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
                 );
end component sdram_s1_arbitrator;

component sdram is 
           port (
                 -- inputs:
                    signal az_addr : IN STD_LOGIC_VECTOR (21 DOWNTO 0);
                    signal az_be_n : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal az_cs : IN STD_LOGIC;
                    signal az_data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal az_rd_n : IN STD_LOGIC;
                    signal az_wr_n : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal za_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal za_valid : OUT STD_LOGIC;
                    signal za_waitrequest : OUT STD_LOGIC;
                    signal zs_addr : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n : OUT STD_LOGIC;
                    signal zs_cke : OUT STD_LOGIC;
                    signal zs_cs_n : OUT STD_LOGIC;
                    signal zs_dq : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n : OUT STD_LOGIC;
                    signal zs_we_n : OUT STD_LOGIC
                 );
end component sdram;

component nios_reset_clk_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component nios_reset_clk_domain_synch_module;

component nios_reset_clk_25_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component nios_reset_clk_25_domain_synch_module;

                signal clk_25_reset_n :  STD_LOGIC;
                signal clk_reset_n :  STD_LOGIC;
                signal clock_0_in_address :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal clock_0_in_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clock_0_in_endofpacket :  STD_LOGIC;
                signal clock_0_in_endofpacket_from_sa :  STD_LOGIC;
                signal clock_0_in_nativeaddress :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clock_0_in_read :  STD_LOGIC;
                signal clock_0_in_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clock_0_in_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clock_0_in_reset_n :  STD_LOGIC;
                signal clock_0_in_waitrequest :  STD_LOGIC;
                signal clock_0_in_waitrequest_from_sa :  STD_LOGIC;
                signal clock_0_in_write :  STD_LOGIC;
                signal clock_0_in_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clock_0_out_address :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal clock_0_out_address_to_slave :  STD_LOGIC_VECTOR (5 DOWNTO 0);
                signal clock_0_out_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clock_0_out_endofpacket :  STD_LOGIC;
                signal clock_0_out_granted_ram_avalon_slave_0 :  STD_LOGIC;
                signal clock_0_out_nativeaddress :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clock_0_out_qualified_request_ram_avalon_slave_0 :  STD_LOGIC;
                signal clock_0_out_read :  STD_LOGIC;
                signal clock_0_out_read_data_valid_ram_avalon_slave_0 :  STD_LOGIC;
                signal clock_0_out_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clock_0_out_requests_ram_avalon_slave_0 :  STD_LOGIC;
                signal clock_0_out_reset_n :  STD_LOGIC;
                signal clock_0_out_waitrequest :  STD_LOGIC;
                signal clock_0_out_write :  STD_LOGIC;
                signal clock_0_out_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clock_1_in_address :  STD_LOGIC;
                signal clock_1_in_endofpacket :  STD_LOGIC;
                signal clock_1_in_endofpacket_from_sa :  STD_LOGIC;
                signal clock_1_in_nativeaddress :  STD_LOGIC;
                signal clock_1_in_read :  STD_LOGIC;
                signal clock_1_in_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal clock_1_in_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal clock_1_in_reset_n :  STD_LOGIC;
                signal clock_1_in_waitrequest :  STD_LOGIC;
                signal clock_1_in_waitrequest_from_sa :  STD_LOGIC;
                signal clock_1_in_write :  STD_LOGIC;
                signal clock_1_in_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal clock_1_out_address :  STD_LOGIC;
                signal clock_1_out_address_to_slave :  STD_LOGIC;
                signal clock_1_out_endofpacket :  STD_LOGIC;
                signal clock_1_out_granted_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal clock_1_out_nativeaddress :  STD_LOGIC;
                signal clock_1_out_qualified_request_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal clock_1_out_read :  STD_LOGIC;
                signal clock_1_out_read_data_valid_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal clock_1_out_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal clock_1_out_requests_ram_signal_avalon_slave_0 :  STD_LOGIC;
                signal clock_1_out_reset_n :  STD_LOGIC;
                signal clock_1_out_waitrequest :  STD_LOGIC;
                signal clock_1_out_write :  STD_LOGIC;
                signal clock_1_out_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cpu_data_master_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_data_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_data_master_byteenable_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_byteenable_sdram_s1 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_data_master_dbs_write_16 :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal cpu_data_master_dbs_write_8 :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal cpu_data_master_debugaccess :  STD_LOGIC;
                signal cpu_data_master_granted_clock_0_in :  STD_LOGIC;
                signal cpu_data_master_granted_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_granted_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_granted_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_data_master_granted_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_no_byte_enables_and_last_term :  STD_LOGIC;
                signal cpu_data_master_qualified_request_clock_0_in :  STD_LOGIC;
                signal cpu_data_master_qualified_request_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_qualified_request_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_data_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_read :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_clock_0_in :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal cpu_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_data_master_requests_clock_0_in :  STD_LOGIC;
                signal cpu_data_master_requests_clock_1_in :  STD_LOGIC;
                signal cpu_data_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_data_master_requests_jtag_uart_avalon_jtag_slave :  STD_LOGIC;
                signal cpu_data_master_requests_ps2_0_avalon_slave_0 :  STD_LOGIC;
                signal cpu_data_master_requests_sdram_s1 :  STD_LOGIC;
                signal cpu_data_master_waitrequest :  STD_LOGIC;
                signal cpu_data_master_write :  STD_LOGIC;
                signal cpu_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_address :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (24 DOWNTO 0);
                signal cpu_instruction_master_dbs_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal cpu_instruction_master_granted_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_granted_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_qualified_request_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_read :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_read_data_valid_sdram_s1_shift_register :  STD_LOGIC;
                signal cpu_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_instruction_master_requests_cpu_jtag_debug_module :  STD_LOGIC;
                signal cpu_instruction_master_requests_sdram_s1 :  STD_LOGIC;
                signal cpu_instruction_master_waitrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal cpu_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal cpu_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal cpu_jtag_debug_module_chipselect :  STD_LOGIC;
                signal cpu_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal cpu_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal cpu_jtag_debug_module_reset :  STD_LOGIC;
                signal cpu_jtag_debug_module_reset_n :  STD_LOGIC;
                signal cpu_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal cpu_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal cpu_jtag_debug_module_write :  STD_LOGIC;
                signal cpu_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal d1_clock_0_in_end_xfer :  STD_LOGIC;
                signal d1_clock_1_in_end_xfer :  STD_LOGIC;
                signal d1_cpu_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_jtag_uart_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_ps2_0_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_ram_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_ram_signal_avalon_slave_0_end_xfer :  STD_LOGIC;
                signal d1_sdram_s1_end_xfer :  STD_LOGIC;
                signal internal_irq_from_the_ps2_0 :  STD_LOGIC;
                signal internal_read_data_from_the_ram_signal :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal internal_readaddr_from_the_ram :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal internal_readdata_from_the_ram :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_zs_addr_from_the_sdram :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal internal_zs_ba_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_cas_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_cke_from_the_sdram :  STD_LOGIC;
                signal internal_zs_cs_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_dqm_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal internal_zs_ras_n_from_the_sdram :  STD_LOGIC;
                signal internal_zs_we_n_from_the_sdram :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_address :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_irq :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal jtag_uart_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal module_input6 :  STD_LOGIC;
                signal module_input7 :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_address :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal ps2_0_avalon_slave_0_chipselect :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_read :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal ps2_0_avalon_slave_0_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal ps2_0_avalon_slave_0_reset :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_waitrequest :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_waitrequest_from_sa :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_write :  STD_LOGIC;
                signal ps2_0_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal ram_avalon_slave_0_address :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal ram_avalon_slave_0_chipselect :  STD_LOGIC;
                signal ram_avalon_slave_0_reset_n :  STD_LOGIC;
                signal ram_avalon_slave_0_write :  STD_LOGIC;
                signal ram_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal ram_signal_avalon_slave_0_address :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_chipselect :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_reset_n :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_write :  STD_LOGIC;
                signal ram_signal_avalon_slave_0_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal reset_n_sources :  STD_LOGIC;
                signal sdram_s1_address :  STD_LOGIC_VECTOR (21 DOWNTO 0);
                signal sdram_s1_byteenable_n :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal sdram_s1_chipselect :  STD_LOGIC;
                signal sdram_s1_read_n :  STD_LOGIC;
                signal sdram_s1_readdata :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_s1_readdata_from_sa :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal sdram_s1_readdatavalid :  STD_LOGIC;
                signal sdram_s1_reset_n :  STD_LOGIC;
                signal sdram_s1_waitrequest :  STD_LOGIC;
                signal sdram_s1_waitrequest_from_sa :  STD_LOGIC;
                signal sdram_s1_write_n :  STD_LOGIC;
                signal sdram_s1_writedata :  STD_LOGIC_VECTOR (15 DOWNTO 0);

begin

  --the_clock_0_in, which is an e_instance
  the_clock_0_in : clock_0_in_arbitrator
    port map(
      clock_0_in_address => clock_0_in_address,
      clock_0_in_byteenable => clock_0_in_byteenable,
      clock_0_in_endofpacket_from_sa => clock_0_in_endofpacket_from_sa,
      clock_0_in_nativeaddress => clock_0_in_nativeaddress,
      clock_0_in_read => clock_0_in_read,
      clock_0_in_readdata_from_sa => clock_0_in_readdata_from_sa,
      clock_0_in_reset_n => clock_0_in_reset_n,
      clock_0_in_waitrequest_from_sa => clock_0_in_waitrequest_from_sa,
      clock_0_in_write => clock_0_in_write,
      clock_0_in_writedata => clock_0_in_writedata,
      cpu_data_master_granted_clock_0_in => cpu_data_master_granted_clock_0_in,
      cpu_data_master_qualified_request_clock_0_in => cpu_data_master_qualified_request_clock_0_in,
      cpu_data_master_read_data_valid_clock_0_in => cpu_data_master_read_data_valid_clock_0_in,
      cpu_data_master_requests_clock_0_in => cpu_data_master_requests_clock_0_in,
      d1_clock_0_in_end_xfer => d1_clock_0_in_end_xfer,
      clk => clk,
      clock_0_in_endofpacket => clock_0_in_endofpacket,
      clock_0_in_readdata => clock_0_in_readdata,
      clock_0_in_waitrequest => clock_0_in_waitrequest,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      reset_n => clk_reset_n
    );


  --the_clock_0_out, which is an e_instance
  the_clock_0_out : clock_0_out_arbitrator
    port map(
      clock_0_out_address_to_slave => clock_0_out_address_to_slave,
      clock_0_out_readdata => clock_0_out_readdata,
      clock_0_out_reset_n => clock_0_out_reset_n,
      clock_0_out_waitrequest => clock_0_out_waitrequest,
      clk => clk_25,
      clock_0_out_address => clock_0_out_address,
      clock_0_out_granted_ram_avalon_slave_0 => clock_0_out_granted_ram_avalon_slave_0,
      clock_0_out_qualified_request_ram_avalon_slave_0 => clock_0_out_qualified_request_ram_avalon_slave_0,
      clock_0_out_read => clock_0_out_read,
      clock_0_out_read_data_valid_ram_avalon_slave_0 => clock_0_out_read_data_valid_ram_avalon_slave_0,
      clock_0_out_requests_ram_avalon_slave_0 => clock_0_out_requests_ram_avalon_slave_0,
      clock_0_out_write => clock_0_out_write,
      clock_0_out_writedata => clock_0_out_writedata,
      d1_ram_avalon_slave_0_end_xfer => d1_ram_avalon_slave_0_end_xfer,
      reset_n => clk_25_reset_n
    );


  --the_clock_0, which is an e_ptf_instance
  the_clock_0 : clock_0
    port map(
      master_address => clock_0_out_address,
      master_byteenable => clock_0_out_byteenable,
      master_nativeaddress => clock_0_out_nativeaddress,
      master_read => clock_0_out_read,
      master_write => clock_0_out_write,
      master_writedata => clock_0_out_writedata,
      slave_endofpacket => clock_0_in_endofpacket,
      slave_readdata => clock_0_in_readdata,
      slave_waitrequest => clock_0_in_waitrequest,
      master_clk => clk_25,
      master_endofpacket => clock_0_out_endofpacket,
      master_readdata => clock_0_out_readdata,
      master_reset_n => clock_0_out_reset_n,
      master_waitrequest => clock_0_out_waitrequest,
      slave_address => clock_0_in_address,
      slave_byteenable => clock_0_in_byteenable,
      slave_clk => clk,
      slave_nativeaddress => clock_0_in_nativeaddress,
      slave_read => clock_0_in_read,
      slave_reset_n => clock_0_in_reset_n,
      slave_write => clock_0_in_write,
      slave_writedata => clock_0_in_writedata
    );


  --the_clock_1_in, which is an e_instance
  the_clock_1_in : clock_1_in_arbitrator
    port map(
      clock_1_in_address => clock_1_in_address,
      clock_1_in_endofpacket_from_sa => clock_1_in_endofpacket_from_sa,
      clock_1_in_nativeaddress => clock_1_in_nativeaddress,
      clock_1_in_read => clock_1_in_read,
      clock_1_in_readdata_from_sa => clock_1_in_readdata_from_sa,
      clock_1_in_reset_n => clock_1_in_reset_n,
      clock_1_in_waitrequest_from_sa => clock_1_in_waitrequest_from_sa,
      clock_1_in_write => clock_1_in_write,
      clock_1_in_writedata => clock_1_in_writedata,
      cpu_data_master_byteenable_clock_1_in => cpu_data_master_byteenable_clock_1_in,
      cpu_data_master_granted_clock_1_in => cpu_data_master_granted_clock_1_in,
      cpu_data_master_qualified_request_clock_1_in => cpu_data_master_qualified_request_clock_1_in,
      cpu_data_master_read_data_valid_clock_1_in => cpu_data_master_read_data_valid_clock_1_in,
      cpu_data_master_requests_clock_1_in => cpu_data_master_requests_clock_1_in,
      d1_clock_1_in_end_xfer => d1_clock_1_in_end_xfer,
      clk => clk,
      clock_1_in_endofpacket => clock_1_in_endofpacket,
      clock_1_in_readdata => clock_1_in_readdata,
      clock_1_in_waitrequest => clock_1_in_waitrequest,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_8 => cpu_data_master_dbs_write_8,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      reset_n => clk_reset_n
    );


  --the_clock_1_out, which is an e_instance
  the_clock_1_out : clock_1_out_arbitrator
    port map(
      clock_1_out_address_to_slave => clock_1_out_address_to_slave,
      clock_1_out_readdata => clock_1_out_readdata,
      clock_1_out_reset_n => clock_1_out_reset_n,
      clock_1_out_waitrequest => clock_1_out_waitrequest,
      clk => clk_25,
      clock_1_out_address => clock_1_out_address,
      clock_1_out_granted_ram_signal_avalon_slave_0 => clock_1_out_granted_ram_signal_avalon_slave_0,
      clock_1_out_qualified_request_ram_signal_avalon_slave_0 => clock_1_out_qualified_request_ram_signal_avalon_slave_0,
      clock_1_out_read => clock_1_out_read,
      clock_1_out_read_data_valid_ram_signal_avalon_slave_0 => clock_1_out_read_data_valid_ram_signal_avalon_slave_0,
      clock_1_out_requests_ram_signal_avalon_slave_0 => clock_1_out_requests_ram_signal_avalon_slave_0,
      clock_1_out_write => clock_1_out_write,
      clock_1_out_writedata => clock_1_out_writedata,
      d1_ram_signal_avalon_slave_0_end_xfer => d1_ram_signal_avalon_slave_0_end_xfer,
      reset_n => clk_25_reset_n
    );


  --the_clock_1, which is an e_ptf_instance
  the_clock_1 : clock_1
    port map(
      master_address => clock_1_out_address,
      master_nativeaddress => clock_1_out_nativeaddress,
      master_read => clock_1_out_read,
      master_write => clock_1_out_write,
      master_writedata => clock_1_out_writedata,
      slave_endofpacket => clock_1_in_endofpacket,
      slave_readdata => clock_1_in_readdata,
      slave_waitrequest => clock_1_in_waitrequest,
      master_clk => clk_25,
      master_endofpacket => clock_1_out_endofpacket,
      master_readdata => clock_1_out_readdata,
      master_reset_n => clock_1_out_reset_n,
      master_waitrequest => clock_1_out_waitrequest,
      slave_address => clock_1_in_address,
      slave_clk => clk,
      slave_nativeaddress => clock_1_in_nativeaddress,
      slave_read => clock_1_in_read,
      slave_reset_n => clock_1_in_reset_n,
      slave_write => clock_1_in_write,
      slave_writedata => clock_1_in_writedata
    );


  --the_cpu_jtag_debug_module, which is an e_instance
  the_cpu_jtag_debug_module : cpu_jtag_debug_module_arbitrator
    port map(
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_jtag_debug_module_address => cpu_jtag_debug_module_address,
      cpu_jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      cpu_jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      cpu_jtag_debug_module_chipselect => cpu_jtag_debug_module_chipselect,
      cpu_jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      cpu_jtag_debug_module_reset => cpu_jtag_debug_module_reset,
      cpu_jtag_debug_module_reset_n => cpu_jtag_debug_module_reset_n,
      cpu_jtag_debug_module_resetrequest_from_sa => cpu_jtag_debug_module_resetrequest_from_sa,
      cpu_jtag_debug_module_write => cpu_jtag_debug_module_write,
      cpu_jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      clk => clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_debugaccess => cpu_data_master_debugaccess,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      cpu_jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      reset_n => clk_reset_n
    );


  --the_cpu_data_master, which is an e_instance
  the_cpu_data_master : cpu_data_master_arbitrator
    port map(
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_dbs_write_8 => cpu_data_master_dbs_write_8,
      cpu_data_master_irq => cpu_data_master_irq,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_readdata => cpu_data_master_readdata,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      clk => clk,
      clock_0_in_readdata_from_sa => clock_0_in_readdata_from_sa,
      clock_0_in_waitrequest_from_sa => clock_0_in_waitrequest_from_sa,
      clock_1_in_readdata_from_sa => clock_1_in_readdata_from_sa,
      clock_1_in_waitrequest_from_sa => clock_1_in_waitrequest_from_sa,
      cpu_data_master_address => cpu_data_master_address,
      cpu_data_master_byteenable_clock_1_in => cpu_data_master_byteenable_clock_1_in,
      cpu_data_master_byteenable_sdram_s1 => cpu_data_master_byteenable_sdram_s1,
      cpu_data_master_debugaccess => cpu_data_master_debugaccess,
      cpu_data_master_granted_clock_0_in => cpu_data_master_granted_clock_0_in,
      cpu_data_master_granted_clock_1_in => cpu_data_master_granted_clock_1_in,
      cpu_data_master_granted_cpu_jtag_debug_module => cpu_data_master_granted_cpu_jtag_debug_module,
      cpu_data_master_granted_jtag_uart_avalon_jtag_slave => cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
      cpu_data_master_granted_ps2_0_avalon_slave_0 => cpu_data_master_granted_ps2_0_avalon_slave_0,
      cpu_data_master_granted_sdram_s1 => cpu_data_master_granted_sdram_s1,
      cpu_data_master_qualified_request_clock_0_in => cpu_data_master_qualified_request_clock_0_in,
      cpu_data_master_qualified_request_clock_1_in => cpu_data_master_qualified_request_clock_1_in,
      cpu_data_master_qualified_request_cpu_jtag_debug_module => cpu_data_master_qualified_request_cpu_jtag_debug_module,
      cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave => cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
      cpu_data_master_qualified_request_ps2_0_avalon_slave_0 => cpu_data_master_qualified_request_ps2_0_avalon_slave_0,
      cpu_data_master_qualified_request_sdram_s1 => cpu_data_master_qualified_request_sdram_s1,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_read_data_valid_clock_0_in => cpu_data_master_read_data_valid_clock_0_in,
      cpu_data_master_read_data_valid_clock_1_in => cpu_data_master_read_data_valid_clock_1_in,
      cpu_data_master_read_data_valid_cpu_jtag_debug_module => cpu_data_master_read_data_valid_cpu_jtag_debug_module,
      cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave => cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
      cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 => cpu_data_master_read_data_valid_ps2_0_avalon_slave_0,
      cpu_data_master_read_data_valid_sdram_s1 => cpu_data_master_read_data_valid_sdram_s1,
      cpu_data_master_read_data_valid_sdram_s1_shift_register => cpu_data_master_read_data_valid_sdram_s1_shift_register,
      cpu_data_master_requests_clock_0_in => cpu_data_master_requests_clock_0_in,
      cpu_data_master_requests_clock_1_in => cpu_data_master_requests_clock_1_in,
      cpu_data_master_requests_cpu_jtag_debug_module => cpu_data_master_requests_cpu_jtag_debug_module,
      cpu_data_master_requests_jtag_uart_avalon_jtag_slave => cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
      cpu_data_master_requests_ps2_0_avalon_slave_0 => cpu_data_master_requests_ps2_0_avalon_slave_0,
      cpu_data_master_requests_sdram_s1 => cpu_data_master_requests_sdram_s1,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_clock_0_in_end_xfer => d1_clock_0_in_end_xfer,
      d1_clock_1_in_end_xfer => d1_clock_1_in_end_xfer,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_jtag_uart_avalon_jtag_slave_end_xfer => d1_jtag_uart_avalon_jtag_slave_end_xfer,
      d1_ps2_0_avalon_slave_0_end_xfer => d1_ps2_0_avalon_slave_0_end_xfer,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      jtag_uart_avalon_jtag_slave_irq_from_sa => jtag_uart_avalon_jtag_slave_irq_from_sa,
      jtag_uart_avalon_jtag_slave_readdata_from_sa => jtag_uart_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
      ps2_0_avalon_slave_0_readdata_from_sa => ps2_0_avalon_slave_0_readdata_from_sa,
      ps2_0_avalon_slave_0_waitrequest_from_sa => ps2_0_avalon_slave_0_waitrequest_from_sa,
      reset_n => clk_reset_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa
    );


  --the_cpu_instruction_master, which is an e_instance
  the_cpu_instruction_master : cpu_instruction_master_arbitrator
    port map(
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_readdata => cpu_instruction_master_readdata,
      cpu_instruction_master_waitrequest => cpu_instruction_master_waitrequest,
      clk => clk,
      cpu_instruction_master_address => cpu_instruction_master_address,
      cpu_instruction_master_granted_cpu_jtag_debug_module => cpu_instruction_master_granted_cpu_jtag_debug_module,
      cpu_instruction_master_granted_sdram_s1 => cpu_instruction_master_granted_sdram_s1,
      cpu_instruction_master_qualified_request_cpu_jtag_debug_module => cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
      cpu_instruction_master_qualified_request_sdram_s1 => cpu_instruction_master_qualified_request_sdram_s1,
      cpu_instruction_master_read => cpu_instruction_master_read,
      cpu_instruction_master_read_data_valid_cpu_jtag_debug_module => cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
      cpu_instruction_master_read_data_valid_sdram_s1 => cpu_instruction_master_read_data_valid_sdram_s1,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      cpu_instruction_master_requests_cpu_jtag_debug_module => cpu_instruction_master_requests_cpu_jtag_debug_module,
      cpu_instruction_master_requests_sdram_s1 => cpu_instruction_master_requests_sdram_s1,
      cpu_jtag_debug_module_readdata_from_sa => cpu_jtag_debug_module_readdata_from_sa,
      d1_cpu_jtag_debug_module_end_xfer => d1_cpu_jtag_debug_module_end_xfer,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      reset_n => clk_reset_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa
    );


  --the_cpu, which is an e_ptf_instance
  the_cpu : cpu
    port map(
      d_address => cpu_data_master_address,
      d_byteenable => cpu_data_master_byteenable,
      d_read => cpu_data_master_read,
      d_write => cpu_data_master_write,
      d_writedata => cpu_data_master_writedata,
      i_address => cpu_instruction_master_address,
      i_read => cpu_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => cpu_data_master_debugaccess,
      jtag_debug_module_readdata => cpu_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => cpu_jtag_debug_module_resetrequest,
      clk => clk,
      d_irq => cpu_data_master_irq,
      d_readdata => cpu_data_master_readdata,
      d_waitrequest => cpu_data_master_waitrequest,
      i_readdata => cpu_instruction_master_readdata,
      i_waitrequest => cpu_instruction_master_waitrequest,
      jtag_debug_module_address => cpu_jtag_debug_module_address,
      jtag_debug_module_begintransfer => cpu_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => cpu_jtag_debug_module_byteenable,
      jtag_debug_module_clk => clk,
      jtag_debug_module_debugaccess => cpu_jtag_debug_module_debugaccess,
      jtag_debug_module_reset => cpu_jtag_debug_module_reset,
      jtag_debug_module_select => cpu_jtag_debug_module_chipselect,
      jtag_debug_module_write => cpu_jtag_debug_module_write,
      jtag_debug_module_writedata => cpu_jtag_debug_module_writedata,
      reset_n => cpu_jtag_debug_module_reset_n
    );


  --the_jtag_uart_avalon_jtag_slave, which is an e_instance
  the_jtag_uart_avalon_jtag_slave : jtag_uart_avalon_jtag_slave_arbitrator
    port map(
      cpu_data_master_granted_jtag_uart_avalon_jtag_slave => cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
      cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave => cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
      cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave => cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
      cpu_data_master_requests_jtag_uart_avalon_jtag_slave => cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
      d1_jtag_uart_avalon_jtag_slave_end_xfer => d1_jtag_uart_avalon_jtag_slave_end_xfer,
      jtag_uart_avalon_jtag_slave_address => jtag_uart_avalon_jtag_slave_address,
      jtag_uart_avalon_jtag_slave_chipselect => jtag_uart_avalon_jtag_slave_chipselect,
      jtag_uart_avalon_jtag_slave_dataavailable_from_sa => jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
      jtag_uart_avalon_jtag_slave_irq_from_sa => jtag_uart_avalon_jtag_slave_irq_from_sa,
      jtag_uart_avalon_jtag_slave_read_n => jtag_uart_avalon_jtag_slave_read_n,
      jtag_uart_avalon_jtag_slave_readdata_from_sa => jtag_uart_avalon_jtag_slave_readdata_from_sa,
      jtag_uart_avalon_jtag_slave_readyfordata_from_sa => jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
      jtag_uart_avalon_jtag_slave_reset_n => jtag_uart_avalon_jtag_slave_reset_n,
      jtag_uart_avalon_jtag_slave_waitrequest_from_sa => jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
      jtag_uart_avalon_jtag_slave_write_n => jtag_uart_avalon_jtag_slave_write_n,
      jtag_uart_avalon_jtag_slave_writedata => jtag_uart_avalon_jtag_slave_writedata,
      clk => clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      jtag_uart_avalon_jtag_slave_dataavailable => jtag_uart_avalon_jtag_slave_dataavailable,
      jtag_uart_avalon_jtag_slave_irq => jtag_uart_avalon_jtag_slave_irq,
      jtag_uart_avalon_jtag_slave_readdata => jtag_uart_avalon_jtag_slave_readdata,
      jtag_uart_avalon_jtag_slave_readyfordata => jtag_uart_avalon_jtag_slave_readyfordata,
      jtag_uart_avalon_jtag_slave_waitrequest => jtag_uart_avalon_jtag_slave_waitrequest,
      reset_n => clk_reset_n
    );


  --the_jtag_uart, which is an e_ptf_instance
  the_jtag_uart : jtag_uart
    port map(
      av_irq => jtag_uart_avalon_jtag_slave_irq,
      av_readdata => jtag_uart_avalon_jtag_slave_readdata,
      av_waitrequest => jtag_uart_avalon_jtag_slave_waitrequest,
      dataavailable => jtag_uart_avalon_jtag_slave_dataavailable,
      readyfordata => jtag_uart_avalon_jtag_slave_readyfordata,
      av_address => jtag_uart_avalon_jtag_slave_address,
      av_chipselect => jtag_uart_avalon_jtag_slave_chipselect,
      av_read_n => jtag_uart_avalon_jtag_slave_read_n,
      av_write_n => jtag_uart_avalon_jtag_slave_write_n,
      av_writedata => jtag_uart_avalon_jtag_slave_writedata,
      clk => clk,
      rst_n => jtag_uart_avalon_jtag_slave_reset_n
    );


  --the_ps2_0_avalon_slave_0, which is an e_instance
  the_ps2_0_avalon_slave_0 : ps2_0_avalon_slave_0_arbitrator
    port map(
      cpu_data_master_granted_ps2_0_avalon_slave_0 => cpu_data_master_granted_ps2_0_avalon_slave_0,
      cpu_data_master_qualified_request_ps2_0_avalon_slave_0 => cpu_data_master_qualified_request_ps2_0_avalon_slave_0,
      cpu_data_master_read_data_valid_ps2_0_avalon_slave_0 => cpu_data_master_read_data_valid_ps2_0_avalon_slave_0,
      cpu_data_master_requests_ps2_0_avalon_slave_0 => cpu_data_master_requests_ps2_0_avalon_slave_0,
      d1_ps2_0_avalon_slave_0_end_xfer => d1_ps2_0_avalon_slave_0_end_xfer,
      ps2_0_avalon_slave_0_address => ps2_0_avalon_slave_0_address,
      ps2_0_avalon_slave_0_byteenable => ps2_0_avalon_slave_0_byteenable,
      ps2_0_avalon_slave_0_chipselect => ps2_0_avalon_slave_0_chipselect,
      ps2_0_avalon_slave_0_read => ps2_0_avalon_slave_0_read,
      ps2_0_avalon_slave_0_readdata_from_sa => ps2_0_avalon_slave_0_readdata_from_sa,
      ps2_0_avalon_slave_0_reset => ps2_0_avalon_slave_0_reset,
      ps2_0_avalon_slave_0_waitrequest_from_sa => ps2_0_avalon_slave_0_waitrequest_from_sa,
      ps2_0_avalon_slave_0_write => ps2_0_avalon_slave_0_write,
      ps2_0_avalon_slave_0_writedata => ps2_0_avalon_slave_0_writedata,
      clk => clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_data_master_writedata => cpu_data_master_writedata,
      ps2_0_avalon_slave_0_readdata => ps2_0_avalon_slave_0_readdata,
      ps2_0_avalon_slave_0_waitrequest => ps2_0_avalon_slave_0_waitrequest,
      reset_n => clk_reset_n
    );


  --the_ps2_0, which is an e_ptf_instance
  the_ps2_0 : ps2_0
    port map(
      PS2_CLK => PS2_CLK_to_and_from_the_ps2_0,
      PS2_DAT => PS2_DAT_to_and_from_the_ps2_0,
      irq => internal_irq_from_the_ps2_0,
      readdata => ps2_0_avalon_slave_0_readdata,
      waitrequest => ps2_0_avalon_slave_0_waitrequest,
      address => ps2_0_avalon_slave_0_address,
      byteenable => ps2_0_avalon_slave_0_byteenable,
      chipselect => ps2_0_avalon_slave_0_chipselect,
      clk => clk,
      read => ps2_0_avalon_slave_0_read,
      reset => ps2_0_avalon_slave_0_reset,
      write => ps2_0_avalon_slave_0_write,
      writedata => ps2_0_avalon_slave_0_writedata
    );


  --the_ram_avalon_slave_0, which is an e_instance
  the_ram_avalon_slave_0 : ram_avalon_slave_0_arbitrator
    port map(
      clock_0_out_granted_ram_avalon_slave_0 => clock_0_out_granted_ram_avalon_slave_0,
      clock_0_out_qualified_request_ram_avalon_slave_0 => clock_0_out_qualified_request_ram_avalon_slave_0,
      clock_0_out_read_data_valid_ram_avalon_slave_0 => clock_0_out_read_data_valid_ram_avalon_slave_0,
      clock_0_out_requests_ram_avalon_slave_0 => clock_0_out_requests_ram_avalon_slave_0,
      d1_ram_avalon_slave_0_end_xfer => d1_ram_avalon_slave_0_end_xfer,
      ram_avalon_slave_0_address => ram_avalon_slave_0_address,
      ram_avalon_slave_0_chipselect => ram_avalon_slave_0_chipselect,
      ram_avalon_slave_0_reset_n => ram_avalon_slave_0_reset_n,
      ram_avalon_slave_0_write => ram_avalon_slave_0_write,
      ram_avalon_slave_0_writedata => ram_avalon_slave_0_writedata,
      clk => clk_25,
      clock_0_out_address_to_slave => clock_0_out_address_to_slave,
      clock_0_out_read => clock_0_out_read,
      clock_0_out_write => clock_0_out_write,
      clock_0_out_writedata => clock_0_out_writedata,
      reset_n => clk_25_reset_n
    );


  --the_ram, which is an e_ptf_instance
  the_ram : ram
    port map(
      readaddr => internal_readaddr_from_the_ram,
      readdata => internal_readdata_from_the_ram,
      address => ram_avalon_slave_0_address,
      addressout => addressout_to_the_ram,
      chipselect => ram_avalon_slave_0_chipselect,
      clk => clk_25,
      read => read_to_the_ram,
      reset_n => ram_avalon_slave_0_reset_n,
      write => ram_avalon_slave_0_write,
      writedata => ram_avalon_slave_0_writedata
    );


  --the_ram_signal_avalon_slave_0, which is an e_instance
  the_ram_signal_avalon_slave_0 : ram_signal_avalon_slave_0_arbitrator
    port map(
      clock_1_out_granted_ram_signal_avalon_slave_0 => clock_1_out_granted_ram_signal_avalon_slave_0,
      clock_1_out_qualified_request_ram_signal_avalon_slave_0 => clock_1_out_qualified_request_ram_signal_avalon_slave_0,
      clock_1_out_read_data_valid_ram_signal_avalon_slave_0 => clock_1_out_read_data_valid_ram_signal_avalon_slave_0,
      clock_1_out_requests_ram_signal_avalon_slave_0 => clock_1_out_requests_ram_signal_avalon_slave_0,
      d1_ram_signal_avalon_slave_0_end_xfer => d1_ram_signal_avalon_slave_0_end_xfer,
      ram_signal_avalon_slave_0_address => ram_signal_avalon_slave_0_address,
      ram_signal_avalon_slave_0_chipselect => ram_signal_avalon_slave_0_chipselect,
      ram_signal_avalon_slave_0_reset_n => ram_signal_avalon_slave_0_reset_n,
      ram_signal_avalon_slave_0_write => ram_signal_avalon_slave_0_write,
      ram_signal_avalon_slave_0_writedata => ram_signal_avalon_slave_0_writedata,
      clk => clk_25,
      clock_1_out_address_to_slave => clock_1_out_address_to_slave,
      clock_1_out_read => clock_1_out_read,
      clock_1_out_write => clock_1_out_write,
      clock_1_out_writedata => clock_1_out_writedata,
      reset_n => clk_25_reset_n
    );


  --the_ram_signal, which is an e_ptf_instance
  the_ram_signal : ram_signal
    port map(
      read_data => internal_read_data_from_the_ram_signal,
      address => ram_signal_avalon_slave_0_address,
      chipselect => ram_signal_avalon_slave_0_chipselect,
      clk => clk_25,
      read_addr => read_addr_to_the_ram_signal,
      reset_n => ram_signal_avalon_slave_0_reset_n,
      write => ram_signal_avalon_slave_0_write,
      writedata => ram_signal_avalon_slave_0_writedata
    );


  --the_sdram_s1, which is an e_instance
  the_sdram_s1 : sdram_s1_arbitrator
    port map(
      cpu_data_master_byteenable_sdram_s1 => cpu_data_master_byteenable_sdram_s1,
      cpu_data_master_granted_sdram_s1 => cpu_data_master_granted_sdram_s1,
      cpu_data_master_qualified_request_sdram_s1 => cpu_data_master_qualified_request_sdram_s1,
      cpu_data_master_read_data_valid_sdram_s1 => cpu_data_master_read_data_valid_sdram_s1,
      cpu_data_master_read_data_valid_sdram_s1_shift_register => cpu_data_master_read_data_valid_sdram_s1_shift_register,
      cpu_data_master_requests_sdram_s1 => cpu_data_master_requests_sdram_s1,
      cpu_instruction_master_granted_sdram_s1 => cpu_instruction_master_granted_sdram_s1,
      cpu_instruction_master_qualified_request_sdram_s1 => cpu_instruction_master_qualified_request_sdram_s1,
      cpu_instruction_master_read_data_valid_sdram_s1 => cpu_instruction_master_read_data_valid_sdram_s1,
      cpu_instruction_master_read_data_valid_sdram_s1_shift_register => cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
      cpu_instruction_master_requests_sdram_s1 => cpu_instruction_master_requests_sdram_s1,
      d1_sdram_s1_end_xfer => d1_sdram_s1_end_xfer,
      sdram_s1_address => sdram_s1_address,
      sdram_s1_byteenable_n => sdram_s1_byteenable_n,
      sdram_s1_chipselect => sdram_s1_chipselect,
      sdram_s1_read_n => sdram_s1_read_n,
      sdram_s1_readdata_from_sa => sdram_s1_readdata_from_sa,
      sdram_s1_reset_n => sdram_s1_reset_n,
      sdram_s1_waitrequest_from_sa => sdram_s1_waitrequest_from_sa,
      sdram_s1_write_n => sdram_s1_write_n,
      sdram_s1_writedata => sdram_s1_writedata,
      clk => clk,
      cpu_data_master_address_to_slave => cpu_data_master_address_to_slave,
      cpu_data_master_byteenable => cpu_data_master_byteenable,
      cpu_data_master_dbs_address => cpu_data_master_dbs_address,
      cpu_data_master_dbs_write_16 => cpu_data_master_dbs_write_16,
      cpu_data_master_no_byte_enables_and_last_term => cpu_data_master_no_byte_enables_and_last_term,
      cpu_data_master_read => cpu_data_master_read,
      cpu_data_master_waitrequest => cpu_data_master_waitrequest,
      cpu_data_master_write => cpu_data_master_write,
      cpu_instruction_master_address_to_slave => cpu_instruction_master_address_to_slave,
      cpu_instruction_master_dbs_address => cpu_instruction_master_dbs_address,
      cpu_instruction_master_read => cpu_instruction_master_read,
      reset_n => clk_reset_n,
      sdram_s1_readdata => sdram_s1_readdata,
      sdram_s1_readdatavalid => sdram_s1_readdatavalid,
      sdram_s1_waitrequest => sdram_s1_waitrequest
    );


  --the_sdram, which is an e_ptf_instance
  the_sdram : sdram
    port map(
      za_data => sdram_s1_readdata,
      za_valid => sdram_s1_readdatavalid,
      za_waitrequest => sdram_s1_waitrequest,
      zs_addr => internal_zs_addr_from_the_sdram,
      zs_ba => internal_zs_ba_from_the_sdram,
      zs_cas_n => internal_zs_cas_n_from_the_sdram,
      zs_cke => internal_zs_cke_from_the_sdram,
      zs_cs_n => internal_zs_cs_n_from_the_sdram,
      zs_dq => zs_dq_to_and_from_the_sdram,
      zs_dqm => internal_zs_dqm_from_the_sdram,
      zs_ras_n => internal_zs_ras_n_from_the_sdram,
      zs_we_n => internal_zs_we_n_from_the_sdram,
      az_addr => sdram_s1_address,
      az_be_n => sdram_s1_byteenable_n,
      az_cs => sdram_s1_chipselect,
      az_data => sdram_s1_writedata,
      az_rd_n => sdram_s1_read_n,
      az_wr_n => sdram_s1_write_n,
      clk => clk,
      reset_n => sdram_s1_reset_n
    );


  --reset is asserted asynchronously and deasserted synchronously
  nios_reset_clk_domain_synch : nios_reset_clk_domain_synch_module
    port map(
      data_out => clk_reset_n,
      clk => clk,
      data_in => module_input6,
      reset_n => reset_n_sources
    );

  module_input6 <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT ((((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(cpu_jtag_debug_module_resetrequest_from_sa)))) OR std_logic_vector'("00000000000000000000000000000000"))));
  --reset is asserted asynchronously and deasserted synchronously
  nios_reset_clk_25_domain_synch : nios_reset_clk_25_domain_synch_module
    port map(
      data_out => clk_25_reset_n,
      clk => clk_25,
      data_in => module_input7,
      reset_n => reset_n_sources
    );

  module_input7 <= std_logic'('1');

  --clock_0_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  clock_0_out_endofpacket <= std_logic'('0');
  --clock_1_out_endofpacket of type endofpacket does not connect to anything so wire it to default (0)
  clock_1_out_endofpacket <= std_logic'('0');
  --vhdl renameroo for output signals
  irq_from_the_ps2_0 <= internal_irq_from_the_ps2_0;
  --vhdl renameroo for output signals
  read_data_from_the_ram_signal <= internal_read_data_from_the_ram_signal;
  --vhdl renameroo for output signals
  readaddr_from_the_ram <= internal_readaddr_from_the_ram;
  --vhdl renameroo for output signals
  readdata_from_the_ram <= internal_readdata_from_the_ram;
  --vhdl renameroo for output signals
  zs_addr_from_the_sdram <= internal_zs_addr_from_the_sdram;
  --vhdl renameroo for output signals
  zs_ba_from_the_sdram <= internal_zs_ba_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cas_n_from_the_sdram <= internal_zs_cas_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cke_from_the_sdram <= internal_zs_cke_from_the_sdram;
  --vhdl renameroo for output signals
  zs_cs_n_from_the_sdram <= internal_zs_cs_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_dqm_from_the_sdram <= internal_zs_dqm_from_the_sdram;
  --vhdl renameroo for output signals
  zs_ras_n_from_the_sdram <= internal_zs_ras_n_from_the_sdram;
  --vhdl renameroo for output signals
  zs_we_n_from_the_sdram <= internal_zs_we_n_from_the_sdram;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component nios is 
           port (
                 -- 1) global signals:
                    signal clk : IN STD_LOGIC;
                    signal clk_25 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_ps2_0
                    signal PS2_CLK_to_and_from_the_ps2_0 : INOUT STD_LOGIC;
                    signal PS2_DAT_to_and_from_the_ps2_0 : INOUT STD_LOGIC;
                    signal irq_from_the_ps2_0 : OUT STD_LOGIC;

                 -- the_ram
                    signal addressout_to_the_ram : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal read_to_the_ram : IN STD_LOGIC;
                    signal readaddr_from_the_ram : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal readdata_from_the_ram : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);

                 -- the_ram_signal
                    signal read_addr_to_the_ram_signal : IN STD_LOGIC;
                    signal read_data_from_the_ram_signal : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- the_sdram
                    signal zs_addr_from_the_sdram : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
                    signal zs_ba_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_cas_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_cke_from_the_sdram : OUT STD_LOGIC;
                    signal zs_cs_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_dq_to_and_from_the_sdram : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
                    signal zs_dqm_from_the_sdram : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal zs_ras_n_from_the_sdram : OUT STD_LOGIC;
                    signal zs_we_n_from_the_sdram : OUT STD_LOGIC
                 );
end component nios;

                signal PS2_CLK_to_and_from_the_ps2_0 :  STD_LOGIC;
                signal PS2_DAT_to_and_from_the_ps2_0 :  STD_LOGIC;
                signal addressout_to_the_ram :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clk :  STD_LOGIC;
                signal clk_25 :  STD_LOGIC;
                signal clock_0_in_endofpacket_from_sa :  STD_LOGIC;
                signal clock_0_out_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clock_0_out_endofpacket :  STD_LOGIC;
                signal clock_0_out_nativeaddress :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal clock_1_in_endofpacket_from_sa :  STD_LOGIC;
                signal clock_1_out_endofpacket :  STD_LOGIC;
                signal clock_1_out_nativeaddress :  STD_LOGIC;
                signal irq_from_the_ps2_0 :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal jtag_uart_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal read_addr_to_the_ram_signal :  STD_LOGIC;
                signal read_data_from_the_ram_signal :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal read_to_the_ram :  STD_LOGIC;
                signal readaddr_from_the_ram :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal readdata_from_the_ram :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal reset_n :  STD_LOGIC;
                signal zs_addr_from_the_sdram :  STD_LOGIC_VECTOR (11 DOWNTO 0);
                signal zs_ba_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_cas_n_from_the_sdram :  STD_LOGIC;
                signal zs_cke_from_the_sdram :  STD_LOGIC;
                signal zs_cs_n_from_the_sdram :  STD_LOGIC;
                signal zs_dq_to_and_from_the_sdram :  STD_LOGIC_VECTOR (15 DOWNTO 0);
                signal zs_dqm_from_the_sdram :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal zs_ras_n_from_the_sdram :  STD_LOGIC;
                signal zs_we_n_from_the_sdram :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : nios
    port map(
      PS2_CLK_to_and_from_the_ps2_0 => PS2_CLK_to_and_from_the_ps2_0,
      PS2_DAT_to_and_from_the_ps2_0 => PS2_DAT_to_and_from_the_ps2_0,
      irq_from_the_ps2_0 => irq_from_the_ps2_0,
      read_data_from_the_ram_signal => read_data_from_the_ram_signal,
      readaddr_from_the_ram => readaddr_from_the_ram,
      readdata_from_the_ram => readdata_from_the_ram,
      zs_addr_from_the_sdram => zs_addr_from_the_sdram,
      zs_ba_from_the_sdram => zs_ba_from_the_sdram,
      zs_cas_n_from_the_sdram => zs_cas_n_from_the_sdram,
      zs_cke_from_the_sdram => zs_cke_from_the_sdram,
      zs_cs_n_from_the_sdram => zs_cs_n_from_the_sdram,
      zs_dq_to_and_from_the_sdram => zs_dq_to_and_from_the_sdram,
      zs_dqm_from_the_sdram => zs_dqm_from_the_sdram,
      zs_ras_n_from_the_sdram => zs_ras_n_from_the_sdram,
      zs_we_n_from_the_sdram => zs_we_n_from_the_sdram,
      addressout_to_the_ram => addressout_to_the_ram,
      clk => clk,
      clk_25 => clk_25,
      read_addr_to_the_ram_signal => read_addr_to_the_ram_signal,
      read_to_the_ram => read_to_the_ram,
      reset_n => reset_n
    );


  process
  begin
    clk <= '0';
    loop
       wait for 10 ns;
       clk <= not clk;
    end loop;
  end process;
  process
  begin
    clk_25 <= '0';
    loop
       wait for 20 ns;
       clk_25 <= not clk_25;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
