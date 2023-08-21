library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ghdl -a state_machine.vhdl tb_state_machine.vhdl && ghdl -r tb_state_machine --vcd=- | gtkwave -v

entity tb_state_machine is
end;

architecture tb of tb_state_machine is
	signal clk, rst, state, finished: std_logic := '0';
begin
	dut: entity work.state_machine port map(clk => clk, rst => rst, state_out => state);
	clk <= not(clk) after 0.5 ns when finished = '0' else '0';

	process is
	begin
		finished <= '1' after 16 ns;
		rst <= '1' after 4 ns,
			   '0' after 13 ns;
		wait;
	end process;
end;
