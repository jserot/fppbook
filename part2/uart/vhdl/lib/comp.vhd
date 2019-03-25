library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp is
  generic (width: natural := 8);
  port ( a: in unsigned(width-1 downto 0);
         b: in unsigned(width-1 downto 0);
         lt: out std_logic;
         eq: out std_logic;
         gt: out std_logic);
end entity;

architecture arch of comp is
begin
  lt <= '1' when a < b else '0';
  eq <= '1' when a = b else '0';
  gt <= '1' when a > b else '0';
end arch;

