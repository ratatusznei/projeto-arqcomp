library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg17 is
	port(
		clk, we, rst: in std_logic;
		data_in: in unsigned(16 downto 0);
		data_out: out unsigned(16 downto 0)
	);
end;

architecture behav of reg17 is
	signal data: unsigned(16 downto 0) := (others => '0');
begin
	data_out <= data;

	process (clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				data <= (others => '0');
			elsif we = '1' then
				data <= data_in;
			end if;
		end if;
	end process;
end;
