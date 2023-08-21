library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ghdl -a ram.vhdl maq_estados.vhdl uc.vhdl rom.vhdl reg1.vhdl reg16.vhdl reg17.vhdl reg_file.vhdl ula.vhdl toplevel.vhdl processador_tb.vhdl && ghdl -r processador_tb --wave=a.ghw && gtkwave a.ghw -a save.gtkw


entity processador_tb is
end;

architecture a of processador_tb is
	signal clk, rst, finished: std_logic := '0';
	signal estado: unsigned(1 downto 0);
	signal pc: unsigned(15 downto 0);
	signal instr_out: unsigned(16 downto 0);
	signal r1_out, r2_out: unsigned(15 downto 0);
	signal ula_out: unsigned(15 downto 0);
	signal primos: unsigned(15 downto 0);
begin
	dut: entity work.toplevel port map(
		primos => primos,
		clk => clk,
		rst => rst,
		estado => estado,
		pc => pc,
		instr_out => instr_out,
		r1_out => r1_out,
		r2_out => r2_out,
		ula_out => ula_out
	);

	clk <= not(clk) after 0.5 ns when finished = '0' else '0';

	rst <= '1' after 1 ns,
		   '0' after 2 ns;
	finished <= '1' after 50000 ns;
end;
