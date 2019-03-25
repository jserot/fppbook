library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity top is
  port(
        h: in std_logic;
        sel: in std_logic;
        xc: in signed(7 downto 0);
        y: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture arch of top is
begin
  U1: entity work.fir(rtl) generic map(3) port map(h, sel, xc, y, rst);
end architecture;
