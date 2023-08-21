library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ghdl -a state_machine.vhdl pc.vhdl uc.vhdl rom.vhdl toplevel.vhdl tb_toplevel.vhdl && ghdl -r tb_toplevel --wave=/tmp/a.ghw | gtkwave /tmp/a.ghw; rm -f /tmp/a.ghw

entity tb_toplevel is
end;

architecture tb of tb_toplevel is
	signal clk, finished: std_logic := '0';
begin
	dut: entity work.toplevel port map(clk => clk);

	clk <= not(clk) after 0.5 ns when finished = '0' else '0';
	finished <= '1' after 49 ns;
end;
