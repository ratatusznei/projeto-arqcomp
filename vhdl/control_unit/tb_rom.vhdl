library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ghdl -a rom.vhdl tb_rom.vhdl && ghdl -r tb_rom --vcd=- | gtkwave -v

entity tb_rom is
end;

architecture tb of tb_rom is
	signal address: unsigned(15 downto 0);
	signal data: unsigned(11 downto 0);
	signal clk: std_logic := '0';
	signal finished: std_logic := '0';
begin
	dut: entity work.rom port map(clk => clk, address => address, data => data);
	clk <= not(clk) after 0.5 ns when finished = '0' else '0';

	process
	begin
		for i in 0 to 65535 loop
			address <= to_unsigned(i, 16);
			wait for 1 ns;
		end loop;

		finished <= '1';
		wait;
	end process;
end;
