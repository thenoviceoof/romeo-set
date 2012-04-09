library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity hooktb2 is
end hooktb2;

architecture tb of hooktb2 is
signal clk25,clk50:	std_logic := '1';
signal reset:		std_logic;
signal a_min:		signed(35 downto 0) := X"F80000000";
signal a_diff:		signed(35 downto 0) := X"0004CCCCC";
signal a_leap:		unsigned(9 downto 0) := "0000000001"; 
signal b_min:		signed(35 downto 0) := X"FC0000000";
signal b_diff:		signed(35 downto 0) := X"000444444";
signal b_leap:		unsigned(9 downto 0) := "0000000011"; 
signal a			: std_logic_vector(35 downto 0);
signal b			: std_logic_vector(35 downto 0);

signal xout:		std_logic_vector(9 downto 0);
signal yout:		std_logic_vector(8 downto 0);

signal count		: unsigned(7 downto 0);
signal we			: std_logic;
signal done			: unsigned(3 downto 0);
signal compute		: unsigned(3 downto 0);

signal eof:			std_logic:='0';
signal    linenumber : integer:=2; --Start at 2 for header line 

--A function for turning std_logic_vectors into strings
function to_string(sv: std_Logic_Vector) return string is
use Std.TextIO.all;
    variable bv: bit_vector(sv'range) := to_bitvector(sv);
    variable lp: line;
begin
write(lp, bv);
return lp.all;
end;

component hook is
  
  port (
	clk50		: in std_logic;								-- Global clock
	clk25		: in std_logic;
	reset		: in std_logic;								-- Clear
	a_min		: in signed(35 downto 0);
	a_diff		: in signed(35 downto 0);
	a_leap		: in unsigned(9 downto 0);
	b_min		: in signed(35 downto 0);
	b_diff		: in signed(35 downto 0);
	b_leap		: in unsigned(9 downto 0);
	xout		: out std_logic_vector(9 downto 0);
	yout		: out std_logic_vector(8 downto 0);
	aout		: out std_logic_vector(35 downto 0);
	bout		: out std_logic_vector(35 downto 0);
	count		: out unsigned (7 downto 0);
	we			: out std_logic;
	done		: out unsigned(3 downto 0);
	compute		: out unsigned(3 downto 0)
	);
  
end component;

begin

	clk50 <= not clk50 after 10 ns;
	clk25 <= not clk25 after 20 ns;
	process	
		begin
		wait for 40 ns;
		reset <= '1';
		wait for 40 ns;
		reset <= '0';
		wait;
	end process;

-- WRITING TO FILE

--write header
process 
file      outfile  : text is out "/home/user4/spring12/lep2141/4840/ifmtest/test_out.txt";  --declare output file
variable  outline  : line;   											--line number declaration  
begin

if(eof='0') then
write(outline, string'("1"));
write(outline, string'(" "));
write(outline, to_string(X"fe0000000"));
write(outline, string'(" ")); 											-- WRITE HEADER ONCE
write(outline, to_string(X"020000000"));
writeline(outfile, outline);						
else
null;
end if;
--file_close(outfile);
wait;
end process;

--write process
writing:
process 
file      outfile  : text is out "/home/user4/spring12/lep2141/4840/ifmtest/test_out.txt";  --declare output file
variable  outline  : line;   											--line number declaration  
begin

wait until clk50 = '0' and clk50'event;
if(eof='0') and (we='1') then   		
write(outline, linenumber);
write(outline, string'(" "));											-- WRITE PER CYCLE
write(outline, to_string(std_logic_vector(a)));
write(outline, string'(" ")); 
write(outline, to_string(std_logic_vector(b)));
write(outline, string'(" ")); 
write(outline, integer'image(to_integer(unsigned(count))));				-- Relevant Signal		
writeline(outfile, outline);
linenumber <= linenumber + 1;
else
null;
end if;

--END WRITING TO FILE

end process writing;

	uut : hook port map(
	clk50		=> clk50,
	clk25		=> clk25,
	reset		=> reset,
	a_min		=> a_min,
	a_diff		=> a_diff,
	a_leap		=> a_leap,
	b_min		=> b_min,
	b_diff		=> b_diff,
	b_leap		=> b_leap,
	xout		=> xout,
	yout		=> yout,
	aout		=> a,
	bout		=> b,
	count		=> count,
	we			=> we,
	done		=> done,
	compute		=> compute
	);
end tb;