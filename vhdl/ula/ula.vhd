library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
		in0, in1: in std_logic_vector(15 downto 0);
		sel: in std_logic_vector(1 downto 0);
		out0: out std_logic_vector(15 downto 0)
	);
end;

architecture arch of ula is
	signal res_soma, res_sub, res_menor, res_nand: std_logic_vector(15 downto 0);
begin
	res_soma <= std_logic_vector(unsigned(in0) + unsigned(in1));
	res_sub <= std_logic_vector(unsigned(in0) - unsigned(in1));
	res_menor <= x"0001" when (unsigned(in0) < unsigned(in1)) else x"0000";
	res_nand <= not(in0 and in1);

	with sel select
		out0 <= res_soma when "00", -- SOMA
			res_sub when "01",      -- SUBTRACAO
			res_menor when "10",    -- MENOR
			res_nand when "11",     -- NAND
			"----------------" when others;
end;
