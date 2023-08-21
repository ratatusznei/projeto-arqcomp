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
		-- 11 10 rrr ..........    LD (HL), r
		-- 11 11 rrr ..........    LD r, (HL)
 		-- cc ∈ { 00 (NZ), 01 (NC), 10 (Z), 11 (C) }
		-- HL = r1

		-- Primeiro salvando o Endereco * 5 em alguns lugares
		0 => b"11_00_011_0000001111", -- LD R3, 15
		1 => b"11_00_001_0000000011", -- LD HL, 3
		2 => b"11_10_011_0000000000", -- LD (HL), R3

		3 => b"11_00_011_0000011110", -- LD R3, 30
		4 => b"11_00_001_0000000110", -- LD HL, 6
		5 => b"11_10_011_0000000000", -- LD (HL), R3

		6 => b"11_00_011_0000000101", -- LD R3, 5
		7 => b"11_00_001_0000000001", -- LD HL, 1
		8 => b"11_10_011_0000000000", -- LD (HL), R3

		9 => b"11_00_011_0111111001", -- LD R3, 505
		10 => b"11_00_001_0001100101", -- LD HL, 101
		11 => b"11_10_011_0000000000", -- LD (HL), R3

		-- Agora le eles em outra ordem
		12 => b"11_00_001_0001100101", -- LD HL, 101
		13 => b"11_11_111_0000000000", -- LD R7, (HL)

		14 => b"11_00_001_0000000001", -- LD HL, 1
		15 => b"11_11_111_0000000000", -- LD R7, (HL)

		16 => b"11_00_001_0000000011", -- LD HL, 3
		17 => b"11_11_111_0000000000", -- LD R7, (HL)

		18 => b"11_00_001_0000000110", -- LD HL, 6
		19 => b"11_11_111_0000000000", -- LD R7, (HL)

		-- Agora salvando o compl2 do Endereco em alguns lugares com outros registradores
		20 => b"11_00_100_1111111101", -- LD R4, -3
		21 => b"11_00_001_0000000011", -- LD HL, 3
		22 => b"11_10_100_0000000000", -- LD (HL), R4

		23 => b"11_00_100_1111001000", -- LD R4, -56
		24 => b"11_00_001_0000111000", -- LD HL, 56
		25 => b"11_10_100_0000000000", -- LD (HL), R4

		26 => b"11_00_100_1110101001", -- LD R4, -87
		27 => b"11_00_001_0001010111", -- LD HL, 87
		28 => b"11_10_100_0000000000", -- LD (HL), R4

		29 => b"11_00_100_1110011011", -- LD R4, -101
		30 => b"11_00_001_0001100101", -- LD HL, 101
		31 => b"11_10_100_0000000000", -- LD (HL), R4

		-- Lendo eles
		32 => b"11_00_001_0000111000", -- LD HL, 56
		33 => b"11_11_110_0000000000", -- LD R6, (HL)

		34 => b"11_00_001_0001100101", -- LD HL, 101
		35 => b"11_11_110_0000000000", -- LD R6, (HL)

		36 => b"11_00_001_0000000011", -- LD HL, 3
		37 => b"11_11_110_0000000000", -- LD R6, (HL)

		38 => b"11_00_001_0001010111", -- LD HL, 87
		39 => b"11_11_110_0000000000", -- LD R7, (HL)


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
