library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir is
  generic (n: natural);
  port(
        h: in std_logic;
        sel: in std_logic; -- sel=0 => xc=coeff, sel=1 => xc=data
        xc: in signed(7 downto 0);
        y: out signed(15 downto 0);
        rst: in std_logic
        );
end entity;

architecture rtl of fir is
  type t_z is array(1 to n) of signed(7 downto 0);
  signal z: t_z;
  type t_acc is array(1 to n-1) of signed(15 downto 0);
  signal acc: t_acc;
begin
  TAP1: entity work.fir_tap port map (h, sel, xc, z(1), to_signed(0,16), acc(1), rst);
  TAPs: for i in 2 to n-1 generate
    TAPi: entity work.fir_tap port map (h, sel, z(i-1), z(i), acc(i-1), acc(i), rst);
  end generate;
  TAPn: entity work.fir_tap port map (h, sel, z(n-1), z(n), acc(n-1), y, rst);
end architecture;
