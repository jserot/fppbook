library ieee;
use ieee.std_logic_1164.all;

entity freqdiv is
  generic (n: natural);
  port (cki: in std_logic;
        cko: out std_logic);
end entity;

architecture struct of freqdiv is
  signal cnt: integer := 0;
  signal ck: std_logic := '0';
begin
  process (cki)
  begin
    if rising_edge(cki) then
      if cnt = n-1 then
        ck <= not ck;
        cnt <= 0;
      else
        cnt <= cnt+1;
      end if;
    end if;
	end process;
	cko <= ck;
end architecture;
