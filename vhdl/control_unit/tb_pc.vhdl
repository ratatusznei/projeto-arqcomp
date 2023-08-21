library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ghdl -a pc.vhdl proto_uc.vhdl tb_pc.vhdl && ghdl -r tb_pc --vcd=- | gtkwave -v

entity tb_pc is
end;

architecture tb of tb_pc is
	signal next_pc, curr_pc: unsigned(15 downto 0) := (others => '0');
	signal clk, rst, we, finished: std_logic := '0';
begin
	dut_pc: entity work.pc port map(data_out => curr_pc, data_in => next_pc, clk => clk, rst => rst, we => we);
	dut_proto_uc: entity work.proto_uc port map(curr_pc => curr_pc, next_pc => next_pc, we_pc => we, rst_pc => rst);
	clk <= not(clk) after 0.5 ns when finished = '0' else '0';
	finished <= '1' after 32 ns;
end;
