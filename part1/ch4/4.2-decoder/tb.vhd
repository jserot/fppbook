library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture beh of tb is
  signal t_x : std_logic_vector(1 downto 0);
  signal t_y : std_logic_vector(0 to 3);
begin
  UUT: entity work.decoder port map (x => t_x, y => t_y);

  STIM: process
    begin
      t_x <= "00"; wait for 10 ns;
      t_x <= "01"; wait for 10 ns;
      t_x <= "10"; wait for 10 ns;
      t_x <= "11"; wait for 10 ns;
      wait;
  end process;
end architecture;
