library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity basic_toplevel is
	port(
		clk: in std_logic;
		data: out unsigned(11 downto 0)
	);
end;

architecture struct of basic_toplevel is
	signal we_pc, rst_pc: std_logic;
	signal next_pc, curr_pc: unsigned(15 downto 0);
begin
	pc: entity work.pc port map(clk => clk, we => we_pc, rst => rst_pc, data_in => next_pc, data_out => curr_pc);	
	uc: entity work.proto_uc port map(curr_pc => curr_pc, next_pc => next_pc, we_pc => we_pc, rst_pc => rst_pc);
	rom: entity work.rom port map(clk => clk, address => curr_pc, data => data);
end;
