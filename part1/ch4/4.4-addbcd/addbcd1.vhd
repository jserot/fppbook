-- Listing 4.3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addbcd1 is
  port(
    a  : in  unsigned(3 downto 0);
    b  : in  unsigned(3 downto 0);
    ci : in  unsigned(0 downto 0);
    s  : out unsigned(3 downto 0);
    co : out unsigned(0 downto 0));
end entity;

architecture arch1 of addbcd1 is
  signal r: unsigned(4 downto 0);
begin
  r <= resize(a,5) + b + ci;
  s <= resize(r-10,4) when r > 9 else resize(r,4);
  co <= "1" when r > 9 else "0";
end architecture;

architecture arch2 of addbcd1 is
 signal r: unsigned(4 downto 0);
begin
 -- Une autre ecriture, parfaitement equivalente
 co <= "1" when r > 9 else "0";
 s <= resize(r-10,4) when r > 9 else resize(r,4);
 r <= resize(a,5) + b + ci;
end architecture;
