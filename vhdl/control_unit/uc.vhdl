library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port(
		clk: in std_logic;

		rom_data: in unsigned(11 downto 0);

		curr_pc: in unsigned(15 downto 0);
		next_pc: out unsigned(15 downto 0);
		we_pc: out std_logic
	);
end;

architecture comb of uc is
	signal state: std_logic;

	signal instr: unsigned(11 downto 0);
	signal opcode: unsigned(3 downto 0);
	signal jump_dest: unsigned(15 downto 0);
begin
	state_machine: entity work.state_machine port map(state_out => state, clk => clk, rst => '0');

	instr <= rom_data;
	opcode <= instr(11 downto 8);
	jump_dest <= x"00" & instr(7 downto 0);

	we_pc <= '1' when state = '1' else '0';
	next_pc <= jump_dest when opcode = x"F" else curr_pc + 1;
end;
