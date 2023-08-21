library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(
		clk: in std_logic;
		address: in unsigned(15 downto 0);
		data: out unsigned(11 downto 0)
	);
end;

architecture behav of rom is
	type mem_type is array (0 to 65535) of unsigned(11 downto 0);
	constant stored_data: mem_type := (
		-- x"000" nop
		-- x"Fxx" jump para xx

		0 => x"000", -- 2 clk
		1 => x"F07", -- 2 clk

		2 => x"000", -- 2 clk
		3 => x"000", -- 2 clk
		4 => x"000", -- 2 clk
		5 => x"000", -- 2 clk
		6 => x"FFF", -- 2 clk

		7 => x"000", -- 2 clk
		8 => x"F02", -- 2 clk

		255 => x"000", -- 2 clk
		256 => x"FFF", -- 2 clk

		-- total 11 * 2 clk = 22 clk => 22 ns ate chegar no endereco 255 pela 2a vez
		-- o 1o clock ocorre em 0.5 ns, ..., o 22o clock ocorren em 21.5 ns

		others => x"000"
	);
begin
	process (clk) is
	begin
		if (rising_edge(clk)) then
			data <= stored_data(to_integer(address));
		end if;
	end process;
end;
