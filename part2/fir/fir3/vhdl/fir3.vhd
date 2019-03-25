-- Listings 6.1, 6.2 et 6.3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir3 is
  generic (a0, a1, a2: signed(6 downto 0));
  port(
        h: in std_logic;
        x: in signed(7 downto 0);
        y: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture rtl1 of fir3 is
begin
  process(rst, h)
    variable z, zz: signed(7 downto 0);
  begin
    if rst='1' then
      z := to_signed(0,8);
      zz:= to_signed(0,8);
    elsif rising_edge(h) then 
      y <= resize(a0,8)*x + resize(a1,8)*z + resize(a2,8)*zz;
      zz := z;
      z := x;
    end if;
  end process;
end architecture;

architecture rtl2 of fir3 is
  signal z, zz: signed(7 downto 0);
begin
  process(rst, h)
  begin
    if rst='1' then
      z <= to_signed(0,8);
      zz <= to_signed(0,8);
    elsif rising_edge(h) then 
      y <= resize(a0,8)*x + resize(a1,8)*z + resize(a2,8)*zz;
      zz <= z;
      z <= x;
    end if;
  end process;
end architecture;

architecture rtl3 of fir3 is
  signal z, zz: signed(7 downto 0);
begin
  process(rst, h)
  begin
    if rst='1' then
      z <= to_signed(0,8);
      zz <= to_signed(0,8);
    elsif rising_edge(h) then 
      z <= x;
      zz <= z;
      y <= resize(a0,8)*x + resize(a1,8)*z + resize(a2,8)*zz;
    end if;
  end process;
end architecture;
