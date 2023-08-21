library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
	port(
		clk: in std_logic
	);
end;

architecture struct of toplevel is
	signal rom_data: unsigned(11 downto 0);

	signal curr_pc: unsigned(15 downto 0);
	signal next_pc: unsigned(15 downto 0);
	signal we_pc: std_logic;
begin
	uc: entity work.uc port map(clk => clk, rom_data => rom_data, curr_pc => curr_pc, next_pc => next_pc, we_pc => we_pc);
	pc: entity work.pc port map(clk => clk, we => we_pc, rst => '0', data_in => next_pc, data_out => curr_pc);
	rom: entity work.rom port map(clk => clk, address => curr_pc, data => rom_data);
end;
