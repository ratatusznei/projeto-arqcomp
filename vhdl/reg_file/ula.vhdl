library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
		rs_in, rt_in: in std_logic_vector(15 downto 0);
		sel: in std_logic_vector(1 downto 0);
		rd_out: out std_logic_vector(15 downto 0)
	);
end;

architecture arch of ula is
	signal res_soma, res_sub, res_menor, res_nand: std_logic_vector(15 downto 0);
begin
	res_soma <= std_logic_vector(unsigned(rs_in) + unsigned(rt_in));
	res_sub <= std_logic_vector(unsigned(rs_in) - unsigned(rt_in));
	res_menor <= x"0001" when (unsigned(rs_in) < unsigned(rt_in)) else x"0000";
	res_nand <= not(rs_in and rt_in);

	with sel select
		rd_out <= res_soma when "00", -- SOMA
			res_sub when "01",      -- SUBTRACAO
			res_menor when "10",    -- MENOR
			res_nand when "11",     -- NAND
			"----------------" when others;
end;
