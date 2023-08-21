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
		-- 00 000  ............    NOP
		-- 01 000  ..iiiiiiiiii    JP imm
		-- 01 001  ..iiiiiiiiii    JR imm
		-- 01 010  cciiiiiiiiii    JR cc, imm
		-- 10 00  ..........rrr    ADD A, r
		-- 10 01  ..........rrr    SUB r
		-- 11 00 rrr iiiiiiiiii    LD r, imm
		-- 11 01 rrr .......ggg    LD r, g
 		-- cc ∈ { 00 (NZ), 01 (NC), 10 (Z), 11 (C) }

		0 => b"11_00_011_0000000000", -- LD R3, 0
		1 => b"11_00_100_0000000000", -- LD R4, 0

		-- passo3:
		2 => b"11_00_000_0000000000", -- LD R0, 0
		3 => b"10_00_0000000000_011", -- ADD R3
		4 => b"10_00_0000000000_100", -- ADD R4
		5 => b"11_01_100_0000000_000", -- LD R4, R0

		6 => b"11_00_000_0000000001", -- LD R0, 1
		7 => b"10_00_0000000000_011", -- ADD R3
		8 => b"11_01_011_0000000_000", -- LD R3, R0

		9 => b"11_00_111_0000011110", -- LD R7, 30
		10 => b"10_01_0000000000_111", -- SUB R7
		11 => b"01_010_01_1111110111", -- JR NC, passo3 (11+1 + x = 2, x = -10)

		12 => b"11_01_101_0000000_100", -- LD R5, R4

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
