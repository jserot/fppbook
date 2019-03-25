library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;

entity top is
  port(
        h: in std_logic;
        x1, x2, x3: in signed(7 downto 0);
        y1, y2, y3: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture arch of top is
  constant a0 : integer := 2;
  constant a1 : integer := -1;
  constant a2 : integer := 1;
begin
  U1: entity work.fir3(rtl1) generic map(to_signed(a0,7), to_signed(a1,7), to_signed(a2,7)) port map(h, x1, y1, rst);
  U2: entity work.fir3(rtl2) generic map(to_signed(a0,7), to_signed(a1,7), to_signed(a2,7)) port map(h, x2, y2, rst);
  U3: entity work.fir3(rtl3) generic map(to_signed(a0,7), to_signed(a1,7), to_signed(a2,7)) port map(h, x3, y3, rst);
end architecture;
