library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_tap is
  port(
        h: in std_logic;
        sel: in std_logic; -- sel=0 => x_i=coeff, sel=1 => x_i=data
        x_i: in signed(7 downto 0);
        x_o: out signed(7 downto 0);
        y_i: in signed(15 downto 0);
        y_o: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture rtl of fir_tap is
  signal z: signed(7 downto 0);
  signal c: signed(7 downto 0);
begin
  process(rst, h)
  begin
    if rst='1' then
        z <= to_signed(0,8);  
        c <= to_signed(0,8);  
    elsif rising_edge(h) then
      if sel='0' then
        c <= x_i;
      else
        z <= x_i;
      end if;
    end if;
  end process;
  x_o <= c when sel='0' else z;
  y_o <= to_signed(0,16) when sel='0' else y_i + z * c;
end architecture;
