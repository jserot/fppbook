library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
  generic (width: integer);
  port ( e0: in unsigned(width-1 downto 0);
         e1: in unsigned(width-1 downto 0);
         sel: in std_logic;
         s: out unsigned(width-1 downto 0));
end entity;

architecture rtl of mux is
begin
  s <= e0 when sel='0' else e1;
end architecture;
