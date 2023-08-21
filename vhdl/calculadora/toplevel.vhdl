library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
	port(
		clk, rst: in std_logic;
		estado: out unsigned(1 downto 0);
		pc: out unsigned(15 downto 0);
		instr_out: out unsigned(16 downto 0);
		r1_out, r2_out: out unsigned(15 downto 0);
		ula_out: out unsigned(15 downto 0)
	);
end;

architecture tl of toplevel is
	signal curr_pc, next_pc: unsigned(15 downto 0);
	signal we_pc, we_ir, we_rd: std_logic;
	signal ula_sel: unsigned(1 downto 0);
	signal rd, rs, rt: unsigned(15 downto 0);
	signal rd_sel, rs_sel, rt_sel: unsigned(2 downto 0);
	signal ula_source1_sel, ula_source2_sel: std_logic;
	signal imm: unsigned(15 downto 0);
	signal instr: unsigned(16 downto 0);
	signal state_out: unsigned(1 downto 0);
	signal ula_in0, ula_in1: unsigned(15 downto 0);

	signal rom_data: unsigned(16 downto 0);
begin
	estado <= state_out;
	instr_out <= instr;
	pc <= curr_pc;
	r1_out <= rs;
	r2_out <= rt;
	ula_out <= rd;

	ula_in0 <= rs when ula_source1_sel = '0' else imm;
	ula_in1 <= rt when ula_source2_sel = '0' else (others => '0');

	pc_reg: entity work.reg16
	port map(we => we_pc, clk => clk, rst => rst, data_in => next_pc, data_out => curr_pc);
	instr_reg: entity work.reg17
	port map(we => we_ir, clk => clk, rst => rst, data_in => rom_data, data_out => instr);

	uc: entity work.uc port map(
		clk => clk,
		rst => rst,

		curr_pc => curr_pc,
		next_pc => next_pc,

		we_pc => we_pc,
		we_ir => we_ir,
		we_rd => we_rd,

		ula_sel => ula_sel,
		rd_sel => rd_sel, 
		rs_sel => rs_sel,
		rt_sel => rt_sel,

		ula_source1_sel => ula_source1_sel,
		ula_source2_sel => ula_source2_sel,
		imm_out => imm,

		instr => instr,
		state_out => state_out
	);

	rom: entity work.rom port map(
		clk => clk,
		address => curr_pc,
		data => rom_data
	);

	reg_file: entity work.reg_file port map(
		rs_sel => rs_sel,
		rt_sel => rt_sel,
		rd_sel => rd_sel,
		rs_out => rs, 
		rt_out => rt,
		rd_in => rd,
		we => we_rd,
		clk => clk,
		rst => rst
	);

	ula: entity work.ula port map(
		in0 => ula_in0,
		in1 => ula_in1,
		sel => ula_sel,
		out0 => rd
	);
end;
