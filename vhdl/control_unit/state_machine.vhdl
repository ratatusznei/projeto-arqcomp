library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is 
	port(
		clk, rst: in std_logic;
		state_out: out std_logic
	);
end;

architecture behav of state_machine is
	signal state: std_logic := '0';
begin
	state_out <= state;

	process (clk) is
	begin
		if rising_edge(clk) then
			if rst = '0' then
				state <= not(state);
			else
				state <= '0';
			end if;
		end if;
	end process;
end;
