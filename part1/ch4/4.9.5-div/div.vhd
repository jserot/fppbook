-- Listing 4.31

library ieee;
use ieee.numeric_std.all;

entity div is
  port (a: in unsigned (15 downto 0);
        b: in unsigned (15 downto 0);
        c: out unsigned (15 downto 0));
end div;

architecture rtl of div is
begin
     c <= a / b;
end rtl;
