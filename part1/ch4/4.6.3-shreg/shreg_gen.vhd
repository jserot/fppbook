-- Listing 4.23

library ieee;
use ieee.std_logic_1164.all;

entity shreg_g is
  generic (n: positive);  -- !!
  port (clk: in std_logic;
        rst: in std_logic;
        din: in std_logic;
        dout: out std_logic_vector(0 to n-1)); -- !!
end entity;

architecture rtl of shreg_g is
  signal r: std_logic_vector(0 to n-1); -- !!
begin
  process (rst, clk)
  begin
    if rst='1' then
      r <= (0 to n-1 => '0');  -- !!
    elsif rising_edge(clk) then
      r <= din & r(0 to n-2);  -- !!
    end if;
  end process;
  dout <= r;
end architecture;
