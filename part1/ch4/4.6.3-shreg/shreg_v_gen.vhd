-- Listing 4.24

library ieee;
use ieee.std_logic_1164.all;

package shreg_types_g is
  type array_slv8 is array(natural range <>) of std_logic_vector(7 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use work.shreg_types_g.all;

entity shreg_vg is
  generic (n: positive);
  port (clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector(0 to 7);
        dout: out array_slv8(0 to n-1));
end entity;

architecture rtl of shreg_vg is
  signal r: array_slv8(0 to n-1);
begin
  process (rst, clk)
  begin
    if rst='1' then
      r <= (0 to n-1 => "00000000");
    elsif rising_edge(clk) then
      r(0) <= din;
      for i in 1 to n-1 loop
      r(i) <= r(i-1);
      end loop;
    end if;
  end process;
  dout <= r;
end architecture;
