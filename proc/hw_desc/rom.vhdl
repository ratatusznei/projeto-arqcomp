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

		-- r7 salva o valor maximo, r6 salva incremento, r5 salva zero
		0 => b"11_00_111_0001100100", -- LD r7, 0x064
		1 => b"11_00_110_0000000001", -- LD r6, 0x001
		2 => b"11_00_101_0000000000", -- LD r5, 0x000

		-- inicializa ram ate endereco r7
		3 => b"11_00_000_0000000000", -- LD A, 0x000
		4 => b"11_00_001_0000000000", -- LD HL, 0x000

		5 => b"11_10_001_0000000000", -- LD (HL), HL
		6 => b"11_01_000_0000000_001", -- LD A, HL
		7 => b"10_00_0000000000_110", -- ADD r6
		8 => b"11_01_001_0000000_000", -- LD HL, A
		9 => b"10_01_0000000000_111", -- SUB r7
		10 => b"01_010_11_1111111011", -- JR C, -5

		-- Inicializa r2
		11 => b"11_00_010_0000000010", -- LD r2, 0x002

		-- Elimina os multiplos de r2, HL é iterador
		12 => b"11_01_001_0000000_010", -- LD HL, r2

		13 => b"11_01_000_0000000_001", -- LD A, HL
		14 => b"10_00_0000000000_010", -- ADD r2
		15 => b"11_01_001_0000000_000", -- LD HL, A
		16 => b"11_10_101_0000000000", -- LD (HL), r5 
		17 => b"10_01_0000000000_111", -- SUB r7
		18 => b"01_010_11_1111111011", -- JR C, -5

		-- Incrementa r2 ate o proximo numero e volta para repetir o loop
		19 => b"11_01_000_0000000_010", -- LD A, r2
		20 => b"10_00_0000000000_110", -- ADD r6
		21 => b"11_01_010_0000000_000", -- LD r2, A

		22 => b"11_01_001_0000000_000", -- LD HL, A
		23 => b"10_01_0000000000_111", -- SUB r7
		24 => b"01_010_01_0000001000", -- JR NC, +8

		25 => b"11_11_000_0000000000", -- LD A, (HL)
		26 => b"10_01_0000000000_101", -- SUB r5
		27 => b"01_010_00_0000000010", -- JR NZ, +2
		28 => b"01_001_00_1111110101", -- JR C, -9
		29 => b"10_01_0000000000_111", -- SUB r7
		30 => b"01_010_11_1111101110", -- JR C, -18


		-- Envia os primos para a saida da ula
		32 => b"11_00_001_0000000010", -- LD HL, 0x002

		33 => b"11_01_000_0000000_001", -- LD A, HL
		34 => b"10_01_0000000000_111", -- SUB r7
		35 => b"01_010_01_0000011101", -- JR NC, +29

		36 => b"11_11_000_0000000000", -- LD A, (HL)
		37 => b"10_01_0000000000_101", -- SUB r5
		38 => b"01_010_10_0000000010", -- JR Z, +2
		39 => b"11_01_100_0000000_000", -- LD r4, A

		40 => b"11_01_000_0000000_001", -- LD A, HL
		41 => b"10_00_0000000000_110", -- ADD r6
		42 => b"11_01_001_0000000_000", -- LD HL, A

		43 => b"01_001_00_1111110110", -- JR -10


		64 => b"01_000_000001000000", -- fim: JP fim

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
