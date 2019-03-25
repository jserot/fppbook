library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_tap is
  generic (a: signed(6 downto 0));
  port(
        h: in std_logic;
        x_i: in signed(7 downto 0);
        x_o: out signed(7 downto 0);
        y_i: in signed(15 downto 0);
        y_o: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture rtl of fir_tap is
  signal z: signed(7 downto 0);
begin
  process(rst, h)
  begin
    if rst='1' then
        z <= to_signed(0,8);  
    elsif rising_edge(h) then
      z <= x_i;
    end if;
  end process;
  x_o <= z;
  y_o <= y_i + z * a;
end architecture;
