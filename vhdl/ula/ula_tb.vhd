library ieee;
use ieee.std_logic_1164.all;

entity ula_tb is
end;

architecture arch of ula_tb
is
	signal in0, in1, out0: std_logic_vector(15 downto 0) := x"0000";
	signal sel: std_logic_vector(1 downto 0) := "00";
begin
	dut: entity work.ula port map(in0, in1, sel, out0);

	process
	begin
		-- soma
		in0 <= x"0000";
		in1 <= x"0000";
		sel <= "00";
		wait for 10 ns;

		in0 <= x"0008";
		in1 <= x"0009";
		sel <= "00";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"0001";
		sel <= "00";
		wait for 10 ns;

		in0 <= x"ABCD";
		in1 <= x"1111";
		sel <= "00";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"FFFE";
		sel <= "00";
		wait for 10 ns;

		-- subtracao
		in0 <= x"0000";
		in1 <= x"0000";
		sel <= "01";
		wait for 10 ns;

		in0 <= x"0001";
		in1 <= x"0002";
		sel <= "01";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"FFFE";
		sel <= "01";
		wait for 10 ns;

		in0 <= x"CDEF";
		in1 <= x"2222";
		sel <= "01";
		wait for 10 ns;

		-- menor
		in0 <= x"0000";
		in1 <= x"0000";
		sel <= "10";
		wait for 10 ns;

		in0 <= x"0001";
		in1 <= x"0002";
		sel <= "10";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"0001";
		sel <= "10";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"FFFF";
		sel <= "10";
		wait for 10 ns;

		in0 <= x"0001";
		in1 <= x"FFFF";
		sel <= "10";
		wait for 10 ns;

		-- nand
		in0 <= x"0000";
		in1 <= x"0000";
		sel <= "11";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"FFFF";
		sel <= "11";
		wait for 10 ns;

		in0 <= x"A5A5";
		in1 <= x"5A5A";
		sel <= "11";
		wait for 10 ns;

		in0 <= x"FFFF";
		in1 <= x"1111";
		sel <= "11";
		wait for 10 ns;

		wait;
	end process;
end;
