-- Listing 4.10

library ieee;
use ieee.std_logic_1164.all;

package shreg_types is
  type array4_slv8 is array(0 to 3) of std_logic_vector(7 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use work.shreg_types.all;

entity shreg_v is
  port (clk: in std_logic;
        rst: in std_logic;
        din: in std_logic_vector(0 to 7);
        dout: out array4_slv8);
end entity;

architecture rtl of shreg_v is
  signal r: array4_slv8;
begin
  process (rst, clk)
  begin
    if rst='1' then
      r <= (others => "00000000");
    elsif rising_edge(clk) then
      r(0) <= din;
      r(1) <= r(0);
      r(2) <= r(1);
      r(3) <= r(2);
    end if;
  end process;
  dout <= r;
end architecture;
