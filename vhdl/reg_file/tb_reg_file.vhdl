library ieee;
use ieee.std_logic_1164.all;

-- ghdl -a reg_file.vhdl tb_reg_file.vhdl && ghdl -r tb_reg_file --vcd=- | gtkwave -v

entity tb_reg_file is
end;

architecture tb of tb_reg_file is
	signal clk, we, rst: std_logic := '0';
	signal rd, rs, rt: std_logic_vector(15 downto 0) := x"0000";
	signal rd_sel, rs_sel, rt_sel: std_logic_vector(2 downto 0) := "000";
begin
	dut: entity work.reg_file port map(
		clk => clk, we => we, rst => rst,
		rd_in => rd, rs_out => rs, rt_out => rt,
		rd_sel => rd_sel, rs_sel => rs_sel, rt_sel => rt_sel
	);
	process
	begin
		-- reset
		rst <= '1';
		wait for 1 ns;
		clk <= '1';
		rst <= '0';
		wait for 1 ns;
		clk <= '0';

		-- Grava 1 no registrador 1 0x0001
		rd_sel <= "001";
		rd <= x"0001";
		we <= '0';
		wait for 1 ns;
		clk <= '1';
		we <= '1';
		wait for 1 ns;
		clk <= '0';
		we <= '0';

		-- Le registrador 1 pelo rs
		rs_sel <= "001";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';

		-- Grava 0xffff no registrador 7
		rd_sel <= "111";
		rd <= x"FFFF";
		we <= '0';
		wait for 1 ns;
		clk <= '1';
		we <= '1';
		wait for 1 ns;
		clk <= '0';

		-- Le registrador 7 pelo rt
		rt_sel <= "111";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';

		-- Tenta escrever no registrador 0, nao eh para funcionar
		rd_sel <= "000";
		rd <= x"CAFE";
		we <= '1';
		wait for 1 ns;
		clk <= '1';
		we <= '0';
		wait for 1 ns;
		clk <= '0';

		-- Le o registrador 0 pelo rs e rt, eh para sair 0
		rs_sel <= "000";
		rt_sel <= "000";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';

		-- reseta
		rst <= '1';
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		rst <= '0';

		-- confere registradores 1 e 7 escritos anteriormente
		rs_sel <= "001";
		rt_sel <= "111";
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
		clk <= '0';

		wait;
	end process;
end;
