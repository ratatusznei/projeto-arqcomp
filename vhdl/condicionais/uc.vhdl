library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port(
		clk, rst: in std_logic;

		instr: in unsigned(16 downto 0);	
		state_out: out unsigned(1 downto 0);

		curr_pc: in unsigned(15 downto 0);
		next_pc: out unsigned(15 downto 0);

		we_pc: out std_logic;
		we_ir: out std_logic;
		we_rd: out std_logic;
		we_flags: out std_logic;

		flag_zero: in std_logic;
		flag_carry: in std_logic;

		ula_sel: out unsigned(1 downto 0);
		rd_sel, rs_sel, rt_sel: out unsigned(2 downto 0);

		ula_source1_sel: out std_logic; -- 0 = RS, 1 = imm
		ula_source2_sel: out std_logic; -- 0 = RT, 1 = 0

		imm_ext: out unsigned(15 downto 0)
	);
end;

architecture comb of uc is
	signal jump_dest: unsigned(15 downto 0);
	signal jump_enabled: std_logic;
	signal state: unsigned(1 downto 0);

	constant fmt_nop: unsigned(1 downto 0) := "00";
	constant fmt_jp: unsigned(1 downto 0) := "01";
	constant fmt_ula: unsigned(1 downto 0) := "10";
	constant fmt_ld: unsigned(1 downto 0) := "11";

	signal format: unsigned(1 downto 0);
	signal opcode: unsigned(2 downto 0);	
	signal imm10: unsigned(9 downto 0);
	signal imm16: unsigned(15 downto 0);
	signal cc: unsigned(1 downto 0); -- { 00 (NZ), 01 (NC), 10 (Z), 11 (C) }
begin
	state_out <= state;

	format <= instr(16 downto 15);
	opcode <= "0" & instr(14 downto 13) when format = fmt_ula or format = fmt_ld else
			  instr(14 downto 12);
	imm10 <= instr(9 downto 0);
	cc <= instr(12 downto 11);

	-- 0: fetch, 1: decode, 2: execute
	maq_estados: entity work.maq_estados port map(clk => clk, rst => rst, estado => state);

	we_ir <= '1' when state = 0 else '0';
	we_pc <= '1' when state = 1 else '0';
	we_rd <= '1' when state = 2 and (format = fmt_ula or format = fmt_ld) else '0';
	we_flags <= '1' when state = 2 and format = fmt_ula and opcode = "01" else '0';

	imm16 <= "000000" & imm10 when imm10(9) = '0' else
			   "111111" & imm10;
	imm_ext <= imm16;

	jump_enabled <= '1' when opcode = "000" or opcode = "001" else
					'1' when opcode = "010" and cc = "00" and flag_zero = '0' else
					'1' when opcode = "010" and cc = "01" and flag_carry = '0' else
					'1' when opcode = "010" and cc = "10" and flag_zero = '1' else
					'1' when opcode = "010" and cc = "11" and flag_carry = '1' else
					'0';

	jump_dest <= "000000" & imm10 when opcode = "000" else
				 (curr_pc + imm16) when opcode = "001" or opcode = "010" else
				 "0000000000000000";

	ula_sel <= opcode(1 downto 0) when format = fmt_ula else
			   "00" when format = fmt_ld else
			   "00"; 

	-- 0 = rs, 1 = imm
	ula_source1_sel <= '0' when format = fmt_ula else
					   '1' when format = fmt_ld and opcode = "00" else
					   '0' when format = fmt_ld and opcode = "01" else
					   '0';

	-- 0 = rt, 1 = (others => '0')
	ula_source2_sel <= '0' when format = fmt_ula else
					   '1' when format = fmt_ld and opcode = "00" else
					   '1' when format = fmt_ld and opcode = "01" else
					   '0';

	rd_sel <= "000" when format = fmt_ula else
			  instr(12 downto 10) when format = fmt_ld else
			  "000";

	rs_sel <= "000" when format = fmt_ula else 
			  instr(2 downto 0) when format = fmt_ld and opcode = "01" else
			  "000";

	rt_sel <= instr(2 downto 0);

	next_pc <= jump_dest when format = fmt_jp and jump_enabled = '1' else (curr_pc + 1);
end;
