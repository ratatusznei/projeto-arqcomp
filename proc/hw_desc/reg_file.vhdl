library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
	port (
		rs_sel, rt_sel, rd_sel: in unsigned(2 downto 0);
		rs_out, rt_out, HL_out, r4_out: out unsigned(15 downto 0) := (others => '0');
		rd_in: in unsigned(15 downto 0);
		we, clk, rst: in std_logic
	);
end;

architecture arch of reg_file is
	type array_reg is array(7 downto 0) of unsigned(15 downto 0);
	signal regs: array_reg := (others => x"0000");
begin
	HL_out <= regs(1);
	r4_out <= regs(4);
	rs_out <= regs(to_integer(rs_sel));
	rt_out <= regs(to_integer(rt_sel));

	process (clk) is
	begin
		if rising_edge(clk) then
			if rst = '0' then
				if we = '1' then
					regs(to_integer(rd_sel)) <= rd_in;
				end if;
			else
				regs <= (others => x"0000");
			end if;
		end if;
	end process;
end;
