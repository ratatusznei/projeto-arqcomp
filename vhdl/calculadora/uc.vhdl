library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port(
		clk, rst: in std_logic;

		curr_pc: in unsigned(15 downto 0);
		next_pc: out unsigned(15 downto 0);

		we_pc: out std_logic;
		we_ir: out std_logic;
		we_rd: out std_logic;

		ula_sel: out unsigned(1 downto 0);
		rd_sel, rs_sel, rt_sel: out unsigned(2 downto 0);

		ula_source1_sel: out std_logic; -- 0 = S, 1 = imm
		ula_source2_sel: out std_logic; -- 0 = T, 1 = 0
		imm_out: out unsigned(15 downto 0);

		instr: in unsigned(16 downto 0);	
		state_out: out unsigned(1 downto 0)
	);
end;

architecture comb of uc is
	signal jump_dest: unsigned(15 downto 0);
	signal opcode: unsigned(2 downto 0);	
	signal state: unsigned(1 downto 0);
begin
	state_out <= state;
	-- 0: fetch, 1: decode, 2: execute
	maq_estados: entity work.maq_estados port map(clk => clk, rst => rst, estado => state);

	we_ir <= '1' when state = 0 else '0';
	we_pc <= '1' when state = 1 else '0';
	we_rd <= '1' when state = 2 and (opcode = "001" or opcode = "010" or opcode = "011" or opcode = "100") else '0';

	opcode <= instr(16 downto 14);
	imm_out <= "00000" & instr(10 downto 0);
	jump_dest <= "00" & instr(13 downto 0);

	ula_sel <= "00" when opcode = "001" or opcode = "011" or opcode = "100" else
	           "01" when opcode = "010" else
	           "--";

	ula_source1_sel <= '0' when opcode = "001" or opcode = "010" or opcode = "100" else
	                   '1' when opcode = "011" else
	                   '-';

	ula_source2_sel <= '0' when opcode = "001" or opcode = "010" else
	                   '1' when opcode = "011" or opcode = "100" else
	                   '-';


	rd_sel <= instr(13 downto 11);
	rs_sel <= instr(10 downto 8);
	rt_sel <= instr(7 downto 5);

	next_pc <= jump_dest when opcode = "111" else curr_pc + 1;
end;
