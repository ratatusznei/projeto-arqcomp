library ieee;
use ieee.std_logic_1164.all;

entity porta is
	port(
		a: in std_logic;
		b: in std_logic;
		y: out std_logic
	);
end;

architecture arch of porta is
begin
	y <= a and not(b);
end;
