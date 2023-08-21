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
		ula_out: out unsigned(15 downto 0);
		primos: out unsigned(15 downto 0)
	);
end;

architecture tl of toplevel is
	signal curr_pc, next_pc: unsigned(15 downto 0);
	signal we_pc, we_ir, we_rd, we_flags, we_ram: std_logic;

	signal ula_sel: unsigned(1 downto 0);
	signal rd, rs, rt, HL: unsigned(15 downto 0);
	signal rd_sel, rs_sel, rt_sel: unsigned(2 downto 0);
	signal rd_source_sel: std_logic; -- 0 = ula_out, 1 = ram_out
	signal ula_source1_sel, ula_source2_sel: std_logic;

	signal ula_zero, ula_carry: std_logic;
	signal flag_zero, flag_carry: std_logic;

	signal imm: unsigned(15 downto 0);
	signal instr: unsigned(16 downto 0);
	signal state_out: unsigned(1 downto 0);
	signal ula_in0, ula_in1: unsigned(15 downto 0);
	signal ula_out_signal: unsigned(15 downto 0);
	signal ram_out: unsigned(15 downto 0);

	signal rom_data: unsigned(16 downto 0);
begin
	estado <= state_out;
	instr_out <= instr;
	pc <= curr_pc;
	r1_out <= rs;
	r2_out <= rt;
	ula_out <= ula_out_signal;

	rd <= ula_out_signal when rd_source_sel = '0' else ram_out;

	ula_in0 <= rs when ula_source1_sel = '0' else imm;
	ula_in1 <= rt when ula_source2_sel = '0' else (others => '0');

	pc_reg: entity work.reg16 port map(we => we_pc, clk => clk, rst => rst, data_in => next_pc, data_out => curr_pc);
	instr_reg: entity work.reg17 port map(we => we_ir, clk => clk, rst => rst, data_in => rom_data, data_out => instr);

	zero_reg: entity work.reg1 port map(we => we_flags, clk => clk, rst => rst, data_in => ula_zero, data_out => flag_zero);
	carry_reg: entity work.reg1 port map(we => we_flags, clk => clk, rst => rst, data_in => ula_carry, data_out => flag_carry);

	uc: entity work.uc port map(
		clk => clk,
		rst => rst,

		curr_pc => curr_pc,
		next_pc => next_pc,

		we_pc => we_pc,
		we_ir => we_ir,
		we_rd => we_rd,
		we_flags => we_flags,
		we_ram => we_ram,

		flag_zero => flag_zero,
		flag_carry => flag_carry,

		ula_sel => ula_sel,
		rd_sel => rd_sel, 
		rs_sel => rs_sel,
		rt_sel => rt_sel,
		rd_source_sel => rd_source_sel,

		ula_source1_sel => ula_source1_sel,
		ula_source2_sel => ula_source2_sel,
		imm_ext => imm,

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
		HL_out => HL,
		r4_out => primos,
		rd_in => rd,
		we => we_rd,
		clk => clk,
		rst => rst
	);

	ram: entity work.ram port map(
		clk => clk,
		endereco => HL,
		wr_en => we_ram,
		dado_in => rs,
		dado_out => ram_out
	);

	ula: entity work.ula port map(
		in0 => ula_in0,
		in1 => ula_in1,
		sel => ula_sel,
		zero => ula_zero,
		carry => ula_carry,
		out0 => ula_out_signal
	);
end;
