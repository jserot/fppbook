-- Listing 4.26

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package addbcd_types is
  type array_u4 is array(natural range <>) of unsigned(3 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.addbcd_types.all;

entity addbcd is
generic(n: positive := 4);  -- A VOIR : ne compile pas sans une valeur par defaut ici ..
port(
  a: in array_u4(n-1 downto 0);
  b: in array_u4(n-1 downto 0);
  s: out array_u4(n-1 downto 0);
  sn : out unsigned(0 downto 0)
  );
  end entity;

architecture struct of addbcd is
  type array_u1 is array(1 to n-1) of unsigned(0 downto 0);
  signal r: array_u1;
begin
  ADD0: entity work.addbcd1 port map(a(0), b(0), "0", s(0), r(1));
  ADDs: for i in 1 to n-2 generate
    ADDi: entity work.addbcd1 port map(a(i), b(i), r(i), s(i), r(i+1));
  end generate;
 ADDf: entity work.addbcd1 port map(a(n-1), b(n-1), r(n-1), s(n-1), sn);
end architecture;
