library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proto_uc is
	port(
		curr_pc: in unsigned(15 downto 0);
		next_pc: out unsigned(15 downto 0);
		we_pc, rst_pc: out std_logic
	);
end;

architecture comb of proto_uc is
begin
	next_pc <= curr_pc + 1;
	we_pc <= '1';
	rst_pc <= '0';
end;
