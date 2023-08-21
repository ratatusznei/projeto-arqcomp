library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1 is
	port(
		clk, we, rst: in std_logic;
		data_in: in std_logic;
		data_out: out std_logic
	);
end;

architecture behav of reg1 is
	signal data: std_logic := '0';
begin
	data_out <= data;

	process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				data <= '0';
			elsif we = '1' then
				data <= data_in;
			end if;
		end if;
	end process;
end;
