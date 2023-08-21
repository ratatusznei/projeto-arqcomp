library ieee;
use ieee.std_logic_1164.all;

-- ghdl -a reg_file.vhdl ula.vhdl toplevel.vhdl tb_toplevel.vhdl && ghdl -r tb_toplevel --vcd=- | grep -v warning | gtkwave -v

entity tb_toplevel is
end;

architecture tb of tb_toplevel is
	signal mux_in1: std_logic_vector(15 downto 0);
	signal mux_sel: std_logic;
	signal clk, we, rst: std_logic;
	signal rd_sel, rs_sel, rt_sel: std_logic_vector(2 downto 0);
	signal ula_out: std_logic_vector(15 downto 0);
begin
	dut: entity work.toplevel port map(
		mux_in1 => mux_in1,
		mux_sel => mux_sel,
		clk => clk, 
		we => we,
		rst => rst,
		rd_sel => rd_sel,
		rs_sel => rs_sel,
		rt_sel => rt_sel,
		ula_out => ula_out
	);

	process
	begin
		clk <= '0';
		we <= '0';
		mux_in1 <= x"0000";
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "000";

		-- Reset
		rst <= '1';
		wait for 1 ns;
		clk <= '1';
		rst <= '0' after 0.1 ns;
		wait for 1 ns;
		clk <= '0';

		-- load b000 para r1
		mux_in1 <= x"B000";
		mux_sel <= '1';
		rd_sel <= "001";
		rs_sel <= "000";
		rt_sel <= "000";
		we <= '1';

		wait for 1 ns;
		clk <= '1';
		we <= '0' after 0.1 ns;
		wait for 1 ns;
		clk <= '0';

		-- load 00b0 para r2
		mux_in1 <= x"00B0";
		mux_sel <= '1';
		rd_sel <= "010";
		rs_sel <= "000";
		rt_sel <= "000";
		we <= '1';

		wait for 1 ns;
		clk <= '1';
		we <= '0' after 0.1 ns;
		wait for 1 ns;
		clk <= '0';

		-- Soma r1 com r2 e grava em r7
		mux_sel <= '0';
		rd_sel <= "111";
		rs_sel <= "010";
		rt_sel <= "001";
		wait for 1 ns; -- clock para leitura de r1 e r2
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		we <= '1';
		wait for 1 ns; -- clock para gravacao em r7
		clk <= '1';
		we <= '0' after 0.1 ns;
		wait for 1 ns;
		clk <= '0';

		-- Confere r1
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "001";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		-- Confere r2
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "010";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		-- Confere r7
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "111";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';

		-- Reset
		rst <= '1';
		wait for 1 ns;
		clk <= '1';
		rst <= '0' after 0.1 ns;
		wait for 1 ns;
		clk <= '0';

		-- Confere r1
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "001";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		-- Confere r2
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "010";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		-- Confere r7
		mux_sel <= '0';
		rd_sel <= "000";
		rs_sel <= "000";
		rt_sel <= "111";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';

		wait;
	end process;
end;
