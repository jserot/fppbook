-- Listing 4.9

library ieee;
use ieee.std_logic_1164.all;

entity shreg is
  port (clk: in std_logic;
        rst: in std_logic;
        din: in std_logic;
        dout: out std_logic_vector(0 to 3));
end entity;

architecture rtl of shreg is
  signal r: std_logic_vector(0 to 3);
begin
  process (rst, clk)
  begin
    if rst='1' then
      r <= "0000";
    elsif rising_edge(clk) then
      r <= din & r(0 to 2);
    end if;
  end process;
  dout <= r;
end architecture;
