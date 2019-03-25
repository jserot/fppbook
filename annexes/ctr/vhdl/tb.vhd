library ieee ;
use ieee.std_logic_1164.all;

entity tb is
end tb;
     
architecture beh of tb is

  signal clk, rst: std_logic;
  signal cnt: std_logic_vector(3 downto 0);

begin

   U: entity work.top generic map (width=>4, divf=>2) port map (clk, rst, cnt);

   CLOCK: process
     begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

   RESET: process
     begin
        rst <= '0'; wait for 1 ns;
        rst <= '1'; wait;
    end process;

end beh;
