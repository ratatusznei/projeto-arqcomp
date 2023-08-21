library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ghdl -a pc.vhdl proto_uc.vhdl basic_toplevel.vhdl tb_basic_toplevel.vhdl && ghdl -r tb_basic_toplevel --vcd=- | gtkwave -v

entity tb_basic_toplevel is
end;

architecture tb of tb_basic_toplevel is
	signal clk, finished: std_logic := '0';
	signal data: unsigned(11 downto 0);
begin
	dut: entity work.basic_toplevel port map(clk => clk, data => data);
	clk <= not(clk) after 0.5 ns when finished = '0' else '0';
	finished <= '1' after 32 ns;
end;
