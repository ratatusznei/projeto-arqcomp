library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port(
		in0, in1: in unsigned(15 downto 0);
		sel: in unsigned(1 downto 0);

		carry: out std_logic;
		zero: out std_logic;
		out0: out unsigned(15 downto 0)
	);
end;

architecture arch of ula is
	signal res, res_sub, res_menor, res_nand: unsigned(15 downto 0);
	signal res_soma: unsigned(16 downto 0);
begin
	res_soma <= unsigned(("0" & in0) + ("0" & in1));
	res_sub <= unsigned(in0 - in1);
	res_menor <= x"0001" when (in0 < in1) else x"0000";
	res_nand <= not(in0 and in1);
	out0 <= res;
	
	zero <= '1' when res = 0 else '0';
	carry <= '1' when sel = "01" and in0 < in1 else 
			 res_soma(16) when sel = "00" else
			 '0';

	with sel select
		res <= res_soma(15 downto 0) when "00", -- SOMA
			res_sub when "01",      -- SUBTRACAO
			res_menor when "10",    -- MENOR
			res_nand when "11",     -- NAND
			(others => '0') when others;
end;
