library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
	port(
		mux_in1: in std_logic_vector(15 downto 0);
		mux_sel: in std_logic;
		clk, we, rst: in std_logic;
		rd_sel, rs_sel, rt_sel: in std_logic_vector(2 downto 0);
		ula_out: out std_logic_vector(15 downto 0)
	);
end;

architecture structural of toplevel is
	signal rd, rs, mux_in0, mux_out: std_logic_vector(15 downto 0);
begin
	mux_out <= mux_in0 when mux_sel = '0' else mux_in1;
	ula_out <= rd;

	ula: entity work.ula port map(
		rd_out => rd,
		rs_in => rs,
		rt_in => mux_out,
		sel => "00"
	);
	reg_file: entity work.reg_file port map(
		rd_in => rd,
		rs_out => rs,
		rt_out => mux_in0,
		rd_sel => rd_sel,
		rs_sel => rs_sel,
		rt_sel => rt_sel,
		we => we, 
		clk => clk,
		rst => rst
	);
end;
