library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(
		clk: in std_logic;
		address: in unsigned(15 downto 0);
		data: out unsigned(16 downto 0)
	);
end;

architecture behav of rom is
	type mem_type is array (0 to 65535) of unsigned(16 downto 0);
	constant stored_data: mem_type := (
		-- b"00000000000000000"      NOP              -- no operation
		-- b"111_xxxxxxxxxxxxxx"     JP               -- jump incondicional para x
		-- b"001_ddd_sss_ttt_00000"  ADD D, S, T      -- D <= S + T
		-- b"010_ddd_sss_ttt_00000"  SUB D, S, T      -- D <= S - T
		-- b"011_ddd_iiiiiiiiiii"    LD D, i           -- D <= imediato
		-- b"100_ddd_sss_00000000"   LD D, S           -- D <= S

		0 => b"011_011_00000000101",   -- LD R3, 5
		1 => b"011_100_00000001000",   -- LD R4, 8
		2 => b"001_101_011_100_00000", -- ADD R5, R3, R4
		3 => b"011_001_00000000001",   -- LD R1, 1
		4 => b"010_101_101_001_00000", -- SUB R5, R5, R1
		5 => b"111_00000000010100",    -- JP 20

		20 => b"100_011_101_00000000", -- LD R3, R5
		21 => b"111_00000000000010",   -- JP 2

		others => (others => '0')
	);
begin
	process (clk) is
	begin
		if (rising_edge(clk)) then
			data <= stored_data(to_integer(address));
		end if;
	end process;
end;
