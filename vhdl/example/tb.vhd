library ieee;
use ieee.std_logic_1164.all;

entity tb is
end;

architecture arch of tb
is
	signal a, b, y: std_logic;
begin
	dut: entity work.porta port map(
		a => a, b => b, y => y
	);

	process
	begin
		a <= '0';
		b <= '0';
		wait for 50 ns;
		a <= '0';
		b <= '1';
		wait for 50 ns;
		a <= '1';
		b <= '0';
		wait for 50 ns;
		a <= '1';
		b <= '1';
		wait for 50 ns;
		wait;
	end process;
end;
