library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir is
  ...
  port(
        h: in std_logic;
        x: in signed(7 downto 0);
        y: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture rtl of fir is
  type mem is array(0 to n-2) of signed(7 downto 0);
  signal z: mem;
begin
  process(rst, h)
  begin
    if rst='1' then
      z(0) <= to_signed(0,8);
      z(1) <= z(0);
      ...
      z(n-2) <= to_signed(0,8);
    elsif rising_edge(h) then 
      y <= resize(a(0),8)*x + resize(a(1),8)*z(0) + ... + resize(a(n-1),8)*z(n-2);
      z(0) <= x;
      z(1) <= z(0);
      ...
      z(n-2) <= z(n-3);
    end if;
  end process;
end architecture;
