library ieee;
use ieee.std_logic_1164.all;	   
use ieee.numeric_std.all;
use work.fir_types.all;

entity top is
  port(
        h: in std_logic;
        x: in signed(7 downto 0);
        y1, y2: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture arch of top is
  constant a1 : t_coeffs := (to_signed(2,7), to_signed(-1,7), to_signed(1, 7));
  constant a2 : t_coeffs := (to_signed(1,7), to_signed(1,7), to_signed(1, 7), to_signed(1,7), to_signed(1,7));
begin
  --U1: entity work.fir(rtl1) generic map(a2) port map(h, x, y1, rst);
  --U2: entity work.fir(rtl2) generic map(a2) port map(h, x, y2, rst);
  --U2: entity work.fir(rtl1) generic map(a2) port map(h, x, y2, rst);
  --U2: entity work.fir(rtl3) generic map(a1) port map(h, x, y2, rst);
  U1: entity work.fir(rtl3) generic map(a1) port map(h, x, y1, rst);
end architecture;
